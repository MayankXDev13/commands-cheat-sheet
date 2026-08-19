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