#!/bin/zsh

THRESHOLD=5
TEST=false
UNZIP=false

# Handle options
while getopts "t:u" opt; do
  case $opt in
    t) THRESHOLD=$OPTARG ;;
    u) UNZIP=true ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

# Get zip file 
shift $((OPTIND - 1))
if [ $# -eq 0 ]; then
  echo "Usage: $0 [-t threshold] [-u] <file.zip>"
  exit 1
fi

# Handle non zip file
ZIPFILE="$1"
if [ ! -f "$ZIPFILE" ]; then
  echo "File not found!"
  exit 1
fi

# Get compression information 
compressed_size=$(stat -f%z "$ZIPFILE")
if [ "$compressed_size" -eq 0 ]; then
  echo "Could not determine the compressed size."
  exit 1
fi

uncompressed_size=$(unzip -l "$ZIPFILE" | awk '/^ *[0-9]/ { total += $1 } END { print total }')
if [ "$uncompressed_size" -eq 0 ]; then
  echo "Could not determine the uncompressed size."
  exit 1
fi

compression_ratio=$((uncompressed_size / compressed_size))

# Handle file safey
if [ "$compression_ratio" -ge "$THRESHOLD" ]; then
  echo "WARNING: The ZIP file may be a ZIP bomb!"
  echo "Compressed size: $compressed_size bytes"
  echo "Uncompressed size: $uncompressed_size bytes"
  echo "Compression ratio: $compression_ratio"
else
  echo "The ZIP file seems safe."
  echo "Compressed size: $compressed_size bytes"
  echo "Uncompressed size: $uncompressed_size bytes"
  echo "Compression ratio: $compression_ratio"
fi

# Handle the unzipping
if [ "$UNZIP" = true ]; then
    echo "Unzipping the file without prompt..."
    unzip "$ZIPFILE"
else
  echo -n "Do you want to unzip the file? (y/n): "
  read -t 60 choice
  case "$choice" in 
    y|Y) echo "Unzipping the file..." ; unzip "$ZIPFILE" ;;
    n|N) echo "Unzip operation cancelled." ;;
    *) echo "Invalid choice. Unzip operation cancelled." ;;
  esac
fi