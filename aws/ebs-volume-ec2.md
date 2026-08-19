# Attach & Manage an EBS Volume on EC2

Attach, format, mount, resize, and unmount an EBS volume on a Linux EC2 instance.

> Replace `<pem-file>`, `<instance-ip>`, and `/dev/<device>` with your own values. Devices are usually `/dev/nvme1n1`, `/dev/sdf`, or `/dev/xvdf`.

## Prerequisites

- EBS volume created in the **same AZ** as the instance (from the EC2 console: Volumes → Create Volume → Attach)
- Volume attached to the instance from the console before you start
- SSH access to the instance

## Step 1: SSH into the instance

```bash
ssh -i <pem-file> ubuntu@<instance-ip>
```

> Username varies by AMI: `ubuntu` (Ubuntu), `ec2-user` (Amazon Linux), `admin` (Debian).

## Step 2: Find the new device

```bash
lsblk
```

Look for a disk with no mount point (e.g. `nvme1n1`).

## Step 3: Check if the disk already has a filesystem

```bash
sudo file -s /dev/<device>
```

- Output `data` → disk is empty, needs formatting
- Output `ext4`, `xfs`, etc. → already has a filesystem, skip to Step 5

## Step 4: Format the volume

- ext4 (Ubuntu default)

```bash
sudo mkfs -t ext4 /dev/<device>
```

- XFS (Amazon Linux default)

```bash
sudo mkfs -t xfs /dev/<device>
```

> Formatting destroys all data on the volume. Double-check you picked the right device.

## Step 5: Create a mount directory and mount

```bash
sudo mkdir -p /mnt/data
sudo mount /dev/<device> /mnt/data
```

## Step 6: Verify

```bash
df -h
lsblk
```

## Step 7: Make it persistent across reboots (fstab)

Get the UUID:

```bash
sudo blkid /dev/<device>
```

Example output:

```text
/dev/nvme1n1: UUID="1234-ABCD" TYPE="ext4"
```

Edit `/etc/fstab`:

```bash
sudo vim /etc/fstab
```

Add a line at the bottom (use your real UUID):

```text
UUID=1234-ABCD /mnt/data ext4 defaults,nofail 0 2
```

> `nofail` prevents boot failures if the volume is missing. For XFS use `xfs` as the filesystem type.

Test:

```bash
sudo mount -a
```

## Increase the size of an EBS volume

1. Modify the volume size from the EC2 console (Volumes → Actions → Modify Volume) and wait for `in-use/optimizing` state.
2. On the instance, verify the new size:

```bash
lsblk
```

3. Resize the partition (only if the disk has partitions, e.g. `/dev/nvme1n1p1`):

```bash
sudo growpart /dev/<device> 1
```

4. Resize the filesystem:
   - ext4 — target the **partition**, not the whole disk:

   ```bash
   sudo resize2fs /dev/<device>p1
   ```

   - XFS:

   ```bash
   sudo xfs_growfs /mnt/data
   ```

5. Confirm the new size:

```bash
df -h
```

## Unmount an EBS volume

1. Check what's mounted:

```bash
df -h
```

2. Unmount:

```bash
sudo umount /mnt/data
```

3. If it's busy (in use), find the culprit:

```bash
sudo lsof +f -- /mnt/data
```

Kill the process, then unmount again.

4. Verify:

```bash
lsblk
```

5. Detach the volume from the EC2 console (Volumes → Actions → Detach Volume) — only after unmounting, to avoid data corruption.

## Troubleshooting

- **`umount: target is busy`** — processes still using the mount point; see `lsof` above.
- **Instance won't boot after editing fstab** — you removed `nofail` or mistyped the UUID. Recover by editing `/etc/fstab` from the rescue instance or console.
- **Device name differs from console (e.g. `/dev/sdf` vs `/dev/nvme1n1`)** — NVMe instances rename devices; always use `lsblk` to confirm.
- **Volume not showing in `lsblk`** — the volume is in a different AZ, or the driver needs a reboot (`sudo reboot`).