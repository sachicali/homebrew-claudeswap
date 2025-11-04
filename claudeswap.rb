class Claudeswap < Formula
  desc "Safely swap between GLM providers (Z.ai), MiniMax, and standard Anthropic Claude configurations with dynamic model mapping and performance optimization"
  homepage "https://github.com/sachicali/homebrew-claude-swap"
  version "1.2.0"
  license "MIT"

  url "https://github.com/sachicali/homebrew-claude-swap/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "cc0da0dc5a821ee791e4d8e98c14da7003f3806904acd98d86998e23bfd85836"

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
