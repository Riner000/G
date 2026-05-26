--// Script By Summer Studio
--// Roblox Real Purchase Visual
--// Mobile/VNG Friendly

local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

local VisualRobux = 0
local LastPrice = 0
local Webhook = ""

--========================
-- GUI
--========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SummerStudio"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

--========================
-- OPEN ICON
--========================

local Open = Instance.new("TextButton")
Open.Parent = ScreenGui
Open.Size = UDim2.new(0,55,0,55)
Open.Position = UDim2.new(0,20,0.5,-27)
Open.Text = "O"
Open.TextScaled = true
Open.TextColor3 = Color3.new(1,1,1)
Open.BackgroundColor3 = Color3.fromRGB(35,35,35)
Open.BackgroundTransparency = 0.2
Open.BorderColor3 = Color3.fromRGB(120,120,120)
Open.BorderSizePixel = 2

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1,0)
OpenCorner.Parent = Open

--========================
-- MAIN GUI
--========================

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,320,0,270)
Main.Position = UDim2.new(0.5,-160,0.5,-135)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,12)
MainCorner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Script By Summer Studio"
Title.TextScaled = true
Title.TextColor3 = Color3.new(1,1,1)

local Close = Instance.new("TextButton")
Close.Parent = Main
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-35,0,5)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(45,45,45)

local Label = Instance.new("TextLabel")
Label.Parent = Main
Label.Size = UDim2.new(1,0,0,30)
Label.Position = UDim2.new(0,0,0,60)
Label.BackgroundTransparency = 1
Label.Text = "Nhập số lượng:"
Label.TextScaled = true
Label.TextColor3 = Color3.new(1,1,1)

local Input = Instance.new("TextBox")
Input.Parent = Main
Input.Size = UDim2.new(0.8,0,0,40)
Input.Position = UDim2.new(0.1,0,0,95)
Input.PlaceholderText = "9999"
Input.Text = ""
Input.TextScaled = true
Input.BackgroundColor3 = Color3.fromRGB(35,35,35)
Input.TextColor3 = Color3.new(1,1,1)

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0,10)
InputCorner.Parent = Input

local Receive = Instance.new("TextButton")
Receive.Parent = Main
Receive.Size = UDim2.new(0.5,0,0,40)
Receive.Position = UDim2.new(0.25,0,0,150)
Receive.Text = "Nhận"
Receive.TextScaled = true
Receive.TextColor3 = Color3.new(1,1,1)
Receive.BackgroundColor3 = Color3.fromRGB(50,50,50)

local ReceiveCorner = Instance.new("UICorner")
ReceiveCorner.CornerRadius = UDim.new(0,10)
ReceiveCorner.Parent = Receive

local Success = Instance.new("TextLabel")
Success.Parent = Main
Success.Size = UDim2.new(1,0,0,35)
Success.Position = UDim2.new(0,0,1,-40)
Success.BackgroundTransparency = 1
Success.Text = ""
Success.TextScaled = true
Success.TextColor3 = Color3.fromRGB(0,255,0)

local ConsoleButton = Instance.new("TextButton")
ConsoleButton.Parent = Main
ConsoleButton.Size = UDim2.new(0,90,0,30)
ConsoleButton.Position = UDim2.new(0.5,-45,0,205)
ConsoleButton.Text = "Console"
ConsoleButton.TextColor3 = Color3.new(1,1,1)
ConsoleButton.BackgroundColor3 = Color3.fromRGB(45,45,45)

--========================
-- CONSOLE
--========================

local Console = Instance.new("Frame")
Console.Parent = ScreenGui
Console.Size = UDim2.new(0,360,0,280)
Console.Position = UDim2.new(0.5,-180,0.5,-140)
Console.BackgroundColor3 = Color3.fromRGB(18,18,18)
Console.Visible = false

local ConsoleCorner = Instance.new("UICorner")
ConsoleCorner.CornerRadius = UDim.new(0,12)
ConsoleCorner.Parent = Console

