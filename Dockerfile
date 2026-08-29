# Glama (and anyone else) can run the hosted Stipple MCP server from this image.
# It is a thin stdio bridge: mcp-remote proxies stdio JSON-RPC to the live
# Streamable HTTP endpoint. The implementation lives in the product monorepo;
# this repo is the public face of the hosted service.
FROM node:22-alpine
RUN npm install -g mcp-remote
# --transport http-only: the endpoint is stateless Streamable HTTP (no SSE fallback needed)
ENTRYPOINT ["mcp-remote", "https://www.stipple.sh/mcp", "--transport", "http-only"]
