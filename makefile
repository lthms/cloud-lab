.PHONY: init deps plan deploy destroy

init:
	git config core.hooksPath .githooks
	terraform init

deps:
	helm dependency update charts/postgresql

plan: deps
	terraform plan -var-file=main.tfvars

deploy: deps
	terraform apply -var-file=main.tfvars

destroy:
	terraform destroy -var-file=main.tfvars
