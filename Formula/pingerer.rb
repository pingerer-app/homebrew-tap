class Pingerer < Formula
  desc "Pingerer from your terminal: uptime, SSL, DNS and email monitoring, incidents, heartbeats and deploys"
  homepage "https://pingerer.com"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pingerer-app/pingerer/releases/download/v0.3.0/pingerer-aarch64-apple-darwin.tar.xz"
      sha256 "0bd99e599bded193be8760cbe2862f2c9d043e33a21e7864c53a3bd312710c4b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pingerer-app/pingerer/releases/download/v0.3.0/pingerer-x86_64-apple-darwin.tar.xz"
      sha256 "40ec94afd57d9fc0da1e517e9b635039b6dc095b4867c3306b0e7d0f0562feef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pingerer-app/pingerer/releases/download/v0.3.0/pingerer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "24b61104af3d737bf99958d536f1dfc97c182a2e9a0c072a8cd4e8667943dfb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pingerer-app/pingerer/releases/download/v0.3.0/pingerer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11da69fad03ec36aef740d3d529281dcaefd857995c325ac3e78ed6e6dac63e7"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
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
      bin.install "pingerer"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pingerer"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pingerer"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pingerer"
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
