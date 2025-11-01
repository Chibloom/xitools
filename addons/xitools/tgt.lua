require('common')
local bit = require('bit')
local imgui = require('imgui')
local ui = require('ui')
local packets = require('utils/packets')

local Scale = 1.0

local shared_dura = {
    BLMDot   = 120,
    Threnody = 120,
}

local Msg = {
    Steps = T{ 519, 520, 521, 591 },
    Debuff = T{ 236, 277, 268, 271 }, --do they need to be seperated? ttimer doesnt...
    Debuffs2 = T{ 237, 267, 278 },
    DiaBio  = T{ 2, 264, 252 },
    Buff = T{ 205, 230, 266, 280, },
}

local StatusType = {
    -- standard fare
    Dia = 'dia',
    Bio = 'bio',
    Paralyze = 'para',
    Slow = 'slow',
    Gravity = 'grav',
    Blind = 'blind',
    Flash = 'flash',
    -- buffs
    Protect = 'protect',
    Shell   = 'shell',
    Regen   = 'regen',
    Blink   = 'blink',
    Shadows = 'shadows',
    Stoneskin = 'stoneskin',
    Refresh = 'refresh',
    Haste   = 'haste',
    Flurry  = 'flurry',
    --storm
    -- utility
    Silence = 'silence',
    Sleep = 'sleep',
    Bind = 'bind',
    Stun = 'stun',
    -- misc
    Virus = 'virus',
    Curse = 'curse',
    Distract = 'distract',
    Frazzle = 'frazzle',
    -- dots
    Poison = 'poison',
    Shock = 'shock',
    Rasp = 'rasp',
    Choke = 'choke',
    Frost = 'frost',
    Burn = 'burn',
    Drown = 'drown',
    --helix
    -- bard stuff
    Requiem = 'requiem',
    Elegy = 'elegy',
    Threnody = 'threnody',
    ThrenodyEle = 'threnodyEle',
}
local ST = StatusType

