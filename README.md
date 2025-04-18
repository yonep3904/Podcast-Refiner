# Podcast-Refiner
ポッドキャスト向けの音質向上スクリプト

## About
ノイズ除去や音量調整など、音声ファイル(.wav)をポッドキャスト向けに編集するためのツール(シェルスクリプト)です。
.wavファイルの入ったフォルダを指定するだけで、簡単に編集することができます。
ノイズの除去には[DeepFilterNet](https://github.com/Rikorose/DeepFilterNet)、その他の音声処理には[FFmpeg](https://github.com/FFmpeg/FFmpeg)を使用しています。

## Requirement
- 対応OS: Windows, MacOS, Linux(一部の古いパソコンや2020年以前のMacBookなどでは動作しない場合があります)
- FFmpegのインストールが必要(インストール方法は後述)
- より高度な設定や強力なノイズ除去を行いたい場合はPython3のインストールが必要(基本的な利用のみの場合は不要)

## Setup
## DeepFilterNetのインストール
このツールを利用するために必要なDeepFilterNetのバイナリファイルとモデルファイルをダウンロードします。

以下のコマンドを実行してDeepFilterNetをインストールします。

#### Windowsの場合
```powershell
cd install
install_win.bat
```

#### MacOSの場合
```bash
cd install
install_mac.sh
```

#### Linuxの場合
```bash
cd install
install_linux.sh
```

### FFmpegのインストール
このツールを利用するために必要なFFmpegをインストールします。

#### Windowsの場合
1. `ターミナル`または`PowerShelll`を開く
2. 以下のコマンドを実行してFFmpegをインストールします。

```powershell
winget install -e --id Gyan.FFmpeg
```

#### MacOSの場合
1. `ターミナル`を開く
2. 以下のコマンドを実行してHomebrewをインストールします。
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3. 以下のコマンドを実行してFFmpegをインストールします。
```bash
brew install ffmpeg
```

#### Linuxの場合
各ディストリビューションに応じた方法でFFmpegをインストールしてください。

```bash
# Ubuntuの場合
sudo apt update
sudo apt install ffmpeg
```

## Usage

### 基本的な利用
以下のコマンドを実行すると、引数に指定したフォルダ内の音声ファイル(.wav)を一括で編集します。編集した音声ファイルは、引数で指定したフォルダと同じ階層のフォルダ`out`内に保存されます。引数を省略した場合、デフォルトでこのリポジトリ内のフォルダ`audios`が指定されます。
#### Windowsの場合
```powershelll
denoise_win.bat C:\Users\username\recordings
```

#### macOSの場合
```bash
denoise_mac.sh /Users/username/recordings
```

#### Linuxの場合
```bash
denoise_linux.sh /home/username/recordings
```

### より高度な設定を行いたい場合
シェルスクリプトによる実行のほか、Pythonのスクリプトをからの実行も可能です。
Pythonのスクリプトではノイズ除去のモデルの選択や音声処理のパラメータを簡単に変更できるため、より高度で柔軟な処理を行うことができます。なお、Pythonの実行にはPython3のインストールが必要なことに注意してください。

#### Windowsの場合
```powershelll
python denoise.py
```
#### macOS/linuxの場合
```bash
python3 denoise.py
```

## License
このリポジトリはMITライセンスのもとで公開されています。
詳しくは[LICENSE](LICENSE)をご覧ください。
