# chef_cookbook-aws_orchestrator

Used to initialize an orchestrator environment that contains all the
tools and utilities needed to run cti tech stacks.

## Getting Started

1. Install ruby/rvm

2. Install test-kitchen

3. Ensure your ~/.ssh/config includes credentials for the CodeCommit/git repositories and that the relevant private
   key is also in the ~/.ssh directory (so git clone xxx from the VM will work)

3. Also ensure that your private key doesn't have a passphrase.  If you need to remove it, the following openssl command should take care of it:

           openssl rsa -in server.key.org -out server.key

4. Set ORCHESTRATOR_NAME in the env.  ( export ORCHESTRATOR_NAME=my-orchestrator )

5. Set RUN_MODE in the env.  If set to "dev" then a Jenkins server will NOT be provisioned.  ( export RUN_MODE=dev )

6. Set ENV_REPO_NAME in the env.  This is needed by Jenkins, so it is not necessary if RUN_MODE is "dev".  ( export ENV_REPO_NAME=gcb_environment-lawnmower )

7. kitchen converge

8. kitchen login

9. sudo -i

10. Set AWS_REGION, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY in the env (given you are running locally without an instance profile).  This is not necssary if the orchestrator was launched using the ec2-wrapper cookbook (gcb_chef_cookbook-orchestrator-ec2-wrapper).

#### If RUN_MODE was set to "dev" then a tech_stack can be executed as follows:
1. cd /orchestrator

2. Set permissions:  chmod 700 bootstrap.sh; chmod 700 destroy_stack.sh

3. Env may be already set if the orchestrator was provisioned using the ec2-wrapper cookbook. If they are not set or need to be overridden then you can do so like this:
 - export AWS_REGION=us-east-1
 - export ORCHESTRATOR_NAME=dave
 - export ENV_REPO_NAME=gcb_environment-lawnmower

4. Clone tech_stack repo (including env repo):  ./bootstrap.sh gcb_tech_stack-sawgrass clone

5. Create the tech_stack: ./bootstrap.sh gcb_tech_stack-sawgrass

6. Destroy a tech_stack:  ./destroy_stack orchestrator_name env_repo_name tech_stack_repo_name

7. Destroy all tech_stacks in an environment: ./destroy_stack orchestrator_name env_repo_name

#### If RUN_MODE was NOT set to "dev" then a tech_stack can be executed from Jenkins:
1. Setup SSH tunnel to access Jenkins UI from VDI:  ssh -i ~/.ssh/aws_ssh_key_id ec2-user@orch_ip_address -L 5000:orch_ip_address:8080 -N

2. Go to localhost:5000 and login

3. Build a tech_stack:  http://localhost:5000/job/gcb_tech_stack-sawgrass/job/gcb_environment-lawnmower/job/runStack/

4. Destroy a tech_stack:  http://localhost:5000/job/gcb_tech_stack-sawgrass/job/gcb_environment-lawnmower/job/destroyStack/
