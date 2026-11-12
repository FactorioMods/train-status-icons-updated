local migration_state = require("migration-state")
--[[function is_table_empty(table)
	for _, _ in pairs(table) do
		return false
	end
	return true
end

function script_init()
	global.locomotives = {}
end

function entity_added(event) end

function entity_removed(event) end

function generate_alerts(event)
	for _, player in pairs(game.connected_players) do
		if not is_table_empty(global.locomotives) then
			for _, entity in pairs(global.locomotives) do
				if entity.valid then
					player.add_custom_alert(
						entity,
						{ type = "virtual", name = "no-path" },
						{ "description.no-path" },
						true
					)
				end
			end
		end
	end
end

function generate_alts(event)
	if not is_table_empty(global.locomotives) then
		for _, entity in pairs(global.locomotives) do
			if entity.valid then
				rendering.draw_sprite()
			end
		end
	end
end

script.on_init(script_init)
script.on_configuration_changed(script_init)

script.on_event(defines.events.on_train_changed_state)

script.on_event({
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity,
	defines.events.script_raised_built,
	defines.events.script_raised_revive,
}, entity_added)
script.on_event({
	defines.events.on_entity_died,
	defines.events.on_player_mined_entity,
	defines.events.on_robot_mined_entity,
	defines.events.script_raised_destroy,
}, entity_removed)

script.on_nth_tick(600, generate_alerts)
script.on_nth_tick(100, generate_alts)]]

function is_table_empty(table)
	for _, _ in pairs(table) do
		return false
	end
	return true
end

function tick_update()
	for _, player in pairs(game.connected_players) do
		local trains = game.train_manager.get_trains{surface=player.surface}
		if not is_table_empty(trains) then
			for _, train in pairs(trains) do
				if train and train.locomotives then
					local front_locomotive = train.front_stock and train.front_stock
						or train.locomotives.front_movers[1]
					if train.state == defines.train_state.no_path then
						if settings.get_player_settings(player)["no-path-alert"].value then
							player.add_custom_alert(
								front_locomotive,
								{ type = "virtual", name = "no-path" },
								{ "description.no-path" },
								true
							)
						end
						rendering.draw_animation({
							animation = "no-path-blinking",
							target = {entity=front_locomotive, offset={0,-0.7}},
							
							surface = player.surface,
							time_to_live = 62,
						})
					elseif train.state == defines.train_state.destination_full then
						rendering.draw_sprite({
							sprite = "destination-full",
							target = {entity=front_locomotive, offset={0,-0.7}},
							
							surface = player.surface,
							time_to_live = 62,
							only_in_alt_mode = settings.get_player_settings(player)["destination-full-behind-alt"].value,
						})
					end
				end
			end
		end
	end

	--[[for _, surface in pairs(game.surfaces) do
		local trains = surface.get_trains()
		game.print(helpers.table_to_json(trains))
		if trains then
			for _, train in pairs(trains) do
				if train and trains.locomotives then
					game.print(train.state)
				end
			end
		end
	end]]
end

script.on_nth_tick(60, tick_update)

--function script_init()
--	--global.locomotives = {}
--end

--player.add_custom_alert(entity, { type = "fluid", name = "no-path" }, { "description.no-path" }, true)
-- /c game.reload_mods()

--script.on_init(script_init)
--script.on_configuration_changed(script_init)

--[[script.on_event(defines.events.on_train_changed_state, function(event)
	local train = event.train
	game.print("on_train_changed_state")
	if train and train.locomotives then
		game.print(train.state)
		if train.state == defines.train_state.no_path then
			game.print("no path")
			for _, player in pairs(game.connected_players) do
				player.add_custom_alert(
					train.locomotives.front_movers[1],
					{ type = "virtual", name = "no-path" },
					{ "description.no-path" },
					true
				)
				--[[player.add_custom_alert(
					train.locomotives.front_movers[1],
					{ type = "fluid", name = "no-path" },
					{ "description.no-path" },
					true
				)
			end
		elseif train.state == defines.train_state.destination_full then
			game.print("d full")
			--rendering.draw_sprite("destination-full")
		else
			game.print("else")
			--rendering.destroy()
		end
	end
end)]]

script.on_init(function() migration_state.adopt() end)
script.on_configuration_changed(function() migration_state.adopt() end)
