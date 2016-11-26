local _G = getfenv(0)

_G.math.modf = function(num)
    int = math.floor(num)
    frac = math.abs(num) - math.abs(int)

    return int, frac
end

_G.math.fmod = function(x, y)
    return x - math.floor(x / y) * y
end
