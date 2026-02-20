.PHONY: init plan deploy destroy

init:
	git config core.hooksPath .githooks
	terraform init

plan:
	terraform plan -var-file=main.tfvars

deploy:
	terraform apply -var-file=main.tfvars

destroy:
	terraform destroy -var-file=main.tfvars
