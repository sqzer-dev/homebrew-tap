class Sqzer < Formula
  desc "Command-line interface for sqzer."
  homepage "https://sqzer.dev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.1.0/sqzer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "66467e03ea768225e8de0a99f4cfa952e53028b4ea559fee54db8d3a9720cd06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.1.0/sqzer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ffd35b0886d680a3e1546ae1849efe02aa43c1d13840a709e47dafce4f743292"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.1.0/sqzer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5fb3cc9aab0ead01cbd65ad0e067d8e481eafa49795ee5074e2caa734449ec62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.1.0/sqzer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e99bd42e21a1ee63d37e9aab15f9744ef01d884b5ed9a95c62489490d638c17b"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]
  depends_on "libheif"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
