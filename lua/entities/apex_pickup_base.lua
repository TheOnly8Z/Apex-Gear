AddCSLuaFile()

ENT.Type                     = "anim"
ENT.Base                     = "base_entity"
ENT.RenderGroup              = RENDERGROUP_TRANSLUCENT

ENT.PrintName                = "Base Apex Pickup"
ENT.Category                 = "Apex Legends - Gear"

ENT.Spawnable                = false
ENT.Model                    = "models/props_junk/plasticbucket001a.mdl"

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "GearID")
    self:NetworkVar("Int", 1, "Capacity") -- for shields
    self:NetworkVar("Int", 2, "Evo") -- for shields
end

function ENT:Initialize()
    local gear = ApexGear.Gear[ApexGear.GearID[self:GetGearID()] or ""]
    if gear then
        if gear.model then self:SetModel(gear.model) end
        if gear.skin then self:SetSkin(gear.skin) end
    else
        self:SetModel(self.Model)
    end

    if SERVER then
        if gear and gear.physbox then
            self:PhysicsInitBox(gear.physbox[1], gear.physbox[2])
        else
            self:PhysicsInit(SOLID_VPHYSICS)
            self:SetMoveType(MOVETYPE_VPHYSICS)
            self:SetSolid(SOLID_VPHYSICS)
        end
        self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        self:SetUseType(SIMPLE_USE)
        self:PhysWake()
    end
end

if SERVER then
    function ENT:Use(ply)
        local gear = ApexGear.Gear[ApexGear.GearID[self:GetGearID()] or ""]
        ply:RemoveApexGear(gear.slot)
        ply:SetApexGear(self:GetGearID())
        self:Remove()
    end
elseif CLIENT then
    function ENT:DrawTranslucent()
        self:DrawModel()
    end
end