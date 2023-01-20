require 'common'
local chat = require('chat')

local Level30 = {
    Base = {
        Main = "Centurion's Sword",
        Sub = "Parana Shield",
        -- Range = "",
        Ammo = "Morion Tathlum",
        -- Head = "",
        Body = "Ryl.Ftm. Tunic",
        Hands = "Savage Gauntlets",
        Legs = "Dream Pants +1",
        Feet = "Savage Gaiters",
        Neck = "Tiger Stole",
        Waist = "Friar's Rope",
        -- Ear1 = "",
        Ear2 = "Cunning Earring",
        Ring1 = "San d'Orian Ring",
        Ring2 = "Chariot Band",
        Back = "Cotton Cape",
    },
    Rest = {
        Main = "Pilgrim's Wand",
    },
    Tp = {
        -- Main = "",
        -- Sub = "",
        -- Range = "",
        -- Ammo = "",
        -- Head = "",
        -- Body = "",
        Hands = "Ryl.Ftm. Gloves",
        -- Legs = "",
        -- Feet = "",
        -- Neck = "",
        -- Waist = "",
        -- Ear1 = "",
        -- Ear2 = "",
        -- Ring1 = "",
        -- Ring2 = "",
        -- Back = "",
    },
    Str = {
        -- Main = "",
        -- Sub = "",
        -- Range = "",
        -- Ammo = "",
        -- Head = "",
        -- Body = "",
        -- Hands = "",
        -- Legs = "",
        Feet = "Savage Gaiters",
        -- Neck = "",
        -- Waist = "",
        -- Ear1 = "",
        -- Ear2 = "",
        Ring1 = "San d'Orian Ring",
        -- Ring2 = "",
        -- Back = "",
    },
    Dex = {
        -- Main = "",
        -- Sub = "",
        -- Range = "",
        -- Ammo = "",
        -- Head = "",
        -- Body = "",
        -- Hands = "",
        -- Legs = "",
        -- Feet = "",
        -- Neck = "",
        -- Waist = "",
        -- Ear1 = "",
        -- Ear2 = "",
        -- Ring1 = "",
        -- Ring2 = "",
        -- Back = "",
    },
    Int = {
        Main = "Yew Wand",
        -- Sub = "",
        -- Range = "",
        Ammo = "Morion Tathlum",
        -- Head = "",
        Body = "Ryl.Ftm. Tunic",
        -- Hands = "",
        -- Legs = "",
        -- Feet = "",
        Neck = "Black Neckerchief",
        Waist = "Wizard's Belt",
        -- Ear1 = "",
        Ear2 = "Cunning Earring",
        Ring1 = "Hermit's Ring",
        Ring2 = "Hermit's Ring",
        -- Back = "",
    },
    Mnd = {
        Main = "Yew Wand",
        -- Sub = "",
        -- Range = "",
        -- Ammo = "",
        -- Head = "",
        Body = "Ryl.Ftm. Tunic",
        Hands = "Savage Gauntlets",
        -- Legs = "",
        -- Feet = "",
        Neck = "Justice Badge",
        Waist = "Friar's Rope",
        -- Ear1 = "",
        -- Ear2 = "",
        Ring1 = "San d'Orian Ring",
        Ring2 = "Ascetic's Ring",
        -- Back = "",
    },
}

