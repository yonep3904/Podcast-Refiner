#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$SCRIPT_DIR/../bin"
MODELS_DIR="$SCRIPT_DIR/../models"

mkdir -p "$BIN_DIR"
mkdir -p "$MODELS_DIR"

curl -L -o "$BIN_DIR/deep-filter-0.5.6-armv7-unknown-linux-gnueabihf" https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-armv7-unknown-linux-gnueabihf
chmod +x "$BIN_DIR/deep-filter-0.5.6-armv7-unknown-linux-gnueabihf"

curl -o "$MODELS_DIR/DeepFilterNet2_onnx.tar.gz" https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet2_onnx.tar.gz
curl -o "$MODELS_DIR/DeepFilterNet2_onnx_ll.tar.gz" https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet2_onnx_ll.tar.gz
curl -o "$MODELS_DIR/DeepFilterNet3_ll_onnx.tar.gz" https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet3_ll_onnx.tar.gz
curl -o "$MODELS_DIR/DeepFilterNet3_onnx.tar.gz" https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet3_onnx.tar.gz

# https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-aarch64-apple-darwin
# https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-armv7-unknown-linux-gnueabihf
# https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-x86_64-pc-windows-msvc.exe

# https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet2_onnx.tar.gz
# https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet2_onnx_ll.tar.gz
# https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet3_ll_onnx.tar.gz
# https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet3_onnx.tar.gz
