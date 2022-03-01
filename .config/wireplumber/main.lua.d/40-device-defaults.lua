device_defaults = {}

device_defaults.properties = {
  -- store preferences to the file system and restore them at startup;
  -- when set to false, default nodes and routes are selected based on
  -- their priorities and any runtime changes do not persist after restart
  ["use-persistent-storage"] = true,

  -- the default volume to apply to ACP device nodes, in the linear scale
  --["default-volume"] = 0.4,

  -- Whether to auto-switch to echo cancel sink and source nodes or not
  ["auto-echo-cancel"] = true,

  -- Sets the default echo-cancel-sink node name to automatically switch to
  ["echo-cancel-sink-name"] = "echo-cancel-sink",

  -- Sets the default echo-cancel-source node name to automatically switch to
  ["echo-cancel-source-name"] = "echo-cancel-source",
}

-- Sets persistent device profiles that should never change when wireplumber is
-- running, even if a new profile with higher priority becomes available
device_defaults.persistent_profiles = {
  {
    matches = {
      {
        -- Matches all devices
        { "device.name", "matches", "*" },
      },
    },
    profile_names = {
      "off",
      "pro-audio"
    }
  },
}

function device_defaults.enable()
  -- Selects appropriate default nodes and enables saving and restoring them
  load_module("default-nodes", device_defaults.properties)

  -- Selects appropriate profile for devices
  load_script("policy-device-profile.lua", {
    persistent = device_defaults.persistent_profiles
  })

  -- Selects appropriate device routes ("ports" in pulseaudio terminology)
  -- and enables saving and restoring them together with
  -- their properties (per-route/port volume levels, channel maps, etc)
  load_script("policy-device-routes.lua", device_defaults.properties)

  if device_defaults.properties["use-persistent-storage"] then
    -- Enables functionality to save and restore default device profiles
    load_module("default-profile")
  end
end
