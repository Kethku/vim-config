-- spring-windows.lua
-- A Neovim plugin that resizes windows dynamically using a spring physics model

local M = {}

-- Configuration with defaults
M.config = {
    -- Physics parameters
    spring_constant = 0.2, -- Spring stiffness (lower = softer)
    damping = 0.1,         -- Damping factor (higher = less oscillation)
    mass = 1.0,            -- Mass (affects momentum)

    -- Window size parameters
    focused_size_ratio = 0.6, -- Target ratio for focused window
    min_width = 20,           -- Minimum window width
    min_height = 5,           -- Minimum window height

    -- Animation parameters
    frame_time = 16, -- Time between frames (roughly 60fps)

    -- Layout preservation
    preserve_layout = true, -- Try to preserve the overall window layout

    -- Behavior
    animate_on_window_change = true, -- Resize when changing windows
    ignore_floating_windows = true,  -- Ignore floating windows
    ignore_filetypes = {             -- Filetypes to ignore
        "NvimTree",
        "neo-tree",
        "tagbar",
        "aerial",
        "help"
    },

    -- Debug options
    debug = false, -- Enable debug logging
}

-- Internal state
local state = {
    windows = {},          -- Table to track window states
    animation_timer = nil, -- Timer for animation
    is_animating = false,  -- Flag for animation in progress
    focused_window = nil,  -- Currently focused window
    settle_counter = 0,

    -- Layout tracking
    initial_layout = {
        total_width = 0,
        total_height = 0
    }
}

-- Debug logging
local function debug_log(...)
    if M.config.debug then
        print(string.format("[SpringWindows] %s", string.format(...)))
    end
end

-- Modified spring physics function for more stability
local function apply_spring_physics(current, target, velocity)
    local distance = target - current
    local spring_force = M.config.spring_constant * distance

    local damping_force = M.config.damping -- adaptive_damping * velocity
    local acceleration = (spring_force - damping_force) / M.config.mass

    local max_acceleration = 0.3
    acceleration = math.max(math.min(acceleration, max_acceleration), -max_acceleration)

    local new_velocity = velocity + acceleration
    local new_position = current + new_velocity

    if math.abs(distance) < 0.3 and math.abs(new_velocity) < 0.1 then
        return target, 0
    end

    return new_position, new_velocity
end

-- Check if a window should be ignored
local function should_ignore_window(winid)
    if not vim.api.nvim_win_is_valid(winid) then
        return true
    end

    if M.config.ignore_floating_windows then
        local config = vim.api.nvim_win_get_config(winid)
        if config and config.relative and config.relative ~= "" then
            return true
        end
    end

    local bufnr = vim.api.nvim_win_get_buf(winid)
    local filetype = vim.bo[bufnr].filetype
    for _, ignored_ft in ipairs(M.config.ignore_filetypes) do
        if filetype == ignored_ft then
            return true
        end
    end

    return false
end

-- Improved calculate_target_sizes function with more balanced approach
local function calculate_target_sizes()
    local editor_width = vim.o.columns
    local editor_height = vim.o.lines - vim.o.cmdheight - 1

    debug_log("Editor dimensions: %d x %d", editor_width, editor_height)

    local horizontal_groups = {}
    local vertical_groups = {}

    for winid, win in pairs(state.windows) do
        if vim.api.nvim_win_is_valid(winid) then
            if not horizontal_groups[win.row] then
                horizontal_groups[win.row] = {}
            end
            table.insert(horizontal_groups[win.row], winid)

            if not vertical_groups[win.col] then
                vertical_groups[win.col] = {}
            end
            table.insert(vertical_groups[win.col], winid)
        end
    end

    for winid, win in pairs(state.windows) do
        if vim.api.nvim_win_is_valid(winid) then
            local windows_in_row = #(horizontal_groups[win.row] or {})
            local windows_in_col = #(vertical_groups[win.col] or {})

            local focus_grow = win.is_focused and 1.15 or 0.95

            if win.is_horizontal_layout then
                win.target_width = vim.api.nvim_win_get_width(winid)
                local base_adjustment = focus_grow
                if windows_in_col > 2 then
                    base_adjustment = win.is_focused and 1.1 or 0.97
                end
                win.target_height = math.max(
                    math.floor(vim.api.nvim_win_get_height(winid) * base_adjustment),
                    M.config.min_height
                )
            else
                win.target_height = vim.api.nvim_win_get_height(winid)
                local base_adjustment = focus_grow
                if windows_in_row > 2 then
                    base_adjustment = win.is_focused and 1.1 or 0.97
                end
                win.target_width = math.max(
                    math.floor(vim.api.nvim_win_get_width(winid) * base_adjustment),
                    M.config.min_width
                )
            end

            debug_log("Window %d: %s, row windows: %d, col windows: %d, current: %d x %d, target: %d x %d",
                winid, win.is_focused and "FOCUSED" or "unfocused",
                windows_in_row, windows_in_col,
                vim.api.nvim_win_get_width(winid), vim.api.nvim_win_get_height(winid),
                win.target_width, win.target_height)
        end
    end
