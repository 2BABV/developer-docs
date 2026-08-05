FROM python:3.12-slim

WORKDIR /docs

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

# Bind to 0.0.0.0 so the port is reachable outside the container
CMD ["python", "-m", "mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
