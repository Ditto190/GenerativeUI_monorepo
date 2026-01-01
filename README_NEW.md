# GenerativeUI Monorepo

> **A hybrid multi-language development workspace for building Generative UI systems and multi-agent architectures**

This monorepo combines TypeScript/React/Next.js frontends with Python backend services to create an experimental playground for AI-driven interfaces and agentic workflows. It's designed as both a **working development environment** and a **template for similar projects**.

## 🎯 What is This?

A **polyglot monorepo** that enables:

- 🎨 **Generative UI Development** - Build AI-generated interfaces with CopilotKit, Next.js, and Material UI
- 🤖 **Multi-Agent Systems** - Create agentic workflows using AG2 (AutoGen), FastAPI, and FastAgency
- 🔒 **Local-First Architecture** - Privacy-focused, offline-capable development with no required cloud dependencies
- 📦 **Template-Ready Structure** - Clear boundaries and documentation for easy adaptation to new projects

### Key Principles

| Challenge                                        | Solution                                                 |
| ------------------------------------------------ | -------------------------------------------------------- |
| **Developers...**                                | **This workspace...**                                    |
| ... struggle with polyglot monorepo setup       | ... provides clear boundaries between languages          |
| ... waste time on dependency conflicts           | ... uses isolated virtual environments per service       |
| ... lack clear documentation for agents/AI       | ... includes AGENT.md for AI agent context              |
| ... need reproducible environments               | ... includes automated setup scripts                     |

## 🚀 Quick Start

### Prerequisites

- **Node.js** 18+ (for frontend)
- **Python** 3.10+ (for backend services)
- **Yarn** 3.3+ (installed automatically if missing)

### Automated Setup

**Linux/Mac:**
```bash
chmod +x scripts/setup-monorepo.sh
./scripts/setup-monorepo.sh
```

**Windows (PowerShell):**
```powershell
.\scripts\setup-monorepo.ps1
```

**Manual Setup:**
```bash
# Install Node.js dependencies
yarn install

# Build shared packages
yarn build

# Setup Python services
cd services/python-brain
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
cd ../..
```

### Running Services

**Frontend (all apps):**
```bash
yarn dev  # Starts all frontend applications
```

**Backend (python-brain):**
```bash
cd services/python-brain
source .venv/bin/activate  # Windows: .venv\Scripts\Activate.ps1
uvicorn main:app --reload --port 8000
```

## 🏗️ Workspace Structure

```
GenerativeUI_monorepo/
├── 📄 AGENT.md                      # AI agent context & rules (READ FIRST for agents)
├── 📄 ProjectOverview.md            # Vision & architecture
├── 📄 copilot-instructions.md       # Agent-specific patterns
│
├── 🟦 packages/                     # TypeScript/React packages (Yarn workspaces)
│   ├── example-react-application/  # React app with CRA
│   ├── example-next-application/   # Next.js app
│   └── example-react-module/       # Reusable React library
│
├── 🟦 apps/                         # Application workspaces
│   ├── web-dashboard/              # Next.js + CopilotKit (Generative UI)
│   └── agent-server/               # 🐍 Python FastAPI + AG2
│
├── 🐍 services/                     # Backend services (isolated Python)
│   └── python-brain/               # FastAPI + pyautogen service
│       ├── .venv/                  # Virtual environment (gitignored)
│       ├── main.py                 # Service entry point
│       ├── requirements.txt        # Python dependencies
│       └── README.md               # Service documentation
│
├── .github/workflows/              # CI/CD automation
│   ├── index.yml                   # Main workflow (lint, test, build)
│   ├── cron--weekly.yml            # Weekly security scans
│   └── playwright-mcp.yml          # Playwright MCP setup
│
├── scripts/                        # Automation scripts
│   ├── setup-monorepo.sh           # Automated setup (Unix)
│   ├── setup-monorepo.ps1          # Automated setup (Windows)
│   ├── setup-playwright-mcp.sh     # Playwright MCP installer
│   └── verify-structure.cjs        # Structure validator
│
└── docs/                           # Technical documentation
```

### Language Boundaries

- **🟦 TypeScript Zone**: `packages/`, `apps/` (except `apps/agent-server/`)
  - Uses **Yarn Berry** with Plug'n'Play
  - Managed by **Turborepo** for builds
  
- **🐍 Python Zone**: `services/`, `apps/agent-server/`
  - Each service has **isolated virtual environment** (`.venv/` or `venv/`)
  - Uses **pip** or **Poetry** for dependency management
  - Never share virtual environments between services

## 🛠️ Technology Stack

### Frontend

- **Frameworks**: React 18, Next.js 14
- **Language**: TypeScript 4.9+
- **AI Integration**: CopilotKit 1.5+
- **Package Manager**: Yarn 3.3 (Berry with PnP)
- **Monorepo Tool**: Turborepo 2.6+
- **Testing**: Jest (unit), Cypress (e2e)
- **Linting**: ESLint + Prettier

### Backend

- **Framework**: FastAPI 0.109+
- **Language**: Python 3.10+
- **AI Framework**: AG2 (AutoGen) 0.2+
- **Server**: Uvicorn with WebSocket support
- **Validation**: Pydantic 2.5+

### Shared

- **Type Safety**: Zod (TypeScript) ↔ Pydantic (Python)
- **Communication**: WebSockets, REST APIs
- **CI/CD**: GitHub Actions
- **Security**: CodeQL analysis, weekly scans

