# Instructions - one time setup

`make setup-step-zero`
`make setup-step-one`
`make setup-step-two`
`make setup-step-three`

---

### Destroy

Follow this procedure to delete your deployment.

1. In `backend_setup.tf`, change the `terraform_state_backend_baseline` module arguments as
   follows:

   ```hcl
    module "terraform_state_backend_baseline" {
        ...
      terraform_backend_config_file_path = ""
      force_destroy                      = true
    }
   ```

1. `make destroy-step-one`.
   This implements the above modifications by deleting the `backend.tf` file
   and enabling deletion of the S3 state bucket.
1. `make destroy-step-two`. Terraform detects that you want to move your
   Terraform state from the S3 backend to local files, and it does so per
   `-auto-approve`. Now the state is once again stored locally and the S3
   state bucket can be safely deleted.
1. `make destroy-step-three`. This deletes all resources in your deployment.
1. Examine local state file `terraform.tfstate` to verify that it contains
   no resources.