local Level40 = {
    Base = {
        Main = "Fencing Degen",
        Sub = "Parana Shield",
        -- Range = "",
        Ammo = "Morion Tathlum",
        -- Head = "",
        Body = "Savage Separates",
        Hands = "Savage Gauntlets",
        Legs = "Savage Loincloth",
        Feet = "Savage Gaiters",
        Neck = "Tiger Stole",
        Waist = "Friar's Rope",
        -- Ear1 = "",
        Ear2 = "Cunning Earring",
        Ring1 = "San d'Orian Ring",
        Ring2 = "Chariot Band",
        Back = "Cotton Cape",
    },
    Rest = {
        Main = "Pilgrim's Wand",
    },
    Tp = {
        -- Main = "",
        -- Sub = "",
        -- Range = "",
        -- Ammo = "",
        -- Head = "",
        -- Body = "",
        Hands = "Ryl.Ftm. Gloves",
        -- Legs = "",
        -- Feet = "",
        -- Neck = "",
        -- Waist = "",
        -- Ear1 = "",
        -- Ear2 = "",
        -- Ring1 = "",
        -- Ring2 = "",
        -- Back = "",
    },
    Str = {
        -- Main = "",
        -- Sub = "",
        -- Range = "",
        -- Ammo = "",
        -- Head = "",
        Body = "Savage Separates",
        -- Hands = "",
        -- Legs = "",
        Feet = "Savage Gaiters",
        -- Neck = "",
        -- Waist = "",
        -- Ear1 = "",
        -- Ear2 = "",
        Ring1 = "San d'Orian Ring",
        -- Ring2 = "",
        -- Back = "",
    },
    Dex = {
        -- Main = "",
        -- Sub = "",
        -- Range = "",
        -- Ammo = "",
        -- Head = "",
        -- Body = "",
        -- Hands = "",
        -- Legs = "",
        -- Feet = "",
        -- Neck = "",
        -- Waist = "",
        -- Ear1 = "",
        -- Ear2 = "",
        -- Ring1 = "",
        -- Ring2 = "",
        -- Back = "",
    },
    Int = {
        Main = "Fencing Degen",
        -- Sub = "",
        -- Range = "",
        Ammo = "Morion Tathlum",
        -- Head = "",
        Body = "Ryl.Ftm. Tunic",
        -- Hands = "",
        -- Legs = "",
        -- Feet = "",
        Neck = "Black Neckerchief",
        Waist = "Wizard's Belt",
        -- Ear1 = "",
        Ear2 = "Cunning Earring",
        Ring1 = "Hermit's Ring",
        Ring2 = "Hermit's Ring",
        -- Back = "",
    },
    Mnd = {
        Main = "Fencing Degen",
        -- Sub = "",
        -- Range = "",
        -- Ammo = "",
        -- Head = "",
        Body = "Ryl.Ftm. Tunic",
        Hands = "Savage Gauntlets",
        Legs = "Savage Loincloth",
        -- Feet = "",
        Neck = "Justice Badge",
        Waist = "Friar's Rope",
        -- Ear1 = "",
        -- Ear2 = "",
        Ring1 = "San d'Orian Ring",
        Ring2 = "Ascetic's Ring",
        -- Back = "",
    },
}

