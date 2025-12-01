# 🚀 StreamlinePay Infrastructure

This repository contains the Terraform code used to build and manage the cloud infrastructure for the **StreamlinePay** microservices platform. It supports multiple environments (like dev, staging, and production) and uses remote state to keep deployments consistent and safe across teams.

---

##  Folder and File Overview

Here’s a quick breakdown of what each part of the project does:

- `main.tf` – The main configuration file that pulls everything together.
- `provider.tf` – Sets up the AWS provider and configures remote state storage.
- `variable.tf` – Defines input variables used throughout the project.
- `outputs.tf` – Lists output values like VPC IDs or DNS names.
- `modules/` – Contains reusable modules for things like VPC, RDS, ECS, etc.
- `environments/` – Holds environment-specific variable files (e.g., `dev.tfvars`, `prod.tfvars`).
- `.terraform.lock.hcl` – Locks provider versions to keep builds consistent. This file should be committed.
- `.gitignore` – Prevents local Terraform files and state files from being committed.

---

##  What You Need Before You Start

Make sure you have the following installed and set up:

- **Terraform v1.5 or newer**
- **AWS CLI** with valid credentials configured
- An **S3 bucket** and **DynamoDB table** for storing remote state

---

## 🛠️ How to Deploy Infrastructure

Here’s how to deploy infrastructure for a specific environment (like `dev`):

### Step 1: Initialize Terraform

```bash
    terraform init

This downloads the necessary providers and sets up remote state.



Step 2: Preview the Changes

    terraform plan -var-file="environments/dev.tfvars"

This shows what Terraform will do before making any changes.


Step 3: Apply the Changes

    terraform apply -var-file="environments/dev.tfvars"

This applies the changes and provisions the infrastructure.

    To deploy to staging or production, just replace dev.tfvars with the appropriate file.


Keeping Your Code Clean

Before committing changes, run these commands:

    terraform fmt -recursive     # Formats your code
    terraform validate           # Checks for errors


To tear down an environment (be careful):

    terraform destroy -var-file="environments/dev.tfvars"


Remote State Setup

This project uses remote state to avoid conflicts when multiple people are working on it. Make sure your provider.tf is set up to use your S3 bucket and DynamoDB table.

Git Best Practices

    Don’t commit .terraform/ or .tfstate files.

    .gitignore is already set up to prevent this.

If you accidentally committed .terraform/, clean it up with:

    git filter-repo --path .terraform --invert-paths --force

Then reinitialize Git and push again:

git remote add origin https://github.com/YOUR-USERNAME/stream-infra.git
git push --force origin main


