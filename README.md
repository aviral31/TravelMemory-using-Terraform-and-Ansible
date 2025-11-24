# TravelMemory — MERN Deployment with Terraform & Ansible

A demonstration project that provisions AWS infrastructure with Terraform and configures & deploys a MERN application using Ansible. This repo contains Terraform configuration and Ansible playbooks used to create the required AWS resources and install the application.

---

**Overview:**

- Terraform: provision VPC, subnets, NAT, Internet Gateway, EC2 instances, security groups, route tables and outputs.
- Ansible: configure EC2 instances (web and db), install runtime dependencies, deploy backend & frontend, and (optionally) install a local MongoDB for assignment demonstration.

Repository used for application code:

- https://github.com/UnpredictablePrashant/TravelMemory

---

**Architecture (high level):**

- `VPC` — isolated network
- `Public Subnet` — Web EC2 (frontend + backend)
- `Private Subnet` — DB EC2 (local MongoDB for demo)
- `NAT Gateway` — allows private instances to reach the internet
- `Security Groups` — restrict SSH and DB access

> Note: Production deployments should use a managed database (MongoDB Atlas). The local MongoDB instance exists only to satisfy assignment demonstration requirements.

---

**Prerequisites**

- Terraform (v1.x)
- Ansible (v2.9+)
- AWS CLI configured with appropriate IAM credentials
- Node.js (for local testing)

**Security reminder:**

- Never commit real credentials (MongoDB URI, AWS secret keys) into the repo. Use environment variables or a secret manager.

---

**Quick start — Terraform**

1. Initialize Terraform providers:

```powershell
cd terraform
terraform init
```

2. Review the plan:

```powershell
terraform plan
```

3. Create resources (apply):

```powershell
terraform apply -auto-approve
```

Terraform will print outputs including the public IP of the web EC2 and the private IP of the DB EC2.

---

**Quick start — Ansible**

1. Prepare inventory (update the host IPs or use the Terraform output to populate `inventory`):

```ini
[web]
<WEB_PUBLIC_IP> ansible_user=ec2-user ansible_ssh_private_key_file=path/to/key.pem

[db]
<DB_PRIVATE_IP> ansible_user=ec2-user ansible_ssh_private_key_file=path/to/key.pem
```

2. Export required variables (example):

```powershell
$env:MONGO_URI = "mongodb+srv://<user>:<pass>@cluster.mongodb.net/<dbname>?retryWrites=true&w=majority"
```

3. Run playbooks:

```powershell
ansible-playbook -i inventory db.yml
ansible-playbook -i inventory web.yml
```

Ansible playbooks perform tasks such as installing Node.js, cloning the TravelMemory app, creating `.env` files, installing dependencies, and launching the services (PM2 is recommended for process management).

---

**Files & roles (what to expect in this repo)**

- `terraform/` — Terraform `.tf` files for AWS resources
- `ansible/` — `web.yml`, `db.yml`, `inventory`, and any roles/handlers
- `README.md` — this document

---

**Testing the deployment**

- Frontend: `http://<WEB_PUBLIC_IP>:3000`
- Backend API: `http://<WEB_PUBLIC_IP>:3001`

Use the API endpoints to verify database connectivity and data operations.

---

**Cleanup (destroy infrastructure)**

Use Terraform to remove the provisioned resources:

```powershell
cd terraform
terraform destroy -auto-approve
```

Note: Ensure you clean up any snapshots, volumes, or unattached resources that may incur cost.

---

**Screenshots / Evidence (placeholders)**

Please replace these placeholders with screenshots required for the assignment submission.

- `screenshots/terraform-apply.png` — Terraform apply output
- `screenshots/aws-vpc.png` — VPC & subnets in AWS console
- `screenshots/ec2-list.png` — EC2 instances list
- `screenshots/security-groups.png` — Security groups showing SSH & DB rules
- `screenshots/ansible-run.png` — Successful Ansible execution
- `screenshots/app-browser.png` — App running in browser
- `screenshots/mongo-atlas.png` — MongoDB Atlas collections (if used)

Insert images in this README using Markdown image syntax, for example:

```markdown
![Terraform apply](screenshots/terraform-apply.png)
```

---

**Notes & recommendations**

- For production, use an RDS or managed MongoDB (Atlas). Do not expose MongoDB publicly.
- Add HTTPS using a reverse proxy (Nginx) and Certbot for Let's Encrypt certificates.
- Use a CI/CD pipeline to run Terraform + Ansible in a controlled workflow.

---

**Contact / References**

- Application repo: https://github.com/UnpredictablePrashant/TravelMemory
- This repo: https://github.com/aviral31/ContainerizationandContainerOrchestration

If you want, I can also:

- add example `inventory` populated from Terraform outputs,
- add a sample `vars` file for Ansible with secure handling suggestions,
- or include a small diagram (ASCII or image) of the architecture.
