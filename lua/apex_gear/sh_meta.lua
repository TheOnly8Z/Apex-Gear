local Player = FindMetaTable("Player")

function Player:GetApexGear(slot)
    if slot == ApexGear.SLOT_BODY then
        return self:GetNW2Int("ApexGear_Body", 0)
    elseif slot == ApexGear.SLOT_HEAD then
        return self:GetNW2Int("ApexGear_Head", 0)
    end
end

function Player:GetApexShield()
    return self:GetNWInt("ApexShield", 0)
end

function Player:SetApexShield(val)
    self:SetNWInt("ApexShield", math.min(self:GetApexShieldMax(), math.Round(val)))
end

function Player:AddApexShield(val, src)
    val = hook.Run("ApexGear_AddShield", self, val, src) or val
    return self:SetApexShield(self:GetApexShield() + val)
end

-- Returns amount of damage not fully absorbed buy shield
function Player:TakeApexShield(val, src)
    val = hook.Run("ApexGear_TakeShield", self, val, src) or val
    local s = self:GetApexShield()
    self:SetApexShield(s - val)
    return math.max(0, val - s)
end

function Player:GetApexShieldMax()
    local s = self:GetApexGear(ApexGear.SLOT_BODY)
    if (s or 0) == 0 then return 0 end
    return ApexGear.Gear[s].capacity or 0
end