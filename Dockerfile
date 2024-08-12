# FROM ubuntu:18.04

# # Prerequisites
# RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

# # Setup new user
# RUN useradd -ms /bin/bash developer
# USER developer
# WORKDIR /home/developer

# # Prepare Android directories and system variables
# RUN mkdir -p Android/sdk
# ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
# RUN mkdir -p .android && touch .android/repositories.cfg

# # Setup Android SDK
# RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
# RUN unzip sdk-tools.zip && rm sdk-tools.zip
# RUN mv tools Android/sdk/tools
# RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
# RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
# ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# # Download Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git
# ENV PATH "$PATH:/home/developer/flutter/bin"

# # Run basic check to download Dark SDK
# RUN flutter doctor

###############################################################################
# Use Ubuntu as the base image
FROM ubuntu:latest

# Set non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Use a faster mirror (optional, adjust to your region)
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.speedpartner.de/ubuntu/|g' /etc/apt/sources.list

# Update package sources and upgrade the system
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

# Install essential dependencies
RUN apt-get install -y \
    git \
    wget \
    curl \
    unzip \
    build-essential \
    cmake \
    ninja-build \
    g++ \
    clang \
    libgl1-mesa-dev \
    libgles2-mesa-dev \
    libegl1-mesa-dev \
    libdrm-dev \
    libgbm-dev \
    fontconfig \
    libsystemd-dev \
    libinput-dev \
    libudev-dev \
    libxkbcommon-dev \
    libglfw3-dev \
    libwayland-dev \
    pkg-config \
    liblz4-tool \
    libgtk-3-dev \
    qemu-user-static && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the timezone
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /usr/local/flutter

# Set Flutter environment variables
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
# Set the CXX environment variable to g++
ENV CXX=g++

# Create a non-root user and switch to that user
RUN useradd -ms /bin/bash flutteruser

# Change ownership of the Flutter directory
RUN chown -R flutteruser:flutteruser /usr/local/flutter

# Switch to the non-root user
USER flutteruser
WORKDIR /home/flutteruser

# Run flutter doctor to verify the setup
RUN flutter doctor -v

# Pre-download Flutter dependencies
RUN flutter precache 

# Clone flutter-pi repository
RUN git clone https://github.com/ardera/flutter-pi.git /home/flutteruser/flutter-pi

# Build flutter-pi
WORKDIR /home/flutteruser/flutter-pi
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# Clone the Flutter Gallery repository
WORKDIR /home/flutteruser
RUN git clone https://github.com/flutter/gallery.git /home/flutteruser/gallery

# Change ownership of the cloned repository
USER root
RUN chown -R flutteruser:flutteruser /home/flutteruser/gallery

# Switch back to non-root user
USER flutteruser

# Navigate to the gallery directory and install dependencies
WORKDIR /home/flutteruser/gallery
RUN flutter pub get

# RUN flutter build linux

# # Build the Flutter Gallery project
# RUN flutter build bundle

# Expose the necessary port (if your Flutter app serves on a port)
EXPOSE 8080

# Default command to run when the container starts
CMD ["bash"]

#############################################

# # Base image
# FROM ubuntu:20.04

# # Install dependencies
# RUN apt-get update && apt-get install -y \
#     openjdk-11-jdk \
#     wget \
#     unzip \
#     curl \
#     git

# # Set environment variables
# ENV ANDROID_SDK_ROOT=/home/developer/Android/sdk
# ENV PATH "${PATH}:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/tools/bin"

# # Install Android SDK
# RUN mkdir -p ${ANDROID_SDK_ROOT} && \
#     cd ${ANDROID_SDK_ROOT} && \
#     wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip && \
#     unzip commandlinetools-linux-8512546_latest.zip && \
#     rm commandlinetools-linux-8512546_latest.zip && \
#     mv tools ${ANDROID_SDK_ROOT}/tools

# # Update SDK and accept licenses
# RUN cd ${ANDROID_SDK_ROOT}/tools/bin && \
#     ./sdkmanager --update && \
#     yes | ./sdkmanager --licenses

# # Install required SDK packages
# RUN cd ${ANDROID_SDK_ROOT}/tools/bin && \
#     ./sdkmanager "build-tools;29.0.2" "platform-tools" "platforms;android-29" "sources;android-29"

# # Set environment variables for build tools
# ENV PATH "${PATH}:${ANDROID_SDK_ROOT}/build-tools/29.0.2"

# # Additional setup or application-specific configurations
# # COPY . /app
# # WORKDIR /app
# # RUN ./gradlew build

# # Default command
# CMD ["bash"]

