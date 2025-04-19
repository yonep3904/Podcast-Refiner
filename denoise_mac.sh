#!/bin/bash

# DeepFilterNet のパスを指定
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEEPFILTERNET_PATH="$SCRIPT_DIR/bin/ddeep-filter-0.5.6-aarch64-apple-darwin"

if [ ! -f "$DEEPFILTERNET_PATH" ]; then
    echo "$DEEPFILTERNET_PATH が見つかりません。"
    echo "DeepFilterNetをダウンロードして、binフォルダに配置してください。"
    exit 1
fi

# ffmpeg の確認
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpegが見つかりません。ffmpegをインストールしてPATHに追加してください。"
    exit 1
fi

# ディレクトリパスを取得（引数がない場合は "audios" ディレクトリを使用）
TINPUT_DIR="$1"
if [ -z "$TINPUT_DIR" ]; then
    TINPUT_DIR="$SCRIPT_DIR/audios"
fi

# ディレクトリが存在するか確認
if [ ! -d "$TINPUT_DIR" ]; then
    echo "指定されたフォルダが存在しません: フォルダ \"$TINPUT_DIR\" を作成し、再実行してください。"
    exit 1
fi

# out ディレクトリの作成
OUTPUT_DIR="$SCRIPT_DIR/out"
mkdir -p "$OUTPUT_DIR"

# .wav ファイルに対してノイズ除去処理を実行
for FILE in "$TINPUT_DIR"/*.wav; do
    [ -e "$FILE" ] || continue
    echo "$FILE ノイズ除去 処理中..."
    "$DEEPFILTERNET_PATH" "$FILE" --output-dir "$OUTPUT_DIR"
    if [ $? -ne 0 ]; then
        echo "$FILE ノイズ除去に失敗しました。"
    fi
done

# out ディレクトリ内のファイルに対して音声処理を実行
for FILE in "$OUTPUT_DIR"/*.wav; do
    [ -e "$FILE" ] || continue
    echo "$FILE 音声処理 処理中..."
    OUTPUT_FILE="${FILE%.*}_n+c.wav"
    ffmpeg -i "$FILE" -af "highpass=f=100, equalizer=f=250:t=q:w=1:g=-3, equalizer=f=1000:t=q:w=1:g=2, acompressor=threshold=-20dB:ratio=3:attack=5:release=50, deesser=i=0.5, loudnorm=I=-16:TP=-2:LRA=11" "$OUTPUT_FILE"
    if [ $? -ne 0 ]; then
        echo "$FILE 音声処理に失敗しました。"
    fi
    rm "$FILE"
done

echo "処理が完了しました。"
read
