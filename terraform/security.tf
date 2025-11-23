# Web (frontend) security group
resource "aws_security_group" "frontend_sg" {
	# Web (frontend) security group
	name   = "tf-mern-frontend-sg"
	vpc_id = aws_vpc.main.id

	ingress {
		description = "SSH from my IP"
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = [var.allowed_ssh_cidr]
	}

	ingress {
		description = "HTTP"
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "Frontend dev port"
		from_port   = 3000
		to_port     = 3000
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}


# Backend security group
resource "aws_security_group" "backend_sg" {
	name   = "tf-mern-backend-sg"
	vpc_id = aws_vpc.main.id

	ingress {
		description = "SSH from my IP"
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = [var.allowed_ssh_cidr]
	}

	ingress {
		description = "Backend API port"
		from_port   = 3001
		to_port     = 3001
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}