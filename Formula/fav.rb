class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/yourusername/fav"
  url "https://github.com/yourusername/fav/archive/v0.1.0.tar.gz"
  sha256 "placeholder_sha256_hash"
  license "MIT"

  def install
    bin.install "fav"
  end

  test do
    assert_equal "ls", shell_output("#{bin}/fav").chomp
  end
end