class ClaudeSwap < Formula
  desc "Safely swap between Z.ai, MiniMax, and standard Anthropic Claude configurations"
  homepage "https://github.com/sachicali/homebrew-claude-swap"
  version "1.0.0"
  license "MIT"

  if OS.mac?
    url "https://github.com/sachicali/homebrew-claude-swap/archive/refs/tags/v1.0.0.tar.gz"
    sha256 "69ccb797923de14536c9e4e0308d803a3b6ea6a0148ebb16c45e9de4b2045243"
  end

  depends_on "jq"

  def install
    # Install the main script
    bin.install "claudeswap"

    # Install the zsh completion file
    zsh_completion.install "claude-swap.zsh" => "_claudeswap"

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
