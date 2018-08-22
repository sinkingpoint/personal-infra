terraform-state:
	aws s3 cp s3://sinking-database-backups/terraform/state ./terraform.tfstate

inf: terraform-state
	terraform init ./terraform
	terraform apply ./terraform
	aws s3 cp ./terraform.tfstate s3://sinking-database-backups/terraform/state
	rm terraform.tfstate* terraform/terraform.tfstate*
