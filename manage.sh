#!/bin/bash

case "$1" in
  start)
    echo "Starting voting application..."
    cd ~/kingsly/multi-stack-project/src/example-voting-app
    docker compose up -d
    echo "App started at http://localhost:5000"
    ;;
  stop)
    echo "Stopping voting application..."
    cd ~/kingsly/multi-stack-project/src/example-voting-app
    docker compose down
    echo "App stopped"
    ;;
  status)
    cd ~/kingsly/multi-stack-project/src/example-voting-app
    docker compose ps
    echo ""
    echo "Results:"
    curl -s http://localhost:5001/results
    ;;
  vote)
    shift
    VOTE=${1:-cat}
    curl -X POST http://localhost:5000 -d "vote=$VOTE"
    echo "Voted for $VOTE"
    ;;
  results)
    curl -s http://localhost:5001/results | python3 -m json.tool 2>/dev/null || curl -s http://localhost:5001/results
    ;;
  *)
    echo "Usage: $0 {start|stop|status|vote|results}"
    echo "  start   - Start the application"
    echo "  stop    - Stop the application"
    echo "  status  - Show container status and results"
    echo "  vote    - Cast a vote (default: cat)"
    echo "  results - Show current vote results"
    ;;
esac
