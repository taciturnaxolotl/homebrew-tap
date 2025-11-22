class Murmur < Formula
  desc "Job-based Whisper transcription server for macOS with Neural Engine acceleration"
  homepage "https://github.com/taciturnaxolotl/murmur"
  url "https://github.com/taciturnaxolotl/murmur/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "e951a9f132de12b2f855edcb89d994b451f44ad574b03774f502da19ae203c5d"
  license "AGPL-3.0"
  head "https://github.com/taciturnaxolotl/murmur.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/taciturnaxolotl/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "dab5d51f4e31cfaec54b1720455c3edf51db2f799ddf0b39a06ec5f5be8a9f1e"
  end

  depends_on xcode: ["14.0", :build]
  depends_on arch: :arm64
  depends_on macos: :ventura

  def install
    # Build release binary
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/murmur"
  end

  service do
    # Run the daemon
    run [opt_bin/"murmur"]
    keep_alive true
    # Ensure writable working/log dirs
    working_dir var/"murmur"
    log_path var/"log/murmur.log"
    error_log_path var/"log/murmur.error.log"
    # Use an explicit per-user config path; derive via Pathname.expand_path to avoid nil Dir.home in service context
    # launchd runs as the installing user for Homebrew services; this expands correctly
    environment_variables MURMUR_CONFIG: Pathname("~/.config/murmur/murmur.yaml").expand_path.to_s
  end

  def post_install
    # Ensure service directories exist
    (var/"murmur").mkpath
    (var/"log").mkpath
    # Create default config in ~/.config/murmur unless in non-writable/CI environment
    begin
      home = Pathname("~").expand_path
      # Skip if HOME is not set or not writable
      if home.directory? && home.writable?
        config_dir = home/".config/murmur"
        config_dir.mkpath
        # Restrict permissions on config directory (0700) for user privacy
        # Note: chmod may fail on some filesystems; ignore failures
        begin
          File.chmod(0700, config_dir.to_s) if config_dir.directory?
        rescue Errno::EPERM, Errno::EACCES
          # ignore
        end
        config_file = config_dir/"murmur.yaml"
        unless config_file.exist?
          # Write atomically to avoid partial files
          tmp = config_dir/"murmur.yaml.tmp"
          tmp.write <<~EOS
            # Murmur Configuration File (YAML)

            server:
              host: 0.0.0.0
              port: 8000

            whisper:
              model: small
              # Optional: specify custom models directory
              # modelsPath: /path/to/whisper/models

            database:
              path: #{config_dir/"murmur.db"}
          EOS
          tmp.rename(config_file)
        end
      end
    rescue Errno::EPERM, Errno::EACCES
      # Skip config creation if home directory is not writable (e.g., CI environments)
      nil
    end
  end

  test do
    # Binary exists and is linked correctly
    assert_match "murmur", (bin/"murmur").realpath.to_s
  end
end
