resource "aws_vpc" "paul_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "paul_public_subnet" {
  vpc_id                  = aws_vpc.paul_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "dev-public"
  }
}

resource "aws_internet_gateway" "paul_internet_gateway" {
  vpc_id = aws_vpc.paul_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "paul_public_rt" {
  vpc_id = aws_vpc.paul_vpc.id

  tags = {
    Name = "dev_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.paul_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.paul_internet_gateway.id
}

resource "aws_route_table_association" "paul_public_assoc" {
  subnet_id      = aws_subnet.paul_public_subnet.id
  route_table_id = aws_route_table.paul_public_rt.id
}

resource "aws_security_group" "paul_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.paul_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["122.172.84.120/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "paul_auth" {
  key_name   = "paulkey"
  public_key = file("~/.ssh/paulkey.pub")
}

resource "aws_instance" "dev_node" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.paul_auth.id
  vpc_security_group_ids = [aws_security_group.paul_sg.id]
  subnet_id              = aws_subnet.paul_public_subnet.id
  user_data              = file("userdata.tpl")
  tags = {
    Name = "dev-node"
  }

  root_block_device {
    volume_size = 10
  }

  provisioner "local-exec" {
    command     = templatefile("${path.module}/windows-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/paulkey",
    })
    interpreter = ["PowerShell", "-Command"]
  }
}