## 📚 Documentation

### Essential Reading

- **[AGENT.md](./AGENT.md)** - 🤖 **Read this FIRST** if you're an AI agent working in this workspace
- **[ProjectOverview.md](./ProjectOverview.md)** - Vision, architecture, and conceptual design
- **[copilot-instructions.md](./copilot-instructions.md)** - Agent-specific patterns and workflows

### Technical Guides

- [Getting started](./docs/GETTING_STARTED.md) - Detailed setup instructions
- [Adding a React application](./docs/REACT_APPLICATION.md) - Create new frontend apps
- [Adding a React module](./docs/REACT_MODULE.md) - Create reusable React libraries
- [Contributing](./docs/CONTRIBUTING.md) - Contribution guidelines
- [Debugging](./docs/DEBUGGING.md) - Troubleshooting common issues

### Service Documentation

- [python-brain Service](./services/python-brain/README.md) - FastAPI + AG2 backend service

## 📦 Package Management

### TypeScript/JavaScript Commands

```bash
# Install all dependencies
yarn install

# Build all packages (Turborepo)
yarn build

# Start all apps in development mode
yarn dev

# Lint all workspaces
yarn lint

# Run tests
yarn test

# Run command in specific workspace
yarn workspace <workspace-name> <command>

# Example: Build only the Next app
yarn workspace example-next-application run build
```

### Python Service Commands

**For `services/python-brain`:**
```bash
cd services/python-brain
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

## Features

- **Cloudflare purge** for _cache busting_
- **CodeQL** for _security analysis_
- **Cypress** for _end-to-end testing_
- **ESLint** for _linting_
- **GitHub Actions** for _continuous integration_ and _continuous delivery_
- **Jest** for _unit testing_
- **Prettier** for _code formatting_
- **React Scripts** for _application development_
- **Rollup** for _module bundling_
- **TypeScript** for _static typing_
- **Yarn** (latest) for _workspaces_
- **FastAPI** for _Python backend services_
- **AG2 (AutoGen)** for _multi-agent systems_

All with _clear boundaries_ and _completely extensible_ if deviation is desired.

## 🔒 Security & Privacy

- ✅ **Local-first**: No cloud dependencies required
- ✅ **Gitignored secrets**: `.env` files and API keys never committed
- ✅ **Isolated environments**: Python virtual environments prevent conflicts
- ✅ **CodeQL scanning**: Automated security analysis weekly
- ✅ **Audit trail**: All operations can be tracked

**Never commit:**
- `.env` files (use `.env.example` templates)
- Virtual environments (`.venv/`, `venv/`)
- API keys or secrets
- Client data or PII

## 🧪 Testing

**Frontend Testing:**
```bash
# Unit tests (Jest)
yarn test

# E2E tests (Cypress)
yarn workspace example-react-application run cypress:start
yarn workspace example-react-application run cypress:run

# Coverage report
yarn workspace example-react-application run coverage
```

**Backend Testing:**
```bash
cd services/python-brain
source .venv/bin/activate
pytest  # (when tests are added)
```

## 🚢 CI/CD Workflows

GitHub Actions workflows automatically run on push/PR:

- **index.yml**: CodeQL analysis, ESLint, Jest tests
- **cron--weekly.yml**: Weekly security scans
- **example-*.yml**: Package-specific builds and tests
- **playwright-mcp.yml**: Playwright MCP setup

## 🤝 Contributing

1. **Read [AGENT.md](./AGENT.md)** - Understand workspace boundaries
2. **Create a feature branch** - Never commit directly to `main`
3. **Follow isolation rules** - Don't mix Python and Node dependencies
4. **Update documentation** - Keep READMEs and AGENT.md current
5. **Test locally** - Run linting and tests before pushing
6. **Submit a PR** - Use the pull request template

## 🆘 Troubleshooting

### "Yarn can't find workspace"
```bash
yarn install  # From root
# Check package.json workspaces array includes your new workspace
```

### "Python module not found"
```bash
source .venv/bin/activate  # Activate virtual environment
pip install -r requirements.txt
```

### "Port already in use"
```bash
# Find and kill the process using the port
lsof -ti:8000 | xargs kill -9  # Mac/Linux
# Or use a different port:
uvicorn main:app --reload --port 8001
```

### "Workflow not triggering"
Check `.github/workflows/<workflow>.yml` triggers:
```yaml
on:
  push:
    paths:
      - 'packages/your-package/**/*'  # Must match your changes
```

## 📖 Learning Resources

- **Monorepos**: [Yarn Workspaces](https://yarnpkg.com/features/workspaces), [Turborepo](https://turbo.build/repo/docs)
- **Generative UI**: [CopilotKit Docs](https://docs.copilotkit.ai/)
- **Multi-Agent Systems**: [AG2 GitHub](https://github.com/ag2ai/ag2)
- **FastAPI**: [FastAPI Documentation](https://fastapi.tiangolo.com/)

## 📝 Project Status

**Current Focus**: Experimental development workspace for Generative UI and multi-agent architectures  
**Stability**: Active development - not production-ready  
**Use Case**: Personal learning project and template for similar initiatives

## 📄 License

MIT License - See [LICENSE](./LICENSE) for details

---

**Made with ❤️ for exploring the future of AI-driven interfaces**
