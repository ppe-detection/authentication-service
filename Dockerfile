# syntax=docker/dockerfile:1

FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# Install system deps (optional but common for SSL/DNS)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl && \
    rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy app
COPY app.py /app/

# Expose container port
EXPOSE 8080

# Start server
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
