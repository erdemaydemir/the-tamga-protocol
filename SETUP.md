# Setup Guide - The Tamga Protocol

**Get started with The Tamga Protocol development in 10 minutes.**

---

## Prerequisites

Before you begin, ensure you have:

- [ ] **Godot 4.2+** installed ([Download](https://godotengine.org/download))
- [ ] **Python 3.8+** installed
- [ ] **Git** installed
- [ ] **Windows PC** (primary development platform)

---

## Quick Setup

### 1. Initialize Framework Submodule

```bash
cd E:\dev\game-ai

# Add framework as git submodule
git submodule add file:///E:/dev/godot-game-framework godot/framework

# Initialize submodule
git submodule update --init --recursive
```

### 2. Open Project in Godot

```bash
# Launch Godot editor
godot -e --path ./godot
```

**First time setup**:
1. Godot will import assets (may take a minute)
2. Go to `Project > Project Settings > Plugins`
3. Enable "Game Framework" plugin
4. Verify autoloads: `Project > Project Settings > Autoload`
   - Should see: EventBus, GameState, SaveSystem

### 3. Verify Setup

```bash
# Run validators
python godot/framework/config/validation/guard-runner.py --all
```

**Expected output**:
```
✅ Structure validation: PASSED
✅ Documentation validation: PASSED
✅ Commit validation: PASSED
```

---

## Project Structure Overview

```
E:\dev\game-ai\
├── .claude\
│   └── AGENTS.md                     # AI agent configuration
│
├── godot\
│   ├── project.godot                 # Godot project file
│   ├── icon.svg                      # Game icon
│   ├── framework\                    # Framework submodule (link)
│   ├── scenes\                       # Game scenes (create)
│   ├── scripts\                      # GDScript files (create)
│   └── assets\                       # Game assets (create)
│
├── data\
│   ├── narrative\
│   │   └── dialogues\                # JSON dialogue files (create)
│   └── events\                       # Daily event definitions (create)
│
├── design\
│   ├── art\
│   │   └── color_palette.md          # 16-color retro palette
│   ├── narrative\
│   │   └── story_bible.md            # Narrative design (create)
│   └── mechanics\
│       └── game_design.md            # Core mechanics (create)
│
├── asset-inbox\                      # Asset import workflow
│   ├── pending\                      # Drop new assets here
│   ├── validated\                    # Validated assets
│   └── rejected\                     # Failed validation
│
├── docs\
│   ├── planning\                     # Development planning
│   ├── guards\                       # Validation logs
│   └── FRAMEWORK-INTEGRATION.md      # Framework integration guide
│
├── README.md                         # Project overview
├── CHANGELOG.md                      # Version history
└── SETUP.md                          # This file
```

---

## Next Steps

### Step 1: Create Story Bible

Create `design/narrative/story_bible.md`:

**Required sections**:
- **Setting**: 1990s Turkey (Ankara, İstanbul, Muğla, İzmir)
- **Characters**: Main characters, NPCs, relationships
- **Plot Overview**: The Tamga Protocol mystery
- **60-Day Structure**: Major story beats per act
- **Endings**: 10+ endings with unlock conditions
- **Göktürk Easter Eggs**: 1-2 subtle Tamga symbol references

### Step 2: Create Initial Scenes

```bash
mkdir godot/scenes
mkdir godot/scenes/ui
mkdir godot/scenes/gameplay
mkdir godot/scenes/cities
```

**Create these scenes**:
- `scenes/main_menu.tscn` - Main menu
- `scenes/ui/day_ui.tscn` - Daily UI display
- `scenes/gameplay/day_cycle.tscn` - Day cycle controller
- `scenes/cities/ankara.tscn` - Ankara location (placeholder)

### Step 3: Create Example Dialogue

Create `data/narrative/dialogues/intro.json`:

```json
{
  "dialogue_id": "intro",
  "dialogues": [
    {
      "speaker": "Ali",
      "text": "Hoş geldin! 1994'ün İstanbul'una...",
      "emotion": "friendly",
      "choices": [
        {
          "id": "friendly",
          "text": "Thanks, it's good to be here.",
          "flags": ["ali_friendly"],
          "stat_changes": {"morale": 5},
          "leads_to": null
        },
        {
          "id": "suspicious",
          "text": "Who are you?",
          "flags": ["ali_suspicious"],
          "leads_to": "ali_explains"
        }
      ]
    }
  ]
}
```

### Step 4: Test Framework Integration

Create `godot/scripts/test_framework.gd`:

```gdscript
extends Node

func _ready():
    # Test EventBus
    EventBus.day_started.connect(_on_day_started)
    print("EventBus: OK")

    # Test GameState
    GameState.set_flag("test_flag", true)
    assert(GameState.has_flag("test_flag"))
    print("GameState: OK")

    # Test SaveSystem
    if SaveSystem.has_save():
        print("SaveSystem: Save file found")
    else:
        print("SaveSystem: No save file (normal for fresh install)")

    print("Framework integration: ✅ ALL OK")

func _on_day_started(day: int):
    print("Day %d started" % day)
```

Run in Godot to verify framework works.

### Step 5: Start Development

**Use AI agents for content creation**:

```
"Generate a dialogue for the first day where the player meets Ali in İstanbul bazaar"
→ Story Agent generates JSON
→ Story Validator checks quality
→ Output saved to data/narrative/dialogues/

"Create a 64x64 portrait for Ali, friendly merchant, age 30"
→ UI Design Agent generates detailed AI prompt
→ You create asset using prompt
→ Drop in asset-inbox/pending/
→ Asset Manager Agent validates
```

---

## Development Workflow

### Daily Workflow

1. **Morning**:
   ```bash
   # Pull latest changes (if team)
   git pull

   # Update framework submodule
   git submodule update --remote
   ```

2. **Development**:
   - Create/modify scenes and scripts
   - Use framework components
   - Follow CLEAN CODE principles
   - Test frequently

3. **Before Commit**:
   ```bash
   # Run validators
   python godot/framework/config/validation/guard-runner.py --all

   # Lint GDScript
   gdlint godot/

   # Commit using Conventional Commits
   git add .
   git commit -m "feat(dialogue): add Ali introduction scene"
   ```

---

## Useful Commands

### Godot

```bash
# Open editor
godot -e --path ./godot

# Run game
godot --path ./godot

# Export build (Windows)
godot --export-release "Windows Desktop" ./builds/windows/TheTamgaProtocol.exe --headless --path ./godot
```

### Validation

```bash
# All validators
python godot/framework/config/validation/guard-runner.py --all

# Structure only
python godot/framework/config/validation/validate-structure.py

# Commits only
python godot/framework/config/validation/validate-commits.py

# Documentation only
python godot/framework/config/validation/validate-docs.py
```

### Linting

```bash
# Install gdlint
pip install gdlint

# Lint all GDScript
gdlint godot/

# Lint with auto-fix
gdlint godot/ --fix
```

### Git

```bash
# Check submodule status
git submodule status

# Update framework
git submodule update --remote godot/framework

# Create feature branch
git checkout -b feature/day-cycle-system
```

---

## Troubleshooting

### "Framework submodule is empty"

```bash
git submodule update --init --recursive
```

### "Autoloads not found"

1. Check plugin is enabled: `Project > Project Settings > Plugins`
2. Restart Godot editor
3. Verify autoloads in `Project > Project Settings > Autoload`

### "Validation failing"

```bash
# Run with verbose output
python godot/framework/config/validation/guard-runner.py --all --verbose
```

### "gdlint not found"

```bash
pip install gdlint
```

---

## Resources

**Framework Documentation**:
- Quick Start: `godot/framework/docs/QUICK-START.md`
- Architecture: `godot/framework/docs/ARCHITECTURE.md`
- Integration: `docs/FRAMEWORK-INTEGRATION.md`

**Game Documentation**:
- Project README: `README.md`
- Color Palette: `design/art/color_palette.md`
- Agent Config: `.claude/AGENTS.md`

**External Resources**:
- [Godot Documentation](https://docs.godotengine.org/en/stable/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

## Getting Help

1. **Framework issues**: Check `godot/framework/docs/`
2. **Agent questions**: Consult `.claude/AGENTS.md`
3. **Validation errors**: Run with `--verbose` flag
4. **Game design**: Review `design/` documents

---

**Setup complete! Start developing The Tamga Protocol. 🎮**
