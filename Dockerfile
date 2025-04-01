FROM python:3.9
WORKDIR /app
COPY . .
CMD ["python", "-c", "print('Hello from Python in Docker!')"]
