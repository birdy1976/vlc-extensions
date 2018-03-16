--[[
	Trash Current File: Extension for VLC
	- - - - -
	Tested on Ubuntu. Installation and Usage:
	- - - - -
	1) sudo apt install trash-cli
	2) Save this script to trash-current-file.lua
	3) Move it to ~/.local/share/vlc/lua/extensions/
	4) Remark: Create above folders if neccessary
	5) To delete a file: View > Trash Current File
	- - - - - 
	https://www.videolan.org/developers/vlc/share/lua/README.txt
	https://addons.videolan.org/p/1154029/
--]]

function descriptor()
	return {
		title = "Trash Current File",
		version = "2018.03.17",
		author = "@birdy1976",
		capabilities = {}
	}
end

function activate()
	if vlc.playlist.status() == "playing" then
		item = vlc.playlist.current() -- id
		path = vlc.playlist.get(item).path
		vlc.playlist.delete(item)
		vlc.playlist.next()
		path = vlc.strings.decode_uri(path)
		path = string.gsub(path, "file://", "") -- for local files
		os.execute("trash-put '"..path.."'")
		-- Dialog Part 1
		-- dialog = vlc.dialog("Trash Current File")
		-- button_play = dialog:add_button("Trash Current File", trash, 1, 4, 4, 1)
		-- dialog:show()
	end
	vlc.deactivate()
end

function deactivate()
end

-- Dialog Part 2
-- function trash()
	-- Press Ctrl+M to read
	-- vlc.msg.info("Button pressed")
-- end

-- Dialog Part 3
-- function close()
    -- vlc.deactivate()
-- end
