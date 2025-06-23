class Fav < Formula
  desc "A bash favorite command tool for macOS"
  homepage "https://github.com/chriopter/homebrew-fav"
  url "https://github.com/chriopter/homebrew-fav/archive/refs/tags/v0.0.23.tar.gz"
  sha256 "a40f83dd81b9ce90246cd01b93be83f17e41db633536d0fb7eb1eaaaec26f152"
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