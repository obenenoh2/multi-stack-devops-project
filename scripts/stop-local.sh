#!/bin/bash
# Stop the voting application

cd ~/kingsly/multi-stack-project/docker

echo "🛑 Stopping kingsly's voting application..."
docker compose down

echo "✅ Application stopped"
