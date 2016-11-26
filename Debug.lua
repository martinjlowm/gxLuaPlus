local _G = getfenv(0)

local TABLEITEMS, TABLEDEPTH = 25, 1

local colors = {boolean = "|cffff9100", number = "|cffff7fff", ["nil"] = "|cffff7f7f"}
local noescape = {["\a"] = "a", ["\b"] = "b", ["\f"] = "f", ["\n"] = "n", ["\r"] = "r", ["\t"] = "t", ["\v"] = "v"}
local function escape(c) return "\\".. (noescape[c] or 0) end


local function TableToString(t, lasti, items, depth)
    items = items or 0
    depth = depth or 0

    if items > TABLEITEMS then
        return "...|cff9f9f9f}|r"
    end

    local i,v = next(t, lasti)
    if items == 0 then
        if next(t, i) then
            return "|cff9f9f9f{|cff7fd5ff"..tostring(i).."|r = "..inspect(v, depth), TableToString(t, i, 1, depth)
        elseif v == nil then
            return "|cff9f9f9f{}|r"
        else
            return "|cff9f9f9f{|cff7fd5ff"..tostring(i).."|r = "..inspect(v, depth).."|cff9f9f9f}|r"
        end
    end
    if next(t, i) then
        return "|cff7fd5ff"..tostring(i).."|r = "..inspect(v, depth), TableToString(t, i, items + 1, depth)
    end

    return "|cff7fd5ff"..tostring(i).."|r = "..inspect(v, depth).."|cff9f9f9f}|r"
end

-- Inspect a variable and convert it and its children to a stringified table
_G.inspect = function(value, depth)
    depth = depth or 0

    local t = type(value)

    if t == "string" then
        return '|cff00ff00"'..string.gsub(string.gsub(value, "|", "||"), "([\001-\031\128-\255])", escape)..'"|r'
    elseif t == "table" then
        if depth > TABLEDEPTH then
            return "|cff9f9f9f{...}|r"
        else
            local suffix = ''
            if value.GetChildren then
                local children = { value:GetChildren() }

                if select('#', children) > 0 then
                    suffix = suffix .. ', |cffff0000CHILDREN[|r' .. string.join(", ", TableToString(children, nil, nil, depth + 1)) .. '|cffff0000]|r'
                end
            end

            if value.GetRegions then
                local regions = { value:GetRegions() }

                if select('#', regions) > 0 then
                    suffix = suffix .. ', |cff00ff00REGIONS[|r' .. string.join(", ", TableToString(regions, nil, nil, depth + 1)) .. '|cff00ff00]|r'
                end
            end

            return "|cff9f9f9f"..string.join(", ", TableToString(value, nil, nil, depth + 1)).."|r"..suffix
        end
    elseif t == "function" then
        return "|cffffea00<"..t..":"..(value or "(anon)")..">|r"
    elseif colors[t] then
        return colors[t]..tostring(value).."|r"
    else
        return tostring(value)
    end
end

_G.Print = function(output)
    DEFAULT_CHAT_FRAME:AddMessage(inspect(output))
end

_G.NOOP = function()
end
