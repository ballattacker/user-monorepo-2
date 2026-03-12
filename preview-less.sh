#!/bin/bash

preview.sh "$1" | less -R --lesskey-src <(echo "h quit")
