--// Script By Summer Studio
--// Mobile/VNG Friendly

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local VisualRobux = 0
local Webhook = ""

local KEYWORDS = {
    "robux",
    "purchase",
    "buy",
    "confirm",
    "donate",
    "gift"
}

--========================
-- GUI
--========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SummerStudioGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

--========================
-- OPEN ICON
--========================

local OpenButton = Instance.new("TextButton")
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0,50,0,50)
OpenButton.Position = UDim2.new(0,20,0.5,-25)
OpenButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
OpenButton.BackgroundTransparency = 0.2
OpenButton.Text = "O"
OpenButton.TextScaled = true
OpenButton.TextColor3 = Color3.new(1,1,1)
OpenButton.BorderSizePixel = 2
OpenButton.BorderColor3 = Color3.fromRGB(120,120,120)

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1,0)
OpenCorner.Parent = OpenButton

--========================
-- MAIN GUI
--========================

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,320,0,260)
Main.Position = UDim2.new(0.5,-160,0.5,-130)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,12)
MainCorner.Parent = Main

-- TITLE

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Script By Summer Studio"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true

-- CLOSE

local Close = Instance.new("TextButton")
Close.Parent = Main
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-35,0,5)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(50,50,50)
Close.TextColor3 = Color3.new(1,1,1)

-- INPUT LABEL

local Label = Instance.new("TextLabel")
Label.Parent = Main
Label.Size = UDim2.new(1,0,0,30)
Label.Position = UDim2.new(0,0,0,60)
Label.BackgroundTransparency = 1
Label.Text = "Nhập số lượng:"
Label.TextColor3 = Color3.new(1,1,1)
Label.TextScaled = true

-- INPUT

local Input = Instance.new("TextBox")
Input.Parent = Main
Input.Size = UDim2.new(0.8,0,0,40)
Input.Position = UDim2.new(0.1,0,0,95)
Input.PlaceholderText = "Robux..."
Input.Text = ""
Input.BackgroundColor3 = Color3.fromRGB(40,40,40)
Input.TextColor3 = Color3.new(1,1,1)
Input.TextScaled = true

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0,10)
InputCorner.Parent = Input

-- RECEIVE BUTTON

local Receive = Instance.new("TextButton")
Receive.Parent = Main
Receive.Size = UDim2.new(0.5,0,0,40)
Receive.Position = UDim2.new(0.25,0,0,150)
Receive.Text = "Nhận"
Receive.BackgroundColor3 = Color3.fromRGB(60,60,60)
Receive.TextColor3 = Color3.new(1,1,1)
Receive.TextScaled = true

local ReceiveCorner = Instance.new("UICorner")
ReceiveCorner.CornerRadius = UDim.new(0,10)
ReceiveCorner.Parent = Receive

-- SUCCESS

local Success = Instance.new("TextLabel")
Success.Parent = Main
Success.Size = UDim2.new(1,0,0,40)
Success.Position = UDim2.new(0,0,1,-45)
Success.BackgroundTransparency = 1
Success.Text = ""
Success.TextColor3 = Color3.fromRGB(0,255,0)
Success.TextScaled = true

-- CONSOLE BUTTON

local ConsoleButton = Instance.new("TextButton")
ConsoleButton.Parent = Main
ConsoleButton.Size = UDim2.new(0,90,0,30)
ConsoleButton.Position = UDim2.new(0.5,-45,0,205)
ConsoleButton.Text = "Console"
ConsoleButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
ConsoleButton.TextColor3 = Color3.new(1,1,1)

local ConsoleCorner = Instance.new("UICorner")
ConsoleCorner.CornerRadius = UDim.new(0,10)
ConsoleCorner.Parent = ConsoleButton

--========================
-- CONSOLE GUI
--========================

local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Parent = ScreenGui
ConsoleFrame.Size = UDim2.new(0,360,0,280)
ConsoleFrame.Position = UDim2.new(0.5,-180,0.5,-140)
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
ConsoleFrame.Visible = false

local ConsoleCorner2 = Instance.new("UICorner")
ConsoleCorner2.CornerRadius = UDim.new(0,12)
ConsoleCorner2.Parent = ConsoleFrame

