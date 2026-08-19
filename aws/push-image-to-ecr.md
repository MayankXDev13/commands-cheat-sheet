# Push a Docker Image to Amazon ECR

Build, tag, and push a Docker image to Amazon Elastic Container Registry (ECR) using the AWS CLI and Docker.

## Prerequisites

- AWS CLI v2 installed and configured (`aws configure`)
- Docker installed and running
- An existing ECR repository

Create a repository if you don't have one:

```bash
aws ecr create-repository --repository-name <my-repo> --region <region>
```

> Replace `<region>` (e.g. `ap-south-1`) and `<my-repo>` with your values. The commands below use environment variables so you only change them once:

```bash
export AWS_REGION=<region>
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export ECR_URI=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
```

## Step 1: Authenticate Docker to ECR

```bash
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI
```

## Step 2: Build the image

Skip this if you already have an image.

```bash
docker build -t <my-app> .
```

## Step 3: Tag the image for ECR

```bash
docker tag <my-app>:latest $ECR_URI/<my-repo>:latest
```

## Step 4: Push the image

```bash
docker push $ECR_URI/<my-repo>:latest
```

## Step 5: Verify

- CLI:

```bash
aws ecr describe-images --repository-name <my-repo> --region $AWS_REGION
```

- Console: ECR → Your Repository → Images tab.

## One-shot version (no env vars)

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.ap-south-1.amazonaws.com
docker tag my-app:latest 123456789012.dkr.ecr.ap-south-1.amazonaws.com/my-repo:latest
docker push 123456789012.dkr.ecr.ap-south-1.amazonaws.com/my-repo:latest
```

## Common errors

### no basic auth credentials

Run the `docker login` step again — the token is short-lived.

### repository does not exist

Create the repository first:

```bash
aws ecr create-repository --repository-name <my-repo> --region $AWS_REGION
```

### AccessDeniedException

Your IAM user/role needs `ecr:GetAuthorizationToken`, `ecr:InitiateLayerUpload`, `ecr:UploadLayerPart`, `ecr:CompleteLayerUpload`, and `ecr:PutImage`.

## Tips

- **Multi-arch images**: build for `linux/amd64` and `linux/arm64` with BuildKit:
  `docker buildx build --platform linux/amd64,linux/arm64 -t $ECR_URI/<my-repo>:latest --push .`
- **Lifecycle policy**: set a lifecycle policy on the repository to auto-expire untagged images and keep costs down.
- **Immutable tags**: enable tag immutability on the repo to prevent accidental overwrites of `latest`.