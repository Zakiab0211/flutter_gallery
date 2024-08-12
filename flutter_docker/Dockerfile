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

# Use the latest stable version of the Cirrus CI Flutter image
FROM cirrusci/flutter:latest

# Set the working directory
WORKDIR /app

# Copy the pubspec files
COPY pubspec.yaml pubspec.lock ./

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos '' developer && chown -R developer:developer /app
USER developer

# Install dependencies
RUN flutter pub get

# Switch back to root to copy the rest of the application code
USER root

# Copy the rest of the application code
COPY . .

# Install Android SDK components
RUN mkdir -p Android/sdk
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O commandlinetools.zip
RUN unzip commandlinetools.zip -d Android/sdk && rm commandlinetools.zip
RUN mv Android/sdk/cmdline-tools Android/sdk/tools
RUN yes | Android/sdk/tools/bin/sdkmanager --licenses
RUN Android/sdk/tools/bin/sdkmanager "build-tools;29.0.2" "platform-tools" "platforms;android-29" "sources;android-29"

# Set PATH for Android SDK
ENV PATH "$PATH:/app/Android/sdk/platform-tools"

# Build the Flutter application
RUN flutter build apk --release

# Set the entrypoint to run the Flutter app
CMD ["flutter", "run", "--release"]
