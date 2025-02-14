require('common')
local bit = require('bit')
local ffi = require('ffi')
local d3d8 = require('d3d8')
local debounce = require('utils.debounce')
local imgui = require('imgui')
local ui = require('ui')

local textures = { }
local inventories = T{ bag = T{}, house = T{}, wardrobe = T{}, gil = 0, }
local gfxDevice = d3d8.get_device()
local fontWidth = imgui.CalcTextSize('A')

local itemTypes = {
    misc = 1,
    weapon = 4,
    armor = 5,
    consumable = 7,
}

local slots = {
    [    1] = 'Main',
    [    2] = 'Sub',
    [    3] = 'Weapon',
    [    4] = 'Range',
    [    8] = 'Ammo',
    [   16] = 'Head',
    [   32] = 'Body',
    [   64] = 'Hands',
    [  128] = 'Legs',
    [  256] = 'Feet',
    [  512] = 'Neck',
    [ 1024] = 'Waist',
    [ 2048] = 'L.Ear',
    [ 4096] = 'R.Ear',
    [ 6144] = 'Earring',
    [ 8192] = 'L.Ring',
    [16384] = 'R.Ring',
    [24576] = 'Ring',
    [32768] = 'Back',
}

local skills = {
    [ 1] = 'Fists',
    [ 2] = 'Dagger',
    [ 3] = 'Sword',
    [ 4] = 'Great Sword',
    [ 5] = 'Axe',
    [ 6] = 'Great Axe',
    [ 7] = 'Scythe',
    [ 8] = 'Polearm',
    [ 9] = 'Katana',
    [10] = 'Great Katana',
    [11] = 'Club',
    [12] = 'Staff',
    [25] = 'Bow',
    [26] = 'Crossbow',
    [27] = 'Throwable',
    -- [28] = 'Guarding',
    -- [29] = 'Evasion',
    [30] = 'Shield',
    -- [31] = 'Parrying',
    -- [32] = 'Divine',
    -- [33] = 'Healing',
    -- [34] = 'Enhancing',
    -- [35] = 'Enfeebling',
    -- [36] = 'Elemental',
    -- [37] = 'Dark',
    -- [38] = 'Summoning',
    -- [39] = 'Ninjutsu',
    [40] = 'Instrument',
    [41] = 'Instrument',
    [42] = 'Instrument',
    -- [43] = 'Blue',
    -- [44] = 'Geomancy',
}

local jobs = {
    [ 1] = 'WAR',
    [ 2] = 'MNK',
    [ 3] = 'WHM',
    [ 4] = 'BLM',
    [ 5] = 'RDM',
    [ 6] = 'THF',
    [ 7] = 'PLD',
    [ 8] = 'DRK',
    [ 9] = 'BST',
    [10] = 'BRD',
    [11] = 'RNG',
    [12] = 'SAM',
    [13] = 'NIN',
    [14] = 'DRG',
    [15] = 'SMN',
    [16] = 'BLU',
    [17] = 'COR',
    [18] = 'PUP',
    [19] = 'DNC',
    [20] = 'SCH',
    [21] = 'GEO',
    [22] = 'RUN',
}

local function FormatGil(number)
    local str = tostring(number)
    local len = #str
    local numSeps = math.ceil((len / 3) - 1)
    local strTbl = str:explode()
    for i = 1, numSeps do
        table.insert(strTbl, len - (3 * i) + 1, ',')
    end
    return strTbl:join('')
end

local function CreateTexture(bitmap, size)
    local c = ffi.C
    local texturePtr = ffi.new('IDirect3DTexture8*[1]')

    local width = 0xFFFFFFFF
    local height = 0xFFFFFFFF
    local mipLevels = 1
    local usage = 0
    local colorKey = 0xFF000000

    local textureSuccess = c.D3DXCreateTextureFromFileInMemoryEx(
        gfxDevice,
        bitmap,
        size,
        width,
        height,
        mipLevels,
        usage,
        c.D3DFMT_A8R8G8B8,
        c.D3DPOOL_MANAGED,
        c.D3DX_DEFAULT,
        c.D3DX_DEFAULT,
        colorKey,
        nil,
        nil,
        texturePtr)

    if textureSuccess == c.S_OK then
        return d3d8.gc_safe_release(ffi.cast('IDirect3DTexture8*', texturePtr[0]))
    else
        return nil
    end
end

