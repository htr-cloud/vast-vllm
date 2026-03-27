FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV VIRTUAL_ENV=/opt/vllm
ENV PATH="/opt/vllm/bin:$PATH"
ENV HF_HOME=/opt/vllm/hf_cache
ENV TRITON_CACHE_DIR=/opt/vllm/triton_cache
ENV PYTORCH_ALLOC_CONF=expandable_segments:True

RUN apt-get update -y && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python-is-python3 \
    curl \
    wget \
    git \
    openssh-server \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN python3 -m venv $VIRTUAL_ENV && \
    pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir vllm

RUN mkdir -p $HF_HOME $TRITON_CACHE_DIR /app

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 22 8000

CMD ["/app/start.sh"]
