#!/bin/bash

INPUT_PATH=/app/in
OUTPUT_PATH=/app/out

echo "Initializing audio..."
# Start the pulseaudio server
pulseaudio -D --exit-idle-time=-1
# Load the virtual sink and set it as default
pacmd load-module module-virtual-sink sink_name=v1
pacmd set-default-sink v1
# set the monitor of v1 sink to be the default source
pacmd set-default-source v1.monitor
echo "Audio initialization done."

echo "Cleaning tts2audio folders."
rm -rf ${INPUT_PATH}/* ${OUTPUT_PATH}/*
echo "Starting tts2audio..."

while true; do
    echo "Scanning for files in ${INPUT_PATH}"
    for file in $(find ${INPUT_PATH} -type f \( ! -iname ".*" \) -exec basename {} \;); do
        echo "Found ${file}!"
        temp=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXXXXXXXX")

        recording_file="${temp}/original.mp3"
        voice_file="${temp}/voice.mp3"

        ffmpeg -loglevel panic -f pulse -i default ${recording_file} &
        PID=$!

        text=$(cat ${INPUT_PATH}/${file})
        google_speech -l en "${text}" -e speed 1.0 overdrive 10 echo 0.8 0.7 1 0.7 echo 0.8 0.7 10 0.7 echo 0.9 0.7 20 0.3
        kill ${PID}

        while kill -0 ${PID} &> /dev/null; do
            sleep 0.2
        done

        # Remove silences in beginning and end
        ffmpeg -loglevel panic -i ${recording_file} -af silenceremove=stop_periods=-1:stop_duration=1:stop_threshold=-90dB ${voice_file}

        cp ${voice_file} ${OUTPUT_PATH}/${file%.*}.mp3
        rm -rf ${INPUT_PATH}/${file}
        rm -rf ${temp}
    done
    sleep 0.2
done