end

-- Global constraint functions to ensure computed targets fit in available space

-- Adjust horizontal (side-by-side) window targets by row
local function apply_global_horizontal_constraints()
    local editor_width = vim.o.columns
    local groups = {}
    -- For windows arranged side by side (not horizontal layout)
    for winid, win in pairs(state.windows) do
        if not win.is_horizontal_layout then
            groups[win.row] = groups[win.row] or {}
            table.insert(groups[win.row], winid)
        end
    end
    for row, group in pairs(groups) do
        local total_target = 0
        for _, winid in ipairs(group) do
            total_target = total_target + state.windows[winid].target_width
        end
        if total_target > editor_width then
            local scale = editor_width / total_target
            for _, winid in ipairs(group) do
                local old = state.windows[winid].target_width
                state.windows[winid].target_width = math.floor(state.windows[winid].target_width * scale)
                debug_log("Row %d: window %d target width adjusted from %d to %d", row, winid, old,
                    state.windows[winid].target_width)
            end
            debug_log("Row %d constrained: total target %d > editor width %d, scale factor %f applied", row, total_target,
                editor_width, scale)
        end
    end
end

-- Adjust vertical (stacked) window targets by column
local function apply_global_vertical_constraints()
    local editor_height = vim.o.lines - vim.o.cmdheight - 1
    local groups = {}
    -- For windows arranged vertically (horizontal layout = true)
    for winid, win in pairs(state.windows) do
        if win.is_horizontal_layout then
            groups[win.col] = groups[win.col] or {}
            table.insert(groups[win.col], winid)
        end
    end
    for col, group in pairs(groups) do
        local total_target = 0
        for _, winid in ipairs(group) do
            total_target = total_target + state.windows[winid].target_height
        end
        if total_target > editor_height then
            local scale = editor_height / total_target
            for _, winid in ipairs(group) do
                local old = state.windows[winid].target_height
                state.windows[winid].target_height = math.floor(state.windows[winid].target_height * scale)
                debug_log("Col %d: window %d target height adjusted from %d to %d", col, winid, old,
                    state.windows[winid].target_height)
            end
            debug_log("Col %d constrained: total target %d > editor height %d, scale factor %f applied", col,
                total_target, editor_height, scale)
        end
    end
end

local function apply_global_constraints()
    apply_global_horizontal_constraints()
    apply_global_vertical_constraints()
end

-- Modified adjust_for_constraints function with more feedback
local function adjust_for_constraints()
    local adjustments = {}
    for winid, win in pairs(state.windows) do
        if vim.api.nvim_win_is_valid(winid) then
            local before_width = vim.api.nvim_win_get_width(winid)
            local before_height = vim.api.nvim_win_get_height(winid)

            local target_width = math.floor(win.width + 0.5)
            local target_height = math.floor(win.height + 0.5)

            if math.abs(before_width - target_width) >= 1 then
                vim.api.nvim_win_set_width(winid, target_width)
            else
                target_width = before_width
            end

            if math.abs(before_height - target_height) >= 1 then
                vim.api.nvim_win_set_height(winid, target_height)
            else
                target_height = before_height
            end

            local after_width = vim.api.nvim_win_get_width(winid)
            local after_height = vim.api.nvim_win_get_height(winid)

            adjustments[winid] = {
                width_delta = after_width - before_width,
                height_delta = after_height - before_height,
                expected_width_delta = target_width - before_width,
                expected_height_delta = target_height - before_height,
                constraint_hit = (after_width ~= target_width or after_height ~= target_height)
            }

            win.width = after_width
            win.height = after_height

            if adjustments[winid].constraint_hit then
                debug_log("Window %d: CONSTRAINT HIT! Expected: %d×%d, Got: %d×%d",
                    winid, target_width, target_height, after_width, after_height)
            end
        end
    end

    return adjustments
end

