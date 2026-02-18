# How to Push a Docker Image to Amazon ECR

This guide explains how to push a Docker image to Amazon Elastic
Container Registry (ECR) using AWS CLI and Docker.

------------------------------------------------------------------------

## Prerequisites

Make sure you have:

-   AWS CLI installed and configured (`aws configure`)
-   Docker installed and running
-   An existing ECR repository

If you do not have a repository yet, create one:

``` bash
aws ecr create-repository --repository-name my-repo --region ap-south-1
```

------------------------------------------------------------------------

## Step 1: Authenticate Docker to ECR

Run the following command to log in Docker to your AWS account:

``` bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

Replace:

-   `<account-id>` with your AWS account ID
-   `ap-south-1` with your AWS region

------------------------------------------------------------------------

## Step 2: Build Your Docker Image

If you already have an image, you can skip this step.

``` bash
docker build -t my-app .
```

------------------------------------------------------------------------

## Step 3: Tag the Image for ECR

Tag the local image with the ECR repository URI.

``` bash
docker tag my-app:latest <account-id>.dkr.ecr.ap-south-1.amazonaws.com/my-repo:latest
```

Example:

``` bash
docker tag my-app:latest 123456789012.dkr.ecr.ap-south-1.amazonaws.com/my-repo:latest
```

------------------------------------------------------------------------

## Step 4: Push Image to ECR

Push the image to the repository:

``` bash
docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/my-repo:latest
```

------------------------------------------------------------------------

## Step 5: Verify the Image

Go to the AWS Console:

ECR → Your Repository → Images tab

You should see the pushed image listed.

------------------------------------------------------------------------

## Quick Command Summary

``` bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com

docker tag my-app:latest <account-id>.dkr.ecr.ap-south-1.amazonaws.com/my-repo:latest

docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/my-repo:latest
```

------------------------------------------------------------------------

## Common Errors

### no basic auth credentials

Run the login command again.

### repository does not exist

Create the repository first using AWS CLI or AWS Console.
