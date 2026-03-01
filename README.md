# terraform-aws-infra

Terraform configuration for AWS infrastructure.

Provisions a VPC with public and private subnets, an Application Load Balancer
fronting an Auto Scaling Group, and a bastion host. Separate configurations
exist for dev and prod environments.

## Repository Structure

```
modules/
  vpc/
  security-groups/
  alb/
  app/
  bastion/

envs/
  dev/
  prod/

.github/workflows/
Makefile
```

- `modules/` contains reusable infrastructure components.
- `envs/` contains environment-specific configuration.

## Running Locally

Initialize an environment:

```
make init ENV=dev
```

Review planned changes:

```
make plan ENV=dev
```

Apply changes:

```
make apply ENV=dev
```

Destroy resources:

```
make destroy ENV=dev
```