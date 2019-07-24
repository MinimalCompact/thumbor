FROM python:2

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

COPY requirements.txt /app/requirements.txt
RUN pip install --trusted-host None --no-cache-dir \
   -r /app/requirements.txt

COPY conf/thumbor.conf.tpl /app/thumbor.conf.tpl

ADD conf/circus.ini.tpl /etc/
RUN mkdir  /etc/circus.d /etc/setup.d
ADD conf/thumbor-circus.ini.tpl /etc/circus.d/

ARG SIMD_LEVEL
# workaround for https://github.com/python-pillow/Pillow/issues/3441
# https://github.com/thumbor/thumbor/issues/1102
RUN PILLOW_VERSION=$(python -c 'import PIL; print(PIL.__version__)') ; \
    if [ -z "$SIMD_LEVEL" ]; then \
      CC="cc" && PILLOW_PACKET="pillow" && PILLOW_VERSION_SUFFIX="" ;\
    else \
      CC="cc -m$SIMD_LEVEL" && PILLOW_PACKET="pillow-SIMD" && PILLOW_VERSION_SUFFIX=".post99" ;\
      # hardcoding to overcome https://github.com/MinimalCompact/thumbor/pull/37#issuecomment-514771902
      PILLOW_VERSION="5.2.0" ; \
    fi ; \

    pip uninstall -y pillow || true && \
    CC=$CC \
    # https://github.com/python-pillow/Pillow/pull/3241
    LIB=/usr/lib/x86_64-linux-gnu/ \
    # https://github.com/python-pillow/Pillow/pull/3237 or https://github.com/python-pillow/Pillow/pull/3245
    INCLUDE=/usr/include/x86_64-linux-gnu/ \
    pip install --no-cache-dir -U --force-reinstall --no-binary=:all: "${PILLOW_PACKET}<=${PILLOW_VERSION}${PILLOW_VERSION_SUFFIX}" \
    # --global-option="build_ext" --global-option="--debug" \
    --global-option="build_ext" --global-option="--enable-lcms" \
    --global-option="build_ext" --global-option="--enable-zlib" \
    --global-option="build_ext" --global-option="--enable-jpeg" \
    --global-option="build_ext" --global-option="--enable-tiff"

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# running thumbor multiprocess via circus by default
# to override and run thumbor solo, set THUMBOR_NUM_PROCESSES=1 or unset it
CMD ["circus"]

EXPOSE 80 8888
