class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "1e27b8cee65c29a64de9f549014d5ac75b263e4d11a18ea5fcc759d371d0759d"
  license "MIT"

  def install
    bin.install "fav"
  end

  test do
    assert_equal "ls", shell_output("#{bin}/fav").chomp
  end
end