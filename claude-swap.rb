class ClaudeSwap < Formula
  desc "Safely swap between Z.ai, MiniMax, and standard Anthropic Claude configurations"
  homepage "https://github.com/sachicali/homebrew-claude-swap"
  version "1.1.0"
  license "MIT"

  if OS.mac?
    url "https://github.com/sachicali/homebrew-claude-swap/archive/refs/tags/v1.1.0.tar.gz"
    sha256 "4e47d29fe56b27bc3a7b05208331b0699a7799d73d49b1d8cade2a8d82e38933"
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