local ConsoleTitle = Instance.new("TextLabel")
ConsoleTitle.Parent = ConsoleFrame
ConsoleTitle.Size = UDim2.new(1,0,0,40)
ConsoleTitle.BackgroundTransparency = 1
ConsoleTitle.Text = "Webhook Console"
ConsoleTitle.TextScaled = true
ConsoleTitle.TextColor3 = Color3.new(1,1,1)

local ConsoleClose = Instance.new("TextButton")
ConsoleClose.Parent = ConsoleFrame
ConsoleClose.Size = UDim2.new(0,30,0,30)
ConsoleClose.Position = UDim2.new(1,-35,0,5)
ConsoleClose.Text = "X"
ConsoleClose.BackgroundColor3 = Color3.fromRGB(50,50,50)
ConsoleClose.TextColor3 = Color3.new(1,1,1)

local WebhookBox = Instance.new("TextBox")
WebhookBox.Parent = ConsoleFrame
WebhookBox.Size = UDim2.new(0.9,0,0,40)
WebhookBox.Position = UDim2.new(0.05,0,0,55)
WebhookBox.PlaceholderText = "Discord Webhook"
WebhookBox.Text = ""
WebhookBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
WebhookBox.TextColor3 = Color3.new(1,1,1)
WebhookBox.TextScaled = true

local Logs = Instance.new("TextBox")
Logs.Parent = ConsoleFrame
Logs.Size = UDim2.new(0.9,0,0.55,0)
Logs.Position = UDim2.new(0.05,0,0,110)
Logs.Text = ""
Logs.MultiLine = true
Logs.ClearTextOnFocus = false
Logs.TextEditable = false
Logs.TextWrapped = false
Logs.TextXAlignment = Enum.TextXAlignment.Left
Logs.TextYAlignment = Enum.TextYAlignment.Top
Logs.BackgroundColor3 = Color3.fromRGB(30,30,30)
Logs.TextColor3 = Color3.new(1,1,1)

--========================
-- DRAG
--========================

local function makeDrag(gui)

    local dragging = false
    local dragInput
    local dragStart
    local startPos

    gui.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)

        if input == dragInput and dragging then

            local delta = input.Position - dragStart

            gui.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDrag(OpenButton)
makeDrag(Main)
makeDrag(ConsoleFrame)

--========================
-- OPEN/CLOSE
--========================

OpenButton.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

ConsoleButton.MouseButton1Click:Connect(function()
    ConsoleFrame.Visible = not ConsoleFrame.Visible
end)

ConsoleClose.MouseButton1Click:Connect(function()
    ConsoleFrame.Visible = false
end)

--========================
-- RECEIVE
--========================

Receive.MouseButton1Click:Connect(function()

    local amount = tonumber(Input.Text)

    if not amount then
        return
    end

    VisualRobux = amount

    Success.Text =
        "Chúc mừng bạn đã nhận "..amount.." !"

    task.delay(2,function()
        Success.Text = ""
    end)

end)

--========================
-- WEBHOOK
--========================

WebhookBox.FocusLost:Connect(function()
    Webhook = WebhookBox.Text
end)

local function sendWebhook(msg)

    if Webhook == "" then
        return
    end

    pcall(function()

        request({
            Url = Webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                content = msg
            })
        })

    end)

end

--========================
-- PATCH ROBUX GUI
--========================

local function patch(v)

    if not (
        v:IsA("TextLabel")
        or v:IsA("TextButton")
    ) then
        return
    end

    local text = ""

    pcall(function()
        text = v.Text
    end)

    local lower = string.lower(text)

    for _,k in pairs(KEYWORDS) do

        if string.find(lower,k) then

            Logs.Text =
                Logs.Text ..
                "\n["..v.Name.."] "..text

            sendWebhook(
                "["..v.Name.."] "..text
            )

            if v.Name == "ItemCost"
            or v.Name == "RobuxPrice" then

                v.Text =
                '<font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="400">robux</font> '..VisualRobux

            end

            break
        end
    end
end

--========================
-- HOOK GUI
--========================

game.CoreGui.DescendantAdded:Connect(function(v)

    task.defer(function()

        pcall(function()
            patch(v)
        end)

    end)

end)