local ActionMap = {
    [4] = {
        [23]  = { name = 'Dia',           dur = 60,   type = ST.Dia,        over = ST.Bio, 
                     msg  = Msg.DiaBio },
        [24]  = { name = 'Dia II',        dur = 120,  type = ST.Dia,        over = ST.Bio, 
                     msg  = Msg.DiaBio },
        [25]  = { name = 'Dia III',       dur = 150,  type = ST.Dia,        over = ST.Bio, 
                     msg  = Msg.DiaBio },
        [33]  = { name = 'Diaga',         dur = 60,   type = ST.Dia,        over = ST.Bio, 
                     msg  = Msg.DiaBio },
        [34]  = { name = 'Diaga II',      dur = 120,  type = ST.Dia,        over = ST.Bio, 
                     msg  = Msg.DiaBio },
        [230] = { name = 'Bio',           dur = 60,   type = ST.Bio,        over = ST.Dia, 
                     msg  = Msg.DiaBio },
        [231] = { name = 'Bio II',        dur = 120,  type = ST.Bio,        over = ST.Dia, 
                     msg  = Msg.DiaBio },
        [232] = { name = 'Bio III',       dur = 150,  type = ST.Bio,        over = ST.Dia, 
                     msg  = Msg.DiaBio },
        [58]  = { name = 'Paralyze',      dur = 120,  type = ST.Paralyze, 
                     msg  = Msg.Debuff },
        [80]  = { name = 'Paralyze II',   dur = 120,  type = ST.Paralyze, 
                     msg  = Msg.Debuff },
        [356] = { name = 'Paralyzega',    dur = 120,  type = ST.Paralyze, 
                     msg  = Msg.Debuff },
        [341] = { name = 'Jubaku: Ichi',  dur = 180,  type = ST.Paralyze, 
                     msg  = Msg.Debuffs2 },
        [342] = { name = 'Jubaku: Ni',    dur = 300,  type = ST.Paralyze, 
                     msg  = Msg.Debuffs2 },
        [343] = { name = 'Jubaku: San',   dur = 420,  type = ST.Paralyze, 
                     msg  = Msg.Debuffs2 },
        [56]  = { name = 'Slow',          dur = 180,  type = ST.Slow, 
                     msg  = Msg.Debuff },
        [79]  = { name = 'Slow II',       dur = 180,  type = ST.Slow, 
                     msg  = Msg.Debuff },
        [357] = { name = 'Slowga',        dur = 180,  type = ST.Slow, 
                     msg  = Msg.Debuff },
        [344] = { name = 'Hojo: Ichi',    dur = 180,  type = ST.Slow, 
                     msg  = Msg.Debuff },
        [345] = { name = 'Hojo: Ni',      dur = 300,  type = ST.Slow, 
                     msg  = Msg.Debuff },
        [346] = { name = 'Hojo: San',     dur = 420,  type = ST.Slow, 
                     msg  = Msg.Debuff },
        [254] = { name = 'Blind',         dur = 180,  type = ST.Blind, 
                     msg  = Msg.Debuff },
        [276] = { name = 'Blind II',      dur = 180,  type = ST.Blind, 
                     msg  = Msg.Debuff },
        [361] = { name = 'Blindga',       dur = 180,  type = ST.Blind, 
                     msg  = Msg.Debuff },
        [347] = { name = 'Kurayami: Ichi',dur = 180,  type = ST.Blind, 
                     msg  = Msg.Debuff },
        [348] = { name = 'Kurayami: Ni',  dur = 300,  type = ST.Blind, 
                     msg  = Msg.Debuff },
        [349] = { name = 'Kurayami: San', dur = 420,  type = ST.Blind, 
                     msg  = Msg.Debuff },
        [216] = { name = 'Gravity',       dur = 120,  type = ST.Gravity, 
                     msg  = Msg.Debuff },
        [217] = { name = 'Gravity II',    dur = 180,  type = ST.Gravity, 
                     msg  = Msg.Debuff },
        [112] = { name = 'Flash',         dur = 12,   type = ST.Flash, 
                     msg  = Msg.Debuff },
        [59]  = { name = 'Silence',       dur = 120,  type = ST.Silence, 
                     msg  = Msg.Debuff },
        [359] = { name = 'Silencega',     dur = 120,  type = ST.Silence, 
                     msg  = Msg.Debuff },
        [253] = { name = 'Sleep',         dur = 60,   type = ST.Sleep, 
                     msg  = Msg.Debuff },
        [259] = { name = 'Sleep II',      dur = 90,   type = ST.Sleep, 
                     msg  = Msg.Debuff },
        [273] = { name = 'Sleepga',       dur = 60,   type = ST.Sleep, 
                     msg  = Msg.Debuff },
        [274] = { name = 'Sleepga II',    dur = 90,   type = ST.Sleep, 
                     msg  = Msg.Debuff },
        [463] = { name = 'Foe Lullaby',   dur = 60,   type = ST.Sleep, 
                     msg  = Msg.Debuffs2 },
        [376] = { name = 'Horde Lullaby', dur = 60,   type = ST.Sleep, 
                     msg  = Msg.Debuffs2 },
        [258] = { name = 'Bind',          dur = 60,   type = ST.Bind, 
                     msg  = Msg.Debuff },
        [362] = { name = 'Bindga',        dur = 60,   type = ST.Bind, 
                     msg  = Msg.Debuff },
        [252] = { name = 'Stun',          dur = 5,    type = ST.Stun, 
                     msg  = Msg.Debuff },
        [220] = { name = 'Poison',        dur = 90,   type = ST.Poison, 
                     msg  = Msg.Debuff },
        [221] = { name = 'Poison II',     dur = 120,  type = ST.Poison, 
                     msg  = Msg.Debuff },
        [225] = { name = 'Poisonga',      dur = 60,   type = ST.Poison, 
                     msg  = Msg.Debuff },
        [226] = { name = 'Poisonga II',   dur = 120,  type = ST.Poison, 
                     msg  = Msg.Debuff },
        [350] = { name = 'Dokumori: Ichi',dur = 60,   type = ST.Poison, 
                     msg  = Msg.Debuffs2 },
        [351] = { name = 'Dokumori: Ni',  dur = 120,  type = ST.Poison, 
                     msg  = Msg.Debuffs2 },
        [352] = { name = 'Dokumori: San', dur = 360,  type = ST.Poison, 
                     msg  = Msg.Debuffs2 },
        [239] = { name = 'Shock',         dur = shared_dura.BLMDot, type = ST.Shock, over = ST.Drown, 
                     msg  = Msg.Debuffs2 },
        [238] = { name = 'Rasp',          dur = shared_dura.BLMDot, type = ST.Rasp, over = ST.Shock, 
                     msg  = Msg.Debuffs2 },
        [237] = { name = 'Choke',         dur = shared_dura.BLMDot, type = ST.Choke, over = ST.Rasp, 
                     msg  = Msg.Debuffs2 },
        [236] = { name = 'Frost',         dur = shared_dura.BLMDot, type = ST.Frost, over = ST.Choke, 
                     msg  = Msg.Debuffs2 },
        [235] = { name = 'Burn',          dur = shared_dura.BLMDot, type = ST.Burn, over = ST.Frost, 
                     msg  = Msg.Debuffs2 },
        [240] = { name = 'Drown',         dur = shared_dura.BLMDot, type = ST.Drown, over = ST.Burn, 
                     msg  = Msg.Debuffs2 },
        [421] = { name = 'Battlefield Elegy', dur = 150, type = ST.Elegy, 
                     msg  = Msg.Debuffs2 },
        [422] = { name = 'Carnage Elegy',     dur = 250, type = ST.Elegy, 
                     msg  = Msg.Debuffs2 },
        [423] = { name = 'Massacre Elegy',    dur = 350, type = ST.Elegy, 
                     msg  = Msg.Debuffs2 },
        [368] = { name = 'Foe Requiem',       dur = 100, type = ST.Requiem, 
                     msg  = Msg.Debuffs2 },
        [369] = { name = 'Foe Requiem II',    dur = 150, type = ST.Requiem, 
                     msg  = Msg.Debuffs2 },
        [370] = { name = 'Foe Requiem III',   dur = 200, type = ST.Requiem, 
                     msg  = Msg.Debuffs2 },
        [371] = { name = 'Foe Requiem IV',    dur = 250, type = ST.Requiem, 
                     msg  = Msg.Debuffs2 },
        [372] = { name = 'Foe Requiem V',     dur = 300, type = ST.Requiem, 
                     msg  = Msg.Debuffs2 },
        [373] = { name = 'Foe Requiem VI',    dur = 350, type = ST.Requiem, 
                     msg  = Msg.Debuffs2 },
        [374] = { name = 'Foe Requiem VII',   dur = 400, type = ST.Requiem, 
                     msg  = Msg.Debuffs2 },
        [454] = { name = 'Fire Threnody',      dur = shared_dura.Threnody, type = ST.Threnody, 
                     msg  = Msg.Debuffs2, ele = 'fire' },
        [455] = { name = 'Ice Threnody',       dur = shared_dura.Threnody, type = ST.Threnody, 
                     msg  = Msg.Debuffs2, ele = 'ice' },
        [456] = { name = 'Wind Threnody',      dur = shared_dura.Threnody, type = ST.Threnody, 
                     msg  = Msg.Debuffs2, ele = 'wind' },
        [457] = { name = 'Earth Threnody',     dur = shared_dura.Threnody, type = ST.Threnody, 
                     msg  = Msg.Debuffs2, ele = 'earth' },
        [458] = { name = 'Lightning Threnody', dur = shared_dura.Threnody, type = ST.Threnody, 
                     msg  = Msg.Debuffs2, ele = 'lightning' },
        [459] = { name = 'Water Threnody',     dur = shared_dura.Threnody, type = ST.Threnody, 
                     msg  = Msg.Debuffs2, ele = 'water' },
        [460] = { name = 'Light Threnody',     dur = shared_dura.Threnody, type = ST.Threnody, 
                     msg  = Msg.Debuffs2, ele = 'light' },
        [461] = { name = 'Dark Threnody',      dur = shared_dura.Threnody, type = ST.Threnody, 
                     msg  = Msg.Debuffs2, ele = 'dark' },
        [43]  = { name = 'Protect',       dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [44]  = { name = 'Protect II',    dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [45]  = { name = 'Protect III',   dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [46]  = { name = 'Protect IV',    dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [47]  = { name = 'Protect V',     dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [125] = { name = 'Protectra',     dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [126] = { name = 'Protectra II',  dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [127] = { name = 'Protectra III', dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [128] = { name = 'Protectra IV',  dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [129] = { name = 'Protectra V',   dur = 900,  type = ST.Protect, 
                     msg  = Msg.Buff },
        [48]  = { name = 'Shell',         dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [49]  = { name = 'Shell II',      dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [50]  = { name = 'Shell III',     dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [51]  = { name = 'Shell IV',      dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [52]  = { name = 'Shell V',       dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [130] = { name = 'Shellra',       dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [131] = { name = 'Shellra II',    dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [132] = { name = 'Shellra III',   dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [133] = { name = 'Shellra IV',    dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [134] = { name = 'Shellra V',     dur = 900,  type = ST.Shell, 
                     msg  = Msg.Buff },
        [54]  = { name = 'Stoneskin',     dur = 300,  type = ST.Stoneskin, 
                     msg  = Msg.Buff },
        [53]  = { name = 'Blink',         dur = 300,  type = ST.Blink,   over = ST.Shadows,
                     msg  = Msg.Buff },     
        [338] = { name = 'Utsusemi: Ichi',dur = 900,  type = ST.Shadows, over = ST.Blink,
                     msg  = Msg.Buff },
        [339] = { name = 'Utsusemi: Ni',  dur = 900,  type = ST.Shadows, over = ST.Blink,
                     msg  = Msg.Buff },
        [340] = { name = 'Utsusemi: San', dur = 900,  type = ST.Shadows, over = ST.Blink,
                     msg  = Msg.Buff },
        [841] = { name = 'Distract',      dur = 300,  type = ST.Distract, 
                     msg  = Msg.Debuff },
        [842] = { name = 'Distract II',   dur = 300,  type = ST.Distract, 
                     msg  = Msg.Debuff },
        [882] = { name = 'Distract III',  dur = 300,  type = ST.Distract, 
                     msg  = Msg.Debuff },
        [843] = { name = 'Frazzle',       dur = 300,  type = ST.Frazzle, 
                     msg  = Msg.Debuff },
        [844] = { name = 'Frazzle II',    dur = 300,  type = ST.Frazzle, 
                     msg  = Msg.Debuff },
        [883] = { name = 'Frazzle III',   dur = 300,  type = ST.Frazzle, 
                     msg  = Msg.Debuff },
    },
    [14] =  { --jas effects? dnc steps might be too much for me...

        [205] = { name = 'Desperate Flourish',   dur = 120,  type = ST.Gravity, 
                msg  = T{127} }, --yeah, ok wtf
                --"${actor} uses ${ability}.${lb}${target} is ${status}.",
        [207] = { name = 'Violent Flourish',     dur = 5,    type = ST.Stun, 
                msg  = T{522} },
                --"${actor} uses ${ability}.${lb}${target} takes ${number} points of damage and is stunned."
        [168] = { name = 'Blade Bash',           dur = 5,    type = ST.Stun, 
                msg  = T{522} }, --gee i sure hope this works
        [46] = { name = 'Shield Bash',          dur = 5,    type = ST.Stun, 
                msg  = T{522} }, --gee i sure hope this works
        [77] = { name = 'Weapon Bash',          dur = 5,    type = ST.Stun, 
                msg  = T{522} }, --gee i sure hope this works
                
    },
    --god i dont want to think about avatars
    --i dont play blu yet sry
}



-- The state we're operating on is the expiry time of the statuses
local DefaultDebuffs = {
    -- standard fare
    dia = 0,
    bio = 0,
    para = 0,
    slow = 0,
    grav = 0,
    blind = 0,
    flash = 0,
    -- buffs
    protect = 0,
    shell   = 0,
    blink   = 0,
    shadows = 0,
    stoneskin = 0,
    regen   = 0,
    refresh = 0,
    haste   = 0,
    flurry  = 0,
    -- utility
    silence = 0,
    sleep = 0,
    bind = 0,
    stun = 0,
    -- misc
    virus = 0,
    curse = 0,
    distract = 0,
    frazzle = 0,
    -- dots
    poison = 0,
    shock = 0,
    rasp = 0,
    choke = 0,
    frost = 0,
    burn = 0,
    drown = 0,
    -- bard stuff
    requiem = 0,
    elegy = 0,
    threnody = 0,
    threnodyEle = nil,
}

local TrackedEnemies = { }

---@param object table
---@return table
local function DeepCopy(object)
    local lookup_table = {}
    local function _copy(obj)
        if type(obj) ~= "table" then
            return obj
        elseif lookup_table[obj] then
            return lookup_table[obj]
        end
        local new_table = {}
        lookup_table[obj] = new_table
        for index, value in pairs(obj) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(obj))
    end
    return _copy(object)
end

local function GetThrenodyColor(element)
    if element == 'light' then
        return ui.Colors.StatusWhite
    elseif element == 'dark' then
        return ui.Colors.StatusBlack
    elseif element == 'fire' then
        return ui.Colors.StatusRed
    elseif element == 'ice' then
        return ui.Colors.StatusCyan
    elseif element == 'wind' then
        return ui.Colors.StatusGreen
    elseif element == 'earth' then
        return ui.Colors.StatusBrown
    elseif element == 'lightning' then
        return ui.Colors.StatusYellow
    elseif element == 'water' then
        return ui.Colors.StatusBlue
    end
end

---@param debuffs table
---@param action any
local function HandleAction(debuffs, action)
    local now = os.time()

    for _, target in pairs(action.targets) do
        for _, ability in pairs(target.actions) do
            if ActionMap[action.category] then
                local actionId = action.param
                local message = ability.message
                local map = ActionMap[action.category][actionId]

                if map and map.msg:contains(message) then
                    debuffs[target.id] = debuffs[target.id] or DeepCopy(DefaultDebuffs)
                    debuffs[target.id][map.type] = now + map.dur

                    if map.ele then
                        debuffs[target.id][StatusType.ThrenodyEle] = map.ele
                    end

                    if map.over then
                        debuffs[target.id][map.over] = 0
                    end
                end
            end
        end
    end
end

---@param debuffs table
---@param basic table
local function HandleBasic(debuffs, basic)
    if basic.message == 6 and debuffs[basic.target] then
        -- mob died, reset its status
        debuffs[basic.target] = nil
        return
    elseif basic.message ~= 206 or debuffs[basic.target] == nil then
        return
    end

    --https://github.com/Windower/Resources/blob/master/resources_data/buffs.lua
    local ResetMap = {
        [2]   = 'sleep', [19] = 'sleep',
        [3]   = 'poison', [540] = 'poison',
        [4]   = 'para', [566] = 'para',
        [5]   = 'blind',
        [6]   = 'silence',
        [8]   = 'virus',
        [9]   = 'curse', [20] = 'curse',
        [10]  = 'stun',
        [11]  = 'bind',
        [12]  = 'grav', [567] = 'grav',
        [13]  = 'slow', [565] = 'slow',
        [33]  = 'haste', [580] = 'haste',
        [40]  = 'protect',
        [41]  = 'shell',
        [36]  = 'blink', 
        [66]  = 'shadows', [444] = 'shadows', [445] = 'shadows', [446] = 'shadows',
        [37]  = 'stoneskin',
        [42]  = 'regen', [539] = 'regen',
        [43]  = 'refresh', [541] = 'refresh',
        [128] = 'burn',
        [129] = 'frost',
        [130] = 'choke',
        [131] = 'rasp',
        [132] = 'shock',
        [133] = 'drown',
        [134] = 'dia',
        [135] = 'bio',
        [148] = 'distract',
        [404] = 'frazzle',
        [192] = 'requiem',
        [194] = 'elegy',
        [217] = 'threnody',
    }

    local key = ResetMap[basic.param]
    if key then
        debuffs[basic.target][key] = 0
        if key == 'threnody' then
            debuffs[basic.target].threnodyEle = nil
        end
    end
end


---@param name     string
---@param distance number
---@param options  table
local function DrawHeader(name, distance, options)
    imgui.Text(name)

    local dist = string.format('%.1fm', distance)
    local width = imgui.CalcTextSize(dist) + ui.Styles.WindowPadding[1] * Scale

    imgui.SameLine()
    imgui.SetCursorPosX(options.size[1] * Scale - width)
    imgui.Text(dist)
end

---@param hpPercent integer
local function DrawHp(hpPercent)
    local title = string.format('HP %3i%%', hpPercent)
    local textColor = ui.Colors.White
    local barColor = ui.Colors.HpBar

    if hpPercent > 0.75 then
        textColor = ui.Colors.White
    elseif hpPercent > 0.50 then
        textColor = ui.Colors.Yellow
    elseif hpPercent > 0.25 then
        textColor = ui.Colors.Orange
    elseif hpPercent >= 0.00 then
        textColor = ui.Colors.Red
    end

    imgui.PushStyleColor(ImGuiCol_Text, textColor)
    imgui.PushStyleColor(ImGuiCol_PlotHistogram, barColor)
    ui.DrawBar(title, hpPercent, 100, ui.Scale(ui.Styles.BarSize, Scale), '')
    imgui.PopStyleColor(2)
end

local function DrawSeparator()
    imgui.PopStyleVar()
    imgui.Text('')
    imgui.SameLine()
    imgui.PushStyleVar(ImGuiStyleVar_ItemSpacing, { 0, 0 })
end

local function DrawStatusEntry(text, isActive, color)
    if isActive then
        imgui.PushStyleColor(ImGuiCol_Text, color)
    else
        imgui.PushStyleColor(ImGuiCol_Text, ui.Colors.StatusGrey)
    end

    imgui.Text(text)
    imgui.SameLine()
    imgui.PopStyleColor()
end

---@param debuffs table
local function DrawStatus(debuffs)
    local now = os.time()
    imgui.PushStyleVar(ImGuiStyleVar_ItemSpacing, { 0, 0 })
    DrawStatusEntry('Prot',  now < debuffs.protect, ui.Colors.StatusCyan)
    DrawSeparator()
    DrawStatusEntry('Shell',  now < debuffs.shell, ui.Colors.StatusGreen)
    DrawSeparator()
    DrawStatusEntry('SS',  now < debuffs.stoneskin, ui.Colors.StatusBrown)
    DrawSeparator()
    DrawStatusEntry('Blink',  now < debuffs.blink, ui.Colors.StatusGreen)
    DrawSeparator()
    DrawStatusEntry('Shadows',  now < debuffs.shadows, ui.Colors.StatusGreen)
    imgui.NewLine()
    DrawStatusEntry('D',  now < debuffs.dia, ui.Colors.StatusWhite)
    DrawStatusEntry('B',  now < debuffs.bio, ui.Colors.StatusBlack)
    DrawSeparator()
    DrawSeparator()
    DrawStatusEntry('P',  now < debuffs.para, ui.Colors.StatusWhite)
    DrawStatusEntry('S',  now < debuffs.slow, ui.Colors.StatusWhite)
    DrawStatusEntry('E',  now < debuffs.elegy, ui.Colors.StatusBrown)
    DrawStatusEntry('G',  now < debuffs.grav, ui.Colors.StatusBlack)
    DrawStatusEntry('B',  now < debuffs.blind, ui.Colors.StatusBlack)
    DrawStatusEntry('F',  now < debuffs.flash, ui.Colors.StatusWhite)
    DrawSeparator()
    DrawSeparator()
    DrawStatusEntry('Si', now < debuffs.silence, ui.Colors.StatusWhite)
    DrawSeparator()
    DrawStatusEntry('Sl', now < debuffs.sleep, ui.Colors.StatusBlack)
    DrawSeparator()
    DrawStatusEntry('Bi', now < debuffs.bind, ui.Colors.StatusBlack)
    DrawSeparator()
    DrawStatusEntry('Di', now < debuffs.distract, ui.Colors.StatusWhite)
    DrawStatusEntry('Fr', now < debuffs.frazzle, ui.Colors.StatusWhite)
    DrawSeparator()
    DrawStatusEntry('Stun', now < debuffs.stun, ui.Colors.StatusYellow)
    imgui.NewLine()
    DrawStatusEntry('Po', now < debuffs.poison, ui.Colors.StatusBlack)
    DrawSeparator()
    DrawStatusEntry('Rq', now < debuffs.requiem, ui.Colors.StatusWhite)
    DrawSeparator()
    DrawStatusEntry('S',  now < debuffs.shock, ui.Colors.StatusYellow)
    DrawStatusEntry('R',  now < debuffs.rasp, ui.Colors.StatusBrown)
    DrawStatusEntry('C',  now < debuffs.choke, ui.Colors.StatusGreen)
    DrawStatusEntry('F',  now < debuffs.frost, ui.Colors.StatusCyan)
    DrawStatusEntry('B',  now < debuffs.burn, ui.Colors.StatusRed)
    DrawStatusEntry('D',  now < debuffs.drown, ui.Colors.StatusBlue)
    --helix

    if debuffs.threnodyEle ~= nil then
        imgui.NewLine()
        imgui.Text('Threnody: ')
        imgui.SameLine()
        imgui.PushStyleColor(ImGuiCol_Text, GetThrenodyColor(debuffs.threnodyEle))
        imgui.Text(debuffs.threnodyEle)
        imgui.PopStyleColor()
    end

    imgui.PopStyleVar()
end

---@param entity Entity
---@param options table
local function DrawTgt(entity, options)
    DrawHeader(entity.Name, math.sqrt(entity.Distance), options)
    DrawHp(entity.HPPercent)
    if options.showStatus[1] then
        DrawStatus(TrackedEnemies[entity.ServerId] or DefaultDebuffs)
    end
end

---@type xitool
local tgt = {
    Name = 'tgt',
    DefaultSettings = T{
        isEnabled = T{ false },
        isVisible = T{ true },
        showMain = T{ true },
        showSub = T{ false },
        showTot = T{ false },
        mainWindow = T{
            isVisible = T{ true },
            showStatus = T{ false },
            name = 'xitools.tgt.main',
            size = T{ 276, -1 },
            pos = T{ 100, 100 },
            flags = bit.bor(ImGuiWindowFlags_NoDecoration),
        },
        subWindow = T{
            isVisible = T{ true },
            showStatus = T{ false },
            name = 'xitools.tgt.sub',
            size = T{ 276, -1 },
            pos = T{ 100, 200 },
            flags = bit.bor(ImGuiWindowFlags_NoDecoration),
        },
        totWindow = T{
            isVisible = T{ true },
            showStatus = T{ false },
            name = 'xitools.tgt.tot',
            size = T{ 276, -1 },
            pos = T{ 386, 100 },
            flags = bit.bor(ImGuiWindowFlags_NoDecoration),
        },
    },
    HandlePacket = function(e, options)
        -- don't track anything if we're not displaying it
        local showStatus =
            options.mainWindow.showStatus[1] or
            options.subWindow.showStatus[1] or
            options.totWindow.showStatus[1]

        if not showStatus then return end

        -- clear state on zone changes
        -- TODO: clear mob state on death
        if e.id == 0x00A then
            TrackedEnemies = { }
        elseif e.id == 0x028 then
            HandleAction(TrackedEnemies, packets.inbound.action.parse(e.data_raw))
        elseif e.id == 0x029 then
            HandleBasic(TrackedEnemies, packets.inbound.basic.parse(e.data))
        end
    end,
    DrawConfig = function(options, gOptions)
        if imgui.BeginTabItem('tgt') then
            imgui.Checkbox('Enabled', options.isEnabled)

            imgui.Checkbox('Show main target', options.showMain)
            imgui.SameLine()
            imgui.Checkbox('Show debuffs##mt', options.mainWindow.showStatus)

            imgui.Checkbox('Show sub-target', options.showSub)
            imgui.SameLine()
            imgui.Checkbox('Show debuffs##st', options.subWindow.showStatus)

            imgui.Checkbox('Show target of target', options.showTot)
            imgui.SameLine()
            imgui.Checkbox('Show debuffs##tot', options.totWindow.showStatus)

            if imgui.InputInt2('Target position', options.mainWindow.pos) then
                imgui.SetWindowPos(options.mainWindow.name, options.mainWindow.pos)
            end
            if imgui.InputInt2('Sub-target position', options.subWindow.pos) then
                imgui.SetWindowPos(options.subWindow.name, options.subWindow.pos)
            end
            if imgui.InputInt2('Target of target position', options.totWindow.pos) then
                imgui.SetWindowPos(options.totWindow.name, options.totWindow.pos)
            end
            imgui.EndTabItem()
        end
    end,
    DrawMain = function(options, gOptions)
        local tgt = AshitaCore:GetMemoryManager():GetTarget()
        local targetId = tgt:GetTargetIndex(0)
        local targetActive = tgt:GetIsActive(0) == 1
        local subTargetId = tgt:GetTargetIndex(1)
        local subTargetActive = tgt:GetIsSubTargetActive() == 1
        local totId = 0

        -- the target struct appears to be a stack, so when we have two targets
        -- that means the subtarget is actually in [0] and main moves to [1]
        if subTargetActive then
            targetId, subTargetId = subTargetId, targetId
        end

        -- TODO: if no subtarget, check for stpt/stal

        Scale = gOptions.uiScale[1]

        if options.showMain[1] and targetActive and targetId ~= 0 then
            ui.DrawUiWindow(options.mainWindow, gOptions, function()
                imgui.SetWindowFontScale(Scale)

                local entity = GetEntity(targetId)
                DrawTgt(entity, options.mainWindow)
                totId = entity.TargetedIndex or 0
            end)
        end

        if options.showSub[1] and subTargetActive and subTargetId ~= 0 then
            ui.DrawUiWindow(options.subWindow, gOptions, function()
                imgui.SetWindowFontScale(Scale)

                local entity = GetEntity(subTargetId)
                DrawTgt(entity, options.subWindow)
            end)
        end

        if options.showTot[1] and totId ~= 0 then
            -- it's possible for your target to be targeting something that your
            -- client does not know about (even if it has an id for it). ensure
            -- that we actually have all the info before trying to draw anything
            local entity = GetEntity(totId)
            if entity then
                ui.DrawUiWindow(options.totWindow, gOptions, function()
                    imgui.SetWindowFontScale(Scale)

                    -- TODO: compact tot display
                    DrawTgt(entity, options.totWindow)
                end)
            end
        end
    end,
}

return tgt
