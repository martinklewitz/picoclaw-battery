#!/usr/bin/env bash

docker run -it \
--mount type=bind,source=./config/config.json,target=/root/.picoclaw/config.json \
--mount type=bind,source=./config/.security.yml,target=/root/.picoclaw/.security.yml \
--mount type=bind,source=./config/launcher-auth.db,target=/root/.picoclaw/launcher-auth.db \
-v ./picoclaw-workspace:/root/.picoclaw/workspace \
-v ./picoclaw-npm-cache:/root/.npm \
-p 18800:18800 \
-p 18790:18790 \
martinklewitz/picoclaw-battery:latest