local function GetJobs(bitfield)
    if bitfield == 8388606 then
        return T{ 'All jobs' }
    end

    local jobList = T{}
    for i = 1, 23 do
        if bit.band(1, bit.rshift(bitfield, i)) == 1 then
            table.insert(jobList, jobs[i])
        end
    end
    return jobList
end

local function GetSlots(bitfield, skill)
    if bitfield <= 3 then
        return skills[skill]
    else
        return slots[bitfield]
    end
end

local function SortInventory(lhs, rhs)
    if lhs.sortId == rhs.sortId then
        if lhs.id == rhs.id then
            return lhs.stackCur > rhs.stackCur
        end

        return lhs.id < rhs.id
    end

    return lhs.sortId < rhs.sortId
end

local function UpdateInventory(bagId)
    local inv = AshitaCore:GetMemoryManager():GetInventory()
    local res = AshitaCore:GetResourceManager()

    local inventory = T{ }
    local itemCount = inv:GetContainerCountMax(bagId)

    for i = 0, itemCount do
        local invItem = inv:GetContainerItem(bagId, i)
        local itemObj = res:GetItemById(invItem.Id)

        if itemObj ~= nil and invItem.Id ~= 65535 then
            if textures[invItem.Id] == nil then
                textures[invItem.Id] = CreateTexture(itemObj.Bitmap, itemObj.ImageSize)
            end

            local coolItem = {
                id = invItem.Id,
                sortId = itemObj.ResourceId,
                uniqueId = ('%i.%i.%s'):format(bagId, invItem.Index, itemObj.Name[1]),
                type = itemObj.Type,
                flags = itemObj.Flags,
                isUsable = bit.band(1, bit.rshift(itemObj.Flags, 10)) == 1,
                isEquippable = itemObj.Type == 4 or itemObj.Type == 5,
                name = ('%s [%i]'):format(itemObj.LogNameSingular[1], invItem.Id),
                shortName = itemObj.Name[1],
                longName = itemObj.LogNameSingular[1],
                desc = itemObj.Description[1],
                stack = nil,
                stackCur = invItem.Count,
                stackMax = itemObj.StackSize,
                level = nil,
                jobs = nil,
                iconPtr = tonumber(ffi.cast('uint32_t', textures[invItem.Id]))
            }

            if coolItem.stackMax > 1 then
                coolItem.stack = ('%i / %i'):format(coolItem.stackCur, coolItem.stackMax)
            end

            if coolItem.type == itemTypes.armor
            or coolItem.type == itemTypes.weapon then
                local itemSlots = GetSlots(itemObj.Slots, itemObj.Skill)
                local itemJobs = GetJobs(itemObj.Jobs)
                coolItem.level = ('Lv %i %s'):format(itemObj.Level, itemSlots)
                coolItem.jobs = itemJobs:join(', ')
                coolItem.slots = itemObj.Slots
            end

            inventory:append(coolItem)
        end
    end

    return inventory
end

local function UpdateInventories()
    local gil = AshitaCore
        :GetMemoryManager()
        :GetInventory()
        :GetContainerItem(0, 0)
        .Count

    inventories.gil = FormatGil(gil)

    inventories.bag = UpdateInventory(0)
        :sort(SortInventory)

    inventories.wardrobe = UpdateInventory(8)
        :extend(UpdateInventory(10))
        :extend(UpdateInventory(11))
        :extend(UpdateInventory(12))
        :extend(UpdateInventory(13))
        :extend(UpdateInventory(14))
        :extend(UpdateInventory(15))
        :extend(UpdateInventory(16))
        :sort(SortInventory)

    inventories.house = UpdateInventory(1)
        :extend(UpdateInventory(2))
        :sort(SortInventory)
end

local function TryToUse(item)
    if imgui.Selectable('Use') then
        local target = '<me>'

        -- TODO: figure out how to actually target correctly
        if item.id >= 5261 and item.id <= 5263 then
            target = '<bt>'
        end

        AshitaCore:GetChatManager():QueueCommand(1, ('/item "%s" %s'):format(item.shortName, target))
    end
end

local function TryToEquip(item)
    for i = 0, 16 do
        local slot = bit.band(item.slots, bit.lshift(1, i))
        if slot > 0 then
            local target = slots[slot]
            local action = ('Equip to %s'):format(target)
            if imgui.Selectable(action) then
                AshitaCore:GetChatManager():QueueCommand(1, ('/equip %s "%s"'):format(target, item.shortName))
            end
        end
    end
end

