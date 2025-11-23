MERN Deployment on AWS using Terraform & Ansible
1. Objective

This project demonstrates deploying a MERN (MongoDB, Express, React, Node.js) application on AWS using:

Terraform for Infrastructure provisioning

Ansible for Configuration Management and Deployment

Application used:
https://github.com/UnpredictablePrashant/TravelMemory

2. Architecture Overview

The deployment consists of:

AWS VPC

Public Subnet

EC2 running frontend & backend

Private Subnet

EC2 running local MongoDB

Used for demonstration of assignment DB setup

NAT Gateway

Private EC2 has restricted internet access

Security Groups

SSH only from my IP

DB accessible only from web instance

Actual production DB usage: MongoDB Atlas
The application connects to Atlas via MONGO_URI.

Local MongoDB on EC2 is installed to satisfy assignment requirement Part 2.3.

3. Terraform — Infrastructure

Terraform provisions:

AWS Resource	Purpose
VPC	Network boundary
Public Subnet	Web server EC2
Private Subnet	DB server EC2
Internet Gateway	Internet access
NAT Gateway	Private EC2 outbound access
EC2-Web	frontend + backend
EC2-DB	MongoDB
Security Groups	Locked-down network access
Route Tables	Public & NAT routing
Outputs	Public & private IP addresses

All .tf files included in repository.

4. Ansible — Configuration & Deployment

Two playbooks were written:

✔ web.yml

Installs Node.js 22.x

Clones TravelMemory repo

Creates .env with MongoDB Atlas URI

Installs dependencies

Starts backend with PM2

Starts frontend with PM2

Sets REACT_APP_BACKEND_URL

✔ db.yml

Installs MongoDB locally on DB EC2

Creates Mongo users and roles

Demonstrates DB server setup as per assignment requirement

5. Database
Resource	Purpose
MongoDB Atlas	Production database used by app
Local MongoDB on DB EC2	Required by assignment to demonstrate DB installation & access

Application ultimately uses:

MONGO_URI= MongoDB Atlas connection string

6. Deployment Steps Run
Terraform
terraform init
terraform plan
terraform apply -auto-approve

Ansible
export MONGO_URI="mongodb+srv://..."
ansible-playbook -i inventory db.yml
ansible-playbook -i inventory web.yml

7. Security Hardening Implemented

SSH restricted to my IP only

DB EC2 isolated in private subnet

MongoDB EC2 only accessible from web server security group

No DB exposed to the public internet

HTTPS can be enabled later using Nginx + certbot

8. Testing

Frontend accessible:

http://WEB_PUBLIC_IP:3000


Backend API:

http://WEB_PUBLIC_IP:3001


MongoDB Atlas verified:

data inserted from backend API

collections populated