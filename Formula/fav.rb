class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v1.2.7.tar.gz"
  sha256 "3937cc70899f740935b384126786a9060f174133d99d5ebd0b0703e15f075850"

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