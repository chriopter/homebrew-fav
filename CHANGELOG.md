# Changelog

## v1.2.0 - KISS Release
- Removed all backup functionality
- Removed all command validation and warnings
- Removed duplicate command confirmations
- Removed config/disable-execution feature entirely
- Simplified file initialization (35+ lines → 11 lines)
- Simplified sed operations (no GNU fallbacks)
- CI now auto-updates formula version from script
- Trust users completely - no safety rails

## v1.0.1
- Fixed version mismatch, added security validation
- Created test suite, improved CI/CD workflows