# Portfolio - Cloud Infrastructure Automation & CI/CD Pipeline

A comprehensive DevOps portfolio project demonstrating modern cloud infrastructure automation, containerization, and CI/CD practices using industry-standard tools and technologies.

## 📋 Overview

This project showcases a full-stack React application deployed using a complete DevOps pipeline with Infrastructure as Code (IaC), configuration management, container orchestration, and continuous integration/continuous deployment.

## 🏗️ Architecture

The project implements a production-ready infrastructure with the following components:

- **Frontend**: React-based portfolio application
- **Infrastructure**: Terraform-managed cloud resources
- **Configuration Management**: Ansible playbooks for server configuration
- **Containerization**: Docker and Docker Compose
- **Orchestration**: Kubernetes manifests for container orchestration
- **CI/CD**: Jenkins pipeline for automated build and deployment

## 🛠️ Technologies Used

### Frontend
- React.js
- JavaScript/CSS/HTML
- Create React App

### Infrastructure & DevOps
- **IaC**: Terraform (HCL)
- **Configuration Management**: Ansible
- **Containerization**: Docker
- **Orchestration**: Kubernetes
- **CI/CD**: Jenkins
- **Version Control**: Git/GitHub

## 📁 Project Structure

```
portfolio/
├── src/                    # React application source code
├── public/                 # Static assets and public files
├── terraform/              # Infrastructure as Code (Terraform)
├── ansible/                # Configuration management playbooks
├── k8s/                    # Kubernetes manifests
├── Dockerfile              # Container image definition
├── Jenkinsfile            # CI/CD pipeline configuration
├── compose.yaml           # Docker Compose configuration
├── package.json           # Node.js dependencies
└── README.Docker.md       # Docker-specific documentation
```

## 🚀 Getting Started

### Prerequisites

- Node.js (v14 or higher)
- npm or yarn
- Docker & Docker Compose (for containerized deployment)
- Terraform (for infrastructure provisioning)
- Ansible (for configuration management)
- kubectl (for Kubernetes deployment)

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/DOWNLOAD-it/portfolio.git
   cd portfolio
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start development server**
   ```bash
   npm start
   ```
   
   The application will open at [http://localhost:3000](http://localhost:3000)

4. **Build for production**
   ```bash
   npm run build
   ```

### Docker Deployment

1. **Build Docker image**
   ```bash
   docker build -t portfolio-app .
   ```

2. **Run with Docker Compose**
   ```bash
   docker compose up
   ```

For detailed Docker instructions, see [README.Docker.md](README.Docker.md)

### Infrastructure Deployment

#### Using Terraform

1. **Navigate to terraform directory**
   ```bash
   cd terraform
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Plan infrastructure changes**
   ```bash
   terraform plan
   ```

4. **Apply configuration**
   ```bash
   terraform apply
   ```

#### Using Ansible

1. **Navigate to ansible directory**
   ```bash
   cd ansible
   ```

2. **Run playbook**
   ```bash
   ansible-playbook -i inventory playbook.yml
   ```

### Kubernetes Deployment

1. **Apply Kubernetes manifests**
   ```bash
   kubectl apply -f k8s/
   ```

2. **Verify deployment**
   ```bash
   kubectl get pods
   kubectl get services
   ```

## 🔄 CI/CD Pipeline

The project includes a Jenkins pipeline (`Jenkinsfile`) that automates:

1. Code checkout from repository
2. Dependency installation
3. Application build
4. Docker image creation
5. Container registry push
6. Deployment to target environment

### Pipeline Stages

- **Build**: Install dependencies and build React app
- **Test**: Run automated tests
- **Dockerize**: Build and tag Docker image
- **Deploy**: Deploy to Kubernetes cluster or target environment

## 📜 Available Scripts

### `npm start`
Runs the app in development mode with hot reload.

### `npm test`
Launches the test runner in interactive watch mode.

### `npm run build`
Builds the app for production to the `build` folder with optimized bundles.

### `npm run eject`
**Note**: This is a one-way operation. Ejects from Create React App for full configuration control.

## 📚 Documentation

- [Docker Documentation](README.Docker.md) - Detailed Docker setup and usage
- [Project Report (PDF)](Rapport%20de%20Projet.pdf) - Complete project documentation
- [Project Presentation (PPTX)](Rapport-de-Projet-Automatisation-dInfrastructure-Cloud-et-Pipeline-CICD.pptx) - Visual overview of the project

## 🏆 Key Features

- ✅ **Infrastructure as Code**: Complete infrastructure defined in Terraform
- ✅ **Configuration Management**: Automated server configuration with Ansible
- ✅ **Containerization**: Multi-stage Docker builds for optimized images
- ✅ **Container Orchestration**: Production-ready Kubernetes manifests
- ✅ **CI/CD Automation**: Fully automated Jenkins pipeline
- ✅ **Version Control**: Git-based workflow with proper .gitignore
- ✅ **Production Ready**: Optimized builds and deployment strategies

## 🔧 Configuration

### Environment Variables

Configure the following environment variables as needed:

```bash
# Application
NODE_ENV=production
PORT=3000

# Docker
DOCKER_REGISTRY=your-registry-url
IMAGE_TAG=latest

# Cloud Provider (adjust based on your provider)
CLOUD_REGION=your-region
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENCE) file for details.

## 👤 Author

**DOWNLOAD-it**

- GitHub: [@DOWNLOAD-it](https://github.com/DOWNLOAD-it)

## 🙏 Acknowledgments

- Create React App for the React boilerplate
- HashiCorp for Terraform
- Red Hat for Ansible
- The Kubernetes community
- Jenkins for CI/CD automation

## 📞 Support

For support and questions, please open an issue in the GitHub repository.

---

**Note**: This is a portfolio project demonstrating DevOps practices and cloud infrastructure automation. Feel free to use it as a reference for your own projects.
