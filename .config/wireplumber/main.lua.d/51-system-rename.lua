device_rule = {
  matches = {
    {{ "device.name", "equals", "alsa_card.pci-0000_00_1b.0"}},
  },
  apply_properties = {
    ["device.description"] = "System",
    ["device.nick"] = "System"
  },
}

node_rule = {
  matches = {
    {{ "node.name", "equals", "alsa_output.pci-0000_00_1b.0.analog-stereo" }},
    {{ "node.name", "equals", "alsa_input.pci-0000_00_1b.0.analog-stereo"}},
  },
  apply_properties = {
    ["node.description"] = "System",
    ["node.nick"] = "System"
  },
}

table.insert(alsa_monitor.rules,device_rule)
table.insert(alsa_monitor.rules,node_rule)
