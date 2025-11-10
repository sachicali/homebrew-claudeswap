# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.3.x   | :white_check_mark: |
| 1.2.x   | :white_check_mark: |
| < 1.2   | :x:                |

## Security Features

Claude Swap implements multiple layers of security to protect your API credentials and system:

### 1. Credential Protection
- **No hardcoded credentials** - All tokens stored in environment variables
- **Local-only operations** - Tokens never transmitted or logged
- **Automatic backups** - Settings backed up before changes
- **Token masking** - Partial display only (e.g., `abc123...xyz`)

### 2. Input Validation
- **Length checks** - Minimum 10 characters for tokens
- **Format validation** - Whitespace and special character detection
- **User confirmation** - Warns on suspicious input patterns
- **Bounded inputs** - Max 50 attempts on interactive prompts

### 3. Injection Prevention
- **Shell injection** - Uses `printf` with proper escaping
- **JSON injection** - Uses `jq --arg` for variable interpolation
- **Command injection** - All user input validated and sanitized

### 4. File Security
- **Atomic operations** - Uses `mktemp` for temporary files
- **Cleanup traps** - Prevents temporary file leaks
- **Permission checks** - Validates write access before operations
- **Safe defaults** - Restrictive file permissions

### 5. Error Handling
- **Bash safety mode** - `set -euo pipefail` in all scripts
- **Return value checks** - All critical operations validated
- **Graceful failures** - Fallbacks prevent data loss
- **Error messages** - No sensitive data in error output

## Reporting a Vulnerability

If you discover a security vulnerability in Claude Swap, please report it by:

1. **DO NOT** open a public GitHub issue
2. Email the maintainer with details:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if available)

We will respond within 48 hours and work with you to:
- Confirm the vulnerability
- Determine severity and impact
- Develop and test a fix
- Release a security update
- Credit you in the release notes (if desired)

## Security Best Practices

When using Claude Swap, follow these best practices:

### API Token Management
```bash
# ✅ GOOD: Store in environment variables
export CLAUDE_ZAI_AUTH_TOKEN="your-token"

# ❌ BAD: Hardcode in scripts
API_TOKEN="sk-ant-12345..."  # Never do this
```

### File Permissions
```bash
# Ensure your shell config is not world-readable
chmod 600 ~/.zshrc

# Check settings file permissions
ls -la ~/.claude/settings.json
# Should be: -rw------- (600)
```

### Token Rotation
- Rotate API tokens regularly (every 90 days)
- Revoke tokens immediately if compromised
- Use separate tokens for different environments

### Backup Security
```bash
# Backup files contain tokens - protect them
chmod 700 ~/.claude/backups
chmod 600 ~/.claude/backups/*
```

## Known Security Considerations

### 1. Bash History
Commands with tokens may appear in shell history. To prevent this:

```bash
# Add to ~/.zshrc or ~/.bashrc
export HISTCONTROL=ignorespace

# Then prefix sensitive commands with a space
 export CLAUDE_ZAI_AUTH_TOKEN="your-token"
```

### 2. Process Listing
Tokens in environment variables may be visible in `ps` output. This is a general limitation of environment variables.

### 3. Shared Systems
On shared systems:
- Use restrictive file permissions (600 for files, 700 for directories)
- Consider using a secrets manager instead of environment variables
- Regularly audit who has access to your home directory

## Audit Log

| Date       | Version | Issue                    | Severity | Status |
|------------|---------|--------------------------|----------|---------|
| 2025-11-10 | 1.3.0   | Shell injection in token write | Critical | Fixed |
| 2025-11-10 | 1.3.0   | JSON injection in jq     | Critical | Fixed |
| 2025-11-10 | 1.3.0   | Unbounded loops          | High     | Fixed |
| 2025-11-10 | 1.3.0   | Race condition in temp files | Medium | Fixed |

## Security Scanning

Claude Swap undergoes regular security reviews:
- ✅ Static analysis with ShellCheck
- ✅ Manual security audit (Nov 2025)
- ✅ NASA's 10 Rules compliance check
- ✅ TIGERSTYLE security review

## Compliance

Claude Swap follows industry best practices:
- **NASA's 10 Rules** for safety-critical code
- **TIGERSTYLE** coding principles
- **OWASP Top 10** awareness (injection, security misconfiguration)
- **Principle of Least Privilege**

## Contact

For security-related questions or concerns:
- Review this document first
- Check existing GitHub issues (public, non-sensitive topics only)
- For sensitive security matters, contact the maintainer directly

**Last Updated:** November 10, 2025
**Next Review:** February 10, 2026
