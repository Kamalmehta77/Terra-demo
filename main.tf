provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

resource "aws_vpc" "project" {
  provider  = aws.us-east-1
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "project2" {
  provider  = aws.us-east-2
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "us-east-first" {
  provider          = aws.us-east-1
  vpc_id            = aws_vpc.project.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "us-east-two" {
  provider          = aws.us-east-2
  vpc_id            = aws_vpc.project2.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_instance" "instance-1" {
  provider       = aws.us-east-1
  ami            = var.instance1
  instance_type  = var.instance_type
  subnet_id      = aws_subnet.us-east-first.id
}

resource "aws_instance" "instance-2" {
  provider       = aws.us-east-2
  ami            = var.instance2
  instance_type  = var.instance_type
  subnet_id      = aws_subnet.us-east-two.id
}
