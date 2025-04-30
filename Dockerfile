
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl git sudo bash && \
    rm -rf /var/lib/apt/lists/*

# Install Ollama (CPU version – works on Apple Silicon)
RUN curl -fsSL https://ollama.com/install.sh | bash

# Add Ollama to PATH
ENV PATH="/root/.ollama/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Copy local files to the container
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose necessary ports
EXPOSE 11434 3000

# Start Ollama and the LangChain app
CMD bash -c "ollama serve & sleep 5 && ollama pull deepseek-coder:1.3b && python3 app/main.py"
