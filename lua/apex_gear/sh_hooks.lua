hook.Add("PlayerDeath", "ApexGear", function(ply)
    ply:RemoveApexGear(ApexGear.SLOT_HEAD)
    ply:RemoveApexGear(ApexGear.SLOT_BODY)
end)

hook.Add("PostEntityTakeDamage", "ApexGear", function(ent, dmg, took)
    if not took then return end
    local atk = dmg:GetAttacker()
    if not atk:IsPlayer() or atk == ent then return end
    local armor = ApexGear.Gear[ApexGear.GearID[atk:GetApexGear(ApexGear.SLOT_BODY)]]
    if not armor or not armor.evo then return end
    atk:SetNW2Int("ApexGear_Evo", atk:GetNW2Int("ApexGear_Evo") + dmg:GetDamage())
    if atk:GetNW2Int("ApexGear_Evo") >= armor.evo then
        ply:SetApexGear(armor.evonext)
    end
end)