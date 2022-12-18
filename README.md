## Terraform for GCP
- Terrafrom remote state is dependent on the formation of the backend bucket. i.e. 
    - Keep the `backend` block in the provider.tf commented until the bucket has been created. The backend bucket has to be created before initializing the terraform remote state with a `terraform init -reconfigure`
    - To reverse the terrafrom state from remote to local and to delete the bucket, first comment on the backend block again, then transfer the remote state back to local with `terraform init -migrate-state`, then delete the remote state backend bucket. Ps. The bucket will not destroy via terraform unless `force_destroy` is set to `true`
