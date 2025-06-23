class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v0.0.9.tar.gz"
  sha256 "4639b7aa27bdf51139b15752bd4672f6a3f10c61d1f1f7168bc4d8c131dfbef3"
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