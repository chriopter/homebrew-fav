class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v0.0.27.tar.gz"
  sha256 "b37f724c708cdd602a66e8bb51ec5e9291ec950cbc49390e43691c1496921edf"
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