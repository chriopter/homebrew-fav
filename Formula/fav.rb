class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "41691b4263ffbd0877359977deaf47ff767c33f599701ef9875ded7a5f5a5507"

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