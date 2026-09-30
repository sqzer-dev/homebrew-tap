class Sqzer < Formula
  desc "Command-line interface for sqzer."
  homepage "https://sqzer.dev"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.2.0/sqzer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7dcf1c72a355e8fa92f236197827fc792ab403904480c25bd868426be4d86f5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.2.0/sqzer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6fa5e60b4a963b3e6c5d0fff0e03e796d1cee84896fd977885e11162d40303fe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.2.0/sqzer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3414006b82278edfab96393b6c212164b33be78d929e467ce74d4128da6cb37c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.2.0/sqzer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9cb536ea432a760b46817db9de64e5174680d4bdbdf902c56f3553d1946c01e2"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]
  depends_on "libheif"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sqzer"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sqzer"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sqzer"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sqzer"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
