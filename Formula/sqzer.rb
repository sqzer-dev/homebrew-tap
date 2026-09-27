class Sqzer < Formula
  desc "Command-line interface for sqzer."
  homepage "https://sqzer.dev"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.1.1/sqzer-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4c297703df3e7e1a238656f6e26d707c7bec779b3ab0545de57841bdd860b264"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.1.1/sqzer-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8d1cabeb3c43c374761b7dc49e37549813b68fff25610e673bb33509404c7d45"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.1.1/sqzer-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "19d7399f85a2b50ccc8b8ea1b95edc80a2d777416c56c489e2d0d6df866a0a59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sqzer-dev/sqzer/releases/download/v0.1.1/sqzer-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ab466fa6c22082c5445ab2546d386fde41cc011171994681cb03d79c6e22343"
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
