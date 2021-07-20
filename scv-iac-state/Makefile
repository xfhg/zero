

#########################################################################################

setup-step-zero:
	pip3 install aws2-wrap==1.1.11

setup-step-one:
	aws2-wrap --profile scv terraform init

setup-step-two:
	aws2-wrap --profile scv terraform apply -auto-approve

setup-step-three:
	aws2-wrap --profile scv terraform init -force-copy

#########################################################################################

# step zero : check README.md

destroy-step-one:
	aws2-wrap --profile scv terraform apply -target module.terraform_state_backend_baseline -auto-approve

destroy-step-two:
	aws2-wrap --profile scv terraform init -force-copy

destroy-step-three:
	aws2-wrap --profile scv terraform destroy

#########################################################################################

danger-clean-init:
	rm terraform.tfstate 
	rm terraform.tfstate.backup
	rm -rf .terraform/
	aws2-wrap --profile scv terraform init

#########################################################################################

init:
	aws2-wrap --profile scv terraform init

plan:
	aws2-wrap --profile scv terraform plan

apply:
	aws2-wrap --profile scv terraform apply 

destroy:
	aws2-wrap --profile scv terraform destroy

#########################################################################################

setup:
	terraform init
	terraform apply -auto-approve
	terraform init -force-copy