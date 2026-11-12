data:extend({
	{
		type = "virtual-signal",
		name = "no-path",
		icon = "__train-status-icons-updated__/graphics/no-path.png",
		icon_size = 78,
		subgroup = "other",
	},
	{
		type = "animation",
		name = "no-path-blinking",
		filename = "__train-status-icons-updated__/graphics/no-path-blinking.png",
		size = 78, -- total 156w 78h
		animation_speed = 0.01,
		frame_count = 2,
		scale = 0.4,
	},
	--[[{
		type = "fluid",
		name = "no-path",
		icon = "__train-status-icons-updated__/graphics/no-path.png",
		icon_size = 78,
		icon_mipmaps = 0,
		default_temperature = 15,
		max_temperature = 100,
		heat_capacity = "0.2KJ",
		base_color = { r = 0, g = 0, b = 0 },
		flow_color = { r = 0, g = 0, b = 0 },
		hidden = true,
		auto_barrel = false,
	},]]
	{
		type = "sprite",
		name = "destination-full",
		filename = "__train-status-icons-updated__/graphics/destination-full.png",
		size = 79,
		scale = 0.4,
	},
})
