#!/usr/bin/env bash
set -euo pipefail

MODEL_NAME="${MODEL_NAME:-mistralai/Devstral-Small-2-24B-Instruct-2512}"
VLLM_PORT="${VLLM_PORT:-8000}"
MAX_MODEL_LEN="${MAX_MODEL_LEN:-4096}"
GPU_MEMORY_UTIL="${GPU_MEMORY_UTIL:-0.80}"
EXTRA_ARGS="${EXTRA_ARGS:---tool-call-parser mistral --enable-auto-tool-choice}"

exec vllm serve "$MODEL_NAME" \
  --host 0.0.0.0 \
  --port "$VLLM_PORT" \
  --max-model-len "$MAX_MODEL_LEN" \
  --gpu-memory-utilization "$GPU_MEMORY_UTIL" \
  --tool-call-parser mistral \
  --enable-auto-tool-choice#!/usr/bin/env bash
set -euo pipefail

/usr/sbin/sshd

MODEL_NAME="${MODEL_NAME:-mistralai/Devstral-Small-2-24B-Instruct-2512}"
VLLM_PORT="${VLLM_PORT:-8000}"
MAX_MODEL_LEN="${MAX_MODEL_LEN:-8192}"
GPU_MEMORY_UTIL="${GPU_MEMORY_UTIL:-0.90}"
DTYPE="${DTYPE:-auto}"
EXTRA_ARGS="${EXTRA_ARGS:---tool-call-parser mistral --enable-auto-tool-choice}"

echo "Starting vLLM"
echo "MODEL_NAME=${MODEL_NAME}"
echo "VLLM_PORT=${VLLM_PORT}"
echo "MAX_MODEL_LEN=${MAX_MODEL_LEN}"
echo "GPU_MEMORY_UTIL=${GPU_MEMORY_UTIL}"
echo "DTYPE=${DTYPE}"
echo "EXTRA_ARGS=${EXTRA_ARGS}"

exec vllm serve "$MODEL_NAME" \
  --host 0.0.0.0 \
  --port "$VLLM_PORT" \
  --dtype "$DTYPE" \
  --gpu-memory-utilization "$GPU_MEMORY_UTIL" \
  --max-model-len "$MAX_MODEL_LEN" \
  --trust-remote-code \
  $EXTRA_ARGS
