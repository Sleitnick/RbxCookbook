-- Lightweight signal class that avoids the table-copying behavior of BindableEvents

local function CreateSignal()
	local Signal, Arguments = {}, {}
	local Bindable = Instance.new("BindableEvent")
	function Signal:Connect(Callback)
		return Bindable.Event:Connect(function()
			Callback(unpack(Arguments, 1, Arguments[0]))
		end)
	end
	function Signal:Wait()
		Bindable.Event:Wait()
		return unpack(Arguments, 1, Arguments[0])
	end
	function Signal:Fire(...)
		Arguments = {[0] = select("#", ...); ...}
		Bindable:Fire()
		Arguments = nil
	end
	function Signal:Destroy()
		Bindable:Destroy()
		Bindable = nil
		Arguments = nil
		Signal = nil
	end
	return Signal
end
