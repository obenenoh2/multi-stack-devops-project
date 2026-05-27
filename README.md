# Kingsly's Multi-Stack DevOps Project

## Project: Microservices Voting Application

This project deploys a voting application using:
- **Docker** for containerization
- **Terraform** for AWS infrastructure
- **Ansible** for configuration management

## Application Services
| Service | Technology | Purpose |
|---------|------------|---------|
| Vote | Python/Flask | Web interface for voting |
| Result | Node.js | Real-time vote display |
| Worker | .NET/C# | Process votes to database |
| Redis | Redis | Message queue |
| DB | PostgreSQL | Persistent storage |

## Directory Structure

## Quick Start
```bash
# Build all Docker images
./scripts/build-images.sh

# Run locally
cd docker && docker compose up -d
