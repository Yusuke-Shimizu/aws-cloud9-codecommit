require 'rake'

namespace :aws do
  namespace :cloud9 do
    desc "Run cloudformation stack"
    task :create do
      sh "aws cloudformation create-stack --stack-name cloud9 --region ap-southeast-1 --template-body file://cloud9.yml | jq ."
    end

    desc "Check cloudformation stack"
    task :check do
      # sh "aws cloudformation describe-stacks --stack-name cloud9 --region ap-southeast-1 | jq ."
      # sh "aws cloudformation describe-stack-events --stack-name cloud9 --region ap-southeast-1 | jq ."
      sh "aws cloudformation describe-stacks --stack-name cloud9 --region ap-southeast-1 --query \"Stacks[*].[StackName,CreationTime,StackStatus]\" --output table"
      sh "aws cloudformation describe-stack-events --stack-name cloud9 --region ap-southeast-1 --query \"StackEvents[*].[ResourceType,Timestamp,ResourceStatus,ResourceStatusReason]\" --output table"
      # sh "aws cloudformation describe-stacks --stack-name cloud9 --region ap-southeast-1 --output table"
      # sh "aws cloudformation describe-stack-events --stack-name cloud9 --region ap-southeast-1 | jq ."
    end

    desc "Delete cloudformation stack"
    task :delete do
      sh "aws cloudformation delete-stack --stack-name cloud9 --region ap-southeast-1 | jq ."
    end
  end

  namespace :codebuild do
    desc "Run cloudformation stack"
    template = "file://codecommit-pipeline.yml"
    region = "ap-northeast-1"
    stack_name = "codebuild-pipeline"
    task :create do
      sh "aws cloudformation create-stack \\
        --stack-name #{stack_name} \\
        --region #{region} \\
        --template-body #{template} \\
        --capabilities CAPABILITY_NAMED_IAM \\
        | jq ."
    end

    desc "Check cloudformation stack"
    task :check do
      
      sh "aws cloudformation describe-stacks \\
        --stack-name #{stack_name} \\
        --region #{region} \\
        --query \"Stacks[*].[StackName,CreationTime,StackStatus]\" \\
        --output table"
      sh "aws cloudformation describe-stack-events \\
        --stack-name #{stack_name} \\
        --region #{region} \\
        --query \"StackEvents[*].[ResourceType,Timestamp,ResourceStatus,ResourceStatusReason]\" \\
        --output table"
    end

    desc "Delete cloudformation stack"
    task :delete do
      sh "aws cloudformation delete-stack \\
        --stack-name #{stack_name} \\
        --region #{region} \\
        | jq ."
    end
  end

  namespace :fargate do
    desc "Run cloudformation stack"
    template = "file://fargate/ecs-refarch-continuous-deployment.yaml"
    region = "ap-northeast-1"
    stack_name = "create_fargate"
    task :create do
      sh "aws cloudformation create-stack \\
        --stack-name #{stack_name} \\
        --region #{region} \\
        --template-body #{template} \\
        --capabilities CAPABILITY_NAMED_IAM \\
        | jq ."
    end

    desc "Check cloudformation stack"
    task :check do
      
      sh "aws cloudformation describe-stacks \\
        --stack-name #{stack_name} \\
        --region #{region} \\
        --query \"Stacks[*].[StackName,CreationTime,StackStatus]\" \\
        --output table"
      sh "aws cloudformation describe-stack-events \\
        --stack-name #{stack_name} \\
        --region #{region} \\
        --query \"StackEvents[*].[ResourceType,Timestamp,ResourceStatus,ResourceStatusReason]\" \\
        --output table"
    end

    desc "Delete cloudformation stack"
    task :delete do
      sh "aws cloudformation delete-stack \\
        --stack-name #{stack_name} \\
        --region #{region} \\
        | jq ."
    end
  end
end

namespace :inspec do
  desc "Run Inspec tests"
  task :default do
    sh 'inspec exec spec/common_spec.rb'
  end
end

namespace :ansible do
  desc "syntax check"
  task :syntax do
    sh 'ansible-playbook main.yml --syntax-check'
  end

  desc "build check"
  task :check do
    sh 'ansible-playbook main.yml -i inventory -vv --check'
  end

  desc "build"
  task :build do
    sh 'ansible-playbook main.yml -i inventory -vv'
  end

  desc "install requirements from galaxy"
  task :install do
    sh 'sudo yum install ansible -y'
    sh 'sudo pip install ansible ansible-lint'
    # sh 'ansible-galaxy install -r requirements.yml'
  end
end

namespace :ci do
  desc "Run CI test"
  task :default do
    Rake::Task["ansible:build"].invoke()
    Rake::Task["inspec:default"].invoke()
  end
end
