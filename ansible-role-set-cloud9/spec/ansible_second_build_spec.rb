# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

# second run
ansible_build_command = "ansible-playbook main.yml"
describe command(ansible_build_command) do
	include_context 'check_command'
	its('stdout') { should match /changed=0.*unreachable=0.*failed=0/ }
end
