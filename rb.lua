-- [[ ROBLOX ADVANCED VISUAL ROBUX & FAKE PURCHASE CONTROL PANEL ]]
if not game:IsLoaded() then game.Loaded:Wait() end

local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- =========================================================================
-- QUẢN LÝ TRẠNG THÁI SỐ DƯ (Số mặc định ban đầu là 9999)
-- =========================================================================
_G.VisualRobuxAmount = 9999 
local PROCESSING_DELAY = 2.0 -- Thời gian xoay vòng chờ (giây)
local SUCCESS_SFX_ID = "rbxassetid://9069609268" -- Âm thanh ăn mừng gốc

local SuccessSound = Instance.new("Sound")
SuccessSound.SoundId = SUCCESS_SFX_ID
SuccessSound.Volume = 0.6
SuccessSound.Parent = SoundService

-- =========================================================================
-- NHÁNH 1: ĐỒNG BỘ SỐ ROBUX VÀO GUI GỐC CỦA ROBLOX (CHẠY 60 LẦN/GIÂY)
-- =========================================================================
local function SynchronizeRobloxNativeGUI()
    local RobloxGui = CoreGui:FindFirstChild("RobloxGui")
    if not RobloxGui then return end
    for _, v in pairs(RobloxGui:GetDescendants()) do
        if v:IsA("TextLabel") then
            if v.Name == "RobuxBalanceText" or v.Name == "CurrentBalance" or v.Name == "BalanceText" then
                v.Text = tostring(_G.VisualRobuxAmount) .. " Robux"
            elseif string.find(v.Text, "Balance:") or string.find(v.Text, "Số dư:") then
                local prefix = string.find(v.Text, "Số dư:") and "Số dư: R$ " or "Balance: R$ "
                v.Text = prefix .. tostring(_G.VisualRobuxAmount)
            end
        end
    end
end
RunService.RenderStepped:Connect(function() pcall(SynchronizeRobloxNativeGUI) end)

-- =========================================================================
-- NHÁNH 2: BẪY CHẶN GIAO DỊCH THẬT & ÉP BẢNG THẬT TRỪ TIỀN ẢO
-- =========================================================================
local MT = getrawmetatable(game)
local Old_Namecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(Self, ...)
    local Args = {...}
    local Method = getnamecallmethod()
    if Self == MarketplaceService and (Method == "PromptGamePassPurchase" or Method == "PromptPurchase" or Method == "PromptProductPurchase") then
        local AssetId = Args[2] or 0
        task.spawn(function()
            task.wait(0.3)
            local RobloxGui = CoreGui:FindFirstChild("RobloxGui")
            if not RobloxGui then return end
            for _, btn in pairs(RobloxGui:GetDescendants()) do
                if btn:IsA("TextButton") and (btn.Name == "ConfirmButton" or string.find(btn.Name:lower(), "buy")) then
                    local ClickSignal
                    ClickSignal = btn.MouseButton1Click:Connect(function()
                        ClickSignal:Disconnect()
                        task.wait(PROCESSING_DELAY) -- Chờ vòng xoay Processing...
                        
                        -- TỰ ĐỘNG TRỪ SỐ ROBUX ẢO ĐI 150 KHI MUA THÀNH CÔNG
                        _G.VisualRobuxAmount = _G.VisualRobuxAmount - 150
                        
                        SuccessSound:Play() -- Phát tiếng chuông "ting"
                        
                        -- Bắn tín hiệu giả ép GUI gốc hiện dấu tích xanh thành công
                        if Method == "PromptGamePassPurchase" then
                            MarketplaceService.PromptGamePassPurchaseFinished:Fire(LocalPlayer, AssetId, true)
                        elseif Method == "PromptProductPurchase" then
                            MarketplaceService.PromptProductPurchaseFinished:Fire(LocalPlayer.UserId, AssetId, true)
                        else
                            MarketplaceService.PromptPurchaseFinished:Fire(LocalPlayer, AssetId, true)
                        end
                    end)
                    break
                end
            end
        end)
        return -- Chặn đứng lệnh mua gốc gửi lên Server để bảo vệ tiền thật
    end
    return Old_Namecall(Self, ...)
end)
setreadonly(MT, true)

-- =========================================================================
-- NHÁNH 3: XÂY DỰNG MENU ĐIỀU KHIỂN TRÊN MÀN HÌNH (GUI ĐÓNG/MỞ KÉO THẢ)
-- =========================================================================
if CoreGui:FindFirstChild("RobuxControlSystem") then CoreGui.RobuxControlSystem:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobuxControlSystem"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- NÚT MỞ MENU
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 80, 0, 35)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 132, 255)
ToggleBtn.Text = "Mở Menu"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleBtn

-- KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Hệ Thống Robux Ảo"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- NÚT ĐÓNG (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame

-- Ô NHẬP SỐ ROBUX
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0, 220, 0, 40)
InputBox.Position = UDim2.new(0, 20, 0, 55)
InputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
InputBox.BorderSizePixel = 0
InputBox.Text = ""
InputBox.PlaceholderText = "Nhập số Robux ảo tại đây..."
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
InputBox.TextSize = 15
InputBox.Font = Enum.Font.SourceSans
InputBox.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 5)
InputCorner.Parent = InputBox

-- NÚT XÁC NHẬN ĐỔI
local ConfirmBtn = Instance.new("TextButton")
ConfirmBtn.Size = UDim2.new(0, 220, 0, 40)
ConfirmBtn.Position = UDim2.new(0, 20, 0, 115)
ConfirmBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 100)
ConfirmBtn.Text = "XÁC NHẬN ĐỔI"
ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmBtn.TextSize = 15
ConfirmBtn.Font = Enum.Font.SourceSansBold
ConfirmBtn.Parent = MainFrame

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 5)
ConfirmCorner.Parent = ConfirmBtn

-- =========================================================================
-- LOGIC ĐÓNG MỞ VÀ CƠ CHẾ KÉO THẢ MƯỢT MÀ (Drag Engine)
-- =========================================================================
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

ConfirmBtn.MouseButton1Click:Connect(function()
    local text = InputBox.Text
    local number = tonumber(text:gsub(",", ""))
    if number then
        _G.VisualRobuxAmount = number
        ConfirmBtn.Text = "ĐÃ ĐỔI THÀNH CÔNG!"
        ConfirmBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        task.wait(1.5)
        ConfirmBtn.Text = "XÁC NHẬN ĐỔI"
        ConfirmBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 100)
    else
        ConfirmBtn.Text = "VUI LÒNG NHẬP SỐ!"
        ConfirmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        task.wait(1.5)
        ConfirmBtn.Text = "XÁC NHẬN ĐỔI"
        ConfirmBtn.BackgroundColor3 = Color3.fromRGB(0, 175, 100)
    end
end)

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)
