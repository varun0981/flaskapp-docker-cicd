# Flask App — Docker & Jenkins CI/CD on AWS EC2

A hands-on DevOps project that automates deployment of a Flask web application from GitHub to an AWS EC2 instance using Jenkins, SSH, and Docker.

## Architecture

![CI/CD architecture](docs/architecture.png)

**Deployment flow**
1. Developer pushes application code to GitHub.
2. GitHub webhook triggers the Jenkins pipeline running in an Ubuntu VM (UTM).
3. Jenkins checks out the repository and connects to EC2 over SSH.
4. EC2 pulls the latest source code and builds the Docker image on its native architecture.
5. Jenkins replaces the previous container with the updated Flask application.
6. The application is exposed on EC2 port `80`.

## Technology Stack

- **Application:** Python / Flask
- **Version control:** Git, GitHub
- **CI/CD:** Jenkins Pipeline, GitHub Webhook
- **Containerization:** Docker
- **Cloud:** AWS EC2 (Ubuntu)
- **Deployment connection:** SSH with Jenkins credentials
- **Local lab:** Ubuntu VM on UTM; Docker Desktop on macOS for separate container experiments

## Repository

- GitHub: [varun0981/flaskapp-docker-cicd](https://github.com/varun0981/flaskapp-docker-cicd)

## Pipeline stages

| Stage | Purpose |
|---|---|
| Checkout | Clone the `main` branch from GitHub |
| Connect to EC2 | Verify SSH access using Jenkins-managed private key |
| Build and Deploy on EC2 | Pull latest code, build Docker image, replace the running container, and test HTTP response |

## Jenkins pipeline

The pipeline is configured in the Jenkins job and uses credentials rather than hard-coded private keys.

- Jenkins credential ID: `ec2-ssh` (SSH Username with private key; username `ubuntu`)
- EC2 target: configured public IP / DNS
- EC2 application container: `flask-ec2-app`
- Container port mapping: `80:80`

> **Security:** Never commit `.pem` files, SSH private keys, passwords, or Docker credentials to GitHub. Store secrets in Jenkins Credentials and restrict EC2 security-group access.

## Screenshots

### Docker Desktop — Containers

![Docker Desktop containers](docs/images/docker-desktop-containers.png)

### Docker Desktop — Images

![Docker Desktop images](docs/images/docker-desktop-images.png)

### Jenkins — Successful webhook-triggered build

![Jenkins successful build](docs/images/jenkins-successful-webhook-build.png)

### AWS EC2 — Instance status

![AWS EC2 instances](docs/images/aws-ec2-instances.png)

## Verify deployment

On EC2, inspect the running container:

```bash
sudo docker ps
sudo docker logs --tail 100 flask-ec2-app
```

Test the application locally on EC2:

```bash
curl -I http://localhost/
```

Test from your browser:

```text
http://<EC2-PUBLIC-IP>/
```

Ensure the EC2 security group allows inbound HTTP traffic on TCP port `80`.

## What this project demonstrates

- GitHub webhook-triggered CI/CD
- Jenkins declarative pipelines
- SSH-based remote deployment
- Docker image build and container lifecycle management
- Deploying a Flask application on AWS EC2
- Basic deployment verification and troubleshooting

## Future improvements

- Push versioned images to Docker Hub or Amazon ECR
- Add automated unit tests before deployment
- Add rollback to the previous image
- Use an Application Load Balancer and Auto Scaling
- Implement blue-green deployment
- Provision EC2 and networking with Terraform
- Add monitoring, logs, and alerts

---
*Learning project — built for hands-on AWS and DevOps practice.*
