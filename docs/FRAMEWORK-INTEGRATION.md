# Framework Integration Guide - The Tamga Protocol

**Version**: 0.1.0
**Last Updated**: 2026-01-31
**Framework Version**: 1.0.0

---

## Overview

This document explains how to integrate the **Game Framework** into The Tamga Protocol project.

The framework is located at `E:\dev\godot-game-framework\` and is linked to this project as a git submodule.

---

## Framework Location

### Separate Repositories

```
E:\dev\
├── godot-game-framework\     # Global reusable framework (submodule source)
└── game-ai\                  # The Tamga Protocol (this project)
    └── godot\
        └── framework\        # Framework submodule (link)
```

### Why Separate?

- **Reusability**: Framework can be used for future games
- **Maintainability**: Framework updates don't pollute game repo
- **Modularity**: Clear separation of concerns
- **Versioning**: Independent version control

---

## Integration Steps

### Step 1: Initialize Git Repository

If not already done:

```bash
cd E:\dev\game-ai
git init
```

### Step 2: Add Framework as Submodule

```bash
# Add framework as submodule
git submodule add file:///E:/dev/godot-game-framework godot/framework

# Or if framework is on GitHub:
# git submodule add https://github.com/yourorg/godot-game-framework.git godot/framework

# Initialize submodule
git submodule update --init --recursive
```

### Step 3: Verify Submodule

```bash
# Check submodule status
git submodule status

# Should show:
# <commit-hash> godot/framework (heads/main)
```

### Step 4: Configure Godot Project

The `project.godot` file is already configured with:

```ini
[editor_plugins]
enabled=PackedStringArray("res://framework/godot/addons/game_framework/plugin.cfg")

[autoload]
EventBus="*res://framework/godot/addons/game_framework/core/autoload/EventBus.gd"
GameState="*res://framework/godot/addons/game_framework/core/autoload/GameState.gd"
SaveSystem="*res://framework/godot/addons/game_framework/core/autoload/SaveSystem.gd"
```

### Step 5: Open in Godot

```bash
# Open Godot editor
godot -e --path ./godot
```

### Step 6: Enable Plugin

1. Go to `Project > Project Settings > Plugins`
2. Find "Game Framework"
3. Click checkbox to enable
4. Autoloads will be registered automatically

### Step 7: Verify Autoloads

1. Go to `Project > Project Settings > Autoload`
2. Verify these are present:
   - EventBus
   - GameState
   - SaveSystem

---

## Framework Structure

### What's in the Framework?

```
godot/framework/                      # Submodule root
├── godot/addons/game_framework/     # Godot plugin
│   ├── plugin.cfg                    # Plugin metadata
│   ├── plugin.gd                     # Plugin initialization
│   ├── core/
│   │   ├── components/               # Reusable components
│   │   │   ├── HealthComponent.gd
│   │   │   ├── InventoryComponent.gd
│   │   │   └── StateMachineComponent.gd
│   │   └── autoload/                 # Global singletons
│   │       ├── EventBus.gd
│   │       ├── GameState.gd
│   │       └── SaveSystem.gd
│   └── narrative/                    # Narrative systems
│       ├── DialogueManager.gd
│       └── StoryState.gd
│
├── config/
│   ├── agents/                       # AI agent configs
│   ├── rules/                        # Development rules
│   ├── validation/                   # Python validators
│   └── schemas/                      # JSON schemas
│
└── docs/                             # Framework documentation
    ├── ARCHITECTURE.md
    ├── QUICK-START.md
    └── INTEGRATION-GUIDE.md
```

### What You Get

**Core Components**:
- `HealthComponent`: Health management with signals
- `InventoryComponent`: Item storage with limits
- `StateMachineComponent`: Generic state machine

**Autoload Singletons**:
- `EventBus`: Global event system
- `GameState`: Global state manager (flags, stats, clues)
- `SaveSystem`: Save/load functionality

**Narrative Systems**:
- `DialogueManager`: JSON-based dialogue trees
- `StoryState`: Story progression tracker, ending calculator

**Validation System**:
- Python validators for structure, commits, docs
- GDScript linter configuration

**AI Agents**:
- 7 specialized agents for development
- User Clarification Protocol

---

## Using Framework Components

### Example: Adding Health to Player

#### 1. Create Player Scene

```
Player (CharacterBody2D)
├── Sprite2D
├── CollisionShape2D
└── HealthComponent (Node)
```

#### 2. Player Script

```gdscript
# Player.gd
extends CharacterBody2D

@onready var health = $HealthComponent

func _ready():
    # Connect to health signals
    health.health_changed.connect(_on_health_changed)
    health.died.connect(_on_player_died)

    # Set initial health
    health.max_health = 100

