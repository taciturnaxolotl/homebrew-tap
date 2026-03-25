class EctfTools < Formula
  desc "Drop-in replacement for MITRE's ectf CLI with reliable serial I/O"
  homepage "https://github.com/taciturnaxolotl/rust-ectf-tools"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/taciturnaxolotl/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "85d8a440a05ac84db72b3932004f93111709ef521c49a939608b1e4a96558a1b"
    sha256 cellar: :any_skip_relocation, sequoia:      "c0ac8f924897bb2ecaa1e6b5d4aaf90b994cc604ae6ded1c8f0b625b7fdec31b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a1cae277faa198aafc0a363f6ee08bc6e12223e73f7d286d6908f5bece1d3ed6"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.4.1/ectf-tools-aarch64-apple-darwin-v0.4.1.tar.gz"
      sha256 "b80d51f4dce8e5e1ca8bb93e6bd0d5ced200db07aca75ebb00d3d91ad39bff48"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.4.1/ectf-tools-x86_64-apple-darwin-v0.4.1.tar.gz"
      sha256 "77e33de128a9020e2f8ba742e1f5f4816ae80931fb42d8df1fa158ed9aa2810a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.4.1/ectf-tools-aarch64-unknown-linux-musl-v0.4.1.tar.gz"
      sha256 "88493fefaebd13bdc8928213a274a586fccf56786261310bb147e334deef167c"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.4.1/ectf-tools-x86_64-unknown-linux-musl-v0.4.1.tar.gz"
      sha256 "b6f297d4968e8d4adf2a5dc322ca27ef5ed57a901b9cb7b801b0de7fee1fb28c"
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
