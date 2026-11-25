class GoogleTasksTui < Formula
  desc "Terminal UI and scriptable CLI for Google Tasks"
  homepage "https://ryanelston.com/google-tasks-tui/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/relston/google-tasks-tui/releases/download/v0.1.0/google-tasks-tui-aarch64-apple-darwin.tar.xz"
      sha256 "29a1848fbf6ae886f7a25ef2b4438d24750558bdc920d1c4d3163c54889186e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/relston/google-tasks-tui/releases/download/v0.1.0/google-tasks-tui-x86_64-apple-darwin.tar.xz"
      sha256 "f446986a9ba6c3ac44f4af40380f9afd4c9914785adf1a420adf32be8042d13e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/relston/google-tasks-tui/releases/download/v0.1.0/google-tasks-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "48af8a7155c717f2c01a87300079441c215170f761f923b779be138ba0941d72"
    end
    if Hardware::CPU.intel?
      url "https://github.com/relston/google-tasks-tui/releases/download/v0.1.0/google-tasks-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ac42c712464c791bf884c0ef51a6f4187eb494165703bca26f45357a1185b680"
    end
  end
  license "MIT"

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
      bin.install "google-tasks-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "google-tasks-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "google-tasks-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "google-tasks-tui"
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
