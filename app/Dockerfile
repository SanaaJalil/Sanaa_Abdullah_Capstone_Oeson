# -------- Stage 1: Build --------
FROM python:3.11-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends gcc

WORKDIR /build

COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

COPY src/ ./src/

# -------- Stage 2: Final image --------
FROM python:3.11-slim

RUN useradd -m appuser

WORKDIR /app

COPY --from=builder /install /usr/local
COPY --from=builder /build/src /app

ENV PATH="/usr/local/bin:$PATH"
ENV PYTHONPATH="/usr/local/lib/python3.11/site-packages"

USER appuser

EXPOSE 8080

CMD ["python", "app.py"]
