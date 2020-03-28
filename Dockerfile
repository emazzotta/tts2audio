FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y \
        alsa-utils \
        ffmpeg \
        inotify-tools \
        libsox-fmt-mp3 \
        pulseaudio \
        python3-pip \
        socat \
        sox && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/requirements.txt

RUN pip3 install -r requirements.txt

COPY tts2audio.sh /app/tts2audio.sh

RUN groupadd -r voicy && \
    useradd -r -g voicy voicy && \
    mkdir /app/in && \
    mkdir /app/out && \
    mkdir /home/voicy

RUN chmod 755 /app/* && \
    chown -R voicy:voicy /app/ && \
    chown -R voicy:voicy /tmp/ && \
    chown -R voicy:voicy /home/voicy/

USER voicy
CMD ["/app/tts2audio.sh"]
