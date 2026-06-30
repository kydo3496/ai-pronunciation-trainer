cat > Dockerfile << 'EOF'
FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=7860
EXPOSE 7860

ENV HF_HOME=/tmp/huggingface
ENV XDG_CACHE_HOME=/tmp/cache
RUN mkdir -p /tmp/huggingface /tmp/cache && chmod -R 777 /tmp/huggingface /tmp/cache

CMD ["python", "webApp.py"]
EOF