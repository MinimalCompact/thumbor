FROM python:3.11-alpine

LABEL maintainer="MinimalCompact"

# Set environment variables
ENV HOME=/app \
    SHELL=/bin/bash \
    WORKON_HOME=/app

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    bash \
    git \
    curl \
    curl-dev \
    build-base \
    jpeg-dev \
    zlib-dev \
    libwebp-dev \
    tiff-dev \
    libpng-dev \
    graphicsmagick \
    imagemagick \
    boost-dev \
    libmemcached-dev \
    gifsicle \
    ffmpeg \
    cairo \
    cairo-dev

# Ensure pip, setuptools, and wheel are up-to-date
RUN pip install --upgrade pip setuptools wheel

# Copy and install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --verbose --no-cache-dir -r /app/requirements.txt

# Copy configuration template
COPY conf/thumbor.conf.tpl /app/thumbor.conf.tpl

# Argument for SIMD optimization
ARG SIMD_LEVEL

RUN PILLOW_VERSION=$(python -c 'import PIL; print(PIL.__version__)') ; \
    if [ "$SIMD_LEVEL" ]; then \
        pip uninstall -y pillow || true && \
        CC="cc -m$SIMD_LEVEL" pip install --no-cache-dir -U --force-reinstall --no-binary=:all: "pillow-SIMD<=${PILLOW_VERSION}.post99" \
            --global-option="build_ext" --global-option="--enable-lcms" \
            --global-option="build_ext" --global-option="--enable-zlib" \
            --global-option="build_ext" --global-option="--enable-jpeg" \
            --global-option="build_ext" --global-option="--enable-tiff" ; \
    fi

# Copy entrypoint script
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# Default Thumbor command
CMD ["thumbor", "--port=$THUMBOR_PORT", "-l ${LOG_LEVEL:-debug}", "--processes=${THUMBOR_NUM_PROCESSES:-1}"]

# Expose ports
EXPOSE 80 8888
