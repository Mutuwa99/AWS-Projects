resource "aws_vpc" "Nobles_VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = "my-terraform-vpc"

  }
}

resource "aws_internet_gateway" "my_IGW" {
  vpc_id = aws_vpc.Nobles_VPC.id

  tags = {
    name = "my_IGW"
  }
}

resource "aws_subnet" "my_pub_subnet" {
  vpc_id                  = aws_vpc.Nobles_VPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "af-south-1a"
  map_public_ip_on_launch = true

  tags = {
    name = "my_pub_sub"
  }

}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.Nobles_VPC.id

}

resource "aws_route" "my_route" {
  route_table_id         = aws_route_table.my_route_table.id
  gateway_id             = aws_internet_gateway.my_IGW.id
  destination_cidr_block = "0.0.0.0/0"

}



resource "aws_route_table_association" "myassc" {
  route_table_id = aws_route_table.my_route_table.id
  subnet_id      = aws_subnet.my_pub_subnet.id

}


resource "aws_security_group" "myec2sg" {
  vpc_id = aws_vpc.Nobles_VPC.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  }


}

resource "aws_instance" "myserver" {

  ami                    = "ami-0f4500c7ee9bc5381"
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.myec2sg.id}"]
  key_name               = "my-lamp-server"
  subnet_id              = aws_subnet.my_pub_subnet.id
  user_data              = <<EOF
    #!/bin/bash
    sudo su
    yum install httpd -y
    systemctl enable httpd.service
    systemctl start httpd.service 
    wget https://isayabuucket.s3.af-south-1.amazonaws.com/about.zip
    unzip about.zip
    EOF

}