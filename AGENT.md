# AGENT.md - Workspace Context for AI Agents

> **Purpose**: This document provides AI agents with clear context, boundaries, and rules for working within this monorepo. Read this file FIRST before making any changes or suggestions.

---

## 🎯 Workspace Identity

**Name**: GenerativeUI_monorepo  
**Type**: Development Workspace & Template Repository  
**Purpose**: Experimental monorepo for building Generative UI systems and multi-agent architectures  
**Status**: Active Development (Not Production-Ready)  
**Philosophy**: Local-first, privacy-focused, multi-paradigm exploration workspace

---

## 🏗️ Architecture Overview

This monorepo is a **hybrid multi-language workspace** that combines:

1. **Frontend Packages** (TypeScript/React/Next.js) - Yarn Berry with PnP
2. **Backend Services** (Python) - Independent virtual environments
3. **Shared Tooling** - Cross-language schemas, scripts, and workflows

### Key Design Principles

- ✅ **Polyglot by Design**: JavaScript/TypeScript AND Python coexist peacefully
- ✅ **Isolated Dependencies**: Each subsystem has its own dependency management
- ✅ **Local-First**: No cloud dependencies required for core functionality
- ✅ **Template-Ready**: Structure designed to be copied and adapted
- ✅ **Auditability**: All changes should be trackable and reversible

---

## 📂 Workspace Structure & Boundaries

```
GenerativeUI_monorepo/
│
├── .github/workflows/          # CI/CD automation (GitHub Actions)
│   ├── index.yml              # Main monorepo workflow (CodeQL, ESLint, Jest)
│   ├── cron--weekly.yml       # Scheduled security scans
│   ├── example-*.yml          # Package-specific workflows
│   └── playwright-mcp.yml     # Playwright MCP setup workflow
│
├── packages/                   # 🟦 TYPESCRIPT ZONE - Yarn Workspaces
│   ├── example-react-application/    # React app (CRA)
│   ├── example-next-application/     # Next.js app
│   └── example-react-module/         # Reusable React library
│
├── apps/                       # 🟦 TYPESCRIPT ZONE - Application workspaces
│   ├── web-dashboard/         # Next.js + CopilotKit dashboard
│   └── agent-server/          # 🐍 PYTHON ZONE - FastAPI backend
│
├── services/                   # 🐍 PYTHON ZONE - Backend services
│   └── python-brain/          # FastAPI + pyautogen service
│       ├── .venv/             # ⚠️ NEVER COMMIT (gitignored)
│       ├── requirements.txt   # Python dependencies
│       └── main.py            # Service entry point
│
├── scripts/                    # Node.js automation scripts
│   ├── verify-structure.cjs   # Monorepo validation
│   └── setup-playwright-mcp.sh # Playwright MCP setup
│
├── docs/                       # Documentation
│   ├── GETTING_STARTED.md
│   ├── REACT_APPLICATION.md
│   └── DEBUGGING.md
│
├── ProjectOverview.md          # 📘 Vision & Architecture Guide
├── copilot-instructions.md     # 🤖 Agent-specific instructions
├── AGENT.md                    # 👈 YOU ARE HERE
├── README.md                   # Public-facing README
├── package.json                # Root workspace config (Yarn)
├── turbo.json                  # Turborepo pipeline config
└── tsconfig.json               # Root TypeScript config

```

---

## 🚨 Critical Rules for AI Agents

### 1. **Virtual Environment Management**

**NEVER commit Python virtual environments:**
- ❌ DO NOT commit `.venv/`, `venv/`, or any `__pycache__/` directories
- ✅ Always check `.gitignore` includes `.venv/`
- ✅ Each Python service has its own isolated virtual environment

**Python Dependency Management:**
```bash
# For services/python-brain/
cd services/python-brain
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

**For apps/agent-server/**
```bash
cd apps/agent-server
# Option A: Poetry (preferred)
poetry install

# Option B: pip + venv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 2. **Workspace Dependencies**

**TypeScript/JavaScript (Yarn Berry):**
```bash
# Install all workspace dependencies
yarn install

# Build shared packages before apps
yarn build

# Run specific workspace commands
yarn workspace <workspace-name> <command>

# Run all workspaces in parallel
yarn workspaces foreach --parallel <command>
```

**Critical Yarn Berry Notes:**
- Uses Plug'n'Play (PnP) - no `node_modules/` in workspaces
- `.yarn/cache/` is gitignored
- `.pnp.cjs` files are generated artifacts
- Always use `yarn` commands, not `npm`

### 3. **Cross-Language Integration**

**Shared Schemas:**
- Located in `packages/shared-schemas/`
- Contains Zod (TypeScript) and Pydantic (Python) type definitions
- Must be built before backend services start: `yarn workspace @generative-ui/shared-schemas build`

**Communication:**
- Frontend ↔ Backend: WebSocket connections
- Schema validation on both sides using Zod/Pydantic
- Environment variables for URLs (`.env.local` for frontend, `.env` for backend)

### 4. **GitHub Workflows**

**Workflow Triggers:**
- `index.yml` - Runs on every push/PR (CodeQL, linting, tests)
- `cron--weekly.yml` - Weekly security scans
- Package-specific workflows - Only run when their paths change

**Adding New Workflows:**
1. Copy existing workflow as template
2. Update `on.push.paths` and `on.pull_request.paths` to target specific directories
3. Adjust job steps for package-specific needs
4. Test locally before committing

