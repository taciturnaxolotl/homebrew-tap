class Murmur < Formula
  desc "Job-based Whisper transcription server for macOS with Neural Engine acceleration"
  homepage "https://github.com/taciturnaxolotl/murmur"
  url "https://github.com/taciturnaxolotl/murmur/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c4731637d20f1e2f4f43b49a978a82252b326b41f5566f141c97a6112e99b318"
  license "AGPL-3.0"
  head "https://github.com/taciturnaxolotl/murmur.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/taciturnaxolotl/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bfaff24b26b59f2586c52401463283cfbbe208176a72ca94f7207d72e75a48d8"
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
    environment_variables MURMUR_CONFIG: "#{Dir.home}/.config/murmur/murmur.yaml"
  end

  def post_install
    (var/"murmur").mkpath
    (var/"log").mkpath
    # Create default config file in ~/.config/murmur
    # Skip if home directory is not writable (e.g., in CI environments)
    begin
      config_dir = Pathname.new(Dir.home)/".config/murmur"
      config_dir.mkpath
      config_file = config_dir/"murmur.yaml"
      unless config_file.exist?
        config_file.write <<~EOS
          # Murmur Configuration File (YAML)

          server:
            host: 0.0.0.0
            port: 8000

          whisper:
            model: small
            # Optional: specify custom models directory
            # modelsPath: /path/to/whisper/models

          database:
            path: #{config_dir}/murmur.db
        EOS
      end
    rescue Errno::EPERM, Errno::EACCES
      # Skip config creation if home directory is not writable
      nil
    end
  end

  test do
    assert_match "murmur", (bin/"murmur").realpath.to_s
  end
end
