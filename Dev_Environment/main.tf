#create a vpc
resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.6.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "dev",
    Environment = "dev"
  }
}

#get the current region from the provider block
data "aws_region" "current" {}

#get the list of Az's which is available in a region
data "aws_availability_zones" "available" {
  state = "available"
}

#Subnet block
resource "aws_subnet" "dev_public_subnet" {
  cidr_block              = "10.6.0.0/24"
  vpc_id                  = aws_vpc.dev_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name        = "dev_public_subnet_1",
    Environment = "dev"
  }
}

#Internet_gateway
resource "aws_internet_gateway" "dev_internet_gateway" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name        = "dev-igw",
    Environment = "dev"
  }
}

#Route table
resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name        = "dev_rt",
    Environment = "dev"
  }
}

#Routes
resource "aws_route" "dev_route" {
  route_table_id         = aws_route_table.dev_route_table.id
  gateway_id             = aws_internet_gateway.dev_internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

#Associate the route table to subnet
resource "aws_route_table_association" "dev_rt_associate" {
  subnet_id      = aws_subnet.dev_public_subnet.id
  route_table_id = aws_route_table.dev_route_table.id
}

#Security group
resource "aws_security_group" "dev_sg" {
  name        = "dev_sg"
  description = "Allow ssh access"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description = "ssh from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Dev_sg",
    Environment = "dev"
  }
}

#keypair
resource "aws_key_pair" "ubuntu_server_ssh_key" {
  key_name   = "ssh_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

#EC2 server
resource "aws_instance" "dev_server" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.ubuntu_server.id
  availability_zone      = data.aws_availability_zones.available.names[0]
  key_name               = aws_key_pair.ubuntu_server_ssh_key.id
  subnet_id              = aws_subnet.dev_public_subnet.id
  vpc_security_group_ids = [aws_security_group.dev_sg.id]
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name        = "dev_server",
    Environment = "dev"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}_ssh_config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/id_rsa"
    })
    interpreter = var.host_os == "linux" ? ["bash", "-c"] : ["Powershell", "-Command"]
    # Condition if host os is linux it wil set the value to bash else powershell.
  }
}