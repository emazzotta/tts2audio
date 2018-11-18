FROM ubuntu:18.10

RUN apt-get update && \
    apt-get install -y \
        alsa-utils \
        ffmpeg \
        libsox-fmt-mp3 \
        pulseaudio \
        python3-pip \
        socat \
        sox

RUN pip3 install google_speech

RUN groupadd -r voicy && \
    useradd -r -g voicy voicy && \
    mkdir /app && \
    mkdir /app/in && \
    mkdir /app/out && \
    mkdir /home/voicy

WORKDIR /app

COPY tts2audio.sh /app/tts2audio.sh

RUN chmod 755 /app/* && \
    chown -R voicy:voicy /app/ && \
    chown -R voicy:voicy /home/voicy/

USER voicy
CMD ["/app/tts2audio.sh"]
