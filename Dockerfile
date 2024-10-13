# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Pass in the name of the module group to install dependencies for
ARG MODULE_GROUP  

# Set PYTHONPATH
ENV PYTHONPATH=/app/src:/app

# Set the working directory in the container
WORKDIR /app

# Install system dependencies required by pygame
RUN apt-get update && apt-get install -y \
    libsdl2-mixer-2.0-0 \
    libglib2.0-dev \
    libasound2-dev \
    alsa-utils \
    pulseaudio \
    && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app
COPY . /app

# Create logs directory
RUN mkdir -p resources/logs

# Install Poetry
RUN pip install poetry
RUN echo "MODULE_GROUP is set to: $MODULE_GROUP"

# Install the Python dependencies using Poetry
RUN poetry install --with $MODULE_GROUP --without dev --no-interaction --no-ansi -vvv