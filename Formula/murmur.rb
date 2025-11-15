class Murmur < Formula
  desc "Job-based Whisper transcription server for macOS with Neural Engine acceleration"
  homepage "https://github.com/taciturnaxolotl/murmur"
  url "https://github.com/taciturnaxolotl/murmur/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "d7c4d7bee9260bc75e7f8b37bee3727ec67fe8491fde82a6a2aa7e59652067a9"
  license "AGPL-3.0"
  head "https://github.com/taciturnaxolotl/murmur.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/taciturnaxolotl/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d79a393aa243537dd36ae166368eafd332913047f4022b0d4207f0dc5d10e7b5"
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
