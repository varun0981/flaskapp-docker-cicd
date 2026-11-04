
FROM python:3.14-slim

WORKDIR /app

# Copy dependencies first
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code afterward
COPY . .

EXPOSE 80

RUN useradd -m appuser
USER appuser

CMD ["python", "run.py"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:80')"
