require "language/go"

class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/spicetify/spicetify-cli"
  url "https://github.com/spicetify/spicetify-cli/archive/v2.27.1.tar.gz"
  head "https://github.com/spicetify/spicetify-cli"
  sha256 "3e41c4ac65d916fea662037a492ad63490a22255fad7397731f8fb6efcb3cf0d"

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
