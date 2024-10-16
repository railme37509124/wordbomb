local gui_data = {}

local TweenService = game:GetService("TweenService")
local RS = game:GetService("RunService")
local ps = game:GetService("Players")

local function Resize(part, new, _delay)
	_delay = _delay or 0.5
	local tweenInfo = TweenInfo.new(_delay, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(part, tweenInfo, new)
	tween:Play()
end

local function ripple(button, x, y)
	spawn(function()
		button.ClipsDescendants = true
		local circle = Instance.new("ImageLabel")
		circle.Name = "Circle"
		circle.Parent = button
		circle.BackgroundColor3 = Color3.new(1, 1, 1)
		circle.BackgroundTransparency = 1
		circle.Image = "rbxassetid://266543268"
		circle.ImageTransparency = 0.5

		circle.Parent = button
		circle.ZIndex = 1000

		local new_x = x - circle.AbsolutePosition.X
		local new_y = y - circle.AbsolutePosition.Y
		circle.Position = UDim2.new(0, new_x, 0, new_y)

		local size = 0
		if button.AbsoluteSize.X > button.AbsoluteSize.Y then
			size = button.AbsoluteSize.X * 1.5
		elseif button.AbsoluteSize.X < button.AbsoluteSize.Y then
			size = button.AbsoluteSize.Y * 1.5
		elseif button.AbsoluteSize.X == button.AbsoluteSize.Y then
			size = button.AbsoluteSize.X * 1.5
		end

		circle:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, -size / 2, 0.5, -size / 2), "Out", "Quad", 0.5, false, nil)
		Resize(circle, {ImageTransparency = 1}, 0.5)

		wait(0.5)
		circle:Destroy()
	end)
end

local UIS = game:GetService("UserInputService")
function dragify(Frame)
	dragToggle = nil
	dragSpeed = 0
	dragInput = nil
	dragStart = nil
	dragPos = nil
	function updateInput(input)
		Delta = input.Position - dragStart
		Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
		game:GetService("TweenService"):Create(Frame, TweenInfo.new(dragSpeed), {Position = Position}):Play()
	end
	Frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	Frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			updateInput(input)
		end
	end)
end