func take_damage(amount: int):
    health.take_damage(amount)

func heal(amount: int):
    health.heal(amount)

func _on_health_changed(current: int, maximum: int):
    print("Health: %d/%d" % [current, maximum])
    # Update UI here

func _on_player_died():
    print("Player died!")
    EventBus.player_died.emit()
```

### Example: Using GameState

```gdscript
# Set story flag
GameState.set_flag("discovered_tamga_symbol", true)

# Check flag
if GameState.has_flag("discovered_tamga_symbol"):
    DialogueManager.start_dialogue("ali_reveal")

# Add clue
GameState.add_clue("mysterious_letter")

# Modify stat
GameState.modify_stat("morale", -10)

# Advance day
GameState.advance_day()
```

### Example: Using EventBus

```gdscript
# Emit event
EventBus.day_started.emit(GameState.current_day)

# Listen to event
func _ready():
    EventBus.dialogue_ended.connect(_on_dialogue_ended)
    EventBus.day_started.connect(_on_day_started)

func _on_dialogue_ended():
    # Resume gameplay

func _on_day_started(day: int):
    print("Day %d started" % day)
```

### Example: Save/Load

```gdscript
# Auto-save on quit
func _notification(what):
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
        SaveSystem.auto_save()
        get_tree().quit()

# Load game
func load_saved_game():
    if SaveSystem.has_save():
        if SaveSystem.load_game():
            print("Game loaded successfully")
            # Transition to gameplay
    else:
        print("No save found, starting new game")
```

---

## Validation Workflow

### Running Validators

```bash
# Run all validators
python godot/framework/config/validation/guard-runner.py --all

# Run specific validator
python godot/framework/config/validation/validate-structure.py
python godot/framework/config/validation/validate-commits.py
python godot/framework/config/validation/validate-docs.py
```

### GDScript Linting

```bash
# Install gdlint
pip install gdlint

# Lint project
gdlint godot/

# Lint specific file
gdlint godot/scripts/Player.gd
```

---

## Updating Framework

### Getting Framework Updates

```bash
cd E:\dev\game-ai

# Update submodule to latest
git submodule update --remote godot/framework

# Or pull specific version
cd godot/framework
git checkout v1.1.0
cd ../..

# Commit submodule update
git add godot/framework
git commit -m "chore: update framework to v1.1.0"
```

### Checking Framework Version

```bash
cd godot/framework
git describe --tags
# Output: v1.0.0
```

---

## Troubleshooting

### Issue: Autoloads Not Found

**Symptom**: `EventBus` is not declared in the scope

**Solution**:
1. Verify plugin is enabled: `Project > Project Settings > Plugins`
2. Check autoloads: `Project > Project Settings > Autoload`
3. Restart Godot editor
4. Check submodule path is correct: `res://framework/godot/addons/game_framework/`

### Issue: Submodule Not Initialized

**Symptom**: `godot/framework/` folder is empty

**Solution**:
```bash
git submodule update --init --recursive
```

### Issue: Plugin Not Showing

**Symptom**: "Game Framework" doesn't appear in Plugins list

**Solution**:
1. Verify `godot/framework/godot/addons/game_framework/plugin.cfg` exists
2. Check `project.godot` has correct path
3. Reload project: `Project > Reload Current Project`

### Issue: Components Not Working

**Symptom**: `HealthComponent` shows errors in scene tree

**Solution**:
1. Verify framework submodule is initialized
2. Check component script path is correct
3. Ensure Godot version is 4.2+

---

## Best Practices

### DO:
✅ Commit submodule updates separately
✅ Use framework components instead of reimplementing
✅ Follow framework's CLEAN CODE standards
✅ Run validators before committing
✅ Keep framework version in sync across team

### DON'T:
❌ Modify framework files directly (create game-specific components instead)
❌ Commit framework changes from game repo
❌ Skip validation steps
❌ Ignore framework updates

---

## Framework Documentation

For complete framework documentation:
- **Quick Start**: `godot/framework/docs/QUICK-START.md`
- **Architecture**: `godot/framework/docs/ARCHITECTURE.md`
- **Integration Guide**: `godot/framework/docs/INTEGRATION-GUIDE.md`
- **Component Reference**: `godot/framework/godot/addons/game_framework/core/components/`
- **Agent System**: `godot/framework/config/agents/`

---

## Next Steps

1. ✅ Framework integrated
2. ⏳ Create game-specific components (extend framework components)
3. ⏳ Implement 60-day cycle mechanics
4. ⏳ Create dialogue JSON files
5. ⏳ Integrate StoryState for ending calculation

---

**Framework Version**: 1.0.0
**Integration Status**: ✅ COMPLETE

For questions about framework usage, consult the framework's `FRAMEWORK-HANDOFF.md` document.
