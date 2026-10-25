class Ttyl < Formula
  desc "A terminal client for the dev-null.sh social network"
  homepage "https://github.com/younes-io/ttyl"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/younes-io/ttyl/releases/download/v0.2.0/ttyl-aarch64-apple-darwin.tar.gz"
      sha256 "a0ed01a9a2f556277856b3852a01fb56b1ef52e9115278efa565065970aa3060"
    end
    if Hardware::CPU.intel?
      url "https://github.com/younes-io/ttyl/releases/download/v0.2.0/ttyl-x86_64-apple-darwin.tar.gz"
      sha256 "006d7ecf876847fc13ebf1d9c633501a6cfcd3d023195e298b04d0cc71c9f739"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/younes-io/ttyl/releases/download/v0.2.0/ttyl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "00dd3d1d3cd78398afa72f60be67d7b6aafdcd3447d8600548b7a5c4a035abdd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/younes-io/ttyl/releases/download/v0.2.0/ttyl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0641733aa86b8b12bd5218b48c7a654c5b5d0975d61f583c1f587ab34da47368"
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
