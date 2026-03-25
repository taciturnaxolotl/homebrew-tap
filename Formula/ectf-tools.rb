class EctfTools < Formula
  desc "Drop-in replacement for MITRE's ectf CLI with reliable serial I/O"
  homepage "https://github.com/taciturnaxolotl/rust-ectf-tools"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.4.0/ectf-tools-aarch64-apple-darwin.tar.gz"
      sha256 "f294de9502c4bd1c9737670b09ae969d47ce92a68db0a486f7748fc08e79a393"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.4.0/ectf-tools-x86_64-apple-darwin.tar.gz"
      sha256 "0314338c680d475a1009456eb7991a45ec32b1fe9154adfd16ed72b395e424bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.4.0/ectf-tools-aarch64-unknown-linux-musl.tar.gz"
      sha256 "09c498365f3ed9a193951f71fe0fa417a9641c652d57c5298fc19ee1d16fa07a"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.4.0/ectf-tools-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6cb0abc70c68b81d3423f044e5a78af72d63593e3c59f1801a08817aad735ce5"
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
