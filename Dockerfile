ARG PYTHON_VER=3.10.11

FROM ubuntu:jammy

ARG PYTHON_VER

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONOPTIMIZE=2 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONHASHSEED=1 \
    PYTHONFAULTHANDLER=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=0 \
    WINEARCH=win64 \
    WINEPREFIX=/wine/.wine \
    WINEPATH=Z:\\wine\\python\\Scripts;Z:\\wine\\python \
    WINEDEBUG=fixme-all \
    DISPLAY=:0 \
    SCREEN_NUM=0 \
    SCREEN_WHD=640x480x8 \
    GRPC_ENABLE_FORK_SUPPORT=1 \
    GRPC_POLL_STRATEGY=epoll1

COPY rootfs /

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        unzip \
        wget \
        wine \
        wine32 \
        wine64 \
        winetricks \
        xvfb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
	&& chmod a+x *.sh \
	&& /xvfb.sh \
    && mkdir -p /wine/python \
    && wine wineboot --init \
    && winetricks --unattended nocrashdialog \
    && cd /wine/python \
    && wget https://www.python.org/ftp/python/${PYTHON_VER}/python-${PYTHON_VER}-embed-amd64.zip \
    && unzip python-${PYTHON_VER}-embed-amd64.zip \
    && rm -f python-${PYTHON_VER}-embed-amd64.zip \
    && sed -i 's/#import site/import site/' python*._pth \
    && wget https://bootstrap.pypa.io/get-pip.py \
	&& wine python /wine/python/get-pip.py \
	&& wine pip install poetry \
    && wine pip install -r /requirements.txt

CMD /app.sh
