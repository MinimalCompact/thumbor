FROM python:3.8

LABEL maintainer="MinimalCompact"

VOLUME /data

ENV HOME /app
ENV SHELL bash
ENV WORKON_HOME /app
WORKDIR /app

RUN pip install thumbor==7.0.0a2 envtpl circus

COPY conf/thumbor.conf.tpl /app/thumbor.conf.tpl

ADD conf/circus.ini.tpl /etc/
RUN mkdir  /etc/circus.d /etc/setup.d
ADD conf/thumbor-circus.ini.tpl /etc/circus.d/

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

# running thumbor multiprocess via circus by default
# to override and run thumbor solo, set THUMBOR_NUM_PROCESSES=1 or unset it
CMD ["circus"]

EXPOSE 80 8888
