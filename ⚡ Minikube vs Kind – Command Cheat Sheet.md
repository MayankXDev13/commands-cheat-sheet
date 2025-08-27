| Task                         | **Minikube**                               | **Kind**                                                                               |
| ---------------------------- | ------------------------------------------ | -------------------------------------------------------------------------------------- |
| **Check version**            | `minikube version`                         | `kind version`                                                                         |
| **Start cluster**            | `minikube start --driver=docker`           | `kind create cluster --name demo`                                                      |
| **Start multi-node cluster** | `minikube start --nodes=3 --driver=docker` | `kind create cluster --name demo --config kind-config.yaml` *(custom config required)* |
| **Check cluster status**     | `minikube status`                          | `kubectl cluster-info --context kind-demo`                                             |
| **List nodes**               | `kubectl get nodes`                        | `kubectl get nodes`                                                                    |
| **Delete cluster**           | `minikube delete --all --purge`            | `kind delete cluster --name demo`                                                      |
| **List clusters**            | `minikube profile list`                    | `kind get clusters`                                                                    |
| **Use dashboard**            | `minikube dashboard`                       | *(No built-in dashboard, deploy manually if needed)*                                   |
| **Enable Ingress**           | `minikube addons enable ingress`           | *(Deploy ingress controller manually via YAML/Helm)*                                   |
| **Access cluster IP**        | `minikube ip`                              | `kubectl get svc`                                                                      |
| **SSH into node**            | `minikube ssh`                             | `docker exec -it <node-container> bash`                                                |
| **View logs**                | `minikube logs`                            | `docker logs <node-container>`                                                         |
