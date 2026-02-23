#!/bin/bash
set -e

echo "Installing dependencies..."

APP_DIR="/home/ec2-user/my-flask-app"

echo "Installing Python if needed..."
sudo yum install -y python3 python3-pip

echo "Creating virtual environment..."

cd $APP_DIR

# Create virtual environment if not exists
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

echo "Activating virtual environment..."
source venv/bin/activate

echo "Upgrading pip..."
pip install --upgrade pip

if [ ! -f "requirements.txt" ]; then
    echo "ERROR: requirements.txt not found!"
    exit 1
fi

echo "Installing requirements..."
pip install -r requirements.txt

echo "Dependencies installed successfully."