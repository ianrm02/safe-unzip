#!/bin/zsh

# With the added unzipping functionality, this script does not work as well

# Consider adding a testing option to the script to fix that

TEST_DIR="testZips"
DETECTOR_SCRIPT_N="./unzipSafe.sh"
DETECTOR_SCRIPT_T="./unzipSafe.sh -t 2"

# Loop through the test zip files
for zipfile in "$TEST_DIR"/*.zip; do
  echo "--------------------------------"
  echo "Testing file: $zipfile (no options)"
  $DETECTOR_SCRIPT_N "$zipfile"
  echo "--------------------------------"
  echo "Testing file: $zipfile (-t 2)"
  $DETECTOR_SCRIPT_T "$zipfile"
done
echo "--------------------------------"