terraform-state:
	aws s3 cp s3://sinking-database-backups/terraform/state ./terraform.tfstate

plan: terraform-state
	terraform plan ./terraform
	rm terraform.tfstate

inf: terraform-state
	terraform init ./terraform
	terraform apply ./terraform
	aws s3 cp ./terraform.tfstate s3://sinking-database-backups/terraform/state
	rm terraform.tfstate* terraform/terraform.tfstate*

test:
	find cookbooks -mindepth 1 -maxdepth 1 -not -name ".kitchen" -exec sh -c "echo {} && cd {} && kitchen test | sed  's@^@[{}] @' &" \;

.PHONY: terraform-state plan inf test
