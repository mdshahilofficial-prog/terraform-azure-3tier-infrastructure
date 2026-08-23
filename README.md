# Terraform Azure 3-Tier Infrastructure

A production-style **3-tier application infrastructure on Microsoft Azure**, provisioned and managed entirely using **Terraform**.

The project demonstrates Infrastructure as Code (IaC), reusable Terraform modules, Azure networking, security, remote state management, and CI/CD automation with GitHub Actions.

---

## 🏗️ Architecture

```text
                           INTERNET
                               │
                               ▼
                    ┌───────────────────┐
                    │   Azure Load      │
                    │    Balancer       │
                    └─────────┬─────────┘
                              │
                    ┌─────────▼─────────┐
                    │      WEB TIER      │
                    │                   │
                    │  Linux VM + NGINX │
                    │  Linux VM + NGINX │
                    └─────────┬─────────┘
                              │
                    ┌─────────▼─────────┐
                    │     APP TIER       │
                    │                   │
                    │    Linux VM       │
                    │    Linux VM       │
                    └─────────┬─────────┘
                              │
                    ┌─────────▼─────────┐
                    │    DATABASE TIER   │
                    │                   │
                    │    Azure SQL      │
                    │     Database      │
                    └───────────────────┘
```

---

## 🎯 Project Objectives

* Provision Azure infrastructure using Terraform
* Implement a 3-tier architecture
* Separate Web, Application, and Database tiers
* Use Azure networking and NSGs for traffic control
* Deploy multiple Linux virtual machines
* Configure NGINX on the Web tier
* Provision Azure SQL Database
* Build reusable Terraform modules
* Store Terraform state remotely in Azure Storage
* Automate Terraform workflows using GitHub Actions

---

## ☁️ Azure Resources

The infrastructure includes:

### Networking

* Resource Group
* Virtual Network
* Web Subnet
* Application Subnet
* Database Subnet
* Network Security Groups
* Public IP
* Load Balancer

### Web Tier

* 2 Linux Virtual Machines
* Network Interfaces
* NGINX
* Load Balancer Backend Pool

### Application Tier

* 2 Linux Virtual Machines
* Network Interfaces
* Private communication with the Web tier

### Database Tier

* Azure SQL Server
* Azure SQL Database

### Terraform State

* Azure Storage Account
* Blob Container
* Remote Terraform State

---

## 📁 Project Structure

```text
terraform-azure-3tier-infrastructure/
│
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── terraform.tfvars.example
├── versions.tf
├── .gitignore
│
├── modules/
│   │
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── database/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── .github/
    └── workflows/
        └── terraform.yml
```

---

## 🧩 Terraform Modules

The infrastructure is divided into reusable modules.

### Network Module

Responsible for:

* Resource Group
* Virtual Network
* Subnets
* NSGs
* Public IP
* Load Balancer

### Compute Module

Responsible for:

* Linux VMs
* Network Interfaces
* VM configuration
* Web tier
* Application tier

### Database Module

Responsible for:

* Azure SQL Server
* Azure SQL Database

This modular approach keeps the Terraform configuration reusable, organized, and easier to maintain.

---

## 🔐 Network Security

Network Security Groups are used to control communication between the different tiers.

Example traffic flow:

```text
Internet
   │
   ▼
Load Balancer
   │
   ▼
Web Subnet
   │
   │ Application traffic
   ▼
Application Subnet
   │
   │ Database traffic
   ▼
Database
```

The architecture follows the principle of allowing only the traffic required between tiers.

---

## 🗄️ Terraform Remote State

Terraform state is stored remotely in an **Azure Storage Account** rather than locally.

```text
Terraform
    │
    ▼
Azure Storage Account
    │
    ▼
Terraform State
```

Benefits include:

* Centralized state
* Team collaboration
* State locking
* Reduced risk of losing local state
* Better CI/CD integration

---

## 🔄 CI/CD Pipeline

