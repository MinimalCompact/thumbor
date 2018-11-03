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
        python-numpy \
        python-opencv \
        git \
        curl \
        libdc1394-22 \
        libjpeg-turbo-progs \
        graphicsmagick \
        libgraphicsmagick++3 \
        libgraphicsmagick++1-dev \
        libgraphicsmagick-q16-3 \
        zlib1g-dev \
        libboost-python-dev \
        libmemcached-dev \
        gifsicle=1.88* \
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

RUN \
    ln /usr/lib/python2.7/dist-packages/cv2.x86_64-linux-gnu.so /usr/local/lib/python2.7/cv2.so && \
    ln /usr/lib/python2.7/dist-packages/cv.py /usr/local/lib/python2.7/cv.py

ARG SIMD_LEVEL
# workaround for https://github.com/python-pillow/Pillow/issues/3441
# https://github.com/thumbor/thumbor/issues/1102
RUN if [ -z "$SIMD_LEVEL" ]; then \
    PILLOW_VERSION=$(python -c 'import PIL; print(PIL.__version__)') && \
    pip uninstall -y pillow || true && \
    # https://github.com/python-pillow/Pillow/pull/3241
    LIB=/usr/lib/x86_64-linux-gnu/ \
    # https://github.com/python-pillow/Pillow/pull/3237 or https://github.com/python-pillow/Pillow/pull/3245
    INCLUDE=/usr/include/x86_64-linux-gnu/ \
    pip install --no-cache-dir -U --force-reinstall --no-binary=:all: "pillow<=$PILLOW_VERSION" \
    # --global-option="build_ext" --global-option="--debug" \
    --global-option="build_ext" --global-option="--enable-lcms" \
    --global-option="build_ext" --global-option="--enable-zlib" \
    --global-option="build_ext" --global-option="--enable-jpeg" \
    --global-option="build_ext" --global-option="--enable-tiff" \
    ; fi
RUN if [ -n "$SIMD_LEVEL" ]; then apt-get install -y -q libjpeg-dev zlib1g-dev; fi
RUN if [ -n "$SIMD_LEVEL" ]; then pip uninstall -y pillow; CC="cc -m$SIMD_LEVEL" LDFLAGS=-L/usr/lib/x86_64-linux-gnu/ pip install --no-cache-dir -U --force-reinstall Pillow-SIMD==5.2.0.post0; fi

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# running thumbor multiprocess via circus by default
# to override and run thumbor solo, set THUMBOR_NUM_PROCESSES=1 or unset it
CMD ["circus"]

EXPOSE 80 8888
