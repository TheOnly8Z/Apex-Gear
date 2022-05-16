ApexGear = {}

ApexGear.SLOT_INV = 0
ApexGear.SLOT_BODY = 1
ApexGear.SLOT_HEAD = 2

ApexGear.EFF_IMPROVEDHEAL = 1
ApexGear.EFF_FASTCHARGE = 2

ApexGear.Gear = {

    ["head1"] = {
        slot = ApexGear.SLOT_HEAD,
        physbox = {Vector(-5, -5, 2), Vector(5, 5, 16)},
        rarity = 1,
        hsmult = 0.8,
        model = "models/apex_helmet.mdl",
        skin = 0,
        icon = "entities/Helmet_level_1.png",
    },
    ["head2"] = {
        slot = ApexGear.SLOT_HEAD,
        physbox = {Vector(-5, -5, 2), Vector(5, 5, 16)},
        rarity = 2,
        hsmult = 0.5,
        model = "models/apex_helmet.mdl",
        skin = 1,
        icon = "entities/Helmet_level_2.png",
    },
    ["head3"] = {
        slot = ApexGear.SLOT_HEAD,
        physbox = {Vector(-5, -5, 2), Vector(5, 5, 16)},
        rarity = 3,
        hsmult = 0.35,
        model = "models/apex_helmet.mdl",
        skin = 2,
        icon = "entities/Helmet_level_3.png",
    },
    ["head4"] = {
        slot = ApexGear.SLOT_HEAD,
        physbox = {Vector(-5, -5, 2), Vector(5, 5, 16)},
        rarity = 4,
        hsmult = 0.35,
        effect = ApexGear.EFF_FASTCHARGE,
        model = "models/apex_helmet.mdl",
        skin = 3,
        icon = "entities/Helmet_level_4.png",
    },

    ["body1"] = {
        -- name = "My Shield" (names are automatically generated otherwise)
        slot = ApexGear.SLOT_BODY,
        physbox = {Vector(-12, -8, 2), Vector(12, 6, 22)},
        model = "models/apex_armor.mdl",
        skin = 1,
        icon = "entities/Body_Shield_level_1.png",
        rarity = 1,
        capacity = 50,
        evo = false,
    },
    ["body2"] = {
        slot = ApexGear.SLOT_BODY,
        physbox = {Vector(-12, -8, 2), Vector(12, 6, 22)},
        rarity = 2,
        model = "models/apex_armor.mdl",
        skin = 2,
        icon = "entities/Body_Shield_level_2.png",
        capacity = 75,
        evo = false,
    },
    ["body3"] = {
        slot = ApexGear.SLOT_BODY,
        physbox = {Vector(-12, -8, 2), Vector(12, 6, 22)},
        rarity = 3,
        model = "models/apex_armor.mdl",
        skin = 3,
        icon = "entities/Body_Shield_level_3.png",
        capacity = 100,
        evo = false,
    },
    ["body4"] = {
        slot = ApexGear.SLOT_BODY,
        physbox = {Vector(-12, -8, 2), Vector(12, 6, 22)},
        rarity = 4,
        model = "models/apex_armor.mdl",
        skin = 4,
        icon = "entities/Body_Shield_level_4.png",
        capacity = 100,
        evo = false,
        effect = ApexGear.EFF_IMPROVEDHEAL,
    },

    ["evo1"] = {
        slot = ApexGear.SLOT_BODY,
        physbox = {Vector(-12, -8, 2), Vector(12, 6, 22)},
        rarity = 1,
        model = "models/apex_armor.mdl",
        skin = 1,
        icon = "entities/Evo_Shield_level_1.png",
        capacity = 50,
        evo = 150,
        evonext = "evo2",
    },
    ["evo2"] = {
        slot = ApexGear.SLOT_BODY,
        physbox = {Vector(-12, -8, 2), Vector(12, 6, 22)},
        rarity = 2,
        model = "models/apex_armor.mdl",
        skin = 2,
        icon = "entities/Evo_Shield_level_2.png",
        capacity = 75,
        evo = 300,
        evonext = "evo3",
    },
    ["evo3"] = {
        slot = ApexGear.SLOT_BODY,
        physbox = {Vector(-12, -8, 2), Vector(12, 6, 22)},
        rarity = 3,
        model = "models/apex_armor.mdl",
        skin = 3,
        icon = "entities/Evo_Shield_level_3.png",
        capacity = 100,
        evo = 750,
        evonext = "evo4",
    },
    ["evo4"] = {
        slot = ApexGear.SLOT_BODY,
        physbox = {Vector(-12, -8, 2), Vector(12, 6, 22)},
        rarity = 5,
        model = "models/apex_armor.mdl",
        skin = 4,
        icon = "entities/Evo_Shield_level_4.png",
        capacity = 125,
        evo = -1,
    },
}

function ApexGear.GetGearName(gear)
    if isstring(gear) then gear = ApexGear.Gear[gear]
    elseif isnumber(gear) then gear = ApexGear.Gear[ApexGear.GearID[gear]] end
    if not gear then return "Gear" end

    if gear.name then return gear.name end

    if gear.slot == ApexGear.SLOT_BODY then
        return gear.evo and "Evo Shield" or "Body Shield"
    elseif gear.slot == ApexGear.SLOT_HEAD then
        return "Helmet"
    end

    return "Gear"
end

ApexGear.GearID = {}
ApexGear.GearNum = 0
ApexGear.GearBits = nil

function ApexGear.LoadGear()

    ApexGear.GearID = {}
    ApexGear.GearNum = 0
    ApexGear.GearBits = nil

    for k, v in SortedPairs(ApexGear.Gear) do
        ApexGear.GearNum = ApexGear.GearNum + 1
        ApexGear.GearID[ApexGear.GearNum] = k
        v.id = ApexGear.GearNum
        v.shortname = k

        local ent = {}
        ent.Base = "apex_pickup_base"
        ent.PrintName = ApexGear.GetGearName(v) .. " [" .. v.rarity .. "]"
        ent.Category = "Apex Legends - Gear"
        ent.IconOverride = v.icon
        ent.Spawnable = true
        ent.GearID = ApexGear.GearNum

        function ent:SpawnFunction(ply, tr, class)
            if not tr.Hit then return end

            local ang = ply:EyeAngles()
            ang.p = 0
            ang.y = ang.y + 180

            local e = ents.Create("apex_pickup_base")
            e:SetPos(tr.HitPos + tr.HitNormal * 10)
            e:SetAngles(ang)
            e:SetGearID(ent.GearID)
            if v.capacity then e:SetCapacity(v.capacity) end
            e:Spawn()
            e:Activate()

            return ent
        end

        scripted_ents.Register(ent, "apex_pickup_" .. k)
    end
end

hook.Add("PostGamemodeLoaded", "ApexGear", ApexGear.LoadGear)
ApexGear.LoadGear()