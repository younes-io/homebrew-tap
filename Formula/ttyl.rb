class Ttyl < Formula
  desc "A terminal client for the dev-null.sh social network"
  homepage "https://github.com/younes-io/ttyl"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/younes-io/ttyl/releases/download/v0.1.0/ttyl-aarch64-apple-darwin.tar.xz"
      sha256 "bff370cd03527620e6e45387b723ee820db8f41af469bb96396fa6ff5979a176"
    end
    if Hardware::CPU.intel?
      url "https://github.com/younes-io/ttyl/releases/download/v0.1.0/ttyl-x86_64-apple-darwin.tar.xz"
      sha256 "608a03e88348df5580319d2c6c683c8859c76ddadd32aa1d42d7372a4f935616"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/younes-io/ttyl/releases/download/v0.1.0/ttyl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e0c1b1932b96ff3f9dec68247752a73002832f27bca95b6eeab3cc9ef8e868c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/younes-io/ttyl/releases/download/v0.1.0/ttyl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d9b6a339518776911ce92a0080bfbb9a4aac07be267dc2184db6f2002879c1da"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "ttyl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ttyl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ttyl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ttyl"
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
