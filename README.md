[![Build Status](https://travis-ci.org/emazzotta/tt2audio.svg?branch=master)](https://travis-ci.org/emazzotta/tt2audio)

# tts2audio

## Getting Started

This is a heavy-weight docker container with lots of audio related stuff pre-installed.
I use it to have [GoogleSpeech](https://github.com/desbma/GoogleSpeech) convert text to speech and output an mp3 file.

Just put a text-file with the content you'd like Google to read in the `in`-directory (see the "Run" section below).
It takes about 5 seconds to have an output file in the `out`-directory.

### Prerequisites

* Docker 18 or later

### Bootstrap

```
# If you want to run the code locally
# Get the code, cd to tt2audio, setup tt2audio in Docker
git clone git@github.com:emazzotta/tt2audio.git && \
    cd tt2audio && \
    make build
```

### Run

```
docker run --rm -v $PWD/in:/app/in -v $PWD/out:/app/out emazzotta/tt2audio
```

## Author

[Emanuele Mazzotta](mailto:hello@mazzotta.me)
