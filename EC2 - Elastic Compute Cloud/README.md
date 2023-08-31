# The steps to set up a web server (Apache) and create a simple HTML file with the message "Happy Learning, Mr.CloudExplorer!" on an Amazon Linux EC2 instance

## Step 1: Connect to Your EC2 Instance

Use SSH to connect to your Amazon Linux EC2 instance. Replace `your-instance-ip` with your instance's public IP address:

```bash
ssh -i your-key.pem ec2-user@your-instance-ip
```

## Step 2: Update the Package Repository

It's a good practice to update the package repository to ensure you are installing the latest software packages:

```bash
sudo yum update -y
```

## Step 3: Install Apache Web Server

Install the Apache web server with the following command:

```bash
sudo yum install httpd -y
```

## Step 4: Start the Apache Service

Start the Apache service and enable it to start automatically on boot:

```bash
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd
```

## Step 5: Create the HTML File

You can use a text editor like `nano` or `vim` to create a simple HTML file. Here, we'll use `nano`:

```bash
sudo nano /var/www/html/index.html
```

Add the following content to the `index.html` file:

[index.html](https://github.com/Vasanthabalaji01/AWS-Projects/blob/main/EC2%20-%20Elastic%20Compute%20Cloud/Index.html)

Save the file and exit the text editor (for `nano`, press `Ctrl + O`, then press `Enter`, and then press `Ctrl + X` to exit).

## Step 6: Configure Security Group**

Make sure that your EC2 instance's security group allows incoming traffic on port 80 (HTTP). You can do this in the AWS Management Console by modifying the security group associated with your EC2 instance.

## Step 7: Access Your Web Page

You should now be able to access your web page by opening a web browser and entering your EC2 instance's public IP address in the address bar. You should see the "Happy Learning, Mr.CloudExplorer!" message displayed on the web page.

![Page hosted](https://github.com/Vasanthabalaji01/AWS-Projects/blob/main/AWS%20Project%20-%20%20image/Page%20Hosted.png)

That's it! You've successfully set up a web server and created a simple HTML page on your Amazon Linux EC2 instance. You can further customize and expand your web application as needed.