local function AddStackSize(posX, posY, count)
    local mainColor = imgui.GetColorU32({ 1, 1, 1, 1 })
    local shadowColor = imgui.GetColorU32({ 0, 0, 0, 1 })
    imgui.GetWindowDrawList():AddText({ posX + 1, posY + 1 }, shadowColor, tostring(count or 0))
    imgui.GetWindowDrawList():AddText({ posX, posY }, mainColor, tostring(count or 0))
end

local function AddHighlight(posX, posY, size, drawList)
    local pad = 2
    local color = imgui.GetColorU32({ 0.23, 0.67, 0.91, 1.0 })
    local upperLeft = { posX - pad, posY - pad }
    local bottomRight = { posX + size + pad, posY + size + pad }
    drawList:AddRect(upperLeft, bottomRight, color, 0.0)
end

local function AddTooltip(item)
    imgui.BeginTooltip()
    imgui.Text(item.name)
    imgui.Text(item.desc)

    if item.stack then
        imgui.Text(item.stack)
    end

    imgui.PushTextWrapPos(fontWidth * 40)
    if item.level then
        imgui.Text(item.level)
    end
    if item.jobs then
        imgui.Text(item.jobs)
    end
    imgui.PopTextWrapPos()

    imgui.EndTooltip()
end

local function AddContextMenu(item)
    local menuOpened = false
    if (item.isUsable or item.isEquippable) and imgui.BeginPopupContextItem(item.uniqueId) then
        menuOpened = true

        if item.isUsable then
            TryToUse(item)
        end

        if item.isEquippable then
            TryToEquip(item)
        end

        if imgui.Selectable('Cancel') then
            imgui.CloseCurrentPopup()
        end

        imgui.EndPopup()
    end

    return menuOpened
end

local function DrawItem(item)
    local iconSize = 32
    local curX, curY = imgui.GetCursorScreenPos()
    local drawList = imgui.GetWindowDrawList()

    imgui.Image(item.iconPtr, { iconSize, iconSize })

    if item.stackMax > 1 then
        AddStackSize(curX, curY, item.stackCur)
    end

    if imgui.IsItemHovered() then
        AddHighlight(curX, curY, iconSize, drawList)
        AddTooltip(item)
    end

    if AddContextMenu(item) then
        AddHighlight(curX, curY, iconSize, drawList)
    end
end

local function DrawBag(bagId)
    local rowLength = 5

    for i, item in ipairs(inventories[bagId]) do
        if i % rowLength ~= 1 then
            imgui.SameLine()
        end

        DrawItem(item)
    end
end

local function DrawInventory()
    imgui.PushStyleVar(ImGuiStyleVar_FramePadding, ui.Styles.FramePaddingSome)
    imgui.Text(('%s G'):format(inventories.gil))

    if imgui.BeginTabBar('xitools.inventories') then
        if imgui.BeginTabItem('bag') then
            DrawBag('bag')
            imgui.EndTabItem()
        end

        if imgui.BeginTabItem('house') then
            DrawBag('house')
            imgui.EndTabItem()
        end

        if imgui.BeginTabItem('wardrobe') then
            DrawBag('wardrobe')
            imgui.EndTabItem()
        end
    end
    imgui.PopStyleVar()
end

---@type xitool
local inv = {
    Name = 'inv',
    Aliases = T{ 'i' },
    DefaultSettings = T{
        name = 'xitools.inventory',
        isEnabled = T{ false },
        isVisible = T{ true },
        size = T{ 0, 0 },
        pos = T{ 256, 256 },
        flags = bit.bor(ImGuiWindowFlags_NoDecoration),
    },
    Load = function()
        if GetPlayerEntity() ~= nil then
            UpdateInventories()
        end
    end,
    HandleCommand = function(args, options)
        if #args == 0 then
            options.isVisible[1] = not options.isVisible[1]
        end
    end,
    HandlePacket = function(e, options)
        if e.id >= 0x01C and e.id <= 0x020 then
            debounce(UpdateInventories)
        end
    end,
    DrawConfig = function(options)
        if imgui.BeginTabItem('inv') then
            if imgui.Checkbox('Enabled', options.isEnabled) and options.isEnabled[1] then
                UpdateInventories()
            end
            imgui.EndTabItem()
        end
    end,
    DrawMain = function(options, gOptions)
        Scale = gOptions.uiScale[1]
        ui.DrawUiWindow(options, gOptions, function()
            imgui.SetWindowFontScale(Scale)
            DrawInventory()
            imgui.End()
        end)
    end,
}

return inv
