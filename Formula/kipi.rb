class Kipi < Formula
  desc "kipi: a scoped map of your local repos and shared skills for LLM coding agents."
  homepage "https://github.com/martin-conur/kipi"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/martin-conur/kipi/releases/download/v0.3.0/kipi-cli-aarch64-apple-darwin.tar.xz"
      sha256 "55a980a79f9509537f1a684e42112fa38c27d3d07fd8192c3200f8c40ed899e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/martin-conur/kipi/releases/download/v0.3.0/kipi-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8ddaec3188d6dbe53ab4a06c8f2a4571c0917aca4b7b5ca99f3dea55649a8d53"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/martin-conur/kipi/releases/download/v0.3.0/kipi-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "711b4f668f36e51e5f8981754ea561565b00f8ec824b6289ec9cb0f744d64282"
    end
    if Hardware::CPU.intel?
      url "https://github.com/martin-conur/kipi/releases/download/v0.3.0/kipi-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c2075e654d5de45caa843e05a6cc2bda72b615a6c01a00b543b8b5c05f3fd8a5"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "kipi"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kipi"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kipi"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kipi"
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
