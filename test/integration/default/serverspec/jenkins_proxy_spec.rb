require 'spec_helper'

describe file('/var/lib/jenkins/proxy.xml') do
  it { should be_file }
  it { should be_owned_by 'jenkins'}
  it { should be_grouped_into 'jenkins'}
  it { should be_mode 644 }

  its(:content) { should match /<name>webproxy\.wlb2\.nam\.nsroot\.net/ }
  its(:content) { should match /<port>8080/ }
  its(:content) { should match /<noProxyHost>\*s3\.amazonaws\.com, \*s3\-external\-1\.amazonaws\.com, 169\.254\.169\.254, 127\.0\.0\.1, localhost/ }
end
