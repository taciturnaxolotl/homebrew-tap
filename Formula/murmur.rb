class Murmur < Formula
  desc "Job-based Whisper transcription server for macOS with Neural Engine acceleration"
  homepage "https://github.com/taciturnaxolotl/murmur"
  url "https://github.com/taciturnaxolotl/murmur/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4c9346b9252dfcbcc2cd6adde84e75304fea22ffd389999b29258906a1d5ed70"
  license "AGPL-3.0"
  head "https://github.com/taciturnaxolotl/murmur.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/taciturnaxolotl/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "57ca9d12f4ce6c329ef3cb190e8f9ce6a9337d77ba3ddae801bc2098ff016341"
  end

  depends_on xcode: ["14.0", :build]
  depends_on arch: :arm64
  depends_on macos: :ventura

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/murmur"
  end

  service do
    run [opt_bin/"murmur"]
    keep_alive true
    working_dir var/"murmur"
    log_path var/"log/murmur.log"
    error_log_path var/"log/murmur.error.log"
    environment_variables PORT: "8000", HOST: "0.0.0.0", WHISPER_MODEL: "small"
  end

  def post_install
    (var/"murmur").mkpath
    (var/"log").mkpath
  end

  test do
    assert_match "murmur", (bin/"murmur").realpath.to_s
  end
end
