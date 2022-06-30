
data "aws_ami" "myami" {
  most_recent = true
  owners = [ "amazon" ]
}


data "aws_security_group" "my-sg" {
  name = "launch-wizard-default"
}

data "aws_subnet" "example" {
  vpc_id = var.vpc_id
}


resource "aws_instance" "testdemo" {
  ami = data.aws_ami.myami.id
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.example.id
  security_groups = [ "${data.aws_security_group.my-sg.id}" ]
  tags = {
      name = "my-test-demo"
}
}