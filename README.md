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

## Features

- **Cloudflare purge** for _cache busting_
- **CodeQL** for _security analysis_
- **Cypress** for _end-to-end testing_
- **ESLint** for _linting_
- **GitHub Actions** for _continuous integration_ and _continuous delivery_
- **GitHub Packages** and **NPM** for _package publishing_
- **GitHub Pages** for _static asset deployments_
- **Jest** for _unit testing_
- **Node** (latest) for _compatibility_
- **NYC** for _code coverage reports_
- **Prettier** for _code formatting_
- **React Scripts** for _application development_
- **Rollup** for _module bundling_
- **Sentry release** for _source mapping_
- **TypeScript** for _static typing_
- **Visual Studio Code** for _code editing_
- **Yarn** (latest) for _workspaces_

All with _zero configuration_ and _completely extensible_ if deviation is
desired.

---

[![Monorepo](https://github.com/monorepo-template/monorepo-template/actions/workflows/index.yml/badge.svg?branch=main&event=push)](https://github.com/monorepo-template/monorepo-template/actions/workflows/index.yml)
[![Cron (weekly)](https://github.com/monorepo-template/monorepo-template/actions/workflows/cron--weekly.yml/badge.svg?branch=main&event=push)](https://github.com/monorepo-template/monorepo-template/actions/workflows/cron--weekly.yml)

[![Next application](https://github.com/monorepo-template/monorepo-template/actions/workflows/example-next-application.yml/badge.svg?branch=main&event=push)](https://github.com/monorepo-template/monorepo-template/actions/workflows/example-next-application.yml)

[![React application](https://github.com/monorepo-template/monorepo-template/actions/workflows/example-react-application.yml/badge.svg?branch=main&event=push)](https://github.com/monorepo-template/monorepo-template/actions/workflows/example-react-application.yml)
[![Cypress](https://img.shields.io/endpoint?url=https://dashboard.cypress.io/badge/simple/4akrvv/main&label=Cypress&style=flat)](https://dashboard.cypress.io/projects/4akrvv/runs)

[![React module](https://github.com/monorepo-template/monorepo-template/actions/workflows/example-react-module.yml/badge.svg?branch=main&event=push)](https://github.com/monorepo-template/monorepo-template/actions/workflows/example-react-module.yml)
[![downloads](https://img.shields.io/npm/dt/@monorepo-template/example-react-module.svg)](https://www.npmjs.com/package/@monorepo-template/example-react-module)
[![minzipped size](https://img.shields.io/bundlephobia/minzip/@monorepo-template/example-react-module.svg?label=minzipped%20size)](https://www.npmjs.com/package/@monorepo-template/example-react-module)
[![version](https://img.shields.io/npm/v/@monorepo-template/example-react-module.svg?label=version)](https://www.npmjs.com/package/@monorepo-template/example-react-module)

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

## Packages

### Next application

- To build the application, run
  `yarn packages/example-next-application run build`.
- To end-to-end test your application, run
  `yarn packages/example-next-application run cypress:start` to first run the
  development server with code coverage reporting enabled, then run
  `yarn packages/example-next-application run cypress:run`.
- To lint your changes to the application, run
  `yarn packages/example-next-application run eslint`.
- To unit test your changes to the application, run
  `yarn packages/example-next-application run jest`.
- To unit test your changes to the application in watch mode, run
  `yarn packages/example-next-application run jest:watch`.
- To start the application development server, run
  `yarn packages/example-next-application run start`.

### React application

- To build the application, run
  `yarn packages/example-react-application run build`.
- To report Cypress's and Jest's combined test coverage, run
  `yarn packages/example-react-application run coverage`. The combined report
  will be located in `/packages/example-react-application/coverage/`.
- To end-to-end test your application, run
  `yarn packages/example-react-application run cypress:start` to first run the
  development server with code coverage reporting enabled, then run
  `yarn packages/example-react-application run cypress:run`.
- To lint your changes to the application, run
  `yarn packages/example-react-application run eslint`.
- To unit test your changes to the application, run
  `yarn packages/example-react-application run jest`.
- To unit test your changes to the application in watch mode, run
  `yarn packages/example-react-application run jest:watch`.
- To start the application development server, run
  `yarn packages/example-react-application run start`.

### React module

- To lint your changes to the module, run
  `yarn packages/example-react-module run eslint`.
- To automatically fix lint errors in the module, run
  `yarn packages/example-react-module run eslint:fix`.
- To unit test your changes to the module, run
  `yarn packages/example-react-module run jest`.
- To unit test your changes to the module in watch mode, run
  `yarn packages/example-react-module run jest:watch`.
- To build the module, run `yarn packages/example-react-module run rollup`.
- To build the module in watch mode, run
  `yarn packages/example-react-module run rollup:watch`.
