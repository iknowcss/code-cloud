#!/bin/bash
set -eu

gpg -c --batch < script/homeinit.sh | base64 -w0 > script/homeinit.crypt.sh