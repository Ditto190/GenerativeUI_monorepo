# GenerativeUI Monorepo - Complete Setup Script (PowerShell)
# This script sets up all dependencies for both TypeScript and Python environments

Write-Host "🚀 GenerativeUI Monorepo Setup" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check if Node.js is installed
Write-Host "📦 Checking prerequisites..." -ForegroundColor Yellow
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js is not installed. Please install Node.js 18+ first." -ForegroundColor Red
    exit 1
}
Write-Host "✅ Node.js $(node --version) found" -ForegroundColor Green

# Check if Python is installed
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Python is not installed. Please install Python 3.10+ first." -ForegroundColor Red
    exit 1
}
Write-Host "✅ Python $(python --version) found" -ForegroundColor Green

# Check if Yarn is installed
if (-not (Get-Command yarn -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️  Yarn not found. Installing Yarn..." -ForegroundColor Yellow
    npm install -g yarn
}
Write-Host "✅ Yarn $(yarn --version) found" -ForegroundColor Green

Write-Host ""
Write-Host "📥 Installing Node.js dependencies..." -ForegroundColor Yellow
yarn install

Write-Host ""
Write-Host "🔨 Building shared packages..." -ForegroundColor Yellow
yarn build

Write-Host ""
Write-Host "🐍 Setting up Python services..." -ForegroundColor Yellow

# Setup python-brain service
if (Test-Path "services/python-brain") {
    Write-Host ""
    Write-Host "Setting up services/python-brain..." -ForegroundColor Cyan
    Push-Location services/python-brain
    
    if (-not (Test-Path ".venv")) {
        Write-Host "Creating virtual environment..." -ForegroundColor Yellow
        python -m venv .venv
    }
    
    Write-Host "Activating virtual environment and installing dependencies..." -ForegroundColor Yellow
    & .\.venv\Scripts\Activate.ps1
    python -m pip install --upgrade pip
    pip install -r requirements.txt
    deactivate
    
    Write-Host "✅ python-brain setup complete" -ForegroundColor Green
    Pop-Location
}

# Setup agent-server (if exists)
if (Test-Path "apps/agent-server") {
    Write-Host ""
    Write-Host "Setting up apps/agent-server..." -ForegroundColor Cyan
    Push-Location apps/agent-server
    
    # Check if Poetry is available
    if (Get-Command poetry -ErrorAction SilentlyContinue) {
        Write-Host "Using Poetry for dependency management..." -ForegroundColor Yellow
        poetry install
        Write-Host "✅ agent-server setup complete (Poetry)" -ForegroundColor Green
    } else {
        Write-Host "Poetry not found, using pip + venv..." -ForegroundColor Yellow
        if (-not (Test-Path "venv")) {
            python -m venv venv
        }
        & .\venv\Scripts\Activate.ps1
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        deactivate
        Write-Host "✅ agent-server setup complete (pip)" -ForegroundColor Green
    }
    
    # Copy environment template if .env doesn't exist
    if (-not (Test-Path ".env") -and (Test-Path ".env.example")) {
        Write-Host "Creating .env from template..." -ForegroundColor Yellow
        Copy-Item .env.example .env
        Write-Host "⚠️  Please edit apps/agent-server/.env and add your API keys" -ForegroundColor Yellow
    }
    
    Pop-Location
}

Write-Host ""
Write-Host "================================" -ForegroundColor Cyan
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Next steps:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Configure environment variables:"
Write-Host "   - Edit apps\agent-server\.env (if it exists)"
Write-Host "   - Add your OpenAI API key or other required keys"
Write-Host ""
Write-Host "2. Start development servers:"
Write-Host ""
Write-Host "   Frontend (all apps):"
Write-Host "   $ yarn dev"
Write-Host ""
Write-Host "   Backend (python-brain):"
Write-Host "   $ cd services\python-brain"
Write-Host "   $ .\.venv\Scripts\Activate.ps1"
Write-Host "   $ uvicorn main:app --reload --port 8000"
Write-Host ""
Write-Host "   Backend (agent-server, if exists):"
Write-Host "   $ cd apps\agent-server"
Write-Host "   $ .\venv\Scripts\Activate.ps1  # or: poetry shell"
Write-Host "   $ python -m src.main"
Write-Host ""
Write-Host "3. Read the documentation:"
Write-Host "   - AGENT.md - Workspace context for AI agents"
Write-Host "   - ProjectOverview.md - Vision and architecture"
Write-Host "   - README.md - Quick start guide"
Write-Host ""
Write-Host "4. Verify setup:"
Write-Host "   $ node scripts\verify-structure.cjs"
Write-Host ""
