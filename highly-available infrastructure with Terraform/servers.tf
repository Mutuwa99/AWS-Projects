resource "aws_security_group" "mysg" {
  name        = "allow_http_access"
  description = "allow inbound http traffic"
  vpc_id      = aws_vpc.Noble_vpc.id

    ingress {
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_instance" "server_one" {
  instance_type          = "t3.micro"
  ami                    = "ami-0f4500c7ee9bc5381"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id              = aws_subnet.my_first_subnet.id
  associate_public_ip_address = true
  user_data = file("server_data/user_data.tpl")
      tags = {
      Name = "app-server-1"
    }
}
resource "aws_instance" "server_two" {
  instance_type          = "t3.micro"
  ami                    = "ami-0f4500c7ee9bc5381"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id              = aws_subnet.my_second_subnet.id
  associate_public_ip_address = true
  user_data = file("server_data/user_data.tpl")
      tags = {
      Name = "app-server-"
    }
}
resource "aws_instance" "server_three" {
  instance_type          = "t3.micro"
  ami                    = "ami-0f4500c7ee9bc5381"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id              = aws_subnet.my_third_subnet.id
  associate_public_ip_address = true
  user_data = file("server_data/user_data.tpl")
      tags = {
      Name = "app-server-3"
    }
}