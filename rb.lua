--// Roblox GUI Runtime Debugger
--// Mobile/VNG Friendly
--// Debug Window + Copy Button

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local WATCH_CLASSES = {
    TextLabel = true,
    TextButton = true,
    ImageButton = true,
    Frame = true,
    ScreenGui = true,
    ScrollingFrame = true
}

local KEYWORDS = {
    "buy",
    "purchase",
    "robux",
    "confirm",
    "success",
    "gift",
    "donate",
    "premium",
    "prompt",
    "mua",
    "shop"
}

local logs = {}

--========================
-- COPY FUNCTION
--========================

local function copyText(str)

    if setclipboard then
        setclipboard(str)
        print("Copied to clipboard")
    end

end

--========================
-- GUI
--========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RuntimeDebugger"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- OPEN BUTTON

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0,120,0,40)
OpenButton.Position = UDim2.new(0,20,0.5,-20)
OpenButton.Text = "OPEN DEBUG"
OpenButton.Parent = ScreenGui

-- MAIN FRAME

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,500,0,350)
Main.Position = UDim2.new(0.5,-250,0.5,-175)
Main.Visible = false
Main.Parent = ScreenGui

-- TITLE

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "GUI DEBUG CONSOLE"
Title.Parent = Main

-- SCROLL

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-10,1,-50)
Scroll.Position = UDim2.new(0,5,0,45)
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Parent = Scroll

-- TOGGLE

OpenButton.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

--========================
-- ADD LOG
--========================

local function addLog(text)

    table.insert(logs,text)

    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(1,-5,0,90)
    Holder.Parent = Scroll

    local Box = Instance.new("TextLabel")
    Box.Size = UDim2.new(1,-80,1,0)
    Box.TextXAlignment = Enum.TextXAlignment.Left
    Box.TextYAlignment = Enum.TextYAlignment.Top
    Box.TextWrapped = true
    Box.TextScaled = false
    Box.Text = text
    Box.Parent = Holder

    local Copy = Instance.new("TextButton")
    Copy.Size = UDim2.new(0,70,0,30)
    Copy.Position = UDim2.new(1,-75,0,5)
    Copy.Text = "COPY"
    Copy.Parent = Holder

    Copy.MouseButton1Click:Connect(function()
        copyText(text)
    end)

    task.wait()

    Scroll.CanvasSize =
        UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
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
-- DEBUG OBJECT
--========================

local function debugObject(v)

    local text = ""

    pcall(function()
        text = v.Text
    end)

    local output =
        "Class : "..v.ClassName.."\n" ..
        "Name  : "..v.Name.."\n" ..
        "Path  : "..v:GetFullName().."\n" ..
        "Text  : "..text

    print(output)

    addLog(output)
end

--========================
-- CHECK GUI
--========================

local function check(v)

    if not WATCH_CLASSES[v.ClassName] then
        return
    end

    local found = false

    if hasKeyword(v.Name) then
        found = true
    end

    pcall(function()
        if v.Text and hasKeyword(v.Text) then
            found = true
        end
    end)

    if found then
        debugObject(v)
    end
end

--========================
-- EXISTING GUI
--========================

for _,v in pairs(game:GetDescendants()) do
    task.spawn(function()
        check(v)
    end)
end

--========================
-- RUNTIME GUI HOOK
--========================

game.DescendantAdded:Connect(function(v)

    task.wait(0.05)

    pcall(function()
        check(v)
    end)

end)

print("GUI DEBUGGER STARTED")
