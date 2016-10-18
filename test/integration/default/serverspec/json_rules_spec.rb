%w(jq jq-devel).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/opt/json-rules') do
  it { should be_directory }
end

describe file('/opt/json-rules/json-rules-0.0.0.gem') do
  it { should be_file }
end