-- Modified animation_frame function with improved settling detection and global constraint propagation
local function animation_frame()
    local still_animating = false
    local settling_threshold = 0.01
    local position_threshold = 0.03

    for winid, win in pairs(state.windows) do
        if vim.api.nvim_win_is_valid(winid) then
            local current_width = vim.api.nvim_win_get_width(winid)
            local current_height = vim.api.nvim_win_get_height(winid)

            if math.abs(win.width - current_width) > 0.5 or math.abs(win.height - current_height) > 0.5 then
                debug_log("Window %d: Neovim changed dimensions", winid)
                win.width = current_width
                win.height = current_height

                if math.abs(win.width - current_width) > 0.5 then
                    win.width_velocity = win.width_velocity * -0.3
                end
                if math.abs(win.height - current_height) > 0.5 then
                    win.height_velocity = win.height_velocity * -0.3
                end

                if win.is_focused and current_width < win.target_width then
                    win.target_width = current_width + 1
                end
                if win.is_focused and current_height < win.target_height then
                    win.target_height = current_height + 1
                end
            end

            local new_width, new_width_velocity = apply_spring_physics(
                win.width, win.target_width, win.width_velocity
            )
            local new_height, new_height_velocity = apply_spring_physics(
                win.height, win.target_height, win.height_velocity
            )

            local max_delta = 2
            new_width = win.width + math.max(math.min(new_width - win.width, max_delta), -max_delta)
            new_height = win.height + math.max(math.min(new_height - win.height, max_delta), -max_delta)

            win.width = new_width
            win.height = new_height
            win.width_velocity = new_width_velocity
            win.height_velocity = new_height_velocity

            if math.abs(win.width_velocity) > settling_threshold or
                math.abs(win.height_velocity) > settling_threshold or
                math.abs(win.width - win.target_width) > position_threshold or
                math.abs(win.height - win.target_height) > position_threshold then
                still_animating = true
            end
        end
    end

    local adjustments = adjust_for_constraints()
    for winid, adjustment in pairs(adjustments) do
        local win = state.windows[winid]
        if win then
            if adjustment.width_delta ~= adjustment.expected_width_delta then
                win.width_velocity = win.width_velocity * -0.3
                win.target_width = win.width
            end
            if adjustment.height_delta ~= adjustment.expected_height_delta then
                win.height_velocity = win.height_velocity * -0.3
                win.target_height = win.height
            end
        end
    end

    -- Apply global constraint propagation so that targets fit within available space
    apply_global_constraints()

    if still_animating then
        state.settle_counter = 0
    else
        state.settle_counter = state.settle_counter + 1
    end

    if state.settle_counter >= 10 then
        if state.animation_timer then
            state.animation_timer:stop()
            state.animation_timer = nil
        end
        state.is_animating = false
        debug_log("Animation settled naturally")
        return false
    end

    return true
end

-- Enhanced window layout detection
local function get_window_layout()
    local layout = {
        horizontal = {},
        vertical = {},
        windows = {}
    }

    local wins = vim.api.nvim_tabpage_list_wins(0)

    for _, winid in ipairs(wins) do
        if vim.api.nvim_win_is_valid(winid) and not should_ignore_window(winid) then
            local pos = vim.api.nvim_win_get_position(winid)
            local win_info = {
                id = winid,
                pos = pos,
                row = pos[1],
                col = pos[2],
                width = vim.api.nvim_win_get_width(winid),
                height = vim.api.nvim_win_get_height(winid)
            }

            layout.windows[winid] = win_info

            if not layout.horizontal[win_info.row] then
                layout.horizontal[win_info.row] = {}
            end
            table.insert(layout.horizontal[win_info.row], winid)

            if not layout.vertical[win_info.col] then
                layout.vertical[win_info.col] = {}
            end
            table.insert(layout.vertical[win_info.col], winid)
        end
    end

    for winid, win in pairs(layout.windows) do
        win.neighbors = {
            left = {},
            right = {},
            top = {},
            bottom = {}
        }

        for other_id, other in pairs(layout.windows) do
            if winid ~= other_id then
                if (win.row < other.row + other.height) and (win.row + win.height > other.row) then
                    if win.col > other.col + other.width - 2 then
                        table.insert(win.neighbors.left, other_id)
                    end
                    if other.col > win.col + win.width - 2 then
                        table.insert(win.neighbors.right, other_id)
                    end
                end

                if (win.col < other.col + other.width) and (win.col + win.width > other.col) then
                    if win.row > other.row + other.height - 2 then
                        table.insert(win.neighbors.top, other_id)
                    end
                    if other.row > win.row + win.height - 2 then
                        table.insert(win.neighbors.bottom, other_id)
                    end
                end
            end
        end
    end

    return layout
end

