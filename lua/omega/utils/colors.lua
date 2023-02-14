local utils = {}

function utils.adjust_color(color, amount)
    color = vim.trim(color)
    color = color:gsub("#", "")
    local first = ("0" .. string.format("%x", (math.min(255, tonumber(color:sub(1, 2), 16) + amount)))):sub(-2)
    local second = ("0" .. string.format("%x", (math.min(255, tonumber(color:sub(3, 4), 16) + amount)))):sub(-2)
    local third = ("0" .. string.format("%x", (math.min(255, tonumber(color:sub(5, -1), 16) + amount)))):sub(-2)
    return "#" .. first .. second .. third
end

--- Darkens a color by a certain value
---@param color string
---@param amount number
---@return string color
function utils.darken_color(color, amount)
    return utils.adjust_color(color, -amount)
end

--- Lightens a color by a certain value
---@param color string
---@param amount number
---@return string color
function utils.lighten_color(color, amount)
    return utils.adjust_color(color, amount)
end

--- Gets red, green and blue values for color
---@param color string @#RRGGBB
---@return string,string,string
function utils.get_color_values(color)
    local red = tonumber(color:sub(2, 3), 16)
    local green = tonumber(color:sub(4, 5), 16)
    local blue = tonumber(color:sub(6, 7), 16)
    return { red, green, blue }
end

--- Inspired from https://github.com/fitrh/init.nvim
--- Blends top color over bottom color
---@param top string @#RRGGBB
---@param bottom string @#RRGGBB
---@param alpha float
function utils.blend_colors(top, bottom, alpha)
    local top_rgb = utils.get_color_values(top)
    local bottom_rgb = utils.get_color_values(bottom)
    local function blend(c)
        c = (alpha * top_rgb[c] + ((1 - alpha) * bottom_rgb[c]))
        return math.floor(math.min(math.max(0, c), 255) + 0.5)
    end
    return ("#%02X%02X%02X"):format(blend(1), blend(2), blend(3))
end

return utils
