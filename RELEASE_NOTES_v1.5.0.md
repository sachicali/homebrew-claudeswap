# ClaudeSwap v1.5.0 - Release Notes

**Release Date:** 2025-11-10
**Status:** Production Ready
**Codename:** Concurrent Execution & Kimi for Coding

---

## 🎉 Overview

ClaudeSwap v1.5.0 is a major release that brings **CCS-style concurrent execution**, **official Kimi for Coding integration**, and critical bug fixes. This release focuses on multi-provider workflows, enabling developers to run multiple Claude providers simultaneously without conflicts.

---

## 🚀 Major Features

### 1. CCS-Style Concurrent Execution

Inspired by [CCS (Claude Code Switch)](https://github.com/kaitranntt/ccs), ClaudeSwap now supports true concurrent multi-provider usage:

**Instance Isolation:**
- Each provider gets its own isolated directory at `~/.claude/instances/<provider>/`
- Separate session files, configuration, and state
- Zero conflicts between concurrent provider sessions

**Direct Command Execution:**
```bash
# CCS-style shorthand - switch and execute in one command
claudeswap kimi "write a bash script"
claudeswap kimi-for-coding "implement authentication system"
claudeswap zai "fix this bug"
claudeswap standard "review code"

# Explicit exec command
claudeswap exec kimi "implement feature"
```

**Concurrent Multi-Provider Usage:**
```bash
# Terminal 1: Coding with Kimi for Coding
claudeswap kimi-for-coding "implement authentication"

# Terminal 2: General queries with regular Kimi (no conflict!)
claudeswap kimi "explain this architecture"

# Terminal 3: Testing with Z.ai
claudeswap zai "write comprehensive tests"

# Terminal 4: Quick queries with Standard API
claudeswap standard "review this code snippet"
```

### 2. Official Kimi for Coding Support ⭐

**OFFICIAL Moonshot AI Product Integration:**
- **Endpoint:** `https://api.kimi.com/coding/` (dedicated coding API)
- **Model:** `kimi-for-coding` (official model identifier)
- **Requirements:** Moonshot membership subscription
- **Optimized for:** Professional coding, complex algorithms, enterprise development
- **Features:** Code-specific training, enhanced tool calling, agentic workflows
- **Compatible with:** Claude Code, Cline, RooCode (Anthropic-compatible API)
- **Separate instance:** Maintains independent directory from regular `kimi`
- **Same token:** Uses `CLAUDE_KIMI_AUTH_TOKEN` but different endpoint

**Usage:**
```bash
claudeswap kimi-for-coding "implement production authentication system"
claudeswap set kimi-for-coding
```

### 3. Kimi K2 Turbo - 4x Faster Performance ⚡

Regular Kimi now uses the blazing-fast K2 Turbo model:

- **Model:** `kimi-k2-turbo-preview` (released August 2025)
- **Speed:** 40 tokens/sec (vs 10 tok/s for standard K2)
- **Context:** 256K tokens
- **Cost:** $0.30/$1.20/$5.00 per million tokens (cache hit/miss/output)
- **Best for:** General queries, fast responses, explanations, documentation

### 4. Auto-Installer Script

One-line installation with bundled Gum:

```bash
curl -fsSL https://raw.githubusercontent.com/sachicali/homebrew-claudeswap/main/install.sh | bash
```

**Features:**
- Automatically downloads and bundles Gum binary for your platform
- Supports macOS and Linux (x86_64, arm64, armv7)
- Auto-detects platform and architecture
- Configures PATH in shell rc file
- Creates instance directories
- No separate Gum installation needed!

---

## 🔧 New Commands

### Instance Management
```bash
# List all provider instances with status
claudeswap instances
claudeswap list

# Initialize new instance
claudeswap init kimi

# Activate specific instance
claudeswap activate zai

# Execute command with provider (CCS-style)
claudeswap exec kimi "write code"
claudeswap kimi "write code"  # Shorthand
```

---

## 🆕 New Environment Variables

- `CLAUDESWAP_CLAUDE_PATH` - Custom Claude CLI path (like CCS's `CCS_CLAUDE_PATH`)
- `CLAUDESWAP_INSTALL_DIR` - Custom installation directory
- `CLAUDESWAP_LIB_DIR` - Custom library directory
- `CLAUDESWAP_TUI_MODE` - TUI mode setting (auto/always/never)
- `CLAUDE_KIMI_FOR_CODING_BASE_URL` - Custom endpoint for Kimi for Coding

---

## 🐛 Bug Fixes

### Critical Syntax Error Fixed
- **Issue:** Duplicate semicolon `;;` in `lib/models.sh:114` causing bash syntax error
- **Impact:** Script failed to load, preventing all operations
- **Fix:** Removed duplicate semicolon in kimi-for-coding case statement
- **Status:** ✅ All syntax checks now passing

### Version Mismatch Resolved
- **Issue:** Main script reported v1.5.0 but Homebrew formula was at v1.2.8
- **Impact:** Version reporting inconsistency, outdated formula
- **Fix:** Updated `claudeswap.rb` to version 1.5.0
- **Status:** ✅ Version consistency verified across codebase

### Bash 3.2 Compatibility
- **Issue:** Usage of bash 4+ features (`readarray`, `local -n` nameref)
- **Impact:** Script failed on macOS with default bash 3.2
- **Fix:** Replaced with bash 3.2-compatible alternatives
- **Status:** ✅ Fully compatible with bash 3.2+

### Duplicate Token Constants
- **Issue:** Token constants declared in multiple files
- **Impact:** Potential inconsistencies and maintenance burden
- **Fix:** Centralized all constants in `lib/constants.sh`
- **Status:** ✅ Single source of truth established

---

## 🎨 Improvements

### Code Quality
- ✅ **NASA-style safety practices:** `set -euo pipefail`, bounded loops, error checking
- ✅ **Modular architecture:** TIGERSTYLE design with single responsibility principle
- ✅ **Atomic operations:** `mktemp` for safe file handling
- ✅ **Input validation:** All user input sanitized
- ✅ **Clean separation:** Provider logic isolated in separate modules

### Performance
- ✅ **Optimized instance management:** Fast provider switching
- ✅ **Efficient model mapping:** Cache-based lookups
- ✅ **Parallel-ready:** Independent provider instances

### Documentation
- ✅ **Updated README:** Complete CCS-style features documentation
- ✅ **CHANGELOG:** Comprehensive version history
- ✅ **SECURITY.md:** Security best practices
- ✅ **ARCHITECTURE.md:** System design documentation
- ✅ **IMPLEMENTATION_COMPLETE.md:** Feature completion summary

---

## 📦 Installation

### Option 1: Auto-Installer (Recommended)
```bash
# One-line install with bundled Gum
curl -fsSL https://raw.githubusercontent.com/sachicali/homebrew-claudeswap/main/install.sh | bash

# Reload shell
source ~/.zshrc
```

### Option 2: Homebrew
```bash
# Install from GitHub repository
brew install sachicali/homebrew-claudeswap/claudeswap

# Install Gum for TUI mode
brew install gum
```

### Option 3: Manual Homebrew Formula
```bash
# Tap the repository
brew tap sachicali/claudeswap

# Install the formula
brew install claudeswap
```

---

## 🔄 Upgrade Instructions

### From v1.2.x to v1.5.0

```bash
# If installed via Homebrew
brew update
brew upgrade claudeswap

# If installed via install.sh
curl -fsSL https://raw.githubusercontent.com/sachicali/homebrew-claudeswap/main/install.sh | bash

# Reload your shell
source ~/.zshrc
```

**Breaking Changes:** None - fully backward compatible!

**Migration Notes:**
- Existing sessions remain compatible
- No configuration changes required
- New features opt-in by default

---

## 🧪 Supported Providers (5 Total)

1. **Standard Anthropic** - Official Claude API
   - Models: claude-sonnet-4-5, claude-haiku-4-5
   - Timeout: 2 minutes (configurable)

2. **Z.ai / GLM** - GLM-4.6 models via Z.ai
   - Models: glm-4.6, glm-4.5-air
   - Timeout: 50 minutes

3. **MiniMax** - MiniMax-M2
   - Models: MiniMax-M2, MiniMax-M1
   - Timeout: 50 minutes

4. **Kimi** - K2 Turbo (4x faster, 40 tok/s)
   - Models: kimi-k2-turbo-preview
   - Context: 256K tokens
   - Timeout: 50 minutes
   - Best for: General queries, fast responses

5. **Kimi for Coding** - Official Moonshot Coding Plan
   - Model: kimi-for-coding
   - Dedicated endpoint: api.kimi.com/coding/
   - Requires: Moonshot membership
   - Best for: Professional coding, enterprise development

---

## 📊 Verification & Testing

All components verified and tested:

```bash
✓ claudeswap version 1.5.0 - Working correctly
✓ All shell scripts pass syntax validation
✓ Version consistency: 1.5.0 across codebase
✓ No bash 4+ incompatibilities
✓ Clean working tree
✓ Instance isolation tested
✓ Multi-provider concurrent execution verified
```

---

## 🙏 Acknowledgments

**Inspired by:**
- **[CCS (Claude Code Switch)](https://github.com/kaitranntt/ccs)** - Instance isolation, concurrent execution, direct command pass-through architecture
- **[Charmbracelet Gum](https://github.com/charmbracelet/gum)** - Beautiful TUI components
- **Moonshot AI** - Official Kimi for Coding plan integration

**Special Thanks:**
- Sourcery AI for code review insights
- The bash scripting community for best practices
- Early adopters and testers

---

## 📝 Full Changelog

For a complete list of changes, see [CHANGELOG.md](CHANGELOG.md)

---

## 🔐 Security

- **Your tokens stay on your machine** - never stored in the repository
- Tokens stored only in environment variables
- Automatic backups of settings (without exposing tokens)
- All token validation is local
- Atomic file operations prevent corruption
- Input sanitization prevents injection attacks

For security concerns, see [SECURITY.md](SECURITY.md)

---

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

---

## 🐛 Known Issues

- SHA256 checksum in `claudeswap.rb` is currently a placeholder
  - Will be updated when v1.5.0 tag is created and release tarball is generated
  - Does not affect functionality when installing from source

---

## 🚀 What's Next?

**Future roadmap (v1.6.0):**
- Additional provider integrations
- Enhanced TUI features
- Performance optimizations
- Extended session management
- Automated testing suite

---

## 📞 Support & Feedback

- **Issues:** [GitHub Issues](https://github.com/sachicali/homebrew-claudeswap/issues)
- **Documentation:** [GitHub Repository](https://github.com/sachicali/homebrew-claudeswap)
- **Changelog:** [CHANGELOG.md](CHANGELOG.md)

---

**Happy Swapping! 🎉**

*ClaudeSwap v1.5.0 - Production Ready*
