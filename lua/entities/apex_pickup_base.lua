AddCSLuaFile()

ENT.Type                     = "anim"
ENT.Base                     = "base_entity"
ENT.RenderGroup              = RENDERGROUP_TRANSLUCENT

ENT.PrintName                = "Base Apex Pickup"

ENT.Spawnable                = false
ENT.Model                    = "models/items/sniper_round_box.mdl"

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "GearID")
end

if SERVER then

    function ENT:Initialize()
        self:SetModel(self.Model)

        if self:GetGearID() > 0 and ApexGear.Gear[self:GetGearID()] then
            local gear = ApexGear.Gear[self:GetGearID()]
        end

        if SERVER then
            self:PhysicsInit(SOLID_VPHYSICS)
            self:SetMoveType(MOVETYPE_VPHYSICS)
            self:SetSolid(SOLID_VPHYSICS)
            self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            self:SetUseType(SIMPLE_USE)
            self:PhysWake()
        end
    end

    function ENT:Use(ply)

    end

end