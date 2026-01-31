# The Tamga Protocol

**A story-driven survival game set in 1990s Turkey**

![Version](https://img.shields.io/badge/version-0.1.0-blue)
![Godot](https://img.shields.io/badge/godot-4.2-blue)
![License](https://img.shields.io/badge/license-MIT-green)

---

## Overview

**The Tamga Protocol** is a narrative-focused survival game where you must endure 60 days during a crisis in 1990s Turkey. Your choices, discovered clues, and relationships with characters across four cities (Ankara, İstanbul, Muğla, İzmir) determine one of 10+ possible endings.

Uncover the mystery of the **Tamga Protocol** — an obscure reference to ancient Turkic runic symbols that holds the key to understanding the crisis.

### Key Features

- 🗓️ **60-Day Survival Cycle**: Each day brings new challenges and choices
- 🔍 **Clue Network**: Interconnected clues reveal the hidden Tamga Protocol
- 🌆 **Four Cities**: Explore Ankara, İstanbul, Muğla, and İzmir
- 🎭 **Character Knowledge System**: Track what each NPC knows
- 🎨 **Retro Pixel Art**: Authentic 1990s aesthetic with 16-color palette
- 🎯 **10+ Endings**: Your choices truly matter
- 🏛️ **Göktürk Easter Eggs**: Hidden references to ancient Turkic heritage

### Game Details

- **Genre**: Story-Driven Survival, Mystery
- **Platform**: Windows PC
- **Art Style**: 2D Pixel Art (8x8 grid)
- **Gameplay Length**: 2-2.5 hours (first playthrough)
- **Build Size**: <1GB
- **Engine**: Godot 4.2+

---

## Project Structure

```
E:\dev\game-ai\
├── .claude\
│   └── AGENTS.md              # AI agent configuration
├── godot\
│   ├── project.godot          # Godot project file
│   ├── scenes\                # Game scenes
│   ├── scripts\               # GDScript files
│   └── framework\             # Framework submodule (link)
├── data\
│   ├── narrative\             # Dialogue JSON files
│   │   └── dialogues\
│   └── events\                # Daily event definitions
├── design\
│   ├── narrative\
│   │   └── story_bible.md     # Narrative design document
│   ├── art\
│   │   ├── style_guide.md     # Visual style guide
│   │   └── color_palette.md   # 16-color retro palette
│   └── mechanics\
│       └── game_design.md     # Core mechanics documentation
├── asset-inbox\               # Asset import workflow
│   ├── pending\               # Drop new assets here
│   ├── validated\             # Validated, ready to import
│   └── rejected\              # Failed validation
├── docs\
│   ├── planning\              # Development planning
│   └── guards\                # Validation logs
├── README.md                  # This file
└── CHANGELOG.md               # Version history
```

---

## Installation & Setup

### Prerequisites

- **Godot 4.2+** ([Download](https://godotengine.org/download))
- **Python 3.8+** (for validators)
- **Git** (for version control)

### Quick Start

#### 1. Clone the Repository

```bash
git clone <repository-url> game-ai
cd game-ai
```

#### 2. Initialize Framework Submodule

```bash
git submodule add <framework-repo-url> godot/framework
git submodule update --init --recursive
```

#### 3. Open in Godot

1. Launch Godot
2. Click "Import"
3. Navigate to `E:\dev\game-ai\godot\project.godot`
4. Click "Import & Edit"

#### 4. Verify Setup

The framework plugin should automatically enable and register autoloads:
- EventBus
- GameState
- SaveSystem

Check: `Project > Project Settings > Autoload`

---

## Development

### Running the Game

```bash
# Open Godot editor
godot -e --path ./godot

# Run game directly
godot --path ./godot
```

### Validation

```bash
# Run all validators
python godot/framework/config/validation/guard-runner.py --all

# Lint GDScript
gdlint godot/
```

### Building

```bash
# Export Windows build
godot --export-release "Windows Desktop" ./builds/windows/TheTamgaProtocol.exe --headless --path ./godot
```

---

## Game Design

### The Tamga Protocol Mystery

**Tamga** (ᛏᛆᛘᚵᚨ) refers to ancient Turkic runic symbols and seals used by Göktürk clans. The game's central mystery revolves around discovering what the "Tamga Protocol" means and how these ancient symbols connect to the 1990s crisis.

Players who research Göktürk heritage will uncover hidden meanings in the game's narrative.

### Core Mechanics

1. **Daily Events**: Each of 60 days presents choices that affect:
   - Player stats (health, morale, resources)
   - Character relationships
   - Story flags
   - Ending scores

2. **Clue Discovery**: Find interconnected clues to unlock:
   - New dialogue options
   - Story revelations
   - Ending paths

3. **Character Knowledge**: Track what each NPC knows to:
   - Navigate conversations strategically
   - Reveal or hide information
   - Build trust or suspicion

4. **Multiple Endings**: 10+ endings determined by:
   - Clues discovered
   - Relationships built
   - Cities visited
   - Critical choices made

### The Four Cities

- **Ankara**: Political center, government connections
- **İstanbul**: Cultural hub, diverse characters
- **Muğla**: Coastal region, tourism economy
- **İzmir**: Industrial port, working class

Each city has unique events, NPCs, and storylines.

---

## AI Agent System

This project uses an AI agent-driven development workflow. All agents follow rules defined in `.claude/AGENTS.md`.

### Active Agents

1. **Plan Agent**: Meta-orchestrator, enforces User Clarification Protocol
2. **Story Agent**: Generates narrative content (dialogues, events)
3. **Story Validator**: Validates narrative quality (75-85% threshold)
4. **UI Design Agent**: Creates asset prompts, enforces visual consistency
5. **Asset Manager Agent**: Validates and imports assets
6. **Github Committer**: Manages version control
7. **Structure Guard**: Validates project structure

For details, see `.claude/AGENTS.md`.

---

## Contributing

### Workflow

1. Create feature branch: `feature/your-feature-name`
2. Make changes following CLEAN CODE principles
3. Run validators: `python godot/framework/config/validation/guard-runner.py --all`
4. Commit using Conventional Commits format
5. Submit pull request to `develop` branch

### Coding Standards

- Follow `framework/config/rules/clean-code.md`
- Use SOLID principles
- All code must pass `gdlint`
- Maximum function length: 50 lines
- Maximum line length: 100 characters

### Commit Format

```
<type>(scope): <description>

[optional body]

[optional footer]
```

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

---

## Documentation

- **Agent Configuration**: `.claude/AGENTS.md`
- **Framework Docs**: `godot/framework/docs/`
- **Story Bible**: `design/narrative/story_bible.md`
- **Style Guide**: `design/art/style_guide.md`
- **Architecture**: `godot/framework/docs/ARCHITECTURE.md`

---

## Roadmap

### v0.1.0 (Alpha) - Current
- ✅ Project setup
- ✅ Framework integration
- ⏳ Story bible completion
- ⏳ Core mechanics implementation
- ⏳ Main menu scene

### v0.2.0 (Alpha)
- First 10 days of content
- Basic UI implementation
- Save/load functionality
- Character system

### v0.3.0 (Beta)
- Complete 60-day cycle
- All 10+ endings
- Full asset integration
- Polished UI/UX

### v1.0.0 (Release)
- Bug fixes and optimization
- Playtesting feedback integration
- Performance optimization
- Final polish

---

## License

[Specify your license here]

---

## Credits

**Game Framework**: Based on [Game Framework](https://github.com/yourorg/godot-game-framework)

**Godot Engine**: [godotengine.org](https://godotengine.org)

---

## Support

For issues, questions, or feedback:
- Create an issue on GitHub
- Check documentation in `docs/`
- Consult `.claude/AGENTS.md` for agent-specific questions

---

**The Tamga Protocol** — Uncover the ancient symbols, survive the crisis, discover your ending.
