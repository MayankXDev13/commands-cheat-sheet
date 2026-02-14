## daily command linux

# NGINX is running

```
 sudo systemctl status nginx
```
# Reload NGINX

```
sudo systemctl reload nginx
```
# Get Stream Chat
```
docker build -t streamchat-backend .
```
```
docker build -t streamchat-frontend .
```
```
docker run --name streamchat-backend-container -p 3000:3000 --env-file .env streamchat-backend:latest
```
```
docker run --name streamchat-frontend-container -p 4173:4173 --env-file .env streamchat-frontend:latest
```

# Restart Docker
```
sudo systemctl restart docker
```

# inspect docker network
```
docker network inspect <networkname>
```
# Genrate Random Key
```
openssl rand -base64 <hom many chr>
```
# Clean Docker System
```
docker system prune
```

# linux commands cheat sheet

## create new user that not have shell access
```
sudo useradd -s /sbin/nologin username
```

## we need to create a custom user john a specific UID and home directory 
```
useradd -u 1756 -d /var/www/john -m john
```
- -u set UID
- -d set home directory
- -m creates the home directory of its it doesn't exist 


```
import secrets

token = secrets.token_hex(32)
print(token)

```