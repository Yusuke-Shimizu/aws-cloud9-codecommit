# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

# first run
ansible_build_command = "ansible-playbook main.yml"
describe command(ansible_build_command) do
	include_context 'check_command'
end
