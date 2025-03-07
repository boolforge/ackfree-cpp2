#!/bin/bash

# Path to the ptoc executable
PTOC_PATH="/c/ptoc2/ptoc"

# Path to the cganal executable
CGANAL_PATH="/c/ptoc2/cganal"

# Include directory
INCLUDE_DIR="include"

# Output directory for converted C files
OUTPUT_DIR="converted_c"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Iterate over all .pas files in the current directory and subdirectories
find . -name "*.pas" -print0 | while IFS= read -r -d $'\0' file; do

  # Clean problematic characters (very conservative)
  tr -dc '[:print:]\t\n\r{}()[]<>;:=+-,./\\*&%$#@!|?\\"' < "$file" > "${file}.cleaned" && mv "${file}.cleaned" "$file"

  # Convert line endings to Unix format
  dos2unix "$file"

  # Convert the Pascal file to C with ptoc
  "$PTOC_PATH" -I "$INCLUDE_DIR" -h -in "$file" -c -analyze -intset -init -unsigned -out "$OUTPUT_DIR/${file##*/}.c"

done

# Execute cganal
"$CGANAL_PATH"

echo "Conversion completed. C files are located in the $OUTPUT_DIR directory"