-- Update initialize_windows to use the enhanced layout detection
local function initialize_windows()
    state.windows = {}
    state.focused_window = vim.api.nvim_get_current_win()

    local wins = vim.api.nvim_tabpage_list_wins(0)
    local total_valid_windows = 0

    local layout = get_window_layout()

    for _, winid in ipairs(wins) do
        if not should_ignore_window(winid) then
            total_valid_windows = total_valid_windows + 1
        end
    end

    if total_valid_windows <= 1 then
        return false
    end

    for winid, win_layout in pairs(layout.windows) do
        if not should_ignore_window(winid) then
            local width = win_layout.width
            local height = win_layout.height
            local is_focused = (winid == state.focused_window)

            local has_vertical_neighbors = #win_layout.neighbors.top > 0 or #win_layout.neighbors.bottom > 0
            local has_horizontal_neighbors = #win_layout.neighbors.left > 0 or #win_layout.neighbors.right > 0

            local is_horizontal_layout
            if has_vertical_neighbors and not has_horizontal_neighbors then
                is_horizontal_layout = true
            elseif has_horizontal_neighbors and not has_vertical_neighbors then
                is_horizontal_layout = false
            else
                local row_count = #(layout.horizontal[win_layout.row] or {})
                local col_count = #(layout.vertical[win_layout.col] or {})
                is_horizontal_layout = row_count <= col_count
            end

            debug_log("Window %d: Position [%d,%d], %s layout",
                winid, win_layout.row, win_layout.col,
                is_horizontal_layout and "horizontal" or "vertical")

            state.windows[winid] = {
                width = width,
                height = height,
                initial_width = width,
                initial_height = height,
                width_velocity = 0,
                height_velocity = 0,
                is_focused = is_focused,
                is_horizontal_layout = is_horizontal_layout,
                row = win_layout.row,
                col = win_layout.col,
                neighbors = win_layout.neighbors
            }
        end
    end

    return true
end

-- Safely stop the animation timer
local function safe_stop_timer()
    if state.animation_timer then
        local status, err = pcall(function()
            state.animation_timer:stop()
        end)
        if not status then
            debug_log("Error stopping timer: %s", err)
        end
        state.animation_timer = nil
    end
    state.is_animating = false
end

-- Start the animation
local function start_animation()
    if state.is_animating then
        safe_stop_timer()
    end

    state.is_animating = true

    local status, timer_or_err = pcall(function()
        return vim.loop.new_timer()
    end)
    if not status then
        debug_log("Error creating timer: %s", timer_or_err)
        state.is_animating = false
        return
    end
    state.animation_timer = timer_or_err

    status, err = pcall(function()
        state.animation_timer:start(0, M.config.frame_time, vim.schedule_wrap(function()
            local continue = false
            local anim_status, anim_result = pcall(animation_frame)
            if anim_status then
                continue = anim_result
            else
                debug_log("Animation error: %s", anim_result)
                continue = false
            end
            if not continue and state.animation_timer then
                safe_stop_timer()
            end
        end))
    end)
    if not status then
        debug_log("Error starting timer: %s", err)
        safe_stop_timer()
    end
end

-- Resize windows based on focus
function M.resize_windows()
    if not initialize_windows() then
        return
    end

    calculate_target_sizes()
    -- Apply global constraints immediately so that targets are consistent with available space.
    apply_global_constraints()
    start_animation()
end

-- Autocommand for window focus change
function M.setup_autocmds()
    vim.api.nvim_create_augroup("SpringWindows", { clear = true })

    if M.config.animate_on_window_change then
        vim.api.nvim_create_autocmd({ "WinEnter" }, {
            group = "SpringWindows",
            callback = function()
                local current_win = vim.api.nvim_get_current_win()
                if state.focused_window ~= current_win then
                    state.focused_window = current_win
                    M.resize_windows()
                end
            end
        })
    end

    vim.api.nvim_create_autocmd({ "VimLeave" }, {
        group = "SpringWindows",
        callback = function()
            safe_stop_timer()
        end
    })
end

-- Plugin setup
function M.setup(user_config)
    if user_config then
        for k, v in pairs(user_config) do
            if type(M.config[k]) == "table" and type(v) == "table" then
                for k2, v2 in pairs(v) do
                    M.config[k][k2] = v2
                end
            else
                M.config[k] = v
            end
        end
    end

    M.setup_autocmds()
    vim.defer_fn(function()
        M.resize_windows()
    end, 100)
end

-- Commands for manual adjustment
function M.create_commands()
    vim.api.nvim_create_user_command("SpringWindowsResize", function()
        M.resize_windows()
    end, {})

    vim.api.nvim_create_user_command("SpringWindowsDebug", function()
        M.config.debug = not M.config.debug
        print("SpringWindows: Debug mode " .. (M.config.debug and "enabled" or "disabled"))
    end, {})

    vim.api.nvim_create_user_command("SpringWindowsReset", function()
        for winid, win in pairs(state.windows) do
            if vim.api.nvim_win_is_valid(winid) then
                vim.api.nvim_win_set_width(winid, win.initial_width)
                vim.api.nvim_win_set_height(winid, win.initial_height)
            end
        end
        state.windows = {}
    end, {})
end

M.create_commands()

return M
