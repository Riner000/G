--// GUI Runtime Hook + Webhook Input
--// Mobile/VNG Friendly

local HttpService = game:GetService("HttpService")

local KEYWORDS = {
    "purchase",
    "buy",
    "confirm",
    "robux",
    "donate"
}

local logged = {}
local WEBHOOK = ""

--========================
-- GUI
--========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WebhookDebugger"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- MAIN

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,420,0,300)
Main.Position = UDim2.new(0.5,-210,0.5,-150)
Main.Parent = ScreenGui

-- TITLE

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "GUI WEBHOOK DEBUGGER"
Title.Parent = Main

-- WEBHOOK BOX

local WebhookBox = Instance.new("TextBox")
WebhookBox.Size = UDim2.new(1,-20,0,35)
WebhookBox.Position = UDim2.new(0,10,0,50)
WebhookBox.PlaceholderText = "Paste Discord Webhook"
WebhookBox.Text = ""
WebhookBox.Parent = Main

-- SAVE BUTTON

local SaveButton = Instance.new("TextButton")
SaveButton.Size = UDim2.new(0,120,0,35)
SaveButton.Position = UDim2.new(0,10,0,95)
SaveButton.Text = "SAVE WEBHOOK"
SaveButton.Parent = Main

-- CONSOLE

local Console = Instance.new("TextBox")
Console.Size = UDim2.new(1,-20,1,-145)
Console.Position = UDim2.new(0,10,0,140)
Console.MultiLine = true
Console.TextWrapped = false
Console.ClearTextOnFocus = false
Console.TextXAlignment = Enum.TextXAlignment.Left
Console.TextYAlignment = Enum.TextYAlignment.Top
Console.TextEditable = false
Console.Text = ""
Console.Parent = Main

--========================
-- SAVE WEBHOOK
--========================

SaveButton.MouseButton1Click:Connect(function()

    WEBHOOK = WebhookBox.Text

    Console.Text =
        Console.Text ..
        "\n[Webhook Saved]\n"

end)

--========================
-- CONSOLE ADD
--========================

local function addConsole(text)

    Console.Text =
        Console.Text ..
        "\n" ..
        text ..
        "\n"

end

--========================
-- SEND WEBHOOK
--========================

local function send(msg)

    if WEBHOOK == "" then
        return
    end

    pcall(function()

        request({
            Url = WEBHOOK,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                content = "```"..msg.."```"
            })
        })

    end)

end

--========================
-- KEYWORD CHECK
--========================

local function hasKeyword(str)

    str = tostring(str):lower()

    for _,k in pairs(KEYWORDS) do
        if str:find(k) then
            return true
        end
    end

    return false
end

--========================
-- CHECK GUI
--========================

local function check(v)

    if logged[v] then
        return
    end

    if not (
        v:IsA("TextLabel")
        or v:IsA("TextButton")
        or v:IsA("ImageButton")
    ) then
        return
    end

    local found = false
    local text = ""

    if hasKeyword(v.Name) then
        found = true
    end

    pcall(function()

        text = v.Text or ""

        if hasKeyword(text) then
            found = true
        end

    end)

    if found then

        logged[v] = true

        local output =
            "Class : "..v.ClassName.."\n" ..
            "Name  : "..v.Name.."\n" ..
            "Path  : "..v:GetFullName().."\n" ..
            "Text  : "..text

        print(output)

        addConsole(output)

        send(output)

    end
end

--========================
-- HOOK GUI
--========================

game.CoreGui.DescendantAdded:Connect(function(v)

    task.defer(function()

        pcall(function()
            check(v)
        end)

    end)

end)

addConsole("GUI Debugger Started")
