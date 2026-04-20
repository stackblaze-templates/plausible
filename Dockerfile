FROM ghcr.io/plausible/community-edition:v2

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD wget -qO- http://localhost:8000/api/health || exit 1
