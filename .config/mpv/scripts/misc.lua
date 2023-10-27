
--[[
    Load files/URLs from clipboard
    ------------------------------
    Loads one or multiple files/URLs from the clipboard.
    The clipboard format can be of type string or file object.
    Allows appending to the playlist.
    On Linux requires xclip being installed.

    In input.conf add:
    ctrl+v script-message-to misc load-from-clipboard
    ctrl+V script-message-to misc append-from-clipboard



    Quick Bookmark
    --------------
    Creates or restores a bookmark. Supports one bookmark per video.

    Usage:
    Create a folder in the following location:
    ~~/script-settings/quick-bookmark/
    Or create it somewhere else, config at:
    ~~/script-opts/misc.conf:
    quick_bookmark_folder=<folder path>

    In input.conf add:
    ctrl+q script-message-to misc quick-bookmark


    Restart mpv
    -----------
    Restarts mpv restoring the properties path, time-pos,
    pause and volume, the playlist is not restored.

    r script-message-to misc restart-mpv



    Execute Lua code
    ----------------
    Allows to execute Lua Code directly from input.conf.

    It's necessary to add a binding to input.conf:
    #Navigates to the last file in the playlist
    END script-message-to misc execute-lua-code "mp.set_property_number('playlist-pos', mp.get_property_number('playlist-count') - 1)"

]]--

----- options

local o = {
    -- Cycle audio and subtitle tracks
    include_no_audio = false,
    include_no_sub = true,
    max_audio_track_count = 5,
    max_sub_track_count = 5,
    -- Quick Bookmark
    quick_bookmark_folder = "~~/script-settings/quick-bookmark/",
}

local opt = require "mp.options"
opt.read_options(o)

----- string

function is_empty(input)
    if input == nil or input == "" then
        return true
    end
end

function contains(input, find)
    if not is_empty(input) and not is_empty(find) then
        return input:find(find, 1, true)
    end
end

function trim(input)
    if not is_empty(input) then
        return input:match "^%s*(.-)%s*$"
    end
end

function split(input, sep)
    local tbl = {}

    if not is_empty(input) then
        for str in string.gmatch(input, "([^" .. sep .. "]+)") do
            table.insert(tbl, str)
        end
    end

    return tbl
end

----- list

function list_contains(list, value)
    for _, v in pairs(list) do
        if v == value then
            return true
        end
    end

    return false
end

----- math

function round(value)
    return value >= 0 and math.floor(value + 0.5) or math.ceil(value - 0.5)
end

----- file

function file_exists(path)
    if is_empty(path) then return false end
    local file = io.open(path, "r")

    if file ~= nil then
        io.close(file)
        return true
    end
end

function file_read(file_path)
    local file = assert(io.open(file_path, "r"))
    local content = file:read("*all")
    file:close()
    return content
end

function file_write(path, content)
    local file = assert(io.open(path, "w"))
    file:write(content)
    file:close()
end

----- Execute Lua code

mp.register_script_message("execute-lua-code", function (code)
    loadstring(code)()
end)

  ----- Load files from clipboard

function loadfiles(mode)
    if is_windows then
        local ps_code = [[
            Add-Type -AssemblyName System.Windows.Forms
            $containsFiles = [Windows.Forms.Clipboard]::ContainsFileDropList()
            
            if ($containsFiles) {
                [Windows.Forms.Clipboard]::GetFileDropList() -join [Environment]::NewLine
            } else {
                Get-Clipboard
            }
        ]]

        proc_args = { "powershell", "-command", ps_code }
    else
        proc_args = { "xclip", "-o", "-selection", "clipboard" }
    end

    subprocess = {
        name = "subprocess",
        args = proc_args,
        playback_only = false,
        capture_stdout = true,
        capture_stderr = true
    }

    proc_result = mp.command_native(subprocess)

    if proc_result.status < 0 then
        msg.error("Error string: " .. proc_result.error_string)
        msg.error("Error stderr: " .. proc_result.stderr)
        return
    end

    proc_output = trim(proc_result.stdout)

    if is_empty(proc_output) then return end

    if contains(proc_output, "\n") then
        mp.commandv("loadlist", "memory://" .. proc_output, mode)
    else
        mp.commandv("loadfile", proc_output, mode)
    end
end

mp.register_script_message("load-from-clipboard", function ()
    loadfiles("replace")
end)

mp.register_script_message("append-from-clipboard", function ()
    loadfiles("append")
end)

----- Restart mpv

mp.register_script_message("restart-mpv", function ()
    local restart_args = {
        "mpv",
        "--pause=" .. mp.get_property("pause"),
        "--volume=" .. mp.get_property("volume"),
    }

    local playlist_pos = mp.get_property_number("playlist-pos")

    if playlist_pos > -1 then
        table.insert(restart_args, "--start=" .. mp.get_property("time-pos"))
        table.insert(restart_args, mp.get_property("path"))
    end

    mp.command_native({
        name = "subprocess",
        playback_only = false,
        detach = true,
        args = restart_args,
    })

    mp.command("quit")
end)

 ----- Quick Bookmark

mp.register_script_message("quick-bookmark", function ()
    local path = mp.get_property("path")

    if is_empty(path) then
        return
    end

    local folder = mp.command_native({"expand-path", o.quick_bookmark_folder})

    if utils.file_info(folder) == nil then
        msg.error("Bookmark folder not found, create it at:\n" .. folder)
        return
    end

    if file_exists(path) then
        _, path = utils.split_path(path)
        path = utils.join_path(folder, path)
    else
        path = utils.join_path(folder, string.gsub(path, "[/\\:]", ""))
    end

    if file_exists(path) then
        mp.set_property_number("time-pos", tonumber(file_read(path)))
        os.remove(path)
    else
        file_write(path, mp.get_property("time-pos"))
        mp.osd_message("Bookmark saved")
    end
end)
