class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/yourusername/fav"
  url "https://github.com/chriopter/fav/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "3e7d04d0bdaf61cda8826983e934393c8e714ece492294fa676464523f1cd5f0"
  license "MIT"

  def install
    bin.install "fav"
  end

  test do
    assert_equal "ls", shell_output("#{bin}/fav").chomp
  end
end