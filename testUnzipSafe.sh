#!/bin/zsh

# Test script to check the functionality of the zip bomb detector

TEST_DIR="testZips"
DETECTOR_SCRIPT="./unzipSafe.sh"

# Loop through the test zip files
for zipfile in "$TEST_DIR"/*.zip; do
  echo "--------------------------------"
  echo "Testing file: $zipfile"
  $DETECTOR_SCRIPT "$zipfile"
  echo "--------------------------------"
done