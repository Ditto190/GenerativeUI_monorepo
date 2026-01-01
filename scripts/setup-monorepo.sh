#!/bin/bash

# GenerativeUI Monorepo - Complete Setup Script
# This script sets up all dependencies for both TypeScript and Python environments

set -e  # Exit on error

echo "🚀 GenerativeUI Monorepo Setup"
echo "================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Node.js is installed
echo "📦 Checking prerequisites..."
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js is not installed. Please install Node.js 18+ first.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Node.js $(node --version) found${NC}"

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Python3 is not installed. Please install Python 3.10+ first.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Python $(python3 --version) found${NC}"

# Check if Yarn is installed
if ! command -v yarn &> /dev/null; then
    echo -e "${YELLOW}⚠️  Yarn not found. Installing Yarn...${NC}"
    npm install -g yarn
fi
echo -e "${GREEN}✅ Yarn $(yarn --version) found${NC}"

echo ""
echo "📥 Installing Node.js dependencies..."
yarn install

echo ""
echo "🔨 Building shared packages..."
yarn build

echo ""
echo "🐍 Setting up Python services..."

# Setup python-brain service
if [ -d "services/python-brain" ]; then
    echo ""
    echo "Setting up services/python-brain..."
    cd services/python-brain
    
    if [ ! -d ".venv" ]; then
        echo "Creating virtual environment..."
        python3 -m venv .venv
    fi
    
    echo "Activating virtual environment and installing dependencies..."
    source .venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
    deactivate
    
    echo -e "${GREEN}✅ python-brain setup complete${NC}"
    cd ../..
fi

# Setup agent-server (if exists)
if [ -d "apps/agent-server" ]; then
    echo ""
    echo "Setting up apps/agent-server..."
    cd apps/agent-server
    
    # Check if Poetry is available
    if command -v poetry &> /dev/null; then
        echo "Using Poetry for dependency management..."
        poetry install
        echo -e "${GREEN}✅ agent-server setup complete (Poetry)${NC}"
    else
        echo "Poetry not found, using pip + venv..."
        if [ ! -d "venv" ]; then
            python3 -m venv venv
        fi
        source venv/bin/activate
        pip install --upgrade pip
        pip install -r requirements.txt
        deactivate
        echo -e "${GREEN}✅ agent-server setup complete (pip)${NC}"
    fi
    
    # Copy environment template if .env doesn't exist
    if [ ! -f ".env" ] && [ -f ".env.example" ]; then
        echo "Creating .env from template..."
        cp .env.example .env
        echo -e "${YELLOW}⚠️  Please edit apps/agent-server/.env and add your API keys${NC}"
    fi
    
    cd ../..
fi

echo ""
echo "================================"
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo "📝 Next steps:"
echo ""
echo "1. Configure environment variables:"
echo "   - Edit apps/agent-server/.env (if it exists)"
echo "   - Add your OpenAI API key or other required keys"
echo ""
echo "2. Start development servers:"
echo ""
echo "   Frontend (all apps):"
echo "   $ yarn dev"
echo ""
echo "   Backend (python-brain):"
echo "   $ cd services/python-brain"
echo "   $ source .venv/bin/activate"
echo "   $ uvicorn main:app --reload --port 8000"
echo ""
echo "   Backend (agent-server, if exists):"
echo "   $ cd apps/agent-server"
echo "   $ source venv/bin/activate  # or: poetry shell"
echo "   $ python -m src.main"
echo ""
echo "3. Read the documentation:"
echo "   - AGENT.md - Workspace context for AI agents"
echo "   - ProjectOverview.md - Vision and architecture"
echo "   - README.md - Quick start guide"
echo ""
echo "4. Verify setup:"
echo "   $ node scripts/verify-structure.cjs"
echo ""
