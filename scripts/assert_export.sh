#!/bin/bash -xe

MODEL_DIR="src/models"
INDEX_FILE="${MODEL_DIR}/index.tsx"

if [ ! -f "$INDEX_FILE" ]; then
    echo "Index file not found: $INDEX_FILE"
    exit 1
fi

for ts_file in "${MODEL_DIR}"/*.tsx; do
    if [[ $(basename "$ts_file") == "index.tsx" ]]; then
        continue
    fi

    file_name=$(basename "$ts_file")

    if ! grep -qE "./${file_name%.tsx}" "$INDEX_FILE"; then
        echo "File $file_name is not exported in $INDEX_FILE"
        exit 1;
    fi
done

echo "Check complete."
