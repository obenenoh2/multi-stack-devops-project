#!/bin/bash
# Start the voting application locally

cd ~/kingsly/multi-stack-project/docker

echo "🚀 Starting kingsly's voting application..."
docker compose up -d

echo ""
echo "📍 Application URLs:"
echo "  Vote:   http://localhost:5000"
echo "  Result: http://localhost:5001"
echo ""
echo "📝 View logs: docker compose logs -f"
