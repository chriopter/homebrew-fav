class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v0.0.12.tar.gz"
  sha256 "41594539f720e6dbda2b6a8e83e90439d50e47c43fc2a6f6d070790f5a6a07ac"
  license "MIT"

  def install
    bin.install "fav"
    man1.install "fav.1"
    bash_completion.install "fav-completion.bash" => "fav"
  end

  test do
    system "#{bin}/fav", "--version"
  end
end