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
