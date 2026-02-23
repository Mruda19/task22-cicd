#!/bin/bash
set -e

# Kill Flask if running
pkill -f "python3 app.py" || true
