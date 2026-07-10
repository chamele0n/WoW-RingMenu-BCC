local RingMenu_AddonName, RingMenu = ...

RingMenu.addonName = RingMenu_AddonName
RingMenu.addonPath = "Interface\\AddOns\\" .. RingMenu_AddonName .. "\\"

function RingMenu.GetAddOnMetadata(field)
    if C_AddOns and C_AddOns.GetAddOnMetadata then
        return C_AddOns.GetAddOnMetadata(RingMenu_AddonName, field)
    end
    if GetAddOnMetadata then
        return GetAddOnMetadata(RingMenu_AddonName, field)
    end
end

function RingMenu.RegisterOptionsPanel(panel)
    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        Settings.RegisterAddOnCategory(category)
        RingMenu.optionsCategoryID = category.ID or (category.GetID and category:GetID()) or panel.name
        return
    end

    if InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel)
    end
end

function RingMenu.OpenOptionsPanel()
    if Settings and Settings.OpenToCategory and RingMenu.optionsCategoryID then
        Settings.OpenToCategory(RingMenu.optionsCategoryID)
        return
    end

    if InterfaceOptionsFrame_OpenToCategory then
        -- Older clients sometimes need two calls to scroll the category into view.
        InterfaceOptionsFrame_OpenToCategory("RingMenu")
        InterfaceOptionsFrame_OpenToCategory("RingMenu")
    end
end

function RingMenu.OpenColorPicker(color, onChanged)
    local previousValues = { color.r, color.g, color.b, color.a }

    local function readColor(restore)
        local r, g, b, a
        if restore then
            if restore.r then
                r, g, b = restore.r, restore.g, restore.b
                a = restore.a or restore.opacity
            else
                r, g, b, a = unpack(restore)
            end
        else
            r, g, b = ColorPickerFrame:GetColorRGB()
            if ColorPickerFrame.GetColorAlpha then
                a = ColorPickerFrame:GetColorAlpha()
            elseif OpacitySliderFrame then
                a = OpacitySliderFrame:GetValue()
            else
                a = color.a
            end
        end

        onChanged({
            r = r,
            g = g,
            b = b,
            a = a or color.a,
        })
    end

    if ColorPickerFrame.SetupColorPickerAndShow then
        ColorPickerFrame:SetupColorPickerAndShow({
            r = color.r,
            g = color.g,
            b = color.b,
            opacity = color.a,
            hasOpacity = true,
            swatchFunc = readColor,
            opacityFunc = readColor,
            cancelFunc = readColor,
        })
        return
    end

    ColorPickerFrame:SetColorRGB(color.r, color.g, color.b)
    ColorPickerFrame.hasOpacity = true
    ColorPickerFrame.opacity = color.a
    ColorPickerFrame.previousValues = previousValues
    ColorPickerFrame.func = readColor
    ColorPickerFrame.opacityFunc = readColor
    ColorPickerFrame.cancelFunc = readColor
    ColorPickerFrame:Hide()
    ColorPickerFrame:Show()
end

function RingMenu.SetActionButtonSlot(button, slot)
    button:SetAttribute("type", "action")
    button:SetAttribute("action", slot)
    button.action = slot

    if ActionButton_UpdateAction then
        pcall(ActionButton_UpdateAction, button, slot)
    elseif ActionButton_Update then
        pcall(ActionButton_Update, button)
    end
end
