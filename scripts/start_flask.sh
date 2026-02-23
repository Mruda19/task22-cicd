#!/bin/bash
set -e

cd /home/ec2-user/my-flask-app || exit 1

# Kill any existing Flask process
pkill -f "python3 app.py" || true

# Start Flask in background and log output
nohup python3 app.py > app.log 2>&1 &
