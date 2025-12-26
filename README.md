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
