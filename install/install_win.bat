@echo off
setlocal

"SCRIPT_DIR"="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
set "SCRIPT=%~dp0.."
set "INSTALL_DIR=%SCRIPT%\bin"
set "MODELS_DIR=%SCRIPT%\models"

mkdir -p "%INSTALL_DIR%"
mkdir -p "%MODELS_DIR%"

curl -o "%INSTALL_DIR%\deep-filter-0.5.6-x86_64-pc-windows-msvc.exe" https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-x86_64-pc-windows-msvc.exe

curl -o "%MODELS_DIR%\DeepFilterNet2_onnx.tar.gz" https://github.com/Rikorose/DeepFilterNet/blob/main/models/DeepFilterNet2_onnx.tar.gz
curl -o "%MODELS_DIR%\DeepFilterNet2_onnx_ll.tar.gz" https://github.com/Rikorose/DeepFilterNet/blob/main/models/DeepFilterNet2_onnx_ll.tar.gz
curl -o "%MODELS_DIR%\DeepFilterNet3_ll_onnx.tar.gz" https://github.com/Rikorose/DeepFilterNet/blob/main/models/DeepFilterNet3_ll_onnx.tar.gz
curl -o "%MODELS_DIR%\DeepFilterNet3_onnx.tar.gz" https://github.com/Rikorose/DeepFilterNet/blob/main/models/DeepFilterNet3_onnx.tar.gz

@REM https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-aarch64-apple-darwin
@REM https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-armv7-unknown-linux-gnueabihf
@REM https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-x86_64-pc-windows-msvc.exe

@REM https://github.com/Rikorose/DeepFilterNet/blob/main/models/DeepFilterNet2_onnx.tar.gz
@REM https://github.com/Rikorose/DeepFilterNet/blob/main/models/DeepFilterNet2_onnx_ll.tar.gz
@REM https://github.com/Rikorose/DeepFilterNet/blob/main/models/DeepFilterNet3_ll_onnx.tar.gz
@REM https://github.com/Rikorose/DeepFilterNet/blob/main/models/DeepFilterNet3_onnx.tar.gz
