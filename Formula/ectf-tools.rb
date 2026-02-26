class EctfTools < Formula
  desc "Drop-in replacement for MITRE's ectf CLI with reliable serial I/O"
  homepage "https://github.com/taciturnaxolotl/rust-ectf-tools"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/taciturnaxolotl/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a64265c57e8844ce8876144f8bc177efd65676eacdf97f7f1495db08b0966cdd"
    sha256 cellar: :any_skip_relocation, sequoia:      "5e853cae860f59be71e4529642cd4681ab3cd45779428e4adf87a4b5e64d7fc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "70cd40c3203497d0f62bbcb84cf8feb0c369e40c2d1903bf6c37c8da27a4fab2"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.2.0/ectf-tools-aarch64-apple-darwin.tar.gz"
      sha256 "5efa05737a23e2e2f77f9dca181eca6ec67d9a260bdce117dce23f01a9fdcc58"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.2.0/ectf-tools-x86_64-apple-darwin.tar.gz"
      sha256 "6dc74f6c216bd87b92e2d036aa111a79d9ba1811fca5772a1e878f9f8f47b7f2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.2.0/ectf-tools-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ec6bcf0990c22f3dcf771830b9fe80e625c69c2521c7148d9b41d404eca70326"
    else
      url "https://github.com/taciturnaxolotl/rust-ectf-tools/releases/download/v0.2.0/ectf-tools-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "de5146f0489cb9bf5370d864d104352b4003af42c81e9db9a9818cf6e99d2a73"
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
