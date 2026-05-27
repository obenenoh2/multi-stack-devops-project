#!/bin/bash
# Build all Docker images for kingsly's project

echo "🐳 Building Docker images for kingsly"
echo "====================================="

echo "📊 Building vote image (Python/Flask)..."
docker build -t kingsly/vote:latest ../src/example-voting-app/vote

echo "📈 Building result image (Node.js)..."
docker build -t kingsly/result:latest ../src/example-voting-app/result

echo "⚙️ Building worker image (.NET)..."
docker build -t kingsly/worker:latest ../src/example-voting-app/worker

echo ""
echo "✅ All images built successfully!"
echo ""
echo "View images with: docker images | grep kingsly"
