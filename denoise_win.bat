@REM @echo off
setlocal enabledelayedexpansion

REM DeepFilterNetのパスを指定
set "DEEPFILTERNET_PATH=%~dp0bin\deep-filter-0.5.6-x86_64-pc-windows-msvc.exe"
if not exist "%DEEPFILTERNET_PATH%" (
    echo %DEEPFILTERNET_PATH% が見つかりません。
    echo DeepFilterNetをダウンロードして、binフォルダに配置してください。
    exit /b 1
)

REM ffmpegの確認
ffmpeg -version
if errorlevel 1 (
    echo ffmpegが見つかりません。ffmpegをインストールしてPATHに追加してください。
)

REM ディレクトリパスを取得（引数がない場合は "audios" ディレクトリを使用）
set "TINPUT_DIR=%~1"
if "%TINPUT_DIR%"=="" (
    set "TINPUT_DIR=%~dp0audios"
)

REM ディレクトリが存在するか確認
if not exist "%TINPUT_DIR%" (
    echo 指定されたフォルダが存在しません: フォルダ"%TINPUT_DIR%"を作成し、再実行してください。
    exit /b 1
)

REM outディレクトリの作成
set "OUTPUT_DIR=%~dp0out"
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

REM .wavファイルに対してノイズ除去処理を実行
for %%F in ("%TINPUT_DIR%\*.wav") do (
    echo %%F ノイズ除去 処理中...
    %DEEPFILTERNET_PATH% %%F --output-dir %OUTPUT_DIR%
    if errorlevel 1 (
        echo %%F ノイズ除去に失敗しました。
    )
)

REM outディレクトリ内のファイルに対して音声処理を実行
for %%F in ("%OUTPUT_DIR%\*.wav") do (
    echo %%F 音声処理 処理中...
    set "OUTPUT_FILE=%%~dpnF_n+c.wav"
    ffmpeg -i "%%F" -af "highpass=f=100, equalizer=f=250:t=q:w=1:g=-3, equalizer=f=1000:t=q:w=1:g=2, acompressor=threshold=-20dB:ratio=3:attack=5:release=50, deesser=i=0.5, loudnorm=I=-16:TP=-2:LRA=11" "!OUTPUT_FILE!"
    if errorlevel 1 (
        echo %%F 音声処理に失敗しました。
    )
    del %%F
)

endlocal
echo 処理が完了しました。
pause
