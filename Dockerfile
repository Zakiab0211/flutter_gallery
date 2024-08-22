###############################################################################
# Use Ubuntu as the base image
# FROM ubuntu:latest

# # Set non-interactive to avoid prompts during package installation
# ENV DEBIAN_FRONTEND=noninteractive

# # Use a faster mirror (optional, adjust to your region)
# RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.speedpartner.de/ubuntu/|g' /etc/apt/sources.list

# # Update package sources and upgrade the system
# RUN apt-get update -y && \
#     apt-get upgrade -y && \
#     apt-get dist-upgrade -y

# # Install essential dependencies
# RUN apt-get install -y \
#     git \
#     wget \
#     curl \
#     unzip \
#     build-essential \
#     cmake \
#     ninja-build \
#     g++ \
#     clang \
#     libgl1-mesa-dev \
#     libgles2-mesa-dev \
#     libegl1-mesa-dev \
#     libdrm-dev \
#     libgbm-dev \
#     fontconfig \
#     libsystemd-dev \
#     libinput-dev \
#     libudev-dev \
#     libxkbcommon-dev \
#     libglfw3-dev \
#     libwayland-dev \
#     pkg-config \
#     liblz4-tool \
#     libgtk-3-dev \
#     qemu-user-static && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# # Set the timezone
# ENV TZ=Europe/Rome
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# # Install Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /usr/local/flutter

# # Set Flutter environment variables
# ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
# # Set the CXX environment variable to g++
# ENV CXX=g++

# # Create a non-root user and switch to that user
# RUN useradd -ms /bin/bash flutteruser

# # Change ownership of the Flutter directory
# RUN chown -R flutteruser:flutteruser /usr/local/flutter

# # Switch to the non-root user
# USER flutteruser
# WORKDIR /home/flutteruser

# # Run flutter doctor to verify the setup
# RUN flutter doctor -v

# # Pre-download Flutter dependencies
# RUN flutter precache 

# # Clone flutter-pi repository
# RUN git clone https://github.com/ardera/flutter-pi.git /home/flutteruser/flutter-pi

# # Build flutter-pi
# WORKDIR /home/flutteruser/flutter-pi
# RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# # Clone the Flutter Gallery repository
# WORKDIR /home/flutteruser
# RUN git clone https://github.com/flutter/gallery.git /home/flutteruser/gallery

# # Change ownership of the cloned repository
# USER root
# RUN chown -R flutteruser:flutteruser /home/flutteruser/gallery

# # Switch back to non-root user
# USER flutteruser

# # Navigate to the gallery directory and install dependencies
# WORKDIR /home/flutteruser/gallery
# RUN flutter pub get

# # RUN flutter build linux

# # # Build the Flutter Gallery project
# # RUN flutter build bundle

# # Expose the necessary port (if your Flutter app serves on a port)
# EXPOSE 8080

# # Default command to run when the container starts
# CMD ["bash"]

#############################################
# FROM ubuntu:latest

# # Set non-interactive to avoid prompts during package installation
# ENV DEBIAN_FRONTEND=noninteractive

# # Use a faster mirror (optional, adjust to your region)
# RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.speedpartner.de/ubuntu/|g' /etc/apt/sources.list

# # Update package sources and upgrade the system
# RUN apt-get update -y && \
#     apt-get upgrade -y && \
#     apt-get dist-upgrade -y

# # Install essential dependencies
# RUN apt-get install -y \
#     git \
#     wget \
#     curl \
#     unzip \
#     build-essential \
#     cmake \
#     ninja-build \
#     g++ \
#     clang \
#     libgl1-mesa-dev \
#     libgles2-mesa-dev \
#     libegl1-mesa-dev \
#     libdrm-dev \
#     libgbm-dev \
#     fontconfig \
#     libsystemd-dev \
#     libinput-dev \
#     libudev-dev \
#     libxkbcommon-dev \
#     libglfw3-dev \
#     libwayland-dev \
#     pkg-config \
#     liblz4-tool \
#     libgtk-3-dev \
#     qemu-user-static && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# # Set the timezone
# ENV TZ=Europe/Rome
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# # Install Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /usr/local/flutter

# # Set Flutter environment variables
# ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
# ENV CXX=g++

# # Create a non-root user and switch to that user
# RUN useradd -ms /bin/bash flutteruser

# # Change ownership of the Flutter directory
# RUN chown -R flutteruser:flutteruser /usr/local/flutter

# # Switch to the non-root user
# USER flutteruser
# WORKDIR /home/flutteruser

# # Run flutter doctor to verify the setup
# RUN flutter doctor -v

# # Pre-download Flutter dependencies
# RUN flutter precache 

# # Clone flutter-pi repository
# RUN git clone https://github.com/ardera/flutter-pi.git /home/flutteruser/flutter-pi

# # Build flutter-pi
# WORKDIR /home/flutteruser/flutter-pi
# RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# # Clone the Flutter Gallery repository
# WORKDIR /home/flutteruser
# RUN git clone https://github.com/flutter/gallery.git /home/flutteruser/gallery

# # Change ownership of the cloned repository
# USER root
# RUN chown -R flutteruser:flutteruser /home/flutteruser/gallery

# # Switch back to non-root user
# USER flutteruser

# # Navigate to the gallery directory and install dependencies
# WORKDIR /home/flutteruser/gallery
# RUN flutter pub get

# # Build the Flutter Gallery project
# RUN flutter build linux

# # Expose the necessary port (if your Flutter app serves on a port)
# EXPOSE 8080

# # Default command to run when the container starts
# CMD ["flutter", "run", "-d", "linux"]

###############################################################
# Base image
# Gunakan Ubuntu sebagai base image
FROM ubuntu:latest

# Set non-interactive untuk menghindari prompt selama instalasi paket
ENV DEBIAN_FRONTEND=noninteractive

# Gunakan mirror yang lebih cepat (opsional, sesuaikan dengan wilayah Anda)
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.speedpartner.de/ubuntu/|g' /etc/apt/sources.list

# Update dan upgrade sistem
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

# Install dependencies penting
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
    rsync \
    xdg-user-dirs \
    qemu-user-static && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set timezone
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /usr/local/flutter

# Set Flutter environment variables
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
# Set the CXX environment variable to g++
ENV CXX=g++

# Create non-root user dan switch ke user tersebut
RUN useradd -ms /bin/bash flutteruser

# Change ownership of the Flutter directory
RUN chown -R flutteruser:flutteruser /usr/local/flutter

# Switch to the non-root user
USER flutteruser
WORKDIR /home/flutteruser

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

# Update dependencies
RUN flutter pub upgrade && \
    dart pub upgrade && \
    flutter pub get

# Build the Flutter project (Linux build for local debugging)
RUN flutter build linux

# Expose the necessary port (if your Flutter app serves on a port)
EXPOSE 8080

# Default command to run when the container starts
CMD ["flutter", "run", "--profile", "--no-sound-null-safety"]

