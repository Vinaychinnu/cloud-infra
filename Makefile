ENV ?= dev

init:
	cd envs/$(ENV) && terraform init

fmt:
	terraform fmt -recursive

validate:
	cd envs/$(ENV) && terraform validate

plan:
	cd envs/$(ENV) && terraform plan -var-file="$(ENV).tfvars"

apply:
	cd envs/$(ENV) && terraform apply -var-file="$(ENV).tfvars"

destroy:
	cd envs/$(ENV) && terraform destroy -var-file="$(ENV).tfvars"