class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/yourusername/fav"
  url "https://github.com/chriopter/fav/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "d5931b4d1adf8f773c7aeec3e03bca7b17f404169c499f30c1113e9be4d8d4cb"
  license "MIT"

  def install
    bin.install "fav"
  end

  test do
    assert_equal "ls", shell_output("#{bin}/fav").chomp
  end
end