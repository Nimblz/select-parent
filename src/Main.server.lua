-- Select Parent
-- Select the parent of current selection

local Selection = game:GetService("Selection")
local HistoryService = game:GetService("ChangeHistoryService")

local source = script.Parent

local Config = require(source:WaitForChild("Config"))

local pluginToolbar = plugin:CreateToolbar(Config.PLUGIN_NAME)
local pluginButton = pluginToolbar:CreateButton(
    Config.PLUGIN_NAME,
    Config.PLUGIN_DESC,
    Config.PLUGIN_ICON
)
local pluginAction = plugin:CreatePluginAction(
    Config.PLUGIN_ID.."-action",
    Config.PLUGIN_NAME,
    Config.PLUGIN_DESC,
    Config.PLUGIN_ICON
)

local function selectParents()

    local childrenSelection = Selection:Get()

    local parentsIndex = {}
    local newParents = {}

    -- for each child selected, add parent to newParents
    for _,child in pairs(childrenSelection) do
        local parent = child.Parent
        if not parentsIndex[parent] then -- if not already added, track it and add to newParents
            parentsIndex[parent] = true
            table.insert(newParents,parent)
        end
    end

    HistoryService:SetWaypoint("Selecting parents")
    Selection:Set(newParents)
    HistoryService:SetWaypoint("Parents selected")
end

HistoryService:SetEnabled(true)

pluginAction.Triggered:Connect(selectParents)
pluginButton.Click:Connect(selectParents)