class EctfTools < Formula
  desc "Drop-in replacement for MITRE's ectf CLI with reliable serial I/O"
  homepage "https://github.com/taciturnaxolotl/rust-ectf-tools"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/taciturnaxolotl/tap"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "55e12cfcbb620ff9baf755e69236442769a82779da06c799c2562b684e63c35d"
    sha256 cellar: :any_skip_relocation, sequoia:      "b437547f12dbd2dd7f4ce46ff4e16cd2a7a9cb0216c95c949489cbf224b0bfe6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "29ce473ca591edf3074a7eff0c2195664e82efa66c3532f152884e46f6926d26"
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
