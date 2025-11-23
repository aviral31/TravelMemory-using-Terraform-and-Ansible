data "aws_ami" "ubuntu_2204" {
most_recent = true
owners = ["099720109477"] # Canonical
filter {
name = "name"
values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
}
}


resource "aws_instance" "frontend" {
ami = data.aws_ami.ubuntu_2204.id
instance_type = var.instance_type_frontend
subnet_id = aws_subnet.public.id
key_name = var.key_name
vpc_security_group_ids = [aws_security_group.frontend_sg.id]


tags = { Name = "tf-mern-frontend" }
}


resource "aws_instance" "backend" {
ami = data.aws_ami.ubuntu_2204.id
instance_type = var.instance_type_backend
subnet_id = aws_subnet.public.id
key_name = var.key_name
vpc_security_group_ids = [aws_security_group.backend_sg.id]


tags = { Name = "tf-mern-backend" }
}