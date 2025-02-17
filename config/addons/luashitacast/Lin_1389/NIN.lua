require 'common'
local levelSync = gFunc.LoadFile('common/levelSync.lua')
local handleSoloMode = gFunc.LoadFile('common/soloMode.lua')
local handleFishMode = gFunc.LoadFile('common/fishMode.lua')
local handleHelmMode = gFunc.LoadFile('common/helmMode.lua')
local handleMagic = gFunc.LoadFile('common/magic.lua')
local handleSwordWs = gFunc.LoadFile('common/weaponskills/sword.lua')
local handleDaggerWs = gFunc.LoadFile('common/weaponskills/dagger.lua')
local handleKatanaWs = gFunc.LoadFile('common/weaponskills/katana.lua')

local profile = {
    Sets = {
        -- situational base sets
        Base_Priority = {
            -- Range = {  },
            Ammo = { "Pebble" },
            Head = { "Brass Hairpin" },
            Body = { "Nanban Kariginu" },
            Hands = { "Windurstian Tekko" },
            Legs = { "Republic Subligar" },
            Feet = { "Fed. Kyahan" },
            Neck = { "Tiger Stole" },
            Waist = { "Warlock's Belt" },
            Ear1 = { "Beetle Earring +1" },
            Ear2 = { "Beetle Earring +1" },
            Ring1 = { "San d'Orian Ring" },
            Ring2 = { "Chariot Band" },
            -- Back = {  },
        },
        Rest_Priority = {
        },
        Movement_Priority = {
        },
        Tp_Priority = {
            -- Range = { },
            -- Ammo = { },
            -- Head = { },
            -- Body = { },
            Hands = { "Mrc. Tekko", },
            Legs = { "Mrc. Sitabaki", },
            -- Feet = { },
            -- Neck = { },
            -- Waist = { },
            -- Ear1 = { },
            -- Ear2 = { },
            Ring1 = { "Balance Ring", },
            Ring2 = { "Balance Ring", },
            -- Back = { },
        },
        -- stat bonus sets
        Str_Priority = {
            -- Range = { },
            -- Ammo = { },
            -- Head = { },
            Body = { "Savage Separates" },
            -- Hands = { },
            -- Legs = { },
            Feet = { "Savage Gaiters" },
            Neck = { "Spike Necklace", },
            -- Waist = { },
            -- Ear1 = { },
            -- Ear2 = { },
            Ring1 = { "San d'Orian Ring" },
            -- Ring2 = { },
            -- Back = { },
        },
        Dex_Priority = {
            -- Range = { },
            -- Ammo = { },
            -- Head = { },
            -- Body = { },
            -- Hands = { },
            -- Legs = { },
            -- Feet = { },
            Neck = { "Spike Necklace", },
            -- Waist = { },
            -- Ear1 = { },
            -- Ear2 = { },
            Ring1 = { "Balance Ring" },
            Ring2 = { "Balance Ring" },
            -- Back = { },
        },
        Vit_Priority = {
        },
        Agi_Priority = {
            Neck = { "Wing Pendant" }
        },
        Int_Priority = {
            -- Range = { },
            Ammo = { "Morion Tathlum" },
            -- Head = {  },
            -- Body = {  },
            -- Hands = {  },
            -- Legs = {  },
            -- Feet = {  },
            -- Neck = {  },
            -- Waist = {  },
            -- Ear1 = {  },
            Ear2 = { "Cunning Earring" },
            Ring1 = { "Eremite's Ring" },
            Ring2 = { "Eremite's Ring" },
            -- Back = {  },
        },
        Mnd_Priority = {
            -- Range = { },
            -- Ammo = { },
            -- Head = { },
            -- Body = { },
            Hands = { "Savage Gauntlets" },
            Legs = { "Savage Loincloth" },
            -- Feet = { },
            Neck = { "Justice Badge" },
            Waist = { "Friar's Rope" },
            -- Ear1 = { },
            -- Ear2 = { },
            Ring1 = { "Saintly Ring" },
            Ring2 = { "Saintly Ring" },
            -- Back = { },
        },
        Chr_Priority = {
        },
        -- substat bonus sets
        Acc_Priority = {
        },
        Att_Priority = {
            Hands = { "Ryl.Ftm. Gloves" }
        },
        Eva_Priority = {
        },
        Hp_Priority = {
        },
        Mp_Priority = {
        },
        Interrupt_Priority = {
        },
        -- skill bonus sets
        Healing_Priority = {
        },
        Elemental_Priority = {
        },
        Enhancing_Priority = {
        },
        Enfeebling_Priority = {
        },
        Divine_Priority = {
        },
        Dark_Priority = {
        },
    },
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true
    gSettings.SoloMode = false
    gSettings.FishMode = false
    gSettings.HelmMode = false

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias add /solo /lac fwd solo')
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias add /fishe /lac fwd fish')
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias add /helm /lac fwd helm')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 4')
end

profile.OnUnload = function()
    handleSoloMode('solo off')
    handleFishMode('fish off')
    handleHelmMode('helm off')

    AshitaCore:GetChatManager():QueueCommand(-1, '/alias del /solo')
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias del /fishe')
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias del /helm')
end

profile.HandleCommand = function(args)
    if #args == 0 then return end
    handleSoloMode(args)
    handleFishMode(args)
    handleHelmMode(args)
end

profile.HandleDefault = function()
    local player = gData.GetPlayer()
    levelSync(profile.Sets)

    gFunc.EquipSet('Base')
    if player.Status == 'Resting' then
        gFunc.EquipSet('Rest')
    elseif player.Status == 'Engaged' then
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
    handleMagic(spell)
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    local weaponskill = gData.GetAction()
    handleSwordWs(weaponskill.Name)
    handleDaggerWs(weaponskill.Name)
    handleKatanaWs(weaponskill.Name)
end

return profile
