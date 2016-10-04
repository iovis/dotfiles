-- requires subliminal, version 1.0 or newer
-- default keybinding: b
local utils = require 'mp.utils'
function load_sub_fn()
    subl = "/usr/local/bin/subliminal" -- use 'which subliminal' to find the path
    mp.msg.info("searching subtitle")
    mp.osd_message("searching subtitle")
    t = {}
    t.args = {subl, "download", "-s", "-l", "en", mp.get_property("path")}
    res = utils.subprocess(t)
    if res.status == 0 then
        mp.commandv("rescan_external_files", "reselect")
        mp.msg.info("subtitle download succeeded")
        mp.osd_message("subtitle download succeeded")
    else
        mp.msg.warn("subtitle download failed")
        mp.osd_message("subtitle download failed")
    end
end

mp.add_key_binding("b", "auto_load_subs", load_sub_fn)

