# Homebrew Tap

This is a Homebrew tap for installing custom formulae.

## How to use this tap

```bash
brew tap taciturnaxolotl/tap
```

## Formulae

### murmur

Job-based Whisper transcription server for macOS with Neural Engine acceleration.

**Installation:**

```bash
brew install murmur
```

**Running as a service:**

```bash
brew services start murmur
```

**Configuration:**

Edit the service configuration at `~/Library/LaunchAgents/homebrew.mxcl.murmur.plist` to customize environment variables like `PORT`, `WHISPER_MODEL`, etc.

**Requirements:**
- macOS 13+ (Ventura or later)
- Apple Silicon (M1/M2/M3)
- Xcode 14.0+

**More info:** https://github.com/taciturnaxolotl/murmur
