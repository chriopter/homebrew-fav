class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v0.0.14.tar.gz"
  sha256 "b04e90055579c4c471dcd15e4563945d4098b1e9d3f44a73304be848d2676927"
  license "MIT"

  def install
    bin.install "fav"
    man1.install "fav.1"
    bash_completion.install "fav-completion.bash" => "fav"
    zsh_completion.install "fav-completion.zsh" => "_fav"
  end

  test do
    system "#{bin}/fav", "--version"
  end
end