local ConsoleTitle = Instance.new("TextLabel")
ConsoleTitle.Parent = Console
ConsoleTitle.Size = UDim2.new(1,0,0,40)
ConsoleTitle.BackgroundTransparency = 1
ConsoleTitle.Text = "Webhook Console"
ConsoleTitle.TextScaled = true
ConsoleTitle.TextColor3 = Color3.new(1,1,1)

local ConsoleClose = Instance.new("TextButton")
ConsoleClose.Parent = Console
ConsoleClose.Size = UDim2.new(0,30,0,30)
ConsoleClose.Position = UDim2.new(1,-35,0,5)
ConsoleClose.Text = "X"
ConsoleClose.TextColor3 = Color3.new(1,1,1)
ConsoleClose.BackgroundColor3 = Color3.fromRGB(45,45,45)

local WebhookBox = Instance.new("TextBox")
WebhookBox.Parent = Console
WebhookBox.Size = UDim2.new(0.9,0,0,40)
WebhookBox.Position = UDim2.new(0.05,0,0,55)
WebhookBox.PlaceholderText = "Discord Webhook"
WebhookBox.Text = ""
WebhookBox.TextScaled = true
WebhookBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
WebhookBox.TextColor3 = Color3.new(1,1,1)

local Logs = Instance.new("TextBox")
Logs.Parent = Console
Logs.Size = UDim2.new(0.9,0,0.55,0)
Logs.Position = UDim2.new(0.05,0,0,110)
Logs.MultiLine = true
Logs.TextEditable = false
Logs.ClearTextOnFocus = false
Logs.TextWrapped = false
Logs.TextXAlignment = Enum.TextXAlignment.Left
Logs.TextYAlignment = Enum.TextYAlignment.Top
Logs.BackgroundColor3 = Color3.fromRGB(30,30,30)
Logs.TextColor3 = Color3.new(1,1,1)

--========================
-- DRAG
--========================

local function Drag(gui)

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

    UIS.InputChanged:Connect(function(input)

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

Drag(Open)
Drag(Main)
Drag(Console)

--========================
-- OPEN/CLOSE
--========================

Open.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

ConsoleButton.MouseButton1Click:Connect(function()
    Console.Visible = not Console.Visible
end)

ConsoleClose.MouseButton1Click:Connect(function()
    Console.Visible = false
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

local function SendWebhook(msg)

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
-- PATCH
--========================

local function Patch(v)

    if not v:IsA("TextLabel") then
        return
    end

    local text = v.Text or ""

    -- ROBUX BALANCE

    if v.Name == "RobuxPrice" then

        v.RichText = true

        v.Text =
        '<font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="400">robux</font> '..VisualRobux

    end

    -- ITEM PRICE

    if v.Name == "ItemCost" then

        local num = tonumber(
            string.match(text,"%d+")
        )

        if num then
            LastPrice = num
        end

    end

    -- BUY BUTTON

    if v.Name == "ButtonText" then

        if string.find(
            string.lower(text),
            "mua"
        ) then

            local button = v.Parent

            if button and button:IsA("TextButton") then

                button.MouseButton1Click:Connect(function()

                    if VisualRobux >= LastPrice then

                        VisualRobux =
                        VisualRobux - LastPrice

                        task.wait(0.2)

                        for _,x in pairs(CoreGui:GetDescendants()) do

                            if x:IsA("TextLabel")
                            and x.Name == "RobuxPrice" then

                                x.RichText = true

                                x.Text =
                                '<font family="rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json" weight="400">robux</font> '..VisualRobux

                            end
                        end

                        Logs.Text =
                        Logs.Text ..
                        "\n[FAKE PURCHASE] "..LastPrice

                        SendWebhook(
                            "[FAKE PURCHASE] "..LastPrice
                        )

                    end
                end)
            end
        end
    end
end

--========================
-- HOOK
--========================

game.CoreGui.DescendantAdded:Connect(function(v)

    task.defer(function()

        pcall(function()
            Patch(v)
        end)

    end)

end)