GitHub Actions is used to automate Terraform operations.

```text
Developer
    │
    ▼
Git Push
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├── Terraform Format
    │
    ├── Terraform Init
    │
    ├── Terraform Validate
    │
    ├── Terraform Plan
    │
    └── Terraform Apply
    │
    ▼
Microsoft Azure
```

The pipeline helps ensure that Terraform configuration is validated before infrastructure changes are deployed.

---

## 🚀 Terraform Workflow

Initialize Terraform:

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt -recursive
```

Validate the configuration:

```bash
terraform validate
```

Review infrastructure changes:

```bash
terraform plan
```

Deploy the infrastructure:

```bash
terraform apply
```

Destroy the infrastructure when it is no longer required:

```bash
terraform destroy
```

---

## ⚙️ Configuration

Create your Terraform variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Update the required values in `terraform.tfvars`.

> Do not commit secrets, passwords, private keys, or other sensitive credentials to GitHub.

---

## 🔑 Authentication

Azure authentication should be handled securely through environment variables or GitHub Actions secrets/OIDC rather than storing credentials directly in Terraform configuration.

For CI/CD, the GitHub Actions workflow is responsible for authenticating with Azure before Terraform operations are executed.

---

## 📊 Infrastructure Flow

```text
                    Azure Resource Group
                            │
                            ▼
                         VNet
                            │
             ┌──────────────┼──────────────┐
             │              │              │
             ▼              ▼              ▼
        Web Subnet     App Subnet      DB Subnet
             │              │              │
             ▼              ▼              ▼
        ┌─────────┐    ┌─────────┐    Azure SQL
        │ VM +    │    │ VM      │
        │ NGINX   │    │         │
        └─────────┘    └─────────┘
             │
        ┌─────────┐    ┌─────────┐
        │ VM +    │    │ VM      │
        │ NGINX   │    │         │
        └─────────┘    └─────────┘
             │              │
             └───────┬──────┘
                     │
                Application
                  Traffic
```

---

## 🛠️ Technologies Used

| Technology          | Purpose                 |
| ------------------- | ----------------------- |
| Microsoft Azure     | Cloud Infrastructure    |
| Terraform           | Infrastructure as Code  |
| HCL                 | Terraform Configuration |
| Azure VNet          | Network Architecture    |
| Azure NSG           | Network Security        |
| Azure Load Balancer | Traffic Distribution    |
| Linux               | Virtual Machine OS      |
| NGINX               | Web Server              |
| Azure SQL           | Database                |
| Azure Storage       | Terraform Remote State  |
| GitHub              | Version Control         |
| GitHub Actions      | CI/CD                   |

---

## 🎓 Key Terraform Concepts Demonstrated

* Providers
* Resources
* Variables
* Outputs
* Locals
* Data Sources
* Modules
* `for_each`
* Resource Dependencies
* Terraform State
* Remote Backend
* State Locking
* `terraform plan`
* `terraform apply`
* `terraform destroy`
* Infrastructure modularization
* CI/CD automation

---

## 💼 Interview Explanation

> I built a three-tier Azure infrastructure using Terraform, separating the Web, Application, and Database layers. I created reusable Terraform modules for networking, compute, and database resources, used Network Security Groups to control traffic between tiers, deployed Linux virtual machines with NGINX for the Web tier, and used Azure SQL for the database layer. I also configured remote Terraform state using Azure Storage and automated Terraform formatting, validation, planning, and deployment through GitHub Actions.

---

## ⚠️ Disclaimer

This project is created for **learning, portfolio, and demonstration purposes**. Infrastructure should be reviewed and hardened further before being used in a real production environment.

---

## 👨‍💻 Author

**Md Shahil**

DevOps / Azure / Terraform

---

## ⭐ If You Find This Project Useful

Feel free to explore the repository, experiment with the Terraform modules, and adapt the architecture for your own learning projects.
