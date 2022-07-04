FROM python:3.9

LABEL maintainer="MinimalCompact"

VOLUME /data

# base OS packages
RUN  \
    awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y autoremove && \
    apt-get install -y -q \
        git \
        curl \
        libjpeg-turbo-progs \
        graphicsmagick \
        libgraphicsmagick++3 \
        libgraphicsmagick++1-dev \
        libgraphicsmagick-q16-3 \
        zlib1g-dev \
        libboost-python-dev \
        libmemcached-dev \
        gifsicle \
        ffmpeg && \
    apt-get clean

ENV HOME /app
ENV SHELL bash
ENV WORKON_HOME /app
WORKDIR /app

RUN pip install thumbor==7.0.10
COPY requirements.txt /app/requirements.txt
RUN pip install --trusted-host None --no-cache-dir -r /app/requirements.txt
RUN pip install --no-dependencies tc-aws==6.2.15
RUN pip install --no-dependencies tc-core==0.4.1
RUN pip install --no-dependencies tc-shortener==0.2.2

RUN pip install thumbor-request-modifier==2.0.4
RUN pip install git+https://github.com/mbarouski/thumbor-redis.git@master
RUN pip install git+https://github.com/mbarouski/thumbor-prometheus.git@master

COPY conf/thumbor.conf.tpl /app/thumbor.conf.tpl

ARG SIMD_LEVEL

RUN PILLOW_VERSION=$(python -c 'import PIL; print(PIL.__version__)') ; \
    if [ "$SIMD_LEVEL" ]; then \
      pip uninstall -y pillow || true && \
      CC="cc -m$SIMD_LEVEL" pip install --no-cache-dir -U --force-reinstall --no-binary=:all: "pillow-SIMD<=${PILLOW_VERSION}.post99" \
      # --global-option="build_ext" --global-option="--debug" \
      --global-option="build_ext" --global-option="--enable-lcms" \
      --global-option="build_ext" --global-option="--enable-zlib" \
      --global-option="build_ext" --global-option="--enable-jpeg" \
      --global-option="build_ext" --global-option="--enable-tiff" ; \
    fi ;

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["thumbor", "--port=8000", "-l ${LOG_LEVEL:-debug}", "--processes=${THUMBOR_NUM_PROCESSES:-1}"]

# Thumbor is on 8000, Prometheus is on 8001
EXPOSE 8000 8001
