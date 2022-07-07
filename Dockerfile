# ================================
# Build image
# ================================
FROM swift:5.6-focal as build
LABEL stage=build

# Install OS updates
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && rm -rf /var/lib/apt/lists/*
    
# Set up a build area
WORKDIR /build

# resolve dependencies - cached layer
COPY ./Package.* ./
RUN swift package resolve

# Copy entire repo into container
COPY . .

# Compile with optimizations
RUN swift build -c release

# Switch to the staging area
WORKDIR /staging

# Copy main executable to staging area
RUN cp "$(swift build --package-path /build -c release --show-bin-path)/AsanaBot" ./

# ================================
# Run image
# ================================
FROM swift:5.6-focal-slim

# Make sure all system packages are up to date.
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && rm -r /var/lib/apt/lists/*

# Copy built executable
COPY --from=build --chown=github:github /staging/AsanaBot /usr/local/bin/asana-bot
