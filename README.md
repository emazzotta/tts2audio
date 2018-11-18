[![Build Status](https://travis-ci.org/emazzotta/tt2audio.svg?branch=master)](https://travis-ci.org/emazzotta/tt2audio)

# tts2audio

## Getting Started

### Prerequisites
* Docker 18 or later

### Bootstrap

```
# Get the code, cd to tt2audio, setup tt2audio in Docker
git clone git@github.com:emazzotta/tt2audio.git && \
    cd tt2audio
```

### Run

```
docker run --rm -v $PWD/in:/app/in -v $PWD/out:/app/out emazzotta/tt2audio
```

## Author

[Emanuele Mazzotta](mailto:hello@mazzotta.me)
