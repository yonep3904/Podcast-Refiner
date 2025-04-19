@echo off
setlocal

set "SCRIPT=%~dp0.."
set "INSTALL_DIR=%SCRIPT%\bin"
set "MODELS_DIR=%SCRIPT%\models"

if not exist "%INSTALL_DIR%" (
    echo Creating directory: %INSTALL_DIR%
    mkdir "%INSTALL_DIR%"
)
if not exist "%MODELS_DIR%" (
    echo Creating directory: %MODELS_DIR%
    mkdir "%MODELS_DIR%"
)

curl -L -o "%INSTALL_DIR%\deep-filter-0.5.6-x86_64-pc-windows-msvc.exe" https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-x86_64-pc-windows-msvc.exe

curl -o "%MODELS_DIR%\DeepFilterNet2_onnx.tar.gz" https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet2_onnx.tar.gz
curl -o "%MODELS_DIR%\DeepFilterNet2_onnx_ll.tar.gz" https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet2_onnx_ll.tar.gz
curl -o "%MODELS_DIR%\DeepFilterNet3_ll_onnx.tar.gz" https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet3_ll_onnx.tar.gz
curl -o "%MODELS_DIR%\DeepFilterNet3_onnx.tar.gz" https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet3_onnx.tar.gz

pause

@REM https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-aarch64-apple-darwin
@REM https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-armv7-unknown-linux-gnueabihf
@REM https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/deep-filter-0.5.6-x86_64-pc-windows-msvc.exe

@REM https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet2_onnx.tar.gz
@REM https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet2_onnx_ll.tar.gz
@REM https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet3_ll_onnx.tar.gz
@REM https://github.com/Rikorose/DeepFilterNet/raw/refs/heads/main/models/DeepFilterNet3_onnx.tar.gz
