-- Implements common string functions

local _G = getfenv(0)

-- string.match
_G.string.match = function(str, pattern)
    local tbl_res = { string.find(str, pattern) }

    if tbl_res[3] then
        return select(3, unpack(tbl_res))
    else
        return tbl_res[1], tbl_res[2]
    end
end

-- string.gmatch
_G.string.gmatch = function(str, pattern)
    local init = 0

    return function()
        local tbl = {string.find(str, pattern, init)}

        local start_pos = tbl[1]
        local end_pos = tbl[2]

        if start_pos then
            init = end_pos

            return unpack({select(3, unpack(tbl))})
        end
    end
end

-- string.join
_G.string.join = function(delim, ...)
    if type(arg) == 'table' then
        return table.concat(arg, delim)
    else
        return delim
    end
end

-- string.split
_G.string.split = function(delim, s, limit)
    local split_string = {}
    local rest = {}

    local i = 1
    for str in string.gfind(s, '([^' .. delim .. ']+)' .. delim .. '?') do
        if limit and i >= limit then
            table.insert(rest, str)
        else
            table.insert(split_string, str)
        end

        i = i + 1
    end

    if limit then
        table.insert(split_string, string.join(delim, unpack(rest)))
    end

    return unpack(split_string)
end

-- string.trim
_G.string.trim = function(str)
    return string.gsub(str, '^%s*(.-)%s*$', '%1')
end

-- strjoin
_G.strjoin = _G.string.join
