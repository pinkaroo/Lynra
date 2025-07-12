return function()
	local tween_service = game:GetService("TweenService")
	local core_gui = game:GetService("CoreGui")

	local notif_container = core_gui:FindFirstChild("NotifContainer") or Instance.new("ScreenGui")
	notif_container.Name = "NotifContainer"
	notif_container.ResetOnSpawn = false
	notif_container.IgnoreGuiInset = true
	notif_container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	notif_container.Parent = core_gui

	local function send_notif(title, message, duration)
		duration = duration or 4

		local frame = Instance.new("Frame")
		frame.AnchorPoint = Vector2.new(0.5, 0)
		frame.Size = UDim2.new(0, 200, 0, 60)
		frame.Position = UDim2.new(0.5, 0, 0, 20)
		frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.ZIndex = 10
		frame.AutomaticSize = Enum.AutomaticSize.XY
		frame.ClipsDescendants = true
		frame.Parent = notif_container

		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

		local padding = Instance.new("UIPadding")
		padding.PaddingLeft = UDim.new(0, 10)
		padding.PaddingRight = UDim.new(0, 10)
		padding.PaddingTop = UDim.new(0, 10)
		padding.PaddingBottom = UDim.new(0, 10)
		padding.Parent = frame

		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(60, 60, 60)
		stroke.Thickness = 1
		stroke.Parent = frame

		local gradient = Instance.new("UIGradient", frame)
		gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25)),
		})
		gradient.Rotation = 90

		local title_label = Instance.new("TextLabel")
		title_label.Text = title
		title_label.Font = Enum.Font.GothamBold
		title_label.TextSize = 16
		title_label.TextColor3 = Color3.fromRGB(255, 255, 255)
		title_label.BackgroundTransparency = 1
		title_label.TextXAlignment = Enum.TextXAlignment.Left
		title_label.AutomaticSize = Enum.AutomaticSize.X
		title_label.Size = UDim2.new(1, 0, 0, 18)
		title_label.Position = UDim2.new(0, 0, 0, 0)
		title_label.ZIndex = 11
		title_label.Parent = frame

		local msg_label = Instance.new("TextLabel")
		msg_label.Text = message
		msg_label.Font = Enum.Font.Gotham
		msg_label.TextSize = 14
		msg_label.TextColor3 = Color3.fromRGB(200, 200, 200)
		msg_label.BackgroundTransparency = 1
		msg_label.TextXAlignment = Enum.TextXAlignment.Left
		msg_label.TextWrapped = true
		msg_label.TextYAlignment = Enum.TextYAlignment.Top
		msg_label.AutomaticSize = Enum.AutomaticSize.XY
		msg_label.Size = UDim2.new(1, 0, 0, 0)
		msg_label.Position = UDim2.new(0, 0, 0, 22)
		msg_label.ZIndex = 11
		msg_label.Parent = frame

		local bar = Instance.new("Frame")
		bar.Size = UDim2.new(1, 0, 0, 3)
		bar.Position = UDim2.new(0, 0, 1, 2)
		bar.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
		bar.BorderSizePixel = 0
		bar.ZIndex = 12
		bar.Parent = frame

		Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

		task.defer(function()
			tween_service:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				BackgroundTransparency = 0
			}):Play()

			tween_service:Create(bar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
				Size = UDim2.new(0, 0, 0, 3)
			}):Play()
		end)

		task.delay(duration, function()
			local tween_out = tween_service:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			})
			tween_out:Play()
			tween_out.Completed:Wait()
			frame:Destroy()
		end)
	end

	return send_notif
end
