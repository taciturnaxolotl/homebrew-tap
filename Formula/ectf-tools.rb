class EctfTools < Formula
  desc "Drop-in replacement for MITRE's ectf CLI with reliable serial I/O"
  homepage "https://github.com/taciturnaxolotl/rust-ectf-tools"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/taciturnaxolotl/tap"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a42b83163658cbf5f88adc6f37a61ece15d88c3ec4bf509fa68a76a90adcb7ac"
    sha256 cellar: :any_skip_relocation, sequoia:      "b49a752e2e5022f94cdc37c34409032d268b11dedde2565b2c01e379a0987f15"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "94d8a724e40342a619fcde19fafdb48f2a2ccd177655b22c8710d6593d1e42c8"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.0/ectf-tools-aarch64-apple-darwin.tar.gz"
      sha256 "4dbd32b3f8ef8fffbec9ba2b4d832575cbb62aa742100f9883666039a251f6a9"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.0/ectf-tools-x86_64-apple-darwin.tar.gz"
      sha256 "61bb823da7e0f4c87947463349d769e9131f2b1f836554900a07e4ca6faedbbb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.0/ectf-tools-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ad97e6ee607f01ec9c0f3149c60e752503744a51ccaf77e38173780f2996e44c"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.0/ectf-tools-x86_64-unknown-linux-musl.tar.gz"
      sha256 "75ce6bc256fd5757038e207c92361fb4a6da96aaf078adf0161edf2aaa9d1080"
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
