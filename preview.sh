#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# If the option `use_preview_script` is set to `true`,
# then this script will be called and its output will be displayed in ranger.
# ANSI color codes are supported.
# STDIN is disabled, so interactive scripts won't work properly

# This script is considered a configuration file and must be updated manually.
# It will be left untouched if you upgrade ranger.

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Display stdout as preview
# 1    | no preview | Display no preview at all
# 2    | plain text | Display the plain content of the file
# 3    | fix width  | Don't reload when width changes
# 4    | fix height | Don't reload when height changes
# 5    | fix both   | Don't ever reload
# 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
# 7    | image      | Display the file directly as an image

# Script arguments
FILE_PATH="${1}"         # Full path of the highlighted file
PV_WIDTH="${2:-80}"          # Width of the preview pane (number of fitting characters)
PV_HEIGHT="${3:-25}"         # Height of the preview pane (number of fitting characters)

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER=$(echo ${FILE_EXTENSION} | tr '[:upper:]' '[:lower:]')

# Settings
HIGHLIGHT_SIZE_MAX=262143  # 256KiB
HIGHLIGHT_TABWIDTH=8
HIGHLIGHT_STYLE='pablo'
PYGMENTIZE_STYLE='autumn'


handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        # Archive
        7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            atool --list -- "${FILE_PATH}" && exit 0
            bsdtar --list --file "${FILE_PATH}" && exit 0
            exit 0;;

        # PDF
        pdf)
            # Preview as text conversion
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w ${PV_WIDTH} && exit 0
            mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | fmt -w ${PV_WIDTH} && exit 0
            exiftool "${FILE_PATH}" && exit 0
            exit 0;;

        # Torrent
        torrent)
            transmission-show -- "${FILE_PATH}" && exit 0
            exit 0;;
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        # Directory
        inode/directory)
            ls -1Ap --color=always ${FILE_PATH} && exit 0
            exit 0;;

        # Text
        text/* | */xml)
            # Syntax highlight
            bat -fpp ${FILE_PATH} && exit 0
            exit 0;;

        # Image
        image/*)
            # Preview as text conversion
            # img2txt --gamma=0.6 --width="${PV_WIDTH}" -- "${FILE_PATH}" && exit 0
            chafa -f symbols -s ${PV_WIDTH}x${PV_HEIGHT} ${FILE_PATH} && exit 0
            exiftool "${FILE_PATH}" && exit 0
            exit 0;;

        # Video and audio
        video/* | audio/*)
            mediainfo "${FILE_PATH}" && exit 0
            exiftool "${FILE_PATH}" && exit 0
            exit 0;;
    esac
}

handle_readable() {
    local encoding="$(file -b --mime-encoding ${FILE_PATH})"
    [[ "$encoding" =~ text|ascii|utf ]] && bat -fpp ${FILE_PATH} && exit 0
}

handle_fallback() {
    echo '----- File Type Classification -----'
    file --dereference --brief -- "${FILE_PATH}"
    file --dereference --brief --mime-type -- "${FILE_PATH}"
    hexdump -vC ${FILE_PATH}
    exit 0
}


MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
handle_extension
handle_mime "${MIMETYPE}"
handle_readable
handle_fallback

exit 0
