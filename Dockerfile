# Basis: Ubuntu 22.04 mit vorinstalliertem CUDA 12.4 Toolkit
FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

# Verhindert interaktive Prompts während der Installation
ENV DEBIAN_FRONTEND=noninteractive

# 1. System-Abhängigkeiten installieren
# Dein Skript benötigt Python 3, venv, curl (für Readiness-Checks) und SSH.
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
# Vast.ai injiziert zwar oft eigene Keys, aber der SSH-Daemon muss laufen.
RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 3. Zielverzeichnis für dein Skript erstellen
RUN mkdir -p /opt/vllm

# 4. Container am Leben halten
# Vast.ai erfordert, dass der Container nicht sofort beendet wird.
# Wir starten den SSH-Dienst und halten den Container unendlich offen.
CMD ["/bin/bash", "-c", "/usr/sbin/sshd && sleep infinity"]
