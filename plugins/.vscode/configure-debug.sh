#!/bin/bash

plugin_executable=gpx_adx
plugin_executable_with_arch=$plugin_executable"_linux_amd64"

go build -gcflags=all="-N -l" -o ./dist/$plugin_executable_with_arch ./pkg
dlv attach $(pgrep $plugin_executable) --headless --listen=:3222 --api-version 2 --log