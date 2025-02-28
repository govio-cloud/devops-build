#!/bin/bash

# Define the EC2 instance's IP and SSH user
EC2_USER="ubuntu"
EC2_IP="35.89.17.0"
PRIVATE_KEY_PATH="/home/ubuntu/aregon_aws_kp1.pem"  # Path to private key on Jenkins server


# Define Docker image
DOCKER_IMAGE="govio/dev:latest"

# SSH into the EC2 instance, pull the Docker image, and run the container
ssh -i ${PRIVATE_KEY_PATH} ${EC2_USER}@${EC2_IP} << EOF
    # Update the EC2 instance
    sudo apt-get update -y

    # Pull the latest image from Docker Hub
    sudo docker pull ${DOCKER_IMAGE}

    # Stop any running container with the same name (optional)
    sudo docker ps -q -f "name=your-container-name" | xargs -r sudo docker stop

    # Remove the existing container (optional)
    sudo docker ps -a -q -f "name=your-container-name" | xargs -r sudo docker rm

    # Run the Docker container
    sudo docker run -d --name your-container-name ${DOCKER_IMAGE}

    # Optionally, expose ports or set environment variables if needed
    # sudo docker run -d -p 80:80 --name your-container-name ${DOCKER_IMAGE}
EOF

echo "Deployment to EC2 successful!"

