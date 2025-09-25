# List all storage devices
lsblk

# Check if the SSD is recognized
sudo fdisk -l

# Create a partition on the NVMe drive
sudo fdisk /dev/<NVMe>

# In fdisk, follow these steps:
# - Press 'n' for new partition
# - Press 'p' for primary partition
# - Press '1' for partition number 1
# - Press Enter twice to accept default start and end sectors
# - Press 'w' to write the changes and exit


# Format the new partition with ext4
sudo mkfs.ext4 /dev/<NVMe>

# Create mount point
sudo mkdir /mnt/ssd

# Mount the SSD
sudo mount /dev/<NVMe> /mnt/ssd

# Make it owned by your user
sudo chown -R $USER:$USER /mnt/ssd

# Test write access
echo "SSD is working" > /mnt/ssd/test.txt
cat /mnt/ssd/test.txt

# Get the UUID
sudo blkid /dev/<NVMe>

# Add to fstab (replace UUID with the actual UUID from above command)
echo "UUID=<UUID> /mnt/ssd ext4 defaults 0 2" | sudo tee -a /etc/fstab

# Stop Docker
sudo systemctl stop docker

# Move Docker data to SSD
sudo mv /var/lib/docker /mnt/ssd/

# Create symlink
sudo ln -s /mnt/ssd/docker /var/lib/docker

# Start Docker
sudo systemctl start docker

# Verify Docker is working
docker ps
