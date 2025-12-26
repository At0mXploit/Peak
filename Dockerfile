FROM python:3.11-slim

WORKDIR /app

# Install system dependencies for psycopg2 and building Python packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    make \
    libc-dev \
    postgresql-client \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Install uv
RUN pip install --no-cache-dir uv

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies using uv sync
RUN uv sync --frozen --no-dev

# Copy application code
COPY app ./app

EXPOSE 8000

CMD ["uv", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
