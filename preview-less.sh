#!/bin/bash

preview.sh "$1" | less --lesskey-src <(echo "h quit")
