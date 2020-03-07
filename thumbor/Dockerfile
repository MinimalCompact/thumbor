FROM python:3.8

LABEL maintainer="MinimalCompact"

VOLUME /data

ENV HOME /app
ENV SHELL bash
ENV WORKON_HOME /app
WORKDIR /app

RUN pip install envtpl

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

RUN apt-get update && apt-get install build-essential -y && \
    mkdir -p /usr/src/app && \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python && \
    # source $HOME/.poetry/env && \
    cd /usr/src/app && \
    git clone https://github.com/kkopachev/thumbor.git . && \
    git checkout kk-multiprocess && \
    $HOME/.poetry/bin/poetry install  --no-dev

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["$HOME/.poetry/bin/poetry", "run", "thumbor", "-l debug", "--processes=$THUMBOR_NUM_PROCESSES"]

EXPOSE 80 8888
