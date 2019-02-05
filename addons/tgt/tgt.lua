-------------------------------------------------------------------------------
-- config
-------------------------------------------------------------------------------

_addon.author  = 'lin'
_addon.name    = 'tgt'
_addon.version = '1.0.0'
_addon.unique  = '__tgt_addon'

require 'common'
require 'lin.text'
require 'lin.packets'
require 'ffxi.targets'

require 'tgt_helpers'

local config = { x = 200, y = 200 }

-------------------------------------------------------------------------------
-- event handlers
-------------------------------------------------------------------------------

-- Just a little syntactical sugar. Takes a conditional and two functions, one
-- for when the conditional is truthy and one for falsey.
local function when(cond, t, f)
    if cond then return t()
    else return f() end
end

local function grey()   return 255, 255, 255, 127 end
local function white()  return 250, 235, 215 end
local function black()  return 145,  44, 238 end
local function yellow() return 205, 205, 205 end
local function brown()  return 139, 126, 102 end
local function green()  return 154, 205,  50 end
local function blue()   return  72, 118, 255 end
local function red()    return 205,  55,   0 end
local function cyan()   return 150, 205, 205 end

local debuffs = { }

ashita.register_event('render', function()
    local font = AshitaCore:GetFontManager():Get(_addon.unique)
    local text = { }

    local target = ashita.ffxi.targets.get_target('t')

    -- do we have anything targeted?
    if target ~= nil and target.Name ~= '' and target.TargetIndex ~= 0 then
        local dist = string.format(
            '[%.1fm]',
            math.sqrt(target.Distance))

        local line1 = string.format(
            '%-17.17s %7s',
            target.Name,
            dist)

        local line2 = string.format(
            'HP      %3i%% %s',
            target.HealthPercent,
            lin.percent_bar(12, target.HealthPercent / 100))

        -- Line 3: debuff status icons.
        -- DB PSGB Sh Ra Ch Fr Bu Dr
        -- Other considerations: Poison, Bind, Sleep, Silence

        local tgt_debuffs = debuffs[target.ServerId] or deepCopy(DEFAULT_STATE)
        local line3 = string.format(
            '%s%s %s%s%s%s %s %s %s %s %s %s',
            lin.colorize_text('D',  when(tgt_debuffs.dia, white, grey)),
            lin.colorize_text('B',  when(tgt_debuffs.bio, black, grey)),
            lin.colorize_text('P',  when(tgt_debuffs.para, white, grey)),
            lin.colorize_text('S',  when(tgt_debuffs.slow, white, grey)),
            lin.colorize_text('G',  when(tgt_debuffs.grav, black, grey)),
            lin.colorize_text('B',  when(tgt_debuffs.blind, black, grey)),
            lin.colorize_text('Sh', when(tgt_debuffs.shock, yellow, grey)),
            lin.colorize_text('Ra', when(tgt_debuffs.rasp, brown, grey)),
            lin.colorize_text('Ch', when(tgt_debuffs.choke, green, grey)),
            lin.colorize_text('Fr', when(tgt_debuffs.frost, cyan, grey)),
            lin.colorize_text('Bu', when(tgt_debuffs.burn, red, grey)),
            lin.colorize_text('Dr', when(tgt_debuffs.drown, blue, grey))
        )

        table.insert(text, '')
        table.insert(text, line1)
        table.insert(text, lin.colorize_text(line2, lin.get_hp_color(target.HealthPercent / 100)))
        table.insert(text, line3)
    end

    font:SetText(table.concat(text, '\n'))
end)

ashita.register_event('incoming_packet', function(id, size, data)
    -- clear state on zone changes
    if (id == 0x0A) then
        debuffs = { }
    elseif (id == 0x0028) then
        handle_action(debuffs, lin.parse_action(data))
    elseif (id == 0x0029) then
        handle_basic(debuffs, lin.parse_basic(data))
    end

    return false
end)

ashita.register_event('load', function()
    local font = AshitaCore:GetFontManager():Create(_addon.unique)
    config = ashita.settings.load_merged(_addon.path .. 'settings/settings.json', config)

    font:SetColor(0xFFFFFFFF)
    font:SetFontFamily('Consolas')
    font:SetFontHeight(10)
    font:SetBold(false)
    font:SetPositionX(config.x)
    font:SetPositionY(config.y)
    font:SetVisibility(true)
    font:GetBackground():SetColor(0xA0000000)
    font:GetBackground():SetVisibility(true)
end)

ashita.register_event('unload', function()
    config.x = AshitaCore:GetFontManager():Get(_addon.unique):GetPositionX()
    config.y = AshitaCore:GetFontManager():Get(_addon.unique):GetPositionY()

    AshitaCore:GetFontManager():Delete(_addon.unique)

    ashita.settings.save(_addon.path .. 'settings/settings.json', config)
end)
