local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EarthquakeGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
titleLabel.Text = "Earthquake Controller"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.Parent = frame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Magnitude Input Box
local magnitudeInput = Instance.new("TextBox")
magnitudeInput.Size = UDim2.new(0, 260, 0, 30)
magnitudeInput.Position = UDim2.new(0, 20, 0, 40)
magnitudeInput.PlaceholderText = "Enter Magnitude"
magnitudeInput.Text = ""
magnitudeInput.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
magnitudeInput.TextColor3 = Color3.new(1, 1, 1)
magnitudeInput.Font = Enum.Font.SourceSansBold
magnitudeInput.TextSize = 18
magnitudeInput.Parent = frame

-- Start Button
local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0, 120, 0, 40)
startButton.Position = UDim2.new(0, 20, 0, 90)
startButton.Text = "Start"
startButton.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.Font = Enum.Font.SourceSansBold
startButton.TextSize = 18
startButton.Parent = frame

-- Stop Button
local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(0, 120, 0, 40)
stopButton.Position = UDim2.new(0, 160, 0, 90)
stopButton.Text = "Stop"
stopButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
stopButton.TextColor3 = Color3.new(1, 1, 1)
stopButton.Font = Enum.Font.SourceSansBold
stopButton.TextSize = 18
stopButton.Parent = frame

-- Earthquake Simulation Logic
local earthquakeActive = false
local function startEarthquake(magnitude)
    earthquakeActive = true
    spawn(function()
        while earthquakeActive do
            local offset = Vector3.new(
                math.random(-magnitude, magnitude) * 0.1,
                0,
                math.random(-magnitude, magnitude) * 0.1
            )
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Anchored then
                    part.Position = part.Position + offset
                end
            end
            wait(0.1)
        end
    end)
end

local function stopEarthquake()
    earthquakeActive = false
end

-- Button Actions
startButton.MouseButton1Click:Connect(function()
    local magnitude = tonumber(magnitudeInput.Text)
    if magnitude and magnitude > 0 then
        stopEarthquake() -- Stop any existing earthquake
        startEarthquake(magnitude)
    else
        magnitudeInput.Text = "Invalid Magnitude"
    end
end)

stopButton.MouseButton1Click:Connect(function()
    stopEarthquake()
end)

