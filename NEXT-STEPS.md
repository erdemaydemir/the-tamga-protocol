# Next Steps - The Tamga Protocol

**Date**: 2026-01-31
**Status**: ✅ Core Systems Implemented (v0.1.0)

---

## ✅ What's Been Built

### 1. Framework Integration
- ✅ Game Framework copied to `godot/addons/game_framework/`
- ✅ Autoload singletons configured (EventBus, GameState, SaveSystem)
- ✅ Plugin system ready (not yet enabled in Godot Editor)

### 2. Core Scenes

#### Main Menu (`scenes/main_menu.tscn`)
- Title screen with game logo
- **NEW GAME** button → Resets GameState, starts Day 1
- **CONTINUE** button → Loads save file (disabled if no save)
- **SETTINGS** button → Placeholder
- **QUIT** button → Exits game

#### Day Cycle (`scenes/gameplay/day_cycle.tscn`)
- Day counter display (Day X / 60)
- Time of day display (Morning/Afternoon/Evening/Night)
- Stats panel (Health, Morale)
- Test button to advance time

### 3. Core Scripts

#### `scripts/ui/main_menu.gd`
- Checks for save file on ready
- Handles New Game (resets state, loads day cycle)
- Handles Continue (loads save, loads day cycle)
- Framework integration test on startup

#### `scripts/gameplay/day_cycle_controller.gd`
- Manages 60-day cycle
- Tracks time of day (Morning → Afternoon → Evening → Night)
- Checks game over conditions (health ≤ 0, morale ≤ 0)
- Auto-saves at end of each day
- Emits signals via EventBus
- Triggers ending at Day 60

### 4. Git Repositories

✅ **Framework**: `E:\dev\godot-game-framework\` (committed)
✅ **Game**: `E:\dev\game-ai\` (committed)

---

## 🎮 How to Test

### Step 1: Open in Godot

```bash
# Navigate to game directory
cd E:\dev\game-ai\godot

# Open with Godot Editor
godot -e .
```

Or manually:
1. Open Godot 4.2+
2. Click "Import"
3. Navigate to `E:\dev\game-ai\godot\project.godot`
4. Click "Import & Edit"

### Step 2: Enable Plugin (Optional)

The framework is already integrated, but you can enable the plugin for additional features:

1. Go to `Project > Project Settings > Plugins`
2. Find "Game Framework"
3. Click checkbox to enable

### Step 3: Run the Game

Click the **Play** button (▶) in Godot Editor

**Expected Behavior**:
1. Main menu appears with brown background
2. Console shows framework integration test:
   ```
   === The Tamga Protocol ===
   Framework Integration Test:
     EventBus: true
     GameState: true
     SaveSystem: true
     Save file exists: false
   ```
3. **CONTINUE** button is disabled (no save file yet)

### Step 4: Test New Game

1. Click **NEW GAME**
2. Console shows:
   ```
   New Game started
   Day 1 started
   ```
3. Day Cycle scene loads
4. Console shows:
   ```
   === DAY 1 / 60 ===
     Health: 100
     Morale: 50
     EventBus: Day 1 started signal received
   ```

### Step 5: Test Day Cycle (Manual)

Currently, you need to manually advance time in the script. Open `day_cycle_controller.gd` and:

1. Add a button signal connection in the scene
2. Or call `advance_time()` from console
3. Watch days progress: Morning → Afternoon → Evening → Night → Next Day

---

## 🚧 What's NOT Yet Implemented

### Critical (Next Sprint)

- [ ] **Dialogue UI** - Visual novel-style dialogue box
- [ ] **DialogueManager Integration** - Load and display `day01_meet_ali.json`
- [ ] **Event System** - Load events from `day_events.json`
- [ ] **Actual Day Content** - Days 1-5 with real events/dialogues
- [ ] **Stats Updates** - Health/Morale changes based on choices

### Important (Sprint 2-3)

- [ ] **Location System** - İstanbul locations (Apartment, Bazaar, Café)
- [ ] **Travel System** - Move between cities
- [ ] **NPC System** - Character portraits and relationship tracking
- [ ] **Journal/Inventory UI** - Track clues, flags, relationships
- [ ] **Save/Load UI** - Save slots, timestamps

### Polish (Later)

- [ ] **Art Assets** - Character portraits, backgrounds, UI elements
- [ ] **Audio** - Music and SFX
- [ ] **Settings Menu** - Volume, text speed, etc.
- [ ] **Endings** - All 12 ending sequences
- [ ] **Polish** - Animations, transitions, particle effects

---

## 📋 Immediate Next Task: Dialogue UI

### Goal
Create a visual novel-style dialogue system that loads `day01_meet_ali.json` and displays it properly.

### Requirements

1. **Create DialogueUI Scene** (`scenes/ui/dialogue_ui.tscn`):
   - Character portrait (64x64px, left side)
   - Character name label
   - Dialogue text box with typewriter effect
   - Choice buttons (2-4 choices)
   - "Next" button for non-choice lines

2. **Create DialogueUI Script** (`scripts/ui/dialogue_ui.gd`):
   - Connect to DialogueManager
   - Listen to signals:
     - `dialogue_started`
     - `line_displayed`
     - `choices_presented`
     - `dialogue_ended`
   - Display text with typewriter effect
   - Handle player choices
   - Update GameState based on choice effects

3. **Integrate with Day Cycle**:
   - On Day 1, automatically load `day01_meet_ali.json`
   - Show dialogue UI overlay
   - When dialogue ends, return to day cycle

4. **Test Flow**:
   ```
   Main Menu → New Game
     → Day 1 starts
     → DialogueManager.start_dialogue("day01_meet_ali")
     → Dialogue UI appears
     → Player reads and makes choices
     → Dialogue ends
     → Day cycle resumes
   ```

### Example Code Template

```gdscript
# scripts/ui/dialogue_ui.gd
extends Control

