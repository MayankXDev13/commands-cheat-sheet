# Docker Networking

## The Default Bridge

### show all IP addresses in the system
```
ip address show
```
### ip route
```
ip route
```
### show all networks in Docker 
```
docker network ls
```
### inspect bridge network
```
docker inspect bridge
```

### The User-Defined Bridge

```
docker network create <name of the network>
```
- What benefits does the use defined bridge in network DNS provide? The same network container ping by the name of the container is useful when ip address is changed.
- when the container is restarted

### The Host


