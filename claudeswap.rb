class Claudeswap < Formula
  desc "Safely swap between GLM providers (Z.ai), MiniMax, and standard Anthropic Claude configurations with dynamic model mapping and performance optimization"
  homepage "https://github.com/sachicali/homebrew-claude-swap"
  version "1.2.0"
  license "MIT"

  url "https://github.com/sachicali/homebrew-claude-swap/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "dddb869f2427e4fc42a05a0d9340c63f0153788435a052be971ace98c60f2e30"

  depends_on "jq"

  def install
    # Install the main script
    bin.install "claudeswap"

    # Install the zsh completion file
    zsh_completion.install "claudeswap.zsh" => "_claudeswap"

    # Install documentation
    doc.install "README.md"
    doc.install "LICENSE"
    doc.install "SETUP-GUIDE.md"
    doc.install "example-configs.md"
  end

  test do
    # Test that the script runs and shows help
    assert_match "Usage: claudeswap", shell_output("#{bin}/claudeswap help")
  end
end
