import os
import platform
import base64
import subprocess
from pathlib import Path
from argparse import ArgumentParser

DIR = Path(__file__).parent

BIN_DIR = DIR / "bin"

BINS = {
    "linux":"rdeep-filter-0.5.6-x86_64-unknown-linux-musl",
    "darwin":"deep-filter-0.5.6-aarch64-apple-darwin",
    "windows":"deep-filter-0.5.6-x86_64-pc-windows-msvc.exe",
}

MODELS = [
    "DeepFilterNet2_onnx_ll.tar.gz",
    "DeepFilterNet2_onnx.tar.gz",
    "DeepFilterNet3_ll_onnx.tar.gz",
    "DeepFilterNet3_onnx.tar.gz",
]

# argparse
# parser = ArgumentParser(description="Denoise audio files using DeepFilterNet.")
# parser.add_argument("input_dir", type=str, help="Input directory containing audio files(.wav).")
# parser.add_argument("output_dir", type=str, help="Output directory to save denoised audio files(.wav).")


# def dev():
#     DeepFilterNet.available_check()
#     FFmpeg.available_check()


#     dfnet = DeepFilterNet()
#     ffmpeg = FFmpeg()
#     ffmpeg.add("highpass", f="100")
#     ffmpeg.add("equalizer", f="250", t="q", w="1", g="-3")
#     ffmpeg.add("equalizer", f="1000", t="q", w="1", g="3")
#     ffmpeg.add("acompressor", threshold="-20dB", ratio="3", attack="5", release="50")
#     ffmpeg.add("deesser", i="0.5")
#     ffmpeg.add("loudnorm", I="-16", TP="-1.5", LRA="11")

#     args = parser.parse_args()
#     input_dir = Path(args.input_dir)
#     output_dir = Path(args.output_dir)

#     for input_file in input_dir.glob("*.wav"):
#         output_file = output_dir / input_file.name
#         dfnet.run(input_file, output_file, model_file=None)
#         ffmpeg.run()

def main():
    input_file = DIR / "test" / "2_ノイズ除去後.wav"
    output_file = input_file.with_stem("out")

    ffmpeg = FFmpeg()
    ffmpeg.add("highpass", f="100")
    ffmpeg.add("equalizer", f="250", t="q", w="1", g="-3")
    ffmpeg.add("equalizer", f="1000", t="q", w="1", g="2")
    ffmpeg.add("acompressor", threshold="-20dB", ratio="3", attack="5", release="50")
    ffmpeg.add("deesser", i="0.5")
    ffmpeg.add("loudnorm", I="-16", TP="-1.5", LRA="11")
    ffmpeg.add("alimiter", limit="0.99")
    print(ffmpeg.args_text())
    # ffmpeg.run(input_file, output_file)

class FFmpeg:
    def __init__(self):
        self.processings: list[tuple[str, dict[str, str]]] = []

    def add(self, name: str, **kwargs: dict[str, str]) -> None:
        """
        Add a parameter to the FFmpeg instance.
        """
        self.processings.append((name, kwargs))

    def args_text(self) -> str:
        """
        Convert the parameters to a command line argument list.
        """
        args = []

        for name, params in self.processings:
            params_text = ":".join((f"{key}={value}" for key, value in params.items()))
            cmd_text = f"{name}={params_text}" if params_text else f"{name}"
            args.append(cmd_text)
        return ", ".join(args)

    def run(self, input_file: Path, output_file: Path) -> None:
        """
        Run the FFmpeg command with the specified parameters.
        """
        if not input_file.exists():
            raise FileNotFoundError(f"Input file '{input_file}' does not exist.")

        subprocess.run(
            args=[f"ffmpeg", "-i", str(input_file), "-af", self.args_text(), str(output_file)],
            stderr=subprocess.STDOUT,
            stdout=subprocess.PIPE,
            check=True,
        )

    @classmethod
    def available_check(cls) -> None:
        """
        Check if FFmpeg is installed.
        """
        try:
            subprocess.run(
                args=["ffmpeg", "-version"],
                stderr=None,
                stdout=None,
                check=True,
            )
        except FileNotFoundError:
            raise FileNotFoundError("FFmpeg is not installed. Please install it first.")
        except subprocess.CalledProcessError:
            raise RuntimeError("FFmpeg command failed.")

class DeepFilterNet:
    global BIN_DIR, BINS, MODELS
    os_name: str = platform.system().lower()
    bin_name: str | None = BINS.get(os_name, None)
    bin_file: str | None = None if bin_name is None else BIN_DIR / bin_name

    def __init__(self) -> None:
        """
        Initialize the DeepFilterNet instance.
        """

    def run(self, input_file: Path, output_file: Path, model_file: Path | None = None) -> None:
        """
        Run the denoising process.
        """
        if not input_file.exists():
            raise FileNotFoundError(f"Input file '{input_file}' does not exist.")

        if model_file is not None and not model_file.exists():
            raise FileNotFoundError(f"Model file '{model_file}' does not exist.")

        args = [DeepFilterNet.bin_file, str(input_file), "--output-dir", str(output_file.parent)] \
            if model_file is None else \
            [DeepFilterNet.bin_file, str(input_file), "--output-dir", str(output_file.parent), "--model", str(model_file)]

        subprocess.run(
            args=args,
            stderr=subprocess.PIPE,
            stdout=subprocess.PIPE,
            # shell=True,
            check=True,
        )

        if input_file.name != output_file.name:
            saved_path = output_file.parent / input_file.name
            saved_path.rename(output_file.name)

    @classmethod
    def available_check(self) -> None:
        """
        Check if the DeepFilterNet binary is available.
        """
        if self.bin_file is None:
            raise OSError(f"Unsupported platform: {DeepFilterNet.os_name}")

        if not DeepFilterNet.bin_file.exists():
            raise FileNotFoundError(f"Binary directory '{DeepFilterNet.bin_file}' does not exist.")

def encode_filename(filename: str) -> str:
    """
    encode filename to base64 (ext is not encoded)
    Args:
        filename (str): The filename to encode.
    Returns:
        str: The encoded filename.
    """
    name, ext = os.path.splitext(filename)
    encoded_name = base64.urlsafe_b64encode(name.encode('utf-8')).decode('ascii')
    return f"{encoded_name}{ext}"

def decode_filename(encoded_filename: str) -> str:
    """
    decode filename from base64 (ext is not encoded)
    Args:
        encoded_filename (str): The encoded filename to decode.
    Returns:
        str: The decoded filename.
    """
    name, ext = os.path.splitext(encoded_filename)
    decoded_name = base64.urlsafe_b64decode(name.encode('ascii')).decode('utf-8')
    return f"{decoded_name}{ext}"


if __name__ == "__main__":
    main()
