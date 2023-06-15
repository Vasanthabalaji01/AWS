#!/bin/bash

# Variables
region="your_region"
instance_name="your_instance_name"
instance_type="your_instance_type"
key_pair_name="your_key_pair_name"
security_group_name="your_security_group_name"
subnet_id="your_subnet_id"

# Step 1: Create the VM
echo "Creating the VM..."
aws ec2 run-instances --region "$region" \
  --image-id "ami-12345678" \ # Replace with the appropriate Ubuntu AMI ID
  --instance-type "$instance_type" \
  --key-name "$key_pair_name" \
  --security-groups "$security_group_name" \
  --subnet-id "$subnet_id" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" \
  --user-data "#!/bin/bash
              sudo apt-get update && sudo apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql"

# Step 2: Wait for VM provisioning
echo "Waiting for VM provisioning..."
sleep 30s

# Step 3: Get the public IP of the VM
public_ip=$(aws ec2 describe-instances --region "$region" \
  --filters "Name=tag:Name,Values=$instance_name" \
  --query "Reservations[].Instances[0].PublicIpAddress" \
  --output text)

# Step 4: Configure Apache
echo "Configuring Apache..."
ssh -o "StrictHostKeyChecking=no" -i "your_key_pair.pem" ubuntu@"$public_ip" \
  "sudo sed -i 's/\/var\/www\/html/\/var\/www\/html\/public/g' /etc/apache2/sites-available/000-default.conf"

# Step 5: Enable Apache modules
echo "Enabling Apache modules..."
ssh -o "StrictHostKeyChecking=no" -i "your_key_pair.pem" ubuntu@"$public_ip" \
  "sudo a2enmod rewrite && sudo systemctl restart apache2"

# Step 6: Configure MySQL
echo "Configuring MySQL..."
ssh -o "StrictHostKeyChecking=no" -i "your_key_pair.pem" ubuntu@"$public_ip" \
  "sudo mysql -u root -e \"ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';FLUSH PRIVILEGES;\""

# Step 7: Cleanup
echo "Cleaning up..."
aws ec2 terminate-instances --region "$region" \
  --instance-ids "$(aws ec2 describe-instances --region "$region" \
  --filters "Name=tag:Name,Values=$instance_name" \
  --query "Reservations[].Instances[].InstanceId" \
  --output text)"

echo "LAMP server setup is complete!"
