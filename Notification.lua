return function(title, message, duration)
	local tween_service = game:GetService("TweenService")
	local core_gui = game:GetService("CoreGui")
	local http_service = game:GetService("HttpService")

	local function guid()
		return http_service:GenerateGUID(false)
	end

	local notif_container = core_gui:FindFirstChild("NotifContainer")
	if not notif_container then
		notif_container = Instance.new("ScreenGui")
		notif_container.Name = "NotifContainer"
		notif_container.ResetOnSpawn = false
		notif_container.IgnoreGuiInset = true
		notif_container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		notif_container.Parent = core_gui

		local holder = Instance.new("Frame")
		holder.Name = "Holder"
		holder.AnchorPoint = Vector2.new(0.5, 0)
		holder.Position = UDim2.new(0.5, 0, 0, 20)
		holder.Size = UDim2.new(0, 220, 1, -40)
		holder.BackgroundTransparency = 1
		holder.BorderSizePixel = 0
		holder.ZIndex = 9
		holder.Parent = notif_container

		local layout = Instance.new("UIListLayout")
		layout.Name = "Layout"
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0, 6)
		layout.VerticalAlignment = Enum.VerticalAlignment.Top
		layout.Parent = holder
	end

	local holder = notif_container:FindFirstChild("Holder")

	duration = duration or 4

	local frame = Instance.new("Frame")
	frame.Name = guid()
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.Size = UDim2.new(1, 0, 0, 60)
	frame.Position = UDim2.new(0.5, 0, 0, 0)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.ZIndex = 10
	frame.ClipsDescendants = true
	frame.LayoutOrder = -tick()
	frame.Parent = holder

	local corner = Instance.new("UICorner")
	corner.Name = guid()
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = frame

	local padding = Instance.new("UIPadding")
	padding.Name = guid()
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)
	padding.PaddingTop = UDim.new(0, 10)
	padding.PaddingBottom = UDim.new(0, 10)
	padding.Parent = frame

	local stroke = Instance.new("UIStroke")
	stroke.Name = guid()
	stroke.Color = Color3.fromRGB(60, 60, 60)
	stroke.Thickness = 1
	stroke.Parent = frame

	local gradient = Instance.new("UIGradient")
	gradient.Name = guid()
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25)),
	})
	gradient.Rotation = 90
	gradient.Parent = frame

	local title_label = Instance.new("TextLabel")
	title_label.Name = guid()
	title_label.Text = title
	title_label.Font = Enum.Font.GothamBold
	title_label.TextSize = 16
	title_label.TextColor3 = Color3.fromRGB(255, 255, 255)
	title_label.BackgroundTransparency = 1
	title_label.TextXAlignment = Enum.TextXAlignment.Left
	title_label.Size = UDim2.new(1, 0, 0, 18)
	title_label.Position = UDim2.new(0, 0, 0, 0)
	title_label.ZIndex = 11
	title_label.Parent = frame

	local msg_label = Instance.new("TextLabel")
	msg_label.Name = guid()
	msg_label.Text = message
	msg_label.Font = Enum.Font.Gotham
	msg_label.TextSize = 14
	msg_label.TextColor3 = Color3.fromRGB(200, 200, 200)
	msg_label.BackgroundTransparency = 1
	msg_label.TextXAlignment = Enum.TextXAlignment.Left
	msg_label.TextWrapped = true
	msg_label.TextYAlignment = Enum.TextYAlignment.Top
	msg_label.Size = UDim2.new(1, 0, 0, 30)
	msg_label.Position = UDim2.new(0, 0, 0, 22)
	msg_label.ZIndex = 11
	msg_label.Parent = frame

	local bar = Instance.new("Frame")
	bar.Name = guid()
	bar.Size = UDim2.new(1, 0, 0, 3)
	bar.Position = UDim2.new(0, 0, 1, 2)
	bar.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
	bar.BorderSizePixel = 0
	bar.ZIndex = 12
	bar.Parent = frame

	local bar_corner = Instance.new("UICorner")
	bar_corner.Name = guid()
	bar_corner.CornerRadius = UDim.new(1, 0)
	bar_corner.Parent = bar

	tween_service:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0
	}):Play()

	tween_service:Create(bar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
		Size = UDim2.new(0, 0, 0, 3)
	}):Play()

	task.delay(duration, function()
		local tween_out = tween_service:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
			BackgroundTransparency = 1
		})
		tween_out:Play()
		tween_out.Completed:Wait()
		frame:Destroy()
	end)
end
