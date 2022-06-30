
resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

data "aws_ami" "east_2_ami" {
  most_recent      = true
  owners           = ["amazon"]
  
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

data "aws_availability_zone" "my_az" {
  state = "available"
}


resource "aws_instance" "MyFirstInstnace" {
  ami           = data.aws_ami.east_2_ami.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name

  vpc_security_group_ids = [aws_security_group.allow-levelup-ssh.id]
  subnet_id = aws_subnet.levelupvpc-public-2.id

  tags = {
    Name = "custom_instance"
  }

}