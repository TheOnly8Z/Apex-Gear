local Player = FindMetaTable("Player")

function Player:GetApexGear(slot)
    if slot == ApexGear.SLOT_BODY then
        return self:GetNW2Int("ApexGear_Body", 0)
    elseif slot == ApexGear.SLOT_HEAD then
        return self:GetNW2Int("ApexGear_Head", 0)
    end
    return 0
end

function Player:RemoveApexGear(slot, dontdrop, resetcapacity)
    local ent
    if slot == ApexGear.SLOT_BODY then
        local cur = self:GetNW2Int("ApexGear_Body", 0)
        if cur > 0 and not dontdrop then
            ent = ents.Create("apex_pickup_base")
            ent:SetGearID(cur)
            local a, b = self:GetApexShield()
            ent:SetCapacity(resetcapacity and b or a)
            ent:SetEvo(self:GetNW2Int("ApexGear_Evo", 0))
            ent:SetPos(self:GetPos())
            ent:SetAngles(self:GetAngles())
            ent:Spawn()
        end
        self:SetNW2Int("ApexGear_Body", 0)
        self:SetNW2Int("ApexGear_Evo", 0)
    elseif slot == ApexGear.SLOT_HEAD then
        local cur = self:GetNW2Int("ApexGear_Head", 0)
        if cur > 0 and not dontdrop then
            ent = ents.Create("apex_pickup_base")
            ent:SetGearID(cur)
            ent:SetPos(self:GetPos())
            ent:SetAngles(self:GetAngles())
            ent:Spawn()
        end
        self:SetNW2Int("ApexGear_Head", 0)
    end

    return ent
end

function Player:SetApexGear(id)
    local gear = ApexGear.Gear[isstring(id) and id or ApexGear.GearID[id] or ""]
    if not gear then return end

    if gear.slot == ApexGear.SLOT_BODY then
        self:SetNW2Int("ApexGear_Body", id)
        DRC:SetShieldInfo(self, true, {
            ["Regenerating"] = false,
            ["Health"] = gear.capacity,
            ["Effects"] = {
                ["BloodEnum"] = BLOOD_COLOR_RED,
                ["Impact"] = "",
                ["Deplete"] = "",
                ["Recharge"] = "",
            },
            ["Sounds"] = {
                ["Impact"] = "",
                ["Deplete"] = "",
                ["Recharge"] = "",
            },
            ["Material"] = gear.shieldmat or "models/vuthakral/shield_example",
            ["AlwaysVisible"] = false,
            ["ScaleMax"] = 1.15,
            ["ScaleMin"] = 1.05,
        })
    elseif gear.slot == ApexGear.SLOT_HEAD then
        self:SetNW2Int("ApexGear_Head", id)
    end
end

function Player:GetApexShield()
    return DRC:GetShield(self)
end

function Player:AddApexShield(val, src)
    val = hook.Run("ApexGear_AddShield", self, val, src) or val
    DRC:AddShield(self, val)
end

-- Returns amount of damage not fully absorbed by shield
function Player:TakeApexShield(val, src)
    val = hook.Run("ApexGear_TakeShield", self, val, src) or val
    local s = self:GetApexShield()
    DRC:SubtractShield(self, val)

    return math.max(0, val - s)
end

function Player:GetApexShieldMax()
    local s = self:GetApexGear(ApexGear.SLOT_BODY)
    if (s or 0) == 0 then return 0 end
    return ApexGear.Gear[s].capacity or 0
end