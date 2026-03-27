FROM vllm/vllm-openai:latest

ENV HF_HOME=/opt/hf_home
ENV TRITON_CACHE_DIR=/opt/triton_cache
ENV PYTORCH_ALLOC_CONF=expandable_segments:True

RUN mkdir -p /opt/hf_home /opt/triton_cache /app

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8000

CMD ["/app/start.sh"]
