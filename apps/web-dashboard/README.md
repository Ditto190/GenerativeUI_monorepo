# Web Dashboard

Next.js 14 + CopilotKit application for the Generative UI system.

## Features

- **GenerativeCanvas Component**: Renders UI dynamically based on AI agent state
- **CopilotKit Integration**: AI-powered chat interface for user interaction
- **WebSocket Connection**: Real-time updates from the agent server
- **Type-Safe**: Uses shared Zod schemas for type safety

## Getting Started

1. Install dependencies:
   ```bash
   yarn install
   ```

2. Set environment variables:
   ```bash
   # .env.local
   NEXT_PUBLIC_AGENT_SERVER_WS_URL=ws://localhost:8000/ws/agent
   ```

3. Run the development server:
   ```bash
   yarn dev
   ```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

## Components

### GenerativeCanvas

The main component that renders UI based on agent actions. It supports multiple component types:
- Text components
- Card components
- List components
- Custom components

### useAgentState Hook

Custom hook that manages WebSocket connection to the agent server and handles state updates.

## Environment Variables

- `NEXT_PUBLIC_AGENT_SERVER_WS_URL`: WebSocket URL for the agent server (default: `ws://localhost:8000/ws/agent`)
