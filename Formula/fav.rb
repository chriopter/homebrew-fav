class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/yourusername/fav"
  url "https://github.com/chriopter/fav/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "229642520c65831b28f8c3dd28dddaff6298ab0d34b40819f8cf2d4e0cdf3ea7"
  license "MIT"

  def install
    bin.install "fav"
  end

  test do
    assert_equal "ls", shell_output("#{bin}/fav").chomp
  end
end