FROM python:3.9
WORKDIR /app
COPY index.html /app/index.html
CMD ["python", "-m", "http.server", "8000"]
