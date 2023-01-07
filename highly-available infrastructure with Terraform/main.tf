resource "aws_vpc" "Noble_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true 
    enable_dns_support = true

    tags = {
        name = "Noble_vpc"
    
    } 

}

resource "aws_internet_gateway" "mygataway" {
    vpc_id = aws_vpc.Noble_vpc.id

    tags = {
        name = "mygataway"
    }
}

//subnets 

resource "aws_subnet" "my_first_subnet" {
     vpc_id = aws_vpc.Noble_vpc.id
     cidr_block = "10.0.1.0/24"
     availability_zone = "af-south-1a"

     tags = {
        name = "my_first_subnet"
     }
}
resource "aws_subnet" "my_second_subnet" {
     vpc_id = aws_vpc.Noble_vpc.id
     cidr_block = "10.0.2.0/24"
     availability_zone = "af-south-1b"

          tags = {
        name = "my_first_subnet"
     }
}
resource "aws_subnet" "my_third_subnet" {
     vpc_id = aws_vpc.Noble_vpc.id
     cidr_block = "10.0.3.0/24"
     availability_zone = "af-south-1c"

          tags = {
        name = "my_first_subnet"
     }
}

resource "aws_route_table" "my_route_table" {
    vpc_id = aws_vpc.Noble_vpc.id

}

resource "aws_route_table_association" "one" {
     route_table_id = aws_route_table.my_route_table.id
     subnet_id = aws_subnet.my_first_subnet.id
}
resource "aws_route_table_association" "two" {
     route_table_id =aws_route_table.my_route_table.id
     subnet_id = aws_subnet.my_second_subnet.id
}
resource "aws_route_table_association" "three" {
     route_table_id = aws_route_table.my_route_table.id
     subnet_id = aws_subnet.my_third_subnet.id
}

resource "aws_route" "myroute" {
    route_table_id = aws_route_table.my_route_table.id
    gateway_id = aws_internet_gateway.mygataway.id
    destination_cidr_block = "0.0.0.0/0"
}

