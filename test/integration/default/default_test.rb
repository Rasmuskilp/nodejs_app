# InSpec test for recipe node_sample::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80) do
  it { should be_listening }
end

describe service 'nginx' do
  it { should be_running }
  it { should be_enabled }
end

describe package('nodejs') do
  it { should be_installed }
  its("version") { should cmp > '8.11.2*'}
end

describe http('http://localhost', enable_remote_worker: true) do
  its('status') { should cmp 502 }
end

## this is the test for attributes
# describe package('node') do
#   it { should be_installed }
#   is("version") { should cmp > '8.11.2*'}
# end
