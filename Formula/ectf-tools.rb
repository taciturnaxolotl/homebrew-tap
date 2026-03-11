class EctfTools < Formula
  desc "Drop-in replacement for MITRE's ectf CLI with reliable serial I/O"
  homepage "https://github.com/taciturnaxolotl/rust-ectf-tools"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/taciturnaxolotl/tap"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "5d86325233433778626b85c3422da68870a6da1fab66177107f53580558afd60"
    sha256 cellar: :any_skip_relocation, sequoia:      "e55b81142b2da9c63b5ea7abf58f13182fc7281a1d97172c3fda792d3f351bac"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "901587fc6f7333d706a3b99de21918304d9254acebfb316881c0ece02db5874b"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.2/ectf-tools-aarch64-apple-darwin.tar.gz"
      sha256 "add35ad7d1effabc1fddd3c707081aa75711905a21fc267505f7b17dc22bf5a5"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.2/ectf-tools-x86_64-apple-darwin.tar.gz"
      sha256 "fcfbef7b18584aede78599a4e5635ba9f680119a86faad6ba1d9927f8ef837bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.2/ectf-tools-aarch64-unknown-linux-musl.tar.gz"
      sha256 "85e8107d35a2cd1cc173b476d7450adfb7cb6e9083e4db63e9f0e871013fadc0"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.2/ectf-tools-x86_64-unknown-linux-musl.tar.gz"
      sha256 "01044abcdcd979e5b5e76c291dcd2d45c079636a099d619f081b1a9d7c1a3e22"
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
