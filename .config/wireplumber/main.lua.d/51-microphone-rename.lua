device_rule = {
  matches = {
    {{ "device.name", "equals", "alsa_card.usb-Samson_Technologies_Samson_GoMic-00"}},
  },
  apply_properties = {
    ["device.description"] = "Samson Go Mic",
    ["device.nick"] = "Samson Go Mic"
  },
}

node_rule = {
  matches = {
    {{ "node.name", "equals", "alsa_output.usb-Samson_Technologies_Samson_GoMic-00.analog-stereo" }},
    {{ "node.name", "equals", "alsa_input.usb-Samson_Technologies_Samson_GoMic-00.analog-stereo"}},
  },
  apply_properties = {
    ["node.description"] = "Samson Go Mic",
    ["node.nick"] = "Samson Go Mic"
  },
}

table.insert(alsa_monitor.rules,device_rule)
table.insert(alsa_monitor.rules,node_rule)
