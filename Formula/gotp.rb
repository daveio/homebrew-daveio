class Gotp < Formula
  desc "Generate OATH-TOTP one-time passwords from the command-line"
  homepage "https://github.com/daveio/gotp"
  url "https://github.com/daveio/gotp/archive/v1.0.0.tar.gz"
  sha256 "62871e4215008dec6daeca9a636c14fee9e8e9704a0eed9fb0e9bd10553094e5"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    srcpath = buildpath/"src/github.com/daveio/gotp"
    srcpath.install buildpath.children

    cd srcpath do
      system "go", "get", "-t"
      system "go", "build", "-o", bin/"gotp"
      prefix.install_metafiles
    end
  end

  test do
    output = shell_output("#{bin}/gotp hello").strip
    assert_equal "https://github.com/daveio/gotp", output
  end
end
