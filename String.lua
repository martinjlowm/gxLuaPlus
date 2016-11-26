local _G = getfenv(0)

_G.string.match = function(str, pattern)
    return select(3, string.find(str, pattern))
end

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

_G.string.join = function(delim, ...)
    if type(arg) == 'table' then
        return table.concat(arg, delim)
    else
        return delim
    end
end

_G.string.split = function(delim, s)
    local split_string = {}

    for str in string.gfind(s, "([^" .. delim .. "]+)" .. delim .. "?") do
        table.insert(split_string, str)
    end

    return unpack(split_string)
end

_G.string.trim = function(str)
    return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

_G.strjoin = _G.string.join
