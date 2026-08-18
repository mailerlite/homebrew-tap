class Mailerlite < Formula
  desc "Command-line interface for the MailerLite API"
  homepage "https://github.com/mailerlite/mailerlite-cli"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mailerlite/mailerlite-cli/releases/download/v2.0.0/mailerlite-aarch64-apple-darwin.tar.gz"
      sha256 "de69a5bb895e6f442bb8b285509bc93855b5e78b7931088bbd7c00a5475dd4d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mailerlite/mailerlite-cli/releases/download/v2.0.0/mailerlite-x86_64-apple-darwin.tar.gz"
      sha256 "0d9072122b6cd9cb678730fb2f4ac2bc6ff2d056a2fb51bc8de04fd0ac6aa2cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mailerlite/mailerlite-cli/releases/download/v2.0.0/mailerlite-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dbdd8fbfd2e2dc8e6dc7cc586a530419ab0fffafdc3a57673ec565cb2b0bb29b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mailerlite/mailerlite-cli/releases/download/v2.0.0/mailerlite-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "233cfbdc7496b3f2fa9290d218553a290efa994bec16e473a2b09634d6ab1b16"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "mailerlite"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mailerlite"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mailerlite"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mailerlite"
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
