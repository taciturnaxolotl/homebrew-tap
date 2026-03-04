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
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.1/ectf-tools-aarch64-apple-darwin.tar.gz"
      sha256 "39d2510ee38fae6133cc030a742f045fb431864591c1220c6246ee353b4bd65a"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.1/ectf-tools-x86_64-apple-darwin.tar.gz"
      sha256 "f9058fd0394d517bfd4f91547b49027850cc3d953c9b2c3d04ccdba89ef60f79"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.1/ectf-tools-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5bfb211b51e7df7d811c28a251182a7ffd371720980911cef8ff038f9443b7c0"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.3.1/ectf-tools-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a0cbd7c8218031282a0873342b051ea15e0d591d41ce3d5b446f20f188fa8568"
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
