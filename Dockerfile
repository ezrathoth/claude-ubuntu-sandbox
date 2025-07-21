# Claude Ubuntu Sandbox Dockerfile
# Multi-stage build for a persistent Ubuntu environment with Claude integration

# Stage 1: Base Ubuntu with desktop environment
FROM ubuntu:22.04 AS base

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages and desktop environment
RUN apt-get update && apt-get install -y \
    ubuntu-desktop-minimal \
        xfce4 \
            xfce4-terminal \
                tightvncserver \
                    novnc \
                        websockify \
                            sudo \
                                curl \
                                    wget \
                                        git \
                                            python3 \
                                                python3-pip \
                                                    python3-venv \
                                                        nodejs \
                                                            npm \
                                                                net-tools \
                                                                    nano \
                                                                        vim \
                                                                            htop \
                                                                                && apt-get clean \
                                                                                    && rm -rf /var/lib/apt/lists/*
