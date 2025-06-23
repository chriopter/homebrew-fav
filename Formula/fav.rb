class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/yourusername/fav"
  url "https://github.com/chriopter/fav/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "2d41afa917017c5b9c614593a5ea00355cc7eaf14efc3fc2685a12baf5ee49d0"
  license "MIT"

  def install
    bin.install "fav"
  end

  test do
    assert_equal "ls", shell_output("#{bin}/fav").chomp
  end
end