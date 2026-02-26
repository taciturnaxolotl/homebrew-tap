class EctfTools < Formula
  desc "Drop-in replacement for MITRE's ectf CLI with reliable serial I/O"
  homepage "https://github.com/taciturnaxolotl/rust-ectf-tools"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.1.0/ectf-tools-aarch64-apple-darwin.tar.gz"
      sha256 "7bb6b0c5f27fd37cb270e292010ca7a1a92a6f33fd914ebb20b7aac6146d1981"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.1.0/ectf-tools-x86_64-apple-darwin.tar.gz"
      sha256 "263d8a7026fb3ab91901ac8de9b926d7e831ca5ceb999e0797d14f4ae1f28ff2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.1.0/ectf-tools-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "24ff9b91bad1fad534c1119254732671b3b53b4b128e96028102bdcfb6db935b"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.1.0/ectf-tools-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c359fab470bdce2f5967ac7efcb725e95d65ecfd01de31543fd0681c6fedce19"
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
