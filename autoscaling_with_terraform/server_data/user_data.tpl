#!/bin/bash
sudo su
yum update -y
yum install -y httpd 
yum install -y jq
systemctl start httpd.service
systemctl enable httpd.service
wget https://isayabuucket.s3.af-south-1.amazonaws.com/about.zip
unzip about.zip
systemctl start httpd.service