@onready var portrait = $Portrait
@onready var speaker_name = $SpeakerName
@onready var dialogue_text = $DialogueText
@onready var choices_container = $ChoicesContainer

func _ready():
	# Connect to DialogueManager signals
	DialogueManager.line_displayed.connect(_on_line_displayed)
	DialogueManager.choices_presented.connect(_on_choices_presented)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_line_displayed(speaker: String, text: String, emotion: String):
	speaker_name.text = speaker
	# TODO: Show typewriter effect
	dialogue_text.text = text
	# TODO: Load portrait based on speaker

func _on_choices_presented(choices: Array):
	# TODO: Create buttons for each choice
	for i in range(choices.size()):
		var choice = choices[i]
		var button = Button.new()
		button.text = choice.text
		button.pressed.connect(_on_choice_selected.bind(i))
		choices_container.add_child(button)

func _on_choice_selected(choice_index: int):
	DialogueManager.select_choice(choice_index)
	# Clear choices
	for child in choices_container.get_children():
		child.queue_free()

func _on_dialogue_ended():
	# Hide dialogue UI
	hide()
```

---

## 🗺️ Development Roadmap

### Sprint 1 (Current - Week 1-2)
- ✅ Framework integration
- ✅ Main menu
- ✅ Day cycle controller
- ✅ Basic HUD
- ⏳ **Dialogue UI** ← YOU ARE HERE
- ⏳ Test with Day 1 dialogue

### Sprint 2 (Week 3-4)
- [ ] Event system loading from JSON
- [ ] Days 1-10 content (dialogues + events)
- [ ] Location system (İstanbul)
- [ ] NPC system (Ali, Zeynep)

### Sprint 3 (Week 5-6)
- [ ] Travel system (4 cities)
- [ ] Days 11-30 content
- [ ] Journal/Inventory UI
- [ ] Save/Load UI improvements

### Sprint 4 (Week 7-10)
- [ ] Days 31-60 content
- [ ] All 12 endings
- [ ] Complete clue network
- [ ] Relationship system testing

### Sprint 5 (Week 11-14)
- [ ] Art assets (characters, UI, backgrounds)
- [ ] Audio (music, SFX)
- [ ] Polish and animations
- [ ] Playtesting

### Sprint 6 (Week 15-16)
- [ ] Bug fixes
- [ ] Performance optimization
- [ ] Final playtesting
- [ ] **Release v1.0.0**

---

## 📚 Documentation Reference

| Document | Purpose | Location |
|----------|---------|----------|
| **PROJECT-STATUS.md** | Full roadmap & status | `E:\dev\game-ai\PROJECT-STATUS.md` |
| **SETUP.md** | Setup instructions | `E:\dev\game-ai\SETUP.md` |
| **story_bible.md** | Narrative reference | `design/narrative/story_bible.md` |
| **game_design.md** | Game mechanics | `design/mechanics/game_design.md` |
| **style_guide.md** | Art specifications | `design/art/style_guide.md` |
| **day01_meet_ali.json** | Example dialogue | `data/narrative/dialogues/day01_meet_ali.json` |
| **day_events.json** | Example events | `data/events/day_events.json` |

---

## 🐛 Known Issues

### Minor
- [ ] Continue button should show save date/time
- [ ] Day cycle "Advance Time" button is manual (should be automatic)
- [ ] No visual feedback when stats change
- [ ] Console warnings about line endings (CRLF vs LF) - harmless

### To Fix Later
- [ ] Add proper error handling for missing files
- [ ] Add loading screens between scenes
- [ ] Optimize save file size

---

## 💡 Tips

### Using the Framework

**EventBus (Global Signals)**:
```gdscript
# Emit
EventBus.day_started.emit(1)

# Listen
EventBus.day_started.connect(_on_day_started)
```

**GameState (Global State)**:
```gdscript
# Set flag
GameState.set_flag("met_ali", true)

# Check flag
if GameState.has_flag("met_ali"):
    # ...

# Modify stat
GameState.modify_stat("morale", -10)
```

**SaveSystem**:
```gdscript
# Auto-save
SaveSystem.auto_save()

# Load
if SaveSystem.load_game():
    # Success
```

**DialogueManager**:
```gdscript
# Start dialogue
DialogueManager.start_dialogue("day01_meet_ali")

# Select choice
DialogueManager.select_choice(0)
```

---

## 🎯 Success Criteria for Next Sprint

**Dialogue UI is complete when**:
- [ ] Can load `day01_meet_ali.json`
- [ ] Displays speaker name and text
- [ ] Shows character portrait (placeholder OK)
- [ ] Presents choices as buttons
- [ ] Choice selection works
- [ ] Stats change based on choice effects
- [ ] Relationship changes are tracked
- [ ] Flags are set correctly
- [ ] Dialogue ends properly
- [ ] Returns to day cycle

**Test it by**:
1. Start New Game
2. Day 1 loads
3. Ali dialogue plays automatically
4. Make all 3 initial choices (friendly/cautious/suspicious)
5. Verify stats and relationship changes
6. Check GameState has correct flags set

---

## 🚀 You Are Here

**Current Phase**: Core Systems Complete → Dialogue UI Implementation

**Next Task**: Create `scenes/ui/dialogue_ui.tscn` and `scripts/ui/dialogue_ui.gd`

**Estimated Time**: 2-3 hours for basic version, 1-2 days for polished version with typewriter effect

---

**Good luck! The foundation is solid. Now it's time to bring the story to life! 📖🎮**
