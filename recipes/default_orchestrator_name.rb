bash 'copy off system_uuid as default seed for orchestrator name' do
  flags '-ex'
  code <<-EOB
    dmidecode -s system-uuid > /var/lib/system_uuid
    chmod 644 /var/lib/system_uuid
  EOB
end
