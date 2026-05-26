--// Script By Summer Studio
--// Fixed + Optimized Version
--// Roblox Purchase Visual (Visual Only)

--========================================================================
-- SERVICES
--========================================================================

local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

--========================================================================
-- ANTI DUPLICATE INJECT
--========================================================================

if CoreGui:FindFirstChild("SummerStudio_VNG") then
    CoreGui.SummerStudio_VNG:Destroy()
end

--========================================================================
-- REQUEST FALLBACK
--========================================================================

local requestfunc =
    request or
    http_request or
    (syn and syn.request) or
    (fluxus and fluxus.request)

--========================================================================
-- VARIABLES
--========================================================================

local VisualRobux = 0
local LastPrice = 0
local Webhook = ""

--========================================================================
-- MAIN GUI
--========================================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SummerStudio_VNG"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

--========================================================================
-- OPEN BUTTON
--========================================================================

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

--========================================================================
-- MAIN FRAME
--========================================================================

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
Title.Text = "Summer Studio"
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
Label.Text = "Nhập số Robux ảo:"
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

--========================================================================
-- CONSOLE
--========================================================================

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

--========================================================================
-- DRAG
--========================================================================

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

--========================================================================
-- OPEN/CLOSE
--========================================================================

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

--========================================================================
-- UPDATE ROBUX UI
--========================================================================

local function UpdateRobuxUI()
    for _, x in pairs(CoreGui:GetDescendants()) do
        if x:IsA("TextLabel") and x.Name == "RobuxPrice" then
            x.RichText = false
            x.Text = "R$ " .. tostring(VisualRobux)
        end
    end
end

--========================================================================
-- RECEIVE
--========================================================================

Receive.MouseButton1Click:Connect(function()

    local amount = tonumber(Input.Text)

    if not amount then
        Success.Text = "Số không hợp lệ!"
        return
    end

    VisualRobux = amount

    UpdateRobuxUI()

    Success.Text = "Đã nhận " .. amount .. " Robux ảo"

    task.delay(2,function()
        Success.Text = ""
    end)
end)

--========================================================================
-- WEBHOOK
--========================================================================

WebhookBox.FocusLost:Connect(function()
    Webhook = WebhookBox.Text
end)

local function SendWebhook(msg)

    if Webhook == "" then
        return
    end

    if not requestfunc then
        return
    end

    pcall(function()

        requestfunc({
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

--========================================================================
-- PATCH SYSTEM
--========================================================================

local function Patch(v)

    if not v:IsA("TextLabel") then

        if v:IsA("TextButton") and v.Name == "BuyButton" then

            local textLabel = v:FindFirstChild("Text")

            if textLabel then
                v = textLabel
            else
                return
            end

        else
            return
        end
    end

    local text = tostring(v.Text or "")

    -- UPDATE ROBUX DISPLAY

    if v.Name == "RobuxPrice" then
        v.RichText = false
        v.Text = "R$ " .. tostring(VisualRobux)
    end

    -- ITEM COST

    if v.Name == "ItemCost" then

        local cleaned = text:gsub("[^%d]", "")
        local num = tonumber(cleaned)

        if num then

            local parentObj = v.Parent

            if parentObj then
                parentObj:SetAttribute("Price", num)
            end

            LastPrice = num
        end
    end

    -- BUY BUTTON

    if v.Name == "Text"
    and (
        string.find(string.lower(text), "mua")
        or string.find(string.lower(text), "buy")
    ) then

        local buyButton = v.Parent

        if buyButton
        and buyButton:IsA("TextButton")
        and buyButton.Name == "BuyButton" then

            if not buyButton:GetAttribute("Hooked") then

                buyButton:SetAttribute("Hooked", true)

                buyButton.MouseButton1Click:Connect(function()

                    local price =
                        buyButton:GetAttribute("Price")
                        or LastPrice
                        or 0

                    if VisualRobux >= price then

                        VisualRobux = VisualRobux - price

                        task.wait(0.1)

                        UpdateRobuxUI()

                        Logs.Text =
                            Logs.Text ..
                            "\n[SUCCESS] Purchased: " ..
                            tostring(price)

                        SendWebhook(
                            "[SUCCESS] Purchased: " ..
                            tostring(price)
                        )

                        pcall(function()

                            local sheet =
                                buyButton:FindFirstAncestor("Sheet")

                            if not sheet then
                                return
                            end

                            local content =
                                sheet:FindFirstChild("Content")

                            if content then
                                content.Visible = false
                            end

                            local SuccessFrame =
                                Instance.new("Frame")

                            SuccessFrame.Name = "VNGSuccessFrame"
                            SuccessFrame.Size = UDim2.new(1,0,1,0)
                            SuccessFrame.BackgroundTransparency = 1
                            SuccessFrame.Parent = sheet

                            local SuccessTitle =
                                Instance.new("TextLabel")

                            SuccessTitle.Parent = SuccessFrame
                            SuccessTitle.Size = UDim2.new(1,0,0,50)
                            SuccessTitle.Position = UDim2.new(0,0,0.3,0)
                            SuccessTitle.BackgroundTransparency = 1
                            SuccessTitle.Text = "Giao dịch thành công!"
                            SuccessTitle.TextSize = 24
                            SuccessTitle.TextColor3 =
                                Color3.fromRGB(255,255,255)

                            local OkButton =
                                Instance.new("TextButton")

                            OkButton.Parent = SuccessFrame
                            OkButton.Size = UDim2.new(0,120,0,40)
                            OkButton.Position =
                                UDim2.new(0.5,-60,0.5,20)

                            OkButton.Text = "OK"

                            OkButton.BackgroundColor3 =
                                Color3.fromRGB(0,170,255)

                            OkButton.TextColor3 =
                                Color3.fromRGB(255,255,255)

                            local OkCorner =
                                Instance.new("UICorner")

                            OkCorner.CornerRadius = UDim.new(0,8)
                            OkCorner.Parent = OkButton

                            OkButton.MouseButton1Click:Connect(function()

                                local sheetContainer =
                                    buyButton:FindFirstAncestor(
                                        "SheetContainer"
                                    )

                                if sheetContainer then
                                    sheetContainer.Visible = false
                                end

                                SuccessFrame:Destroy()

                                if content then
                                    content.Visible = true
                                end
                            end)
                        end)

                    else

                        Logs.Text =
                            Logs.Text ..
                            "\n[FAILED] Not enough balance"
                    end
                end)
            end
        end
    end
end

--========================================================================
-- INITIAL SCAN
--========================================================================

for _, v in pairs(CoreGui:GetDescendants()) do

    if v:IsA("TextLabel")
    or v:IsA("TextButton") then

        pcall(function()
            Patch(v)
        end)
    end
end

--========================================================================
-- LIVE SCAN
--========================================================================

CoreGui.DescendantAdded:Connect(function(v)

    if not v:IsA("TextLabel")
    and not v:IsA("TextButton") then
        return
    end

    task.defer(function()

        pcall(function()
            Patch(v)
        end)

    end)
end)
