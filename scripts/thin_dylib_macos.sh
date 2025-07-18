#!/bin/bash

# Show help documentation
function show_help {
    echo "Usage: $0 [architecture] [target path]"
    echo ""
    echo "Parameters:"
    echo "  architecture    Must be either arm64 or x86_64"
    echo "  target path     Optional, path to the directory containing .dylib files, default is current directory"
    echo ""
    echo "Examples:"
    echo "  $0 arm64                  # Process all .dylib files in current directory, extract arm64 architecture"
    echo "  $0 x86_64 /path/to/libs  # Process all .dylib files in specified directory, extract x86_64 architecture"
    echo ""
    echo "Notes:"
    echo "  - The script only processes non-symlink .dylib files"
    echo "  - If the target path does not exist, the script will exit with an error"
    echo "  - Extracted files will overwrite the original files"
    exit 1
}

# Check if architecture parameter is provided
if [ -z "$1" ]; then
    show_help
fi

# Show help if first argument is -h or --help
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
fi

ARCH=$1

# Only support arm64 and x86_64
if [ "$ARCH" != "arm64" ] && [ "$ARCH" != "x86_64" ]; then
    echo "Only supported architectures: arm64 or x86_64"
    exit 1
fi

# Check if target path is provided
if [ -z "$2" ]; then
    TARGET_DIR="."
else
    TARGET_DIR="$2"

    # Check if target path exists
    if [ ! -d "$TARGET_DIR" ]; then
        echo "Target path does not exist: $TARGET_DIR"
        exit 1
    fi
fi

# Iterate over all .dylib files in target directory
for file in "$TARGET_DIR"/*.dylib; do
    # Skip symbolic links
    if [ -L "$file" ]; then
        echo "Skipping symlink: $file"
        continue
    fi

    # Execute lipo to extract specified architecture and overwrite original file
    echo "Processing: $file"
    lipo "$file" -extract "$ARCH" -output "$file"
done