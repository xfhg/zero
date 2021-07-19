
setup:
	terraform init
	terraform apply -auto-approve
	terraform init -force-copy

setup:
	pip3 install aws2-wrap==1.1.11

clean-init:
	rm -rf .terraform/
	aws2-wrap --profile scv terraform init