function gui_data:MakeWindow(title, size)
	local FanumGUI = Instance.new("ScreenGui")
	local topbar = Instance.new("Frame")
	local topbarTitle = Instance.new("TextLabel")
	local minimize = Instance.new("ImageButton")
	local contents = Instance.new("Frame")
	local secdata = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local seccontent = Instance.new("Frame")

	FanumGUI.Name = "FanumGUI"
	FanumGUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	FanumGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	topbar.Name = "topbar"
	topbar.Parent = FanumGUI
	topbar.AnchorPoint = Vector2.new(0.5, 0.5)
	topbar.BackgroundColor3 = Color3.fromRGB(9, 10, 10)
	topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	topbar.BorderSizePixel = 0
	topbar.Position = UDim2.new(0.498746067, 0, 0.495530725, 0)
	topbar.Size = UDim2.new(0, size.x or 380, 0, 19)
	topbar.ZIndex = 2

	topbarTitle.Name = "topbarTitle"
	topbarTitle.Parent = topbar
	topbarTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	topbarTitle.BackgroundTransparency = 1.000
	topbarTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	topbarTitle.BorderSizePixel = 0
	topbarTitle.Position = UDim2.new(0, 29, 0, 0)
	topbarTitle.Size = UDim2.new(0, 170, 0, 18)
	topbarTitle.Font = Enum.Font.RobotoMono
	topbarTitle.Text = title
	topbarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	topbarTitle.TextSize = 14.000
	topbarTitle.TextXAlignment = Enum.TextXAlignment.Left

	minimize.Name = "minimize"
	minimize.Parent = topbar
	minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	minimize.BackgroundTransparency = 1.000
	minimize.BorderColor3 = Color3.fromRGB(0, 0, 0)
	minimize.BorderSizePixel = 0
	minimize.Position = UDim2.new(0, 6, 0, 2)
	minimize.Rotation = 90.000
	minimize.Size = UDim2.new(0, 16, 0, 16)
	minimize.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"
	minimize.ImageColor3 = Color3.fromRGB(225, 225, 225)

	contents.Name = "contents"
	contents.Parent = topbar
	contents.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
	contents.BackgroundTransparency = 0.100
	contents.BorderColor3 = Color3.fromRGB(0, 0, 0)
	contents.BorderSizePixel = 0
	contents.Position = UDim2.new(0, 0, 1, 0)
	contents.Size = UDim2.new(1, 0, 1.89473689, size.y or 269)
	contents.ClipsDescendants = true

	secdata.Name = "secdata"
	secdata.Parent = contents
	secdata.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	secdata.BackgroundTransparency = 1.000
	secdata.BorderColor3 = Color3.fromRGB(0, 0, 0)
	secdata.BorderSizePixel = 0
	secdata.ClipsDescendants = true
	secdata.Size = UDim2.new(0, 384, 0, 18)

	UIListLayout.Parent = secdata
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 2)

	seccontent.Name = "seccontent"
	seccontent.Parent = contents
	seccontent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	seccontent.BackgroundTransparency = 1.000
	seccontent.BorderColor3 = Color3.fromRGB(0, 0, 0)
	seccontent.BorderSizePixel = 0
	seccontent.Position = UDim2.new(0, 0, 0, 25)
	seccontent.Size = UDim2.new(0, 384, 1, -25)
	
	local minimized = false
	minimize.MouseButton1Click:Connect(function()
		minimized = not minimized
		game:GetService("TweenService"):Create(minimize, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Rotation = minimized and 0 or 90}):Play()
		game:GetService("TweenService"):Create(contents, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Size = minimized and UDim2.new(1, 0, 0, 0) or UDim2.new(1, 0, 1.895, size.y or 269)}):Play()
	end)
	
	dragify(topbar)
	
	function gui_data:AddTab(title)
		tab_data = {}
		
		local Page = Instance.new("ScrollingFrame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local Tab1 = Instance.new("TextButton")
		
		Page.Name = "Page"
		Page.Parent = seccontent
		Page.Active = true
		Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Page.BackgroundTransparency = 1.000
		Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Page.BorderSizePixel = 0
		Page.Position = UDim2.new(0, 13, 0, 0)
		Page.Size = UDim2.new(0.95599997, -15, 1, -5)
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.ScrollBarThickness = 0
		Page.Visible = false
		Page.AutomaticCanvasSize = Enum.AutomaticSize.Y

		UIListLayout_2.Parent = Page
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 5)

		Tab1.Name = "Tab1"
		Tab1.Parent = secdata
		Tab1.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
		Tab1.BackgroundTransparency = 0.5
		Tab1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab1.BorderSizePixel = 0
		Tab1.AutoButtonColor = false
		Tab1.Font = Enum.Font.RobotoMono
		Tab1.Text = " "..title.." "
		Tab1.TextColor3 = Color3.fromRGB(163, 163, 163)
		Tab1.TextSize = 14.000
		Tab1.Size = UDim2.new(0, Tab1.TextBounds.X + 22, 0, 18)
		
		Tab1.MouseButton1Click:Connect(function()
			for _, v in secdata:GetChildren() do
				if not v:IsA("TextButton") then continue end
				v.TextColor3 = Color3.fromRGB(163, 163, 163)
			end
			for _, v in seccontent:GetChildren() do
				if not v:IsA("ScrollingFrame") then continue end
				v.Visible = false
			end
			Tab1.TextColor3 = Color3.fromRGB(217, 217, 217)
			Page.Visible = true
		end)
		
		function tab_data:AddSwitch(title, callback, default)
			local createdtoggle = Instance.new("Frame")
			local callbackfunctoggle = Instance.new("TextButton")
			local tUICorner = Instance.new("UICorner")
			local togglename = Instance.new("TextLabel")

			createdtoggle.Name = "createdtoggle"
			createdtoggle.Parent = Page
			createdtoggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			createdtoggle.BackgroundTransparency = 1.000
			createdtoggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			createdtoggle.BorderSizePixel = 0
			createdtoggle.Size = UDim2.new(0, 199, 0, 23)

			callbackfunctoggle.Name = "callbackfunctoggle"
			callbackfunctoggle.Parent = createdtoggle
			callbackfunctoggle.BackgroundColor3 = Color3.fromRGB(31, 48, 73)
			callbackfunctoggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			callbackfunctoggle.BorderSizePixel = 0
			callbackfunctoggle.Size = UDim2.new(0, 23, 0, 23)
			callbackfunctoggle.AutoButtonColor = false
			callbackfunctoggle.Font = Enum.Font.SourceSans
			callbackfunctoggle.Text = ""
			callbackfunctoggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			callbackfunctoggle.TextSize = 18.000

			tUICorner.CornerRadius = UDim.new(0, 5)
			tUICorner.Parent = callbackfunctoggle

			togglename.Name = "togglename"
			togglename.Parent = createdtoggle
			togglename.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			togglename.BackgroundTransparency = 1.000
			togglename.BorderColor3 = Color3.fromRGB(0, 0, 0)
			togglename.BorderSizePixel = 0
			togglename.Position = UDim2.new(0.17085427, 0, 0, 0)
			togglename.Size = UDim2.new(0, 0, 0, 23)
			togglename.Font = Enum.Font.RobotoMono
			togglename.Text = title
			togglename.TextColor3 = Color3.fromRGB(255, 255, 255)
			togglename.TextSize = 14.000
			togglename.TextXAlignment = Enum.TextXAlignment.Left
			
			local toggled = false
			local function toggleonclick()
				toggled = not toggled
				callbackfunctoggle.Text = toggled and utf8.char(10003) or ""
				callback(toggled)
			end
			if default == true then toggleonclick() end
			callbackfunctoggle.MouseButton1Click:Connect(toggleonclick)
		end
		
		function tab_data:AddButton(title, callback)
			local createdbutton = Instance.new("TextButton")
			local bUICorner = Instance.new("UICorner")

			createdbutton.Name = "createdbutton"
			createdbutton.Parent = Page
			createdbutton.BackgroundColor3 = Color3.fromRGB(41, 74, 122)
			createdbutton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			createdbutton.BorderSizePixel = 0
			createdbutton.Position = UDim2.new(0, 0, 0.125560537, 0)
			createdbutton.AutoButtonColor = false
			createdbutton.Font = Enum.Font.RobotoMono
			createdbutton.Text = title
			createdbutton.TextColor3 = Color3.fromRGB(255, 255, 255)
			createdbutton.TextSize = 14.000

			bUICorner.CornerRadius = UDim.new(0, 5)
			bUICorner.Parent = createdbutton
			
			createdbutton.MouseButton1Click:Connect(function()
				spawn(callback)
				local mouse = ps.LocalPlayer:GetMouse()
				ripple(createdbutton, mouse.X, mouse.Y)
			end)
			task.spawn(function() repeat createdbutton.Size = UDim2.new(0, createdbutton.TextBounds.X + 15, 0, 20) task.wait() until nil end)
		end
		
		function tab_data:AddKeybind(title, callback, default)
			local keybind = Instance.new("Frame")
			local kUICorner = Instance.new("UICorner")
			local keybindname = Instance.new("TextLabel")
			local choosebind = Instance.new("TextButton")
			local kUICorner2 = Instance.new("UICorner")

			keybind.Name = "keybind"
			keybind.Parent = Page
			keybind.BackgroundColor3 = Color3.fromRGB(52, 53, 56)
			keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
			keybind.BorderSizePixel = 0
			keybind.Position = UDim2.new(0, 0, 0.192727268, 0)
			keybind.Size = UDim2.new(0, 214, 0, 23)

			kUICorner.CornerRadius = UDim.new(0, 5)
			kUICorner.Name = "kUICorner"
			kUICorner.Parent = keybind

			keybindname.Name = "keybindname"
			keybindname.Parent = keybind
			keybindname.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			keybindname.BackgroundTransparency = 1.000
			keybindname.BorderColor3 = Color3.fromRGB(0, 0, 0)
			keybindname.BorderSizePixel = 0
			keybindname.Size = UDim2.new(0, 112, 0, 23)
			keybindname.Font = Enum.Font.RobotoMono
			keybindname.Text = " "..title
			keybindname.TextColor3 = Color3.fromRGB(255, 255, 255)
			keybindname.TextSize = 14.000
			keybindname.TextXAlignment = Enum.TextXAlignment.Left

			choosebind.Name = "choosebind"
			choosebind.Parent = keybind
			choosebind.BackgroundColor3 = Color3.fromRGB(74, 75, 80)
			choosebind.BorderColor3 = Color3.fromRGB(0, 0, 0)
			choosebind.BorderSizePixel = 0
			choosebind.AnchorPoint = Vector2.new(1, 0)
			choosebind.Position = UDim2.new(1, -5, 0.16, 0)
			choosebind.Size = UDim2.new(0, 77, 0, 16)
			choosebind.AutoButtonColor = false
			choosebind.Font = Enum.Font.RobotoMono
			choosebind.Text = default or "None"
			choosebind.TextColor3 = Color3.fromRGB(255, 255, 255)
			choosebind.TextSize = 14.000

			kUICorner2.CornerRadius = UDim.new(0, 5)
			kUICorner2.Name = "kUICorner2"
			kUICorner2.Parent = choosebind
			
			local keybndc
			choosebind.MouseButton1Click:Connect(function()
				choosebind.Text = "..."
				local keycode, gpe = UIS.InputBegan:Wait()
				if gpe then return end
				if keycode.KeyCode == Enum.KeyCode.Unknown then return end
				choosebind.Text = keycode.KeyCode.Name
				keybndc = keycode.KeyCode
			end)

			UIS.InputBegan:Connect(function(keycode, gpe)
				if gpe then return end
				if keycode.KeyCode == keybndc then
					callback()
				end
			end)
			
			task.spawn(function() repeat keybind.Size = UDim2.new(0, keybindname.TextBounds.X + 140, 0, 23) task.wait() until nil end)
		end
		
		function tab_data:AddDropdown(title, list, callback)
			local dropdown = Instance.new("Frame")
			local kUICorner = Instance.new("UICorner")
			local dImageLabel = Instance.new("ImageLabel")
			local dropdownname = Instance.new("TextLabel")
			local dropdowncontent = Instance.new("ScrollingFrame")
			local dUIListLayout = Instance.new("UIListLayout")
			local clickboxdd = Instance.new("TextButton")

			dropdown.Name = "dropdown"
			dropdown.Parent = Page
			dropdown.BackgroundColor3 = Color3.fromRGB(52, 53, 56)
			dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			dropdown.BorderSizePixel = 0
			dropdown.Position = UDim2.new(0, 0, 0.294545442, 0)
			dropdown.Size = UDim2.new(0, 214, 0, 23)
			dropdown.ClipsDescendants = true

			kUICorner.CornerRadius = UDim.new(0, 5)
			kUICorner.Name = "kUICorner"
			kUICorner.Parent = dropdown

			dImageLabel.Parent = dropdown
			dImageLabel.AnchorPoint = Vector2.new(1, 0)
			dImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			dImageLabel.BackgroundTransparency = 1.000
			dImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			dImageLabel.BorderSizePixel = 0
			dImageLabel.Position = UDim2.new(1, -5, 0, 3)
			dImageLabel.Rotation = -90.000
			dImageLabel.Size = UDim2.new(0, 15, 0, 15)
			dImageLabel.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4744658743"

			dropdownname.Name = "dropdownname"
			dropdownname.Parent = dropdown
			dropdownname.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			dropdownname.BackgroundTransparency = 1.000
			dropdownname.BorderColor3 = Color3.fromRGB(0, 0, 0)
			dropdownname.BorderSizePixel = 0
			dropdownname.Size = UDim2.new(0, 132, 0, 23)
			dropdownname.Font = Enum.Font.RobotoMono
			dropdownname.Text = " "..title
			dropdownname.TextColor3 = Color3.fromRGB(255, 255, 255)
			dropdownname.TextSize = 14.000
			dropdownname.TextXAlignment = Enum.TextXAlignment.Left

			dropdowncontent.Name = "dropdowncontent"
			dropdowncontent.Parent = dropdown
			dropdowncontent.Active = true
			dropdowncontent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			dropdowncontent.BackgroundTransparency = 1.000
			dropdowncontent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			dropdowncontent.BorderSizePixel = 0
			dropdowncontent.Position = UDim2.new(0.0280373823, 0, 0.176923081, 0)
			dropdowncontent.Size = UDim2.new(1, -15, 0, 100)
			dropdowncontent.Visible = false
			dropdowncontent.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			dropdowncontent.CanvasSize = UDim2.new(0, 0, 0, 0)
			dropdowncontent.ScrollBarThickness = 3
			dropdowncontent.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			dropdowncontent.ClipsDescendants = true
			dropdowncontent.AutomaticCanvasSize = Enum.AutomaticSize.Y

			dUIListLayout.Parent = dropdowncontent
			dUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			dUIListLayout.Padding = UDim.new(0, 3)

			clickboxdd.Name = "clickboxdd"
			clickboxdd.Parent = dropdown
			clickboxdd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			clickboxdd.BackgroundTransparency = 1.000
			clickboxdd.BorderColor3 = Color3.fromRGB(0, 0, 0)
			clickboxdd.BorderSizePixel = 0
			clickboxdd.Size = UDim2.new(0, 214, 0, 18)
			clickboxdd.ZIndex = 2
			clickboxdd.Font = Enum.Font.SourceSans
			clickboxdd.Text = ""
			clickboxdd.TextColor3 = Color3.fromRGB(0, 0, 0)
			clickboxdd.TextSize = 14.000
			
			local dropOpen = false
			local ddOnclick = function()
				dropOpen = not dropOpen
				dropdowncontent.Visible = dropOpen
				TweenService:Create(dropdown, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Size = dropOpen and UDim2.new(0, dropdown.Size.X.Offset, 0, 130) or UDim2.new(0, dropdown.Size.X.Offset, 0, 23)}):Play()
				TweenService:Create(dImageLabel, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Rotation = dropOpen and 0 or -90}):Play()
			end
			
			task.spawn(function() repeat dropdown.Size = UDim2.new(0, dropdownname.TextBounds.X + 100, 0, dropdown.Size.Y.Offset) task.wait() until nil end)
			
			clickboxdd.MouseButton1Click:Connect(ddOnclick)
			for i,v in list do
				local dditem = Instance.new("TextButton")
				local ddiUICorner = Instance.new("UICorner")
			
				dditem.Name = "dditem"
				dditem.Parent = dropdowncontent
				dditem.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
				dditem.BorderColor3 = Color3.fromRGB(0, 0, 0)
				dditem.BorderSizePixel = 0
				dditem.Size = UDim2.new(1, -10, 0, 25)
				dditem.AutoButtonColor = false
				dditem.Font = Enum.Font.RobotoMono
				dditem.Text = tostring(v)
				dditem.TextColor3 = Color3.fromRGB(255, 255, 255)
				dditem.TextSize = 14.000
				dditem.RichText = true

				ddiUICorner.CornerRadius = UDim.new(0, 5)
				ddiUICorner.Name = "ddiUICorner"
				ddiUICorner.Parent = dditem
				
				dditem.MouseButton1Click:Connect(function()
					ddOnclick()
					callback(v)
				end)
			end
		end
		
		return tab_data
	end
end
return gui_data
