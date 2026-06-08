--- @sync entry

local function get()
	local ratio = rt.mgr.ratio
	return {
		parent = ratio.parent,
		current = ratio.current,
		preview = ratio.preview,
	}
end

local function set(ratio)
	rt.mgr.ratio = { ratio.parent, ratio.current, ratio.preview }
end

local function entry(st)
	local current = get()
	st.default = st.default or current

	current.parent = current.parent == 0 and st.default.parent or 0
	set(current)
	ya.emit("app:resize", {})
end

return { entry = entry }
