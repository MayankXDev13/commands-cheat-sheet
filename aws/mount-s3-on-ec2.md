# Mount S3 Bucket on EC2 (s3fs-fuse)

Mount an S3 bucket as a filesystem on an EC2 instance.

## Prerequisites

- EC2 instance running Linux (Ubuntu, Amazon Linux 2, or Amazon Linux 2023)
- S3 bucket already created
- IAM Role attached to the EC2 instance (see [Security notes](#security-notes))
- The EC2 instance must be able to reach the internet (NAT gateway or public IP)

> Replace `<my-bucket>` and `/mnt/s3bucket` with your own values throughout.

## Step 1: Update the instance

- Ubuntu

```bash
sudo apt update && sudo apt upgrade -y
```

- Amazon Linux 2

```bash
sudo yum update -y
```

- Amazon Linux 2023

```bash
sudo dnf update -y
```

## Step 2: Install s3fs

- Ubuntu

```bash
sudo apt install s3fs -y
```

- Amazon Linux 2 / 2023 (build from source — no packaged s3fs available)

```bash
sudo yum install automake fuse fuse-devel gcc-c++ git libcurl-devel libxml2-devel make openssl-devel -y
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
./autogen.sh
./configure
make
sudo make install
```

> Amazon Linux 2023: use `sudo dnf install ...` instead of `yum`.

## Step 3: Verify the IAM role

Confirm the instance role works before mounting:

```bash
aws sts get-caller-identity
```

You should see your account ID and the instance role ARN. If you see an error, the role is not attached.

## Step 4: Create a mount directory

```bash
sudo mkdir /mnt/s3bucket
```

## Step 5: Enable FUSE for other users

```bash
sudo vim /etc/fuse.conf
```

Uncomment / add this line:

```text
user_allow_other
```

## Step 6: Mount the S3 bucket

```bash
sudo s3fs <my-bucket> /mnt/s3bucket -o iam_role=auto -o allow_other
```

> `iam_role=auto` uses the EC2 instance role. For an access-key based mount see the s3fs README (`-o passwd_file=`).

## Step 7: Verify the mount

```bash
df -h
ls -la /mnt/s3bucket
```

`df -h` should list `s3fs` as the filesystem type, and the directory should show your bucket objects.

## Step 8: Mount automatically at boot (fstab)

Add this line to `/etc/fstab`:

```text
s3fs#<my-bucket> /mnt/s3bucket fuse _netdev,allow_other,iam_role=auto 0 0
```

Test it:

```bash
sudo mount -a
```

> `_netdev` tells the system to wait for the network to be up before mounting.

## Unmount

```bash
sudo umount /mnt/s3bucket
```

> If it reports "target is busy", find and stop the process using it:
> `sudo lsof +f -- /mnt/s3bucket`

## Troubleshooting

- **Mount fails / no such bucket**: check the bucket name and region. s3fs auto-detects the region from IAM, but you can force it with `-o endpoint=<region>`.
- **Permission denied on files**: the bucket objects may have restrictive ACLs; use `-o umask=022` or check bucket policy.
- **Slow listing of large buckets**: s3fs has performance limits; for heavy workloads prefer AWS CLI sync (`aws s3 sync`) or AWS Storage Gateway.
- **Logs**: s3fs writes to `/var/log/s3fs.log`; add `-o dbglevel=info -f` to run in the foreground with verbose output.

## Security notes

- Prefer least-privilege IAM over `AmazonS3FullAccess`. Example bucket policy actions:
  - `s3:GetObject`, `s3:ListBucket` (read-only mount)
  - `s3:PutObject`, `s3:DeleteObject` (if the app needs writes)
- Never store access keys on the instance; use the instance role instead.