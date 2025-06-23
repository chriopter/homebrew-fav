class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "5f83eb1fb914202ebf3d45613a71f774e2e1841a8e8fad0a7b4968a4d9d32d11"
  license "MIT"

  def install
    bin.install "fav"
  end

  test do
    assert_equal "ls", shell_output("#{bin}/fav").chomp
  end
end