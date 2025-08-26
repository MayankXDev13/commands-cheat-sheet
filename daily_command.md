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
