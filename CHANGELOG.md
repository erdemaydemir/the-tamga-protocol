# Changelog - The Tamga Protocol

All notable changes to The Tamga Protocol will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Story bible completion (60-day narrative structure)
- Core game mechanics implementation
- Character system
- Dialogue system integration
- Save/load functionality
- First 10 days of content

## [0.1.0] - 2026-01-31

### Added
- **Project Initialization**
  - Game project structure created
  - Godot 4.2 project configured
  - Framework integration (Game Framework v1.0.0 as submodule)
  - Agent configuration (7 specialized agents)

- **Documentation**
  - Game README.md with project overview
  - AGENTS.md with game-specific configuration
  - Color palette (16-color retro theme)
  - Asset inbox workflow documentation

- **Design Documents**
  - Color palette specification (`design/art/color_palette.md`)
  - 16-color retro aesthetic defined
  - Warm earth tones for 1990s Turkey theme

- **Project Configuration**
  - Godot project settings
  - Autoload singletons configured (EventBus, GameState, SaveSystem)
  - Asset pipeline structure (pending/validated/rejected)
  - Directory structure for narrative, art, and mechanics

- **Game Context**
  - Title: "The Tamga Protocol"
  - Setting: 1990s Turkey (Ankara, İstanbul, Muğla, İzmir)
  - Theme: Survival mystery with Göktürk easter eggs
  - Art style: 2D pixel art, 16-color palette

### Technical Specifications
- **Engine**: Godot 4.2
- **Language**: GDScript
- **Platform**: Windows (PC)
- **Target Build Size**: <1GB
- **Target Gameplay**: 60 days, 2-2.5 hour first playthrough
- **Endings**: 10+ (planned)

### Framework Integration
- Game Framework v1.0.0 linked as submodule
- Component-based architecture enabled
- SOLID + CLEAN CODE principles adopted
- Validation pipeline configured

### Notes
- Initial alpha version
- Framework setup complete
- Content creation phase begins

[Unreleased]: https://github.com/yourorg/tamga-protocol/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/yourorg/tamga-protocol/releases/tag/v0.1.0
