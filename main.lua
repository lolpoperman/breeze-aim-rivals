if game.PlaceId == 17625359962 then
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = Rayfield:CreateWindow({
        Name = "Breeze Client | Rivals",
        LoadingTitle = "Loading breeze client",
        LoadingSubtitle = "made by Beezee",
        ConfigurationSaving = {
           Enabled = true,
           FolderName = nil, -- Create a custom folder for your hub/game
           FileName = "Big Hub"
        },
        Discord = {
           Enabled = true,
           Invite = "discord.gg/tATpXktzeT", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
           RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
        KeySystem = true, -- Set this to true to use our key system
        KeySettings = {
           Title = "Da Key boi",
           Subtitle = "Key System",
           Note = "Key Here --> discord.gg/tATpXktzeT",
           FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
           SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
           GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
           Key = {"breezebetter352"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
        }
     })

     local Tab = Window:CreateTab("Visuals", 4483362458) -- Title, Image

     local Toggle = Tab:CreateToggle({
        Name = "Toggle Example",
        CurrentValue = false,
        Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
        -- Preview: https://cdn.discordapp.com/attachments/796378086446333984/818089455897542687/unknown.png
-- Made by Blissful#4992
local Settings = {
    Box_Color = Color3.fromRGB(255, 0, 0),
    Tracer_Color = Color3.fromRGB(255, 0, 0),
    Tracer_Thickness = 1,
    Box_Thickness = 1,
    Tracer_Origin = "Bottom", -- Middle or Bottom if FollowMouse is on this won't matter...
    Tracer_FollowMouse = false,
    Tracers = true
}
local Team_Check = {
    TeamCheck = false, -- if TeamColor is on this won't matter...
    Green = Color3.fromRGB(0, 255, 0),
    Red = Color3.fromRGB(255, 0, 0)
}
local TeamColor = true

--// SEPARATION
local player = game:GetService("Players").LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local mouse = player:GetMouse()

local function NewQuad(thickness, color)
    local quad = Drawing.new("Quad")
    quad.Visible = false
    quad.PointA = Vector2.new(0,0)
    quad.PointB = Vector2.new(0,0)
    quad.PointC = Vector2.new(0,0)
    quad.PointD = Vector2.new(0,0)
    quad.Color = color
    quad.Filled = false
    quad.Thickness = thickness
    quad.Transparency = 1
    return quad
end

local function NewLine(thickness, color)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color 
    line.Thickness = thickness
    line.Transparency = 1
    return line
end

local function Visibility(state, lib)
    for u, x in pairs(lib) do
        x.Visible = state
    end
end

local function ToColor3(col) --Function to convert, just cuz c;
    local r = col.r --Red value
    local g = col.g --Green value
    local b = col.b --Blue value
    return Color3.new(r,g,b); --Color3 datatype, made of the RGB inputs
end

local black = Color3.fromRGB(0, 0 ,0)
local function ESP(plr)
    local library = {
        --//Tracer and Black Tracer(black border)
        blacktracer = NewLine(Settings.Tracer_Thickness*2, black),
        tracer = NewLine(Settings.Tracer_Thickness, Settings.Tracer_Color),
        --//Box and Black Box(black border)
        black = NewQuad(Settings.Box_Thickness*2, black),
        box = NewQuad(Settings.Box_Thickness, Settings.Box_Color),
        --//Bar and Green Health Bar (part that moves up/down)
        healthbar = NewLine(3, black),
        greenhealth = NewLine(1.5, black)
    }

    local function Colorize(color)
        for u, x in pairs(library) do
            if x ~= library.healthbar and x ~= library.greenhealth and x ~= library.blacktracer and x ~= library.black then
                x.Color = color
            end
        end
    end

    local function Updater()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                local HumPos, OnScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local head = camera:WorldToViewportPoint(plr.Character.Head.Position)
                    local DistanceY = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(HumPos.X, HumPos.Y)).magnitude, 2, math.huge)
                    
                    local function Size(item)
                        item.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2)
                        item.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)
                        item.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)
                        item.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2)
                    end
                    Size(library.box)
                    Size(library.black)

                    --//Tracer 
                    if Settings.Tracers then
                        if Settings.Tracer_Origin == "Middle" then
                            library.tracer.From = camera.ViewportSize*0.5
                            library.blacktracer.From = camera.ViewportSize*0.5
                        elseif Settings.Tracer_Origin == "Bottom" then
                            library.tracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y) 
                            library.blacktracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)
                        end
                        if Settings.Tracer_FollowMouse then
                            library.tracer.From = Vector2.new(mouse.X, mouse.Y+36)
                            library.blacktracer.From = Vector2.new(mouse.X, mouse.Y+36)
                        end
                        library.tracer.To = Vector2.new(HumPos.X, HumPos.Y + DistanceY*2)
                        library.blacktracer.To = Vector2.new(HumPos.X, HumPos.Y + DistanceY*2)
                    else 
                        library.tracer.From = Vector2.new(0, 0)
                        library.blacktracer.From = Vector2.new(0, 0)
                        library.tracer.To = Vector2.new(0, 0)
                        library.blacktracer.To = Vector2.new(0, 02)
                    end

                    --// Health Bar
                    local d = (Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2) - Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)).magnitude 
                    local healthoffset = plr.Character.Humanoid.Health/plr.Character.Humanoid.MaxHealth * d

                    library.greenhealth.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                    library.greenhealth.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2 - healthoffset)

                    library.healthbar.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                    library.healthbar.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y - DistanceY*2)

                    local green = Color3.fromRGB(0, 255, 0)
                    local red = Color3.fromRGB(255, 0, 0)

                    library.greenhealth.Color = red:lerp(green, plr.Character.Humanoid.Health/plr.Character.Humanoid.MaxHealth);

                    if Team_Check.TeamCheck then
                        if plr.TeamColor == player.TeamColor then
                            Colorize(Team_Check.Green)
                        else 
                            Colorize(Team_Check.Red)
                        end
                    else 
                        library.tracer.Color = Settings.Tracer_Color
                        library.box.Color = Settings.Box_Color
                    end
                    if TeamColor == true then
                        Colorize(plr.TeamColor.Color)
                    end
                    Visibility(true, library)
                else 
                    Visibility(false, library)
                end
            else 
                Visibility(false, library)
                if game.Players:FindFirstChild(plr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Updater)()
end

for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= player.Name then
        coroutine.wrap(ESP)(v)
    end
end

game.Players.PlayerAdded:Connect(function(newplr)
    if newplr.Name ~= player.Name then
        coroutine.wrap(ESP)(newplr)
    end
end)
        -- The variable (Value) is a boolean on whether the toggle is true or false
        end,
     })
    


     local Tab = Window:CreateTab("Tabfgdsg", 4483362458) -- Title, Image

     local Toggle = Tab:CreateToggle({
        Name = "Toggle Example",
        CurrentValue = false,
        Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            local Camera = workspace.CurrentCamera
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local UserInputService = game:GetService("UserInputService")
            local TweenService = game:GetService("TweenService")
            local LocalPlayer = Players.LocalPlayer
            local Holding = false
            
            _G.AimbotEnabled = true
            _G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
            _G.AimPart = "Head" -- Where the aimbot script would lock at.
            _G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.
            
            _G.CircleSides = 64 -- How many sides the FOV circle would have.
            _G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
            _G.CircleTransparency = 0.7 -- Transparency of the circle.
            _G.CircleRadius = 150 -- Increase the radius of the FOV to make it bigger.
            _G.CircleFilled = false -- Determines whether or not the circle is filled.
            _G.CircleVisible = true -- Determines whether or not the circle is visible.
            _G.CircleThickness = 0 -- The thickness of the circle.
            
            local FOVCircle = Drawing.new("Circle")
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            FOVCircle.Radius = _G.CircleRadius
            FOVCircle.Filled = _G.CircleFilled
            FOVCircle.Color = _G.CircleColor
            FOVCircle.Visible = _G.CircleVisible
            FOVCircle.Radius = _G.CircleRadius
            FOVCircle.Transparency = _G.CircleTransparency
            FOVCircle.NumSides = _G.CircleSides
            FOVCircle.Thickness = _G.CircleThickness
            
            local function GetClosestPlayer()
                local MaximumDistance = _G.CircleRadius
                local Target = nil
            
                for _, v in next, Players:GetPlayers() do
                    if v.Name ~= LocalPlayer.Name then
                        if _G.TeamCheck == true then
                            if v.Team ~= LocalPlayer.Team then
                                if v.Character ~= nil then
                                    if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                        if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                            local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                            
                                            if VectorDistance < MaximumDistance then
                                                Target = v
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if v.Character ~= nil then
                                if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                    if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                        local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                        local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                        
                                        if VectorDistance < MaximumDistance then
                                            Target = v
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            
                return Target
            end
            
            UserInputService.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Holding = true
                end
            end)
            
            UserInputService.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Holding = false
                end
            end)
            
            RunService.RenderStepped:Connect(function()
                FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Filled = _G.CircleFilled
                FOVCircle.Color = _G.CircleColor
                FOVCircle.Visible = _G.CircleVisible
                FOVCircle.Radius = _G.CircleRadius
                FOVCircle.Transparency = _G.CircleTransparency
                FOVCircle.NumSides = _G.CircleSides
                FOVCircle.Thickness = _G.CircleThickness
            
                if Holding == true and _G.AimbotEnabled == true then
                    TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
                end
            end)
        -- The variable (Value) is a boolean on whether the toggle is true or false
        end,
     })

    
    end
    OrionLib:Init()
