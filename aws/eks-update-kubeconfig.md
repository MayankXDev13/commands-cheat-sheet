# Update kubeconfig for an EKS Cluster

Point `kubectl` at an Amazon EKS cluster so you can run `kubectl` commands against it.

## Prerequisites

- AWS CLI v2 installed and configured (`aws configure`)
- `eks:DescribeCluster` permission for the cluster
- `kubectl` installed

## Update kubeconfig

```bash
aws eks update-kubeconfig --name <cluster-name> --region <region>
```

Example:

```bash
aws eks update-kubeconfig --name my-cluster --region us-east-1
```

This merges a new context named `<cluster-name>` into `~/.kube/config`.

## Working with multiple clusters

Give the context a custom alias so cluster names don't collide:

```bash
aws eks update-kubeconfig --name <cluster-name> --region <region> --alias <short-name>
```

## Verify

```bash
kubectl config current-context
kubectl get nodes
```

## Troubleshooting

- **`could not find cluster <cluster-name>`** — cluster is in a different region/account, or you lack `eks:DescribeCluster`.
- **`context was not found` when running kubectl** — you updated kubeconfig for a different cluster/region. List contexts with `kubectl config get-contexts` and switch with `kubectl config use-context <name>`.
- **`error: You must be logged in to the server` / auth errors** — your IAM user/role is not in the cluster's `aws-auth` ConfigMap, or the token is expired (re-run the command).