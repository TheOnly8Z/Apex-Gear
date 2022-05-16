ApexGear = {}

ApexGear.SLOT_INV = 0
ApexGear.SLOT_BODY = 1
ApexGear.SLOT_HEAD = 2

ApexGear.EFF_IMPROVEDHEAL = 1
ApexGear.EFF_FASTCHARGE = 2

ApexGear.Gear = {

    ["head1"] = {
        slot = ApexGear.SLOT_HEAD,
        rarity = 1,
        hsmult = 0.8,
    },
    ["head2"] = {
        slot = ApexGear.SLOT_HEAD,
        rarity = 2,
        hsmult = 0.5,
    },
    ["head3"] = {
        slot = ApexGear.SLOT_HEAD,
        rarity = 3,
        hsmult = 0.35,
    },
    ["head4"] = {
        slot = ApexGear.SLOT_HEAD,
        rarity = 4,
        hsmult = 0.35,
        effect = ApexGear.EFF_FASTCHARGE,
    },

    ["body1"] = {
        -- name = "My Shield" (names are automatically generated otherwise)
        slot = ApexGear.SLOT_BODY,
        rarity = 1,
        capacity = 50,
        evo = false,
    },
    ["body2"] = {
        slot = ApexGear.SLOT_BODY,
        rarity = 2,
        capacity = 75,
        evo = false,
    },
    ["body3"] = {
        slot = ApexGear.SLOT_BODY,
        rarity = 3,
        capacity = 100,
        evo = false,
    },
    ["body4"] = {
        slot = ApexGear.SLOT_BODY,
        rarity = 4,
        capacity = 100,
        evo = false,
        effect = ApexGear.EFF_IMPROVEDHEAL,
    },

    ["evo0"] = {
        slot = ApexGear.SLOT_BODY,
        rarity = 1,
        capacity = 0,
        evo = 100,
        evonext = "evo1",
    },
    ["evo1"] = {
        slot = ApexGear.SLOT_BODY,
        rarity = 1,
        capacity = 50,
        evo = 150,
        evonext = "evo2",
    },
    ["evo2"] = {
        slot = ApexGear.SLOT_BODY,
        rarity = 2,
        capacity = 75,
        evo = 300,
        evonext = "evo3",
    },
    ["evo3"] = {
        slot = ApexGear.SLOT_BODY,
        rarity = 3,
        capacity = 100,
        evo = 750,
        evonext = "evo4",
    },
    ["evo4"] = {
        slot = ApexGear.SLOT_BODY,
        rarity = 5,
        capacity = 125,
        evo = false,
    },
}

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
        v.ID = ApexGear.GearNum
        v.ShortName = k
    end
end

hook.Add("PostGamemodeLoaded", "ApexGear", ApexGear.LoadGear)