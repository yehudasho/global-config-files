FROM python:3.9
COPY index.html index.html
CMD ["python", "-m", "http.server", "8000"]
