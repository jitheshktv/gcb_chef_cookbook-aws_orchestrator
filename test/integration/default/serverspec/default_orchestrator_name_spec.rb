describe file('/var/lib/system_uuid') do
  it { should be_directory }
  it { should be_mode 0644 }
end
