# # encoding: utf-8

# Inspec test for recipe install-py-rb-go::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

# check command
command_list = ["ansible", "inspec", "docker", "docker-compose", "aws", "ecs-cli", "awslogs", "molecule", "jq", "terraform"]
command_list.each{|command_name|
	describe command(command_name) do
		it { should exist }
	end
}

describe command("git secrets --list") do
	include_context 'check_command'
	its('stdout') { should match 'secrets.providers git secrets --aws-provider' }
end

describe service('td-agent') do
	it { should be_installed }
	it { should be_enabled }
	# it { should be_running }
end
describe command("service td-agent status") do
	its('stdout') { should match (/running/) }
end
