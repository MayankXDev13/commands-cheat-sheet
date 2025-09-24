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

# make file system
```
sudo mkfs -t ext4 /dev/newdevicename
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
  
