FROM python:3.11-slim

# Set metadata
LABEL maintainer="AI Invoice Extractor Team"
LABEL description="Invoice Extraction System for PDF invoices"

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY invoice_extractor.py .
COPY models/ ./models/

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Run the application
CMD ["python", "invoice_extractor.py"]