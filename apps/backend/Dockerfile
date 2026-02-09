# -------- Builder stage --------
FROM python:3.12-slim AS builder
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# -------- Runtime stage --------
FROM python:3.12-slim
WORKDIR /app

# Create non-root user
RUN useradd -u 10001 appuser

# Copy Python libs AND binaries
COPY --from=builder /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --from=builder /usr/local/bin /usr/local/bin

COPY app app

USER 10001

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

