# Mount S3 Bucket on EC2
## Prerequisites
- EC2 instance running Linux (Ubuntu or Amazon Linux)
- S3 bucket already created
- IAM Role with AmazonS3FullAccess (or bucket-specific policy) attached to EC2

## Step 1: Update your EC2 instance
- Ubuntu
  ```
    sudo apt update && sudo apt upgrade -y
  ```
- Amazon Linux
  ```
  sudo yum update -y
  ```
## Step 2: Install dependencies
- Ubuntu
  ```
  sudo apt install s3fs -y
  ```
- Amazon Linux
  ```
  sudo yum install automake fuse fuse-devel gcc-c++ git libcurl-devel libxml2-devel make openssl-devel -y
  git clone https://github.com/s3fs-fuse/s3fs-fuse.git
  cd s3fs-fuse
  ./autogen.sh
  ./configure
  make
  sudo make install
  ```
## Step 4: Create a mount directory
  ```
    sudo mkdir /mnt/s3bucket
  ```
## Edit FUSE Configuration
```
sudo vim /etc/fuse.conf
```
```
user_allow_other

```
## Step 5: Mount the S3 bucket
  ```
    sudo s3fs my-bucket-name /mnt/s3bucket -o iam_role=auto -o allow_other
  ```
## Step 6: Verify the mount
  ```
    df -h
    ls /mnt/s3bucket
  ```
## Edit /etc/fstab
```
sudo vim /etc/fstab
```

## Step 7: Mount automatically at boot
- Add this line to /etc/fstab so your bucket mounts automatically using the IAM role:
  ```
  s3fs#mayankxdev13-mount-to-ec2 /mnt/s3-bucket fuse _netdev,allow_other,iam_role=auto 0 0
  ```
- Test:
  ```
    sudo mount -a
  ```

