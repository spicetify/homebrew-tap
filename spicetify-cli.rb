require "language/go"

class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/spicetify/spicetify-cli"
  url "https://github.com/spicetify/spicetify-cli/archive/v2.33.2.tar.gz"
  head "https://github.com/spicetify/spicetify-cli"
  sha256 "e7677a51707be900e154e8d659f0fc8f980ca7e5526cc91b1a8660a4218735e2"

  depends_on "go" => "1.19"

  def install
    ENV["GOPATH"] = buildpath
    path = buildpath/"dep"
    path.install Dir["*"]
    cd path do
      system "go", "build", "-ldflags", "-X main.version=#{version.to_s}", "-o", "#{bin}/spicetify"
      cp_r "./globals.d.ts", bin
      cp_r "./jsHelper", bin
      cp_r "./Themes", bin
      cp_r "./Extensions", bin
      cp_r "./CustomApps", bin
      cp_r "./css-map.json", bin
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spicetify", "-v")
  end
end
