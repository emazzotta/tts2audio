[![Build Status](https://travis-ci.org/emazzotta/tts2audio.svg?branch=master)](https://travis-ci.org/emazzotta/tts2audio)

# tts2audio

🐳 A docker container to record audio inside the container.

## Getting Started

This is a heavy-weight docker container with lots of audio related stuff pre-installed.
I use it to have [GoogleSpeech](https://github.com/desbma/GoogleSpeech) convert text to speech and record the audio output to an mp3 file.

Just put a text-file with the content you'd like Google to read in the `in`-directory (see the "Run" section below).
It takes a couple of seconds to have an output file in the `out`-directory depending on the input file content length.

### Prerequisites

* Docker 18 or later

### Bootstrap

```
# If you want to run the code locally
# Get the code, cd to tts2audio, setup tts2audio in Docker
git clone git@github.com:emazzotta/tts2audio.git && \
    cd tts2audio && \
    make build
```

### Run

```
docker run --rm -v $PWD/in:/app/in -v $PWD/out:/app/out emazzotta/tts2audio
```

## Author

[Emanuele Mazzotta](mailto:hello@mazzotta.me)