### 5. **File Modification Rules**

**DO NOT modify without explicit permission:**
- `.github/workflows/*.yml` (unless specifically asked)
- `package.json` workspaces configuration
- `turbo.json` pipeline configuration
- Root `.gitignore`

**ALWAYS update when adding Python services:**
- Add new service to `.gitignore` if it has `.venv/`
- Document setup steps in service README
- Add service to `services/` directory with clear boundaries

### 6. **Documentation Standards**

**When creating new features:**
1. Update `AGENT.md` with new boundaries/rules
2. Create/update service-specific READMEs
3. Add examples to `ProjectOverview.md` if relevant
4. Update `copilot-instructions.md` for agent-specific patterns

---

## 🛠️ Tool-Specific Contexts

### Frontend Tools (TypeScript Zone)

**Package Manager**: Yarn Berry v3.3+ (PnP mode)  
**Monorepo Tool**: Turborepo v2.6+  
**Testing**: Jest (unit), Cypress (e2e)  
**Linting**: ESLint + Prettier  
**Type Checking**: TypeScript 4.9+

**Key Commands:**
```bash
yarn dev          # Start all apps in dev mode
yarn build        # Build all packages (Turborepo)
yarn lint         # Lint all workspaces
yarn test         # Run all tests
```

### Backend Tools (Python Zone)

**Package Manager**: pip + venv (services/python-brain), Poetry (apps/agent-server)  
**Framework**: FastAPI 0.109+  
**Agent Framework**: AG2 (AutoGen) 0.2+ / pyautogen  
**Type Checking**: Pydantic 2.5+

**Key Commands:**
```bash
# For python-brain
cd services/python-brain
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000

# For agent-server
cd apps/agent-server
poetry install  # or: pip install -r requirements.txt
python -m src.main
```

### Containerization

**DO NOT USE DOCKER** for Python execution.  
✅ Use **MicroSandbox** microVMs for isolated code execution (per `copilot-instructions.md`)

---

## 🧭 Navigation Guide for Agents

### "I need to add a new React component"
→ Go to `packages/example-react-application/src/components/` or `packages/example-next-application/src/components/`

### "I need to add a new Python backend service"
→ Create in `services/<service-name>/` with isolated `.venv` and `requirements.txt`

### "I need to modify CI/CD"
→ Edit `.github/workflows/` - be careful with triggers

### "I need to add shared types"
→ Update `packages/shared-schemas/src/` with Zod schemas

### "I need to understand the project vision"
→ Read `ProjectOverview.md` and `copilot-instructions.md`

### "I need to debug a workflow"
→ Check `docs/DEBUGGING.md` and GitHub Actions logs

---

## 🎓 Learning Resources

**For understanding monorepos:**
- Yarn Workspaces: https://yarnpkg.com/features/workspaces
- Turborepo: https://turbo.build/repo/docs

**For Generative UI:**
- CopilotKit: https://docs.copilotkit.ai/
- AG-UI Architecture: See `ProjectOverview.md`

**For Multi-Agent Systems:**
- AG2 (AutoGen): https://github.com/ag2ai/ag2
- FastAgency: See `copilot-instructions.md`

---

## 🔐 Security & Privacy

**This workspace is designed for:**
- ✅ Local development (no cloud dependencies required)
- ✅ Client data privacy (data never leaves local machine)
- ✅ Offline capability
- ✅ Auditability and compliance

**NEVER commit:**
- `.env` files (use `.env.example` templates)
- API keys or secrets
- Virtual environments (`.venv/`, `venv/`)
- Client data or PII
- `node_modules/` or generated artifacts

---

## 📝 Change Log for Agents

**When making changes, update this section:**

### 2026-01-01
- ✅ Created AGENT.md for workspace context
- ✅ Added `.venv/` to `.gitignore`
- ✅ Removed committed `.venv` files from git history
- ✅ Created `playwright-mcp.yml` workflow
- ✅ Created `scripts/setup-playwright-mcp.sh`

---

## 🤝 Contributing Guidelines

1. **Understand the boundaries** - Read this file completely before changes
2. **Test locally first** - Never commit untested code
3. **Update documentation** - Keep AGENT.md and READMEs current
4. **Respect isolation** - Don't mix Python and Node.js dependencies
5. **Ask before major changes** - This is an experimental workspace

---

## 🆘 Common Issues & Solutions

### Issue: "Yarn can't find workspace"
**Solution**: Run `yarn install` from root, check `package.json` workspaces array

### Issue: "Python module not found"
**Solution**: Activate virtual environment, run `pip install -r requirements.txt`

### Issue: "Workflow not triggering"
**Solution**: Check `on.push.paths` and `on.pull_request.paths` in workflow file

### Issue: "Type errors in shared schemas"
**Solution**: Run `yarn workspace @generative-ui/shared-schemas build` first

---

## 📞 Need Help?

1. Check `ProjectOverview.md` for vision and architecture
2. Check `copilot-instructions.md` for agent-specific patterns
3. Check service-specific READMEs in `apps/` and `services/`
4. Review GitHub Issues for known problems
5. Ask the human maintainer for clarification

---

**Last Updated**: 2026-01-01  
**Maintained By**: AI Agents + Human Oversight  
**Version**: 1.0.0
