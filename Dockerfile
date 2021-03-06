FROM nodered/node-red:latest
USER root

COPY settings.js /data/settings.js

RUN apk update \
    && apk add --no-cache curl fontconfig \
    && curl -O https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
    && curl -O https://noto-website.storage.googleapis.com/pkgs/NotoSerifCJKjp-hinted.zip \
    && mkdir -p /usr/share/fonts/NotoSansCJKjp \
    && mkdir -p /usr/share/fonts/NotoSerifCJKjp \
    && unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ \
    && unzip NotoSerifCJKjp-hinted.zip -d /usr/share/fonts/NotoSerifCJKjp/ \
    && rm NotoSansCJKjp-hinted.zip \
    && rm NotoSerifCJKjp-hinted.zip \
    && fc-cache -fv
RUN apk add cups-client

RUN npm install \
    node-red-contrib-google-sheets \
    node-red-contrib-loop-processing \
    node-red-contrib-play-audio \
    node-red-dashboard \
    node-red-node-mysql \
    node-red-node-pi-gpio \
    node-red-node-ping \
    node-red-node-random \
    node-red-node-rbe \
    node-red-node-serialport \
    node-red-node-smooth \
    node-red-node-sqlite \
    node-red-node-tail

RUN apk --update-cache add \
    freetype-dev \
    gcc \
    g++ \
    gfortran \
    jpeg-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    linux-headers \
    musl \
    make \
    openblas-dev \
    python3-dev \
    zlib-dev
RUN cd /usr/bin \
	&& ln -sf idle3 idle \
	&& ln -sf pydoc3 pydoc \
	&& ln -sf python3 python \
	&& ln -sf python3-config python-config \
	&& ln -sf pip3 pip
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

RUN pip install --upgrade pip setuptools wheel
RUN pip install \
    gspread \
    mysql-connector-python-rf \
    numpy \
    oauth2client \
    pandas \
    pillow \
    pydrive \
    pyusb \
    qrcode
