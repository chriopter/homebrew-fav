class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v0.0.8.tar.gz"
  sha256 "1a2f1559a2c8c28be9c0de5537d8caaced0aa0ec45935a71fb54fdaafaabac87"
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