# These are the commands to update Docker Engine on RPi nodes. Start with worker nodes and then update the leader.

# From leader - drain worker
sudo docker node update --availability drain <id>
# Wait for tasks to migrate
sudo docker node ps <id>

# SSH to into worker and update
ssh <ip>
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo systemctl restart docker

# Back on leader - reactivate worker
sudo docker node update --availability active <id>

# Verify worker is healthy
sudo docker node ls

# ...Then for leader, just do 
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo systemctl restart docker

# Verify everything is healthy and up
sudo docker node ls
