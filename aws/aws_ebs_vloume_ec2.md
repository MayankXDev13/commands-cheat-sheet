# ssh to instance
```
ssh -i  pemfile ubuntu@0.0.0.0
```
# find new device
```
lsblk
```
# check if the disk already has a filesystem
```
sudo file -s /dev/filename
```
- If it says data → the disk is empty (needs formatting).
- If it says ext4, xfs, etc. → it already has a filesystem

# format new EBS volume
- ext4
  ```
  sudo mkfs -t ext4 /dev/newdevicename
  ```
- XFS
  ```
  sudo mkfs -t xfs /dev/nvme1n1
  ```

# make a mount directory
```
sudo mkdir -p /mnt/data
```
# mount the volume
```
sudo mount /dev/newdevicenname /mnt/data
```
# verify
```
df -h
lsblk
```
# make it persistent across reboots
```
sudo blkid /dev/nvme1n1
```
- output
  ```
  /dev/nvme1n1: UUID="1234-ABCD" TYPE="ext4"  
  ```
- Edit /etc/fstab
  ```
  sudo vim /etc/fstab
  ```
- Add a line like this at the bottom
  ```
  UUID=1234-ABCD   /mnt/data   ext4   defaults,nofail   0   2  
  ```
- save
   ```
   sudo mount -a
   ```

# Increase the size of an EBS volume

## Verify the New Size on the Instance
### SSH into your EC2 instance and run
```
lsblk
```

## Resize Partition (only if partition exists)
```
sudo growpart /dev/nvme1n1 1
```


## Resize the Filesystem
- For ext4
  ```
      sudo resize2fs /dev/nvme1n1
  ```
- For XFS
  ```
  sudo xfs_growfs /mnt/data

  ```

- Confirm the New Size
  ```
  df -h

  ```
  
