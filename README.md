# MyCloudApp - Azure Deployment

A robust ASP.NET Core MVC application deployed to an Azure Virtual Machine (Ubuntu Linux). This project demonstrates cloud infrastructure provisioning, server configuration, and automated process management using Systemd.

## 🚀 Deployment Overview

The application is hosted on an Azure Virtual Machine and exposed to the public internet.

- **Public IP:** `20.166.30.103`
- **Port:** `5000`
- **OS:** Ubuntu Linux 24.04 LTS
- **Runtime:** .NET 10 (Preview/RC)

## 🛠 Tech Stack

- **Framework:** ASP.NET Core MVC (.NET 10)
- **Cloud Provider:** Microsoft Azure (Virtual Machine)
- **Infrastructure:** Azure Bicep (IaC)
- **Process Management:** Systemd (Linux Service)
- **Web Server:** Kestrel

## 📂 Project Structure

- `/Controllers`: C# logic handling HTTP requests.
- `/Views`: Razor pages for the UI.
- `/azure-config`: Infrastructure-as-Code (Bicep) scripts.
- `mycloudapp.service`: Systemd unit file for managing the application service.

## ⚙️ Configuration & Setup

### 1. Prerequisites
- An Azure Subscription.
- .NET 10 SDK installed locally.
- SSH client for server access.

### 2. Service Configuration (Systemd)
To ensure high availability, the application is managed by a systemd service.
File: `mycloudapp.service`

```ini
[Unit]
Description=My .NET Cloud Application
After=network.target

[Service]
WorkingDirectory=/var/www/mycloudapp
ExecStart=/usr/bin/dotnet /var/www/mycloudapp/MyCloudApp.dll
Restart=always
RestartSec=10
User=azureuser
Environment=ASPNETCORE_ENVIRONMENT=Production

[Install]
WantedBy=multi-user.target

3. Installation Steps (Manual)
Provision Azure VM using Bicep.

SSH into the VM: ssh azureuser@<public-ip>.

Install .NET Runtime via Snap.

Deploy published artifacts to /var/www/mycloudapp.

Enable and start the service:

Bash
sudo cp mycloudapp.service /etc/systemd/system/
sudo systemctl enable mycloudapp.service
sudo systemctl start mycloudapp.service
🔒 Security Measures
SSH Key Authentication: Password login disabled.

Network Security Group (NSG): Only ports 22 (SSH) and 5000 (App) are open.

Least Privilege: Application runs as azureuser, not root.

👤 Author
Hanita Melin Cloud Application Deployment Assignment