# Cross-Compilation Setup for rs_floating_duration

This document describes how to cross-compile the `rs_floating_duration` Ruby gem with Rust native extensions for multiple platforms.

## Overview

The gem now supports cross-compilation using `rb-sys-dock`, which provides Docker-based cross-compilation environments for building Ruby native extensions written in Rust.

## Supported Platforms

- `aarch64-linux` (ARM64 Linux)
- `x86_64-linux` (x86_64 Linux)
- `x86_64-darwin` (x86_64 macOS)
- `arm64-darwin` (ARM64 macOS)

## Supported Ruby Versions

- Ruby 2.7+
- Ruby 3.0+
- Ruby 3.1+
- Ruby 3.2+
- Ruby 3.3+

Note: Ruby 2.6 is not supported due to compatibility issues with Magnus 0.6.2.

## Prerequisites

1. **Docker**: Required for cross-compilation. Install Docker Desktop or Docker Engine.
2. **Bundle dependencies**: Run `bundle install` to install all required gems.

## Cross-Compilation Commands

### Single Platform

To cross-compile for a specific platform:

```bash
# For ARM64 Linux
bundle exec rake native[aarch64-linux]

# For x86_64 Linux
bundle exec rake native[x86_64-linux]

# For x86_64 macOS
bundle exec rake native[x86_64-darwin]

# For ARM64 macOS
bundle exec rake native[arm64-darwin]
```

### All Platforms

To cross-compile for all supported platforms:

```bash
bundle exec rake cross_compile
```

### Using rb-sys-dock directly

You can also use `rb-sys-dock` directly:

```bash
# Cross-compile for ARM64 Linux with specific Ruby versions
bundle exec rb-sys-dock --platform aarch64-linux --ruby-versions 2.7,3.0,3.1,3.2,3.3 --build

# Cross-compile for x86_64 Linux
bundle exec rb-sys-dock --platform x86_64-linux --ruby-versions 2.7,3.0,3.1,3.2,3.3 --build
```

## Generated Gems

After cross-compilation, you'll find platform-specific gems in the `pkg/` directory:

```
pkg/
├── rs_floating_duration-0.1.1-aarch64-linux.gem
├── rs_floating_duration-0.1.1-x86_64-linux.gem
├── rs_floating_duration-0.1.1-arm64-darwin.gem
├── rs_floating_duration-0.1.1-x86_64-darwin.gem
└── rs_floating_duration-0.1.1.gem (source gem)
```

## Gem Structure

Each cross-compiled gem contains native extensions for multiple Ruby versions:

```
lib/rs_floating_duration/
├── 2.7/rs_floating_duration.so
├── 3.0/rs_floating_duration.so
├── 3.1/rs_floating_duration.so
├── 3.2/rs_floating_duration.so
└── 3.3/rs_floating_duration.so
```

## Troubleshooting

### Docker Issues

If you encounter Docker-related errors:

1. Ensure Docker is running
2. Check Docker daemon status: `docker info`
3. Try pulling the image manually: `docker pull rbsys/aarch64-linux:0.9.87`

### Ruby Version Compatibility

If you see compilation errors related to missing symbols:

1. Check that you're not building for Ruby 2.6 (not supported)
2. Update Magnus dependency if needed
3. Verify the gemspec `required_ruby_version` setting

### Platform Issues

If a specific platform fails to build:

1. Check that the platform name is correct (use `bundle exec rb-sys-dock --list-platforms`)
2. Ensure the Docker image for that platform is available
3. Try building for that platform individually to isolate the issue

## CI/CD Integration

For automated cross-compilation in CI/CD pipelines, you can use GitHub Actions with the following approach:

```yaml
- name: Cross-compile gems
  run: |
    bundle exec rake cross_compile
    
- name: Upload gems
  uses: actions/upload-artifact@v3
  with:
    name: cross-compiled-gems
    path: pkg/*.gem
```

## Publishing

To publish all platform-specific gems to RubyGems:

```bash
# Publish each platform gem
gem push pkg/rs_floating_duration-0.1.1-aarch64-linux.gem
gem push pkg/rs_floating_duration-0.1.1-x86_64-linux.gem
gem push pkg/rs_floating_duration-0.1.1-arm64-darwin.gem
gem push pkg/rs_floating_duration-0.1.1-x86_64-darwin.gem

# Also publish the source gem
gem push pkg/rs_floating_duration-0.1.1.gem
```

## Performance Notes

- Cross-compilation can take 10-15 minutes per platform due to Rust compilation
- Docker images are downloaded once and cached locally
- Subsequent builds for the same platform are faster due to Docker layer caching
- Consider building platforms in parallel if using CI/CD