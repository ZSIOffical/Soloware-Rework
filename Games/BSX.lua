local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local GUI = Mercury:Create{
    Name = "BSX [ Soloware BETA ]",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

local Tab = GUI:Tab{
	Name = "Farming",
	Icon = "rbxassetid://8569322835"
}

local Toggled = false
local Eggs = {}
local CurrentSelected;
local AmountToHatchAtATime = 3;
local EggAutoOpen = false
local Pets;
local AutoUpgrade;

for _,v in pairs(game:GetService("ReplicatedStorage").assetObjects.eggs:GetChildren()) do 
    if not Eggs[v.Name] then 
        Eggs[#Eggs+1] = v.Name 
    end
end


Tab:Textbox{
    Name = "How Many eggs to hatch",
    Callback = function(text)
        AmountToHatchAtATime = tonumber(text)
    end
}
Tab:Textbox{
    Name = "Add NPC to farm ( use , to split it ) ",
    Callback = function(text)
        Pets = string.split(text,",")
    end
}
Tab:Textbox{
    Name = "Remove NPC to farm",
    Callback = function(text)
        table.remove(Pets,text)
    end
}


Tab:Dropdown{
    Name = "Presets",
    StartingText = "Select...",
    Description = nil,
    Items = {
        "First World",
        "Second World",
        "Third World",
        "Fourth World",
        "Fith World",
        "Sixth World",
        "Seventh World",
        "Eigth World",
        "Nineth World",
        "Tenth World",
        "Eleventh World",
        "Twelveth World"
    },
    Callback = function(item)
        if string.find(item,"First") then
            Pets = {"Forest Wizard","Mushroom King"}
        elseif string.find(item,"Second") then
            Pets = {"Forest Wizard","Mushroom King","Desert Bandit","Desert Scout"}
        elseif string.find(item,"Third") then
            Pets = {"Desert Bandit","Desert Scout","Floral Girl","Magic Floral Man"}
        elseif string.find(item,"Fourth") then 
            Pets = {"Floral Girl","Magic Floral Man","Onett","Bee King"}
        elseif string.find(item,"Fith") then 
            Pets = {"Onett","Bee King","Ice Skier","Ice Golem"}
        elseif string.find(item,"Sixth") then 
            Pets = {"Ice Skier","Ice Golem","Beach Boy","Pufferfish King"}
        elseif string.find(item,"Seventh") then
            Pets = {"Beach Boy","Pufferfish King","Sparkletime King","Pastel Guardian"}
        elseif string.find(item,"Eigth") then 
            Pets = {"Mining Guy","Elemental King","Lava Lord","Headless Doombringer"} 
        elseif string.find(item,"Tenth") then 
            Pets = {"Lava Lord","Headless Doombringer","Ud'zal","Enchanted Golem"}
        elseif string.find(item,"Eleventh") then 
            Pets = {"Ud'zal","Enchanted Golem","Toxic Sparkletime King","Toxic Wastelander"}  
        elseif string.find(item,"Twelveth") then 
            Pets = {"Toxic Sparkletime King","Toxic Wastelander","Neon Jester","Prince"}  
        end
    end
}

Tab:Dropdown{
    Name = "Select Egg ( Void only )",
    StartingText = "Select...",
    Description = nil,
    Items = Eggs,
    Callback = function(item) 
        CurrentSelected = item
    end
}

Tab:Toggle{
    Name = "Autoopen Egg ( must stand near to the egg )",
    StartingState = false,
    Description = nil,
    Callback = function(state)
        EggAutoOpen = state
    end
}
Tab:Toggle{
    Name = "Farm",
    StartingState = false,
    Description = nil,
    Callback = function(state)
        Toggled = state
    end
}
Tab:Toggle{
    Name = "Autoupgrade",
    StartingState = false,
    Description = nil,
    Callback = function(state)
        AutoUpgrade = state
    end
}

Tab:Button{
    Name = "Antiafk",
    Callback = function()
        local VirtualUser=game:GetService('VirtualUser')
        game:GetService('Players').LocalPlayer.Idled:connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
}


task.spawn(function()
    game:GetService("RunService").Heartbeat:connect(function()
        game:GetService("RunService").Heartbeat:Wait() 
        if Toggled then
            local args = {
                [1] = workspace.npcs:FindFirstChild(Pets[math.random(#Pets)])
            }
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.damageNPC:FireServer(unpack(args))  
        end  
        if AutoUpgrade then
            task.wait(1)
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.unlockRank:FireServer()
        end
        if EggAutoOpen then 
            local args = {
                [1] = "F196388E-0A95-490F-B137-0495057A031B",
                [2] = {[1] = AmountToHatchAtATime,[2] = CurrentSelected,[3] = true}
            }
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("eggs/hatchEgg"):FireServer(unpack(args))
        end
    end)
end)
