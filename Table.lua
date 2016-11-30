local _G = getfenv(0)

-- Implements select
_G.select = function(idx, ...)
    local len = table.getn(arg)

    if type(idx) == 'string' and idx == '#' then
        return len
    else
        local tbl = {}

        for i = idx, len do
            table.insert(tbl, arg[i])
        end

        return unpack(tbl)
    end
end

-- table.wipe
_G.table.wipe = function(tbl)
    for k in pairs(tbl) do
        tbl[k] = nil
    end
end

-- wipe
_G.wipe = _G.table.wipe
