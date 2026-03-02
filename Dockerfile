# Basis: Ubuntu 22.04 mit vorinstalliertem CUDA 12.4 Toolkit
FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

# Verhindert interaktive Prompts während der apt-Installation
ENV DEBIAN_FRONTEND=noninteractive

# 1. System-Abhängigkeiten installieren
RUN apt-get update -y && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python-is-python3 \
    curl \
    wget \
    git \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# 2. SSH für Vast.ai vorbereiten
RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 3. Python venv erstellen und in den PATH laden
ENV VIRTUAL_ENV=/opt/vllm
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 4. vLLM und Agent-Abhängigkeiten installieren
# Wir nutzen den CUDA 12.4 Index für PyTorch, um Kompatibilität zu garantieren
RUN pip install --no-cache-dir --upgrade pip wheel setuptools && \
    pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124 && \
    pip install --no-cache-dir vllm fastapi uvicorn

# 5. Container am Leben halten und SSH starten
CMD ["/bin/bash", "-c", "/usr/sbin/sshd && sleep infinity"]
