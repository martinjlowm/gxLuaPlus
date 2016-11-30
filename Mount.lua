-- Implements Dismount() and makes CastBySpellName dismount

local _G = getfenv(0)

do
    local scanner = CreateFrame('GameTooltip', 'DismountScanner', nil,
                                'GameTooltipTemplate')

    _G.Dismount = function()
        local i = 0
        local buff
        scanner:SetOwner(WorldFrame, 'CENTER')
        while true do
            buff = UnitBuff('player', i + 1)

            if not buff then
                return
            end

            scanner:SetPlayerBuff(i)
            local buff_text = _G[scanner:GetName() .. 'TextLeft2']:GetText()
            if buff_text and string.match(buff_text,
                                          '(Increases speed by)') then
                CancelPlayerBuff(i)
            end

            i = i + 1
        end

    end

    local origCastSpellByName = CastSpellByName
    _G.CastSpellByName = function(...)
        Dismount()
        scanner:Hide()
        origCastSpellByName(unpack(arg))
    end
end
