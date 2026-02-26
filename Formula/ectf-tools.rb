class EctfTools < Formula
  desc "Drop-in replacement for MITRE's ectf CLI with reliable serial I/O"
  homepage "https://github.com/taciturnaxolotl/rust-ectf-tools"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.2.0/ectf-tools-aarch64-apple-darwin.tar.gz"
      sha256 "d8a6c45e629e910bf6a8833add9bfd05de730a5bd18d0de074fec33535ce1e20"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.2.0/ectf-tools-x86_64-apple-darwin.tar.gz"
      sha256 "4e23d662ffe7c825195ec9489b95a5fb765ff25a045aabcfc7327385286de650"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.2.0/ectf-tools-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c62efb8f9dc41d59fd10a2c0963227500462eebbdb9a20e8bfa2e7691de307ad"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.2.0/ectf-tools-x86_64-unknown-linux-musl.tar.gz"
      sha256 "00cdf4467061d7e9dd3c49adf350275e74fcf81e8153aef0e3700b5bad44460c"
    end
  end

  def install
    bin.install "ectf-tools"
    generate_completions_from_executable(bin/"ectf-tools", "completions")
  end

  test do
    assert_match "Drop-in replacement", shell_output("#{bin}/ectf-tools --help")
  end
end