local profile = {
    Sets = {
        Base = {
            Main = "Fencing Degen",
            Sub = "Parana Shield",
            -- Range = "",
            Ammo = "Morion Tathlum",
            -- Head = "",
            Body = "Savage Separates",
            Hands = "Savage Gauntlets",
            Legs = "Savage Loincloth",
            Feet = "Savage Gaiters",
            Neck = "Tiger Stole",
            Waist = "Friar's Rope",
            -- Ear1 = "",
            Ear2 = "Cunning Earring",
            Ring1 = "San d'Orian Ring",
            Ring2 = "Chariot Band",
            Back = "Cotton Cape",
        },
        Rest = {
            Main = "Pilgrim's Wand",
        },
        Tp = {
            -- Main = "",
            -- Sub = "",
            -- Range = "",
            -- Ammo = "",
            -- Head = "",
            -- Body = "",
            Hands = "Ryl.Ftm. Gloves",
            -- Legs = "",
            -- Feet = "",
            -- Neck = "",
            -- Waist = "",
            -- Ear1 = "",
            -- Ear2 = "",
            -- Ring1 = "",
            -- Ring2 = "",
            -- Back = "",
        },
        Str = {
            -- Main = "",
            -- Sub = "",
            -- Range = "",
            -- Ammo = "",
            -- Head = "",
            Body = "Savage Separates",
            -- Hands = "",
            -- Legs = "",
            Feet = "Savage Gaiters",
            -- Neck = "",
            -- Waist = "",
            -- Ear1 = "",
            -- Ear2 = "",
            Ring1 = "San d'Orian Ring",
            -- Ring2 = "",
            -- Back = "",
        },
        Dex = {
            -- Main = "",
            -- Sub = "",
            -- Range = "",
            -- Ammo = "",
            -- Head = "",
            -- Body = "",
            -- Hands = "",
            -- Legs = "",
            -- Feet = "",
            -- Neck = "",
            -- Waist = "",
            -- Ear1 = "",
            -- Ear2 = "",
            -- Ring1 = "",
            -- Ring2 = "",
            -- Back = "",
        },
        Int = {
            Main = "Fencing Degen",
            -- Sub = "",
            -- Range = "",
            Ammo = "Morion Tathlum",
            -- Head = "",
            Body = "Ryl.Ftm. Tunic",
            -- Hands = "",
            -- Legs = "",
            -- Feet = "",
            Neck = "Black Neckerchief",
            Waist = "Wizard's Belt",
            -- Ear1 = "",
            Ear2 = "Cunning Earring",
            Ring1 = "Hermit's Ring",
            Ring2 = "Hermit's Ring",
            -- Back = "",
        },
        Mnd = {
            Main = "Fencing Degen",
            -- Sub = "",
            -- Range = "",
            -- Ammo = "",
            -- Head = "",
            Body = "Ryl.Ftm. Tunic",
            Hands = "Savage Gauntlets",
            Legs = "Savage Loincloth",
            -- Feet = "",
            Neck = "Justice Badge",
            Waist = "Friar's Rope",
            -- Ear1 = "",
            -- Ear2 = "",
            Ring1 = "San d'Orian Ring",
            Ring2 = "Ascetic's Ring",
            -- Back = "",
        },
        Movement = { },
        Fish = {
            Range = "Bamboo Fish. Rod",
            Ammo = "Insect Ball",
            Hands = "Fsh. Gloves",
        },
        Glamour = {
            Head = nil,
            Body = "Dream Robe",
            Hands = "Dream Mittens +1",
            Legs = "Dream Pants +1",
            Feet = "Dream Boots +1",
        },
    },
    Packer = {
    },
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true
    gSettings.SoloMode = false
    gSettings.FishMode = false

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 2')

    local player = gData.GetPlayer()
    if player.SubJob == 'WHM' then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
    elseif player.SubJob == 'BLM' then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 2')
    elseif player.SubJob == 'THF' then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 3')
    elseif player.SubJob == 'NIN' then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 4')
    end

    AshitaCore:GetChatManager():QueueCommand(1, '/sl self on')
    AshitaCore:GetChatManager():QueueCommand(1, '/sl others on')
    AshitaCore:GetChatManager():QueueCommand(1, '/sl target on')

    ashita.tasks.once(3, function()
        print(chat.header('LAC: RDM'):append(chat.message('setting glamour')))
        AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 19')
        AshitaCore:GetChatManager():QueueCommand(1, '/sl blink')
    end)
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
    if #args == 0 then return end

    if args[1] == 'solo' then
        if (#args == 1 and not gSettings.SoloMode) or (#args == 2 and args[2] == 'on') then
            gSettings.SoloMode = true
            print(chat.header('LAC: RDM'):append(chat.message('enabling solo mode')))
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Main')
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Sub')
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Range')
        elseif (#args == 1 and gSettings.SoloMode) or (#args == 2 and args[2] == 'off') then
            gSettings.SoloMode = false
            print(chat.header('LAC: RDM'):append(chat.message('disabling solo mode')))
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Main')
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Sub')
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Range')
        end
    end

    if args[1] == 'fish' then
        if (#args == 1 and not gSettings.FishMode) or (#args == 2 and args[2] == 'on') then
            gSettings.FishMode = true
            print(chat.header('LAC: RDM'):append(chat.message('enabling fish mode')))
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable')
            gFunc.ForceEquipSet('Fish')
        elseif (#args == 1 and gSettings.FishMode) or (#args == 2 and args[2] == 'off') then
            gSettings.FishMode = false
            print(chat.header('LAC: RDM'):append(chat.message('disabling fish mode')))
            AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable')
        end
    end
end

profile.HandleDefault = function()
    gFunc.EquipSet(Level30.Base)
    gFunc.EquipSet(Level40.Base)
    gFunc.EquipSet('Base')

    local player = gData.GetPlayer()
    if player.IsMoving then
        gFunc.EquipSet('Movement')
    elseif player.Status == 'Resting' then
        gFunc.EquipSet(Level30.Rest)
        gFunc.EquipSet(Level40.Rest)
        gFunc.EquipSet('Rest')
    elseif player.Status == 'Engaged' then
        gFunc.EquipSet(Level30.Tp)
        gFunc.EquipSet(Level40.Tp)
        gFunc.EquipSet('Tp')
    end
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
    local item = gData.GetAction()
    if item.Name == 'Orange Juice' then
        gFunc.Equip('Legs', "Dream Pants +1")
    end
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
    local spell = gData.GetAction()

    if spell.Name == 'Sneak' then
        gFunc.Equip('Feet', "Dream Boots +1")
    elseif spell.Name == 'Invisible' then
        gFunc.Equip('Hands', "Dream Mittens +1")
    elseif spell.Type == 'White Magic' then
        gFunc.EquipSet(Level30.Mnd)
        gFunc.EquipSet(Level40.Mnd)
        gFunc.EquipSet('Mnd')
    elseif spell.Type == 'Black Magic' then
        gFunc.EquipSet(Level30.Int)
        gFunc.EquipSet(Level40.Int)
        gFunc.EquipSet('Int')
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    local weaponskill = gData.GetAction()
    local strSkills = T{ 'Flat Blade', 'Circle Blade', 'Vorpal Blade' }
    local dexSkills = T{ 'Fast Blade' }
    local mndSkills = T{ 'Requiescat' }
    local strMndSkills = T{ 'Shining Blade', 'Seraph Blade', 'Swift Blade', 'Savage Blade', 'Sanguine Blade', 'Knights of Round', 'Death Blossom' }
    local strIntSkills = T{ 'Burning Blade', 'Red Lotus Blade' }
    local hpSkills = T{ 'Spirits Within' }

    if strSkills:contains(weaponskill.Name) then
        gFunc.EquipSet(Level30.Str)
        gFunc.EquipSet(Level40.Str)
        gFunc.EquipSet('Str')
    elseif dexSkills:contains(weaponskill.Name) then
        gFunc.EquipSet(Level30.Dex)
        gFunc.EquipSet(Level40.Dex)
        gFunc.EquipSet('Dex')
    elseif mndSkills:contains(weaponskill.Name) then
        gFunc.EquipSet(Level30.Mnd)
        gFunc.EquipSet(Level40.Mnd)
        gFunc.EquipSet('Mnd')
    elseif strMndSkills:contains(weaponskill.Name) then
        gFunc.EquipSet(Level30.Str)
        gFunc.EquipSet(Level40.Str)
        gFunc.EquipSet('Str')
        gFunc.EquipSet(Level30.Mnd)
        gFunc.EquipSet(Level40.Mnd)
        gFunc.EquipSet('Mnd')
    elseif strIntSkills:contains(weaponskill.Name) then
        gFunc.EquipSet(Level30.Str)
        gFunc.EquipSet(Level40.Str)
        gFunc.EquipSet('Str')
        gFunc.EquipSet(Level30.Int)
        gFunc.EquipSet(Level40.Int)
        gFunc.EquipSet('Int')
    elseif hpSkills:contains(weaponskill.Name) then
    end
end

return profile
