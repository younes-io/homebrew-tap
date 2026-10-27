class Ttyl < Formula
  desc "A terminal client for the dev-null.sh social network"
  homepage "https://github.com/younes-io/ttyl"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/younes-io/ttyl/releases/download/v0.3.0/ttyl-aarch64-apple-darwin.tar.gz"
      sha256 "299a493c22d588ad7788186011e5ff45e6d55f1bd17933941c414bc11be173c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/younes-io/ttyl/releases/download/v0.3.0/ttyl-x86_64-apple-darwin.tar.gz"
      sha256 "5c33c9d4423c3bea43ec26ed0ec4d4690755f66f0918b8d3b62d01d1fa68742f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/younes-io/ttyl/releases/download/v0.3.0/ttyl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "652e6d80096b070662a9ad5a4a8507e0365de6ea195cd571f9fd6dda1ff69ae6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/younes-io/ttyl/releases/download/v0.3.0/ttyl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e3ee41bb852d6760b0053d1822f757d2ac1140a28843d506ca8bff52468cc898"
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
