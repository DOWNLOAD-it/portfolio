# 1. Provider Configuration
provider "aws" {
  region = "eu-west-3"
}

# 2. Fetch Latest Debian 12 AMI
data "aws_ami" "debian_12" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }
}

# 3. Security Group
resource "aws_security_group" "devops_sg" {
  name        = "devops-paris-sg"
  description = "Security group for Debian 3-node stack"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins Web UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes API"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Portfolio Web App UI"
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- INSTANCES ---

resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.debian_12.id
  instance_type          = "t3.micro"
  key_name               = "cloud-project-key"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              dd if=/dev/zero of=/swapfile bs=1M count=1024
              chmod 600 /swapfile
              mkswap /swapfile
              swapon /swapfile
              echo '/swapfile none swap sw 0 0' >> /etc/fstab
              EOF

  tags = { Name = "Jenkins-Server" }
}

resource "aws_instance" "k8s_worker" {
  ami                    = data.aws_ami.debian_12.id
  instance_type          = "t3.micro"
  key_name               = "cloud-project-key"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              dd if=/dev/zero of=/swapfile bs=1M count=1024
              chmod 600 /swapfile
              mkswap /swapfile
              swapon /swapfile
              echo '/swapfile none swap sw 0 0' >> /etc/fstab
              EOF

  tags = { Name = "K8s-Worker" }
}

resource "aws_instance" "k8s_master" {
  ami                    = data.aws_ami.debian_12.id
  instance_type          = "t3.micro"
  key_name               = "cloud-project-key"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  # Install Ansible immediately upon boot
  user_data = <<-EOF
              #!/bin/bash
              dd if=/dev/zero of=/swapfile bs=1M count=1024
              chmod 600 /swapfile
              mkswap /swapfile
              swapon /swapfile
              echo '/swapfile none swap sw 0 0' >> /etc/fstab
              
              apt-get update -y
              apt-get install -y software-properties-common ansible
              EOF

  tags = { Name = "K8s-Master" }
}

# --- AUTOMATION ---

# Create the dynamic inventory file locally on Windows
resource "local_file" "ansible_inventory" {
  filename = "hosts.ini"
  content  = <<EOT
[jenkins]
jenkins_server ansible_host=${aws_instance.jenkins_server.public_ip} ansible_user=admin ansible_ssh_private_key_file=/home/admin/cloud-project-key.pem

[master]
master_node ansible_host=${aws_instance.k8s_master.public_ip} ansible_user=admin ansible_ssh_private_key_file=/home/admin/cloud-project-key.pem

[worker]
worker_node ansible_host=${aws_instance.k8s_worker.public_ip} ansible_user=admin ansible_ssh_private_key_file=/home/admin/cloud-project-key.pem

[all:vars]
# Ensure this matches the variable name in your jenkins_setup.yml
master_private_ip=${aws_instance.k8s_master.private_ip}
EOT
}

# INITIAL SETUP 
resource "null_resource" "initial_setup" {
  triggers = {
    master_id  = aws_instance.k8s_master.id
    jenkins_id = aws_instance.jenkins_server.id
    worker_id  = aws_instance.k8s_worker.id
  }

  # 1. Clean up broken files and create the ansible directory on the Master
  provisioner "remote-exec" {
    inline = [
      "rm -rf /home/admin/*",
      "rm -f /home/admin/cloud-project-key.pem",
      "mkdir -p /home/admin/ansible"
    ]
    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("C:/Users/dodso/Desktop/Cloud app/cloud-project-key.pem")
      host        = aws_instance.k8s_master.public_ip
    }
  }

  # 2. Upload all Ansible Playbooks (Note the trailing slash!)
  provisioner "file" {
    source      = "C:/Users/dodso/Desktop/Cloud app/ansible/" 
    destination = "/home/admin/ansible/"
    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("C:/Users/dodso/Desktop/Cloud app/cloud-project-key.pem")
      host        = aws_instance.k8s_master.public_ip
    }
  }

  # 3. Upload the dynamic hosts.ini
  provisioner "file" {
    source      = "hosts.ini"
    destination = "/home/admin/ansible/hosts.ini"
    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("C:/Users/dodso/Desktop/Cloud app/cloud-project-key.pem")
      host        = aws_instance.k8s_master.public_ip
    }
  }

  # 4. Upload .pem key and Execute
  provisioner "file" {
    source      = "C:/Users/dodso/Desktop/Cloud app/cloud-project-key.pem"
    destination = "/home/admin/cloud-project-key.pem"
    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("C:/Users/dodso/Desktop/Cloud app/cloud-project-key.pem")
      host        = aws_instance.k8s_master.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/admin/cloud-project-key.pem",
      "echo 'Waiting for Ansible installation on OS to finish...'",
      "sleep 45",
      "cd /home/admin/ansible",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini master_setup.yml --private-key /home/admin/cloud-project-key.pem",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini jenkins_setup.yml --private-key /home/admin/cloud-project-key.pem",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini worker_setup.yml --private-key /home/admin/cloud-project-key.pem"
    ]
    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("C:/Users/dodso/Desktop/Cloud app/cloud-project-key.pem")
      host        = aws_instance.k8s_master.public_ip
    }
  }

  depends_on = [local_file.ansible_inventory]
}

# RECONFIGURATION 
resource "null_resource" "reconfigure_stack" {
  triggers = {
    master_ip  = aws_instance.k8s_master.public_ip
    jenkins_ip = aws_instance.jenkins_server.public_ip
    worker_ip  = aws_instance.k8s_worker.public_ip
  }

  # Ensure the fresh hosts.ini is uploaded before reconnecting nodes
  provisioner "file" {
    source      = "hosts.ini"
    destination = "/home/admin/ansible/hosts.ini"
    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("C:/Users/dodso/Desktop/Cloud app/cloud-project-key.pem")
      host        = aws_instance.k8s_master.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/admin/ansible",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini reconfigure.yml --private-key /home/admin/cloud-project-key.pem"
    ]
    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("C:/Users/dodso/Desktop/Cloud app/cloud-project-key.pem")
      host        = aws_instance.k8s_master.public_ip
    }
  }

  depends_on = [null_resource.initial_setup]
}