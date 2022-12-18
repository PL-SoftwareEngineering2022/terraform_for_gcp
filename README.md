## Terraform for GCP
- Terrafrom remote state is dependent on the formation of the backend bucket. i.e. 
    - The backend bucket has to be created before initializing the terraform remote state with a 
        - `terraform init -reconfigure`