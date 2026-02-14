# Docker Daily Usage Commands

## 1. Docker Installation & Version

``` bash
docker --version
docker version
docker info
```

------------------------------------------------------------------------

## 2. Working with Docker Images

### Search Image

``` bash
docker search <image_name>
```

### Pull Image

``` bash
docker pull <image_name>
docker pull <image_name>:<tag>
```

### List Images

``` bash
docker images
```

### Remove Image

``` bash
docker rmi <image_id>
docker rmi <image_name>
```

### Remove All Images

``` bash
docker rmi $(docker images -q)
```

------------------------------------------------------------------------

## 3. Working with Containers

### Run Container

``` bash
docker run <image_name>
docker run -it <image_name>
docker run -d <image_name>
docker run -p 8080:80 <image_name>
docker run --name mycontainer <image_name>
```

### List Containers

``` bash
docker ps
docker ps -a
```

### Stop Container

``` bash
docker stop <container_id>
```

### Start Container

``` bash
docker start <container_id>
```

### Restart Container

``` bash
docker restart <container_id>
```

### Remove Container

``` bash
docker rm <container_id>
```

### Remove All Stopped Containers

``` bash
docker container prune
```

------------------------------------------------------------------------

## 4. Executing Commands in Container

``` bash
docker exec -it <container_id> bash
docker exec -it <container_id> sh
```

------------------------------------------------------------------------

## 5. Container Logs & Monitoring

``` bash
docker logs <container_id>
docker logs -f <container_id>
docker stats
docker top <container_id>
```

------------------------------------------------------------------------

## 6. Docker Volumes

### Create Volume

``` bash
docker volume create myvolume
```

### List Volumes

``` bash
docker volume ls
```

### Inspect Volume

``` bash
docker volume inspect myvolume
```

### Remove Volume

``` bash
docker volume rm myvolume
```

------------------------------------------------------------------------

## 7. Docker Networks

### List Networks

``` bash
docker network ls
```

### Create Network

``` bash
docker network create mynetwork
```

### Inspect Network

``` bash
docker network inspect mynetwork
```

### Remove Network

``` bash
docker network rm mynetwork
```

------------------------------------------------------------------------

# Docker Networking

## The Default Bridge

### Show all IP addresses in the system

``` bash
ip address show
```

### Show routing table

``` bash
ip route
```

### Show all Docker networks

``` bash
docker network ls
```

### Inspect default bridge network

``` bash
docker network inspect bridge
```

------------------------------------------------------------------------

## The User-Defined Bridge

### Create a user-defined bridge network

``` bash
docker network create <name_of_network>
```

### Benefits of User-Defined Bridge Network

-   Built-in DNS resolution between containers.
-   Containers on the same network can communicate using container
    names.
-   No need to manually manage IP addresses.
-   Even if a container restarts and its IP changes, other containers
    can still reach it using its name.
-   Better isolation compared to the default bridge.

------------------------------------------------------------------------

## The Host Network

The host network removes network isolation between the container and the
Docker host.

### Run container using host network

``` bash
docker run --network host <image_name>
```

### Key Points

-   Container shares the host's network stack.
-   No port mapping (`-p`) is required.
-   Useful for high-performance networking scenarios.
-   Works only on Linux hosts.