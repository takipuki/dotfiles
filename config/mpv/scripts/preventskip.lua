mp.add_hook("on_load_fail", 5, function()
	mp.osd_message("Failed to load file" .. mp.get_property("stream-open-filename"))
	mp.set_property_native("pause", true)
end)
