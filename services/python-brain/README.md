# Python Brain Service

A FastAPI-based backend service for multi-agent systems integration using AG2 (AutoGen).

## Overview

This service provides a REST API for AI agent interactions and multi-agent orchestration. It's designed to work with the GenerativeUI frontend applications in this monorepo.

## Features

- **FastAPI Framework**: Modern, fast async API framework
- **CORS Enabled**: Pre-configured for frontend integration
- **AG2 Integration**: Ready for pyautogen multi-agent workflows
- **Isolated Environment**: Uses its own Python virtual environment

## Technology Stack

- **Framework**: FastAPI 0.109+
- **Server**: Uvicorn with auto-reload
- **AI Framework**: pyautogen (AG2)
- **Python**: 3.10+

## Setup

### Prerequisites

- Python 3.10 or higher
- pip (Python package installer)

### Installation

1. **Navigate to the service directory:**
   ```bash
   cd services/python-brain
   ```

2. **Create a virtual environment:**
   ```bash
   python -m venv .venv
   ```

3. **Activate the virtual environment:**
   
   **Linux/Mac:**
   ```bash
   source .venv/bin/activate
   ```
   
   **Windows (PowerShell):**
   ```powershell
   .\.venv\Scripts\Activate.ps1
   ```
   
   **Windows (Command Prompt):**
   ```cmd
   .venv\Scripts\activate.bat
   ```

4. **Install dependencies:**
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

## Running the Service

### Development Mode (with auto-reload)

```bash
# Make sure virtual environment is activated
source .venv/bin/activate  # Linux/Mac
# or
.\.venv\Scripts\Activate.ps1  # Windows

# Start the server
uvicorn main:app --reload --port 8000
```

The API will be available at:
- **API Endpoint**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs (Swagger UI)
- **Alternative Docs**: http://localhost:8000/redoc (ReDoc)

### Production Mode

```bash
uvicorn main:app --host 0.0.0.0 --port 8000
```

## API Endpoints

### GET `/`

**Health check endpoint**

**Response:**
```json
{
  "message": "AG2 Brain is Online",
  "status": "ready"
}
```

## Project Structure

```
services/python-brain/
├── .venv/              # Virtual environment (gitignored)
├── main.py             # FastAPI application entry point
├── requirements.txt    # Python dependencies
└── README.md          # This file
```

## Environment Variables

Currently, no environment variables are required for basic operation. As you add features, create a `.env` file:

```bash
# Example .env file
PORT=8000
HOST=0.0.0.0
LOG_LEVEL=info
```

## Dependencies

- **fastapi**: Web framework
- **uvicorn**: ASGI server
- **pyautogen**: AG2 multi-agent framework

See `requirements.txt` for versions.

## Development Guidelines

### Adding New Endpoints

1. Define your route in `main.py` or create a new router module
2. Use FastAPI's dependency injection for shared resources
3. Add Pydantic models for request/response validation
4. Document your endpoints using FastAPI's automatic documentation

### Example: Adding a New Route

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class AgentRequest(BaseModel):
    message: str
    agent_type: str

@app.post("/agent/chat")
async def chat_with_agent(request: AgentRequest):
    # Your agent logic here
    return {"response": "Agent response", "agent": request.agent_type}
```

### Testing

```bash
# Install dev dependencies
pip install pytest pytest-asyncio httpx

# Run tests (when test files are added)
pytest
```

## Integration with Frontend

This service is configured to work with the Next.js and React applications in this monorepo:

```typescript
// Example frontend integration
const response = await fetch('http://localhost:8000/', {
  method: 'GET',
});
const data = await response.json();
console.log(data.message); // "AG2 Brain is Online"
```

## Troubleshooting

### Issue: "Command 'uvicorn' not found"

**Solution**: Make sure your virtual environment is activated and dependencies are installed:
```bash
source .venv/bin/activate
pip install -r requirements.txt
```

### Issue: "ModuleNotFoundError: No module named 'fastapi'"

**Solution**: Install dependencies in the virtual environment:
```bash
pip install -r requirements.txt
```

### Issue: "Port 8000 is already in use"

**Solution**: Either stop the other service or use a different port:
```bash
uvicorn main:app --reload --port 8001
```

## Next Steps

1. **Add Authentication**: Implement API key or OAuth2 authentication
2. **Add AG2 Agents**: Create multi-agent workflows using pyautogen
3. **Add Database**: Integrate SQLite or PostgreSQL for persistence
4. **Add WebSocket Support**: Enable real-time bidirectional communication
5. **Add Testing**: Create pytest test suites for endpoints

## Related Documentation

- [AGENT.md](../../AGENT.md) - Workspace boundaries and rules
- [ProjectOverview.md](../../ProjectOverview.md) - Project vision and architecture
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [AG2 Documentation](https://github.com/ag2ai/ag2)

## License

Same as parent monorepo (see root LICENSE file).
