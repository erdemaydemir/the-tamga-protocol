# Game Design Document - The Tamga Protocol

**Version**: 1.0
**Last Updated**: 2026-01-31
**Genre**: Story-Driven Survival, Mystery

---

## Core Concept

**The Tamga Protocol** is a narrative-focused survival game where players must endure 60 days during the 1990s Turkey economic crisis while uncovering the mystery of an ancient Turkic protocol. Player choices, discovered clues, and character relationships determine one of 10+ possible endings.

---

## Core Pillars

### 1. Meaningful Choices
Every decision matters. Dialogue choices, resource management, and investigation paths all impact the story and ending.

### 2. Survival Tension
Balancing immediate survival needs (health, morale) with long-term investigation creates constant strategic decisions.

### 3. Mystery & Discovery
The Tamga Protocol mystery unfolds gradually through clues, dialogue, and player detective work.

### 4. Character Relationships
NPCs remember your choices and their knowledge/trust levels directly affect available endings.

---

## Game Loop

### Daily Cycle

Each day follows this structure:

```
DAY START
    ↓
MORNING EVENT (automatic or choice-based)
    ↓
FREE TIME (choose activity)
    ↓
EVENING EVENT (automatic or choice-based)
    ↓
NIGHT SUMMARY (stats review, save)
    ↓
DAY END → NEXT DAY
```

**Duration**: Each in-game day = ~2-3 minutes real-time
**Total Playtime**: 60 days × 2.5 min = ~2.5 hours (first playthrough)

### Activity Types

**Investigation**:
- Visit locations for clues
- Talk to NPCs
- Research at library
- Follow leads

**Survival**:
- Manage health (rest, eat)
- Maintain morale (socialize, relax)
- Earn/save resources (if economy mechanic)

**Relationship Building**:
- Have conversations
- Help NPCs
- Make promises/commitments

---

## Player Stats

### Primary Stats

#### Health (0-100)
**Represents**: Physical well-being
**Increases**:
- Resting (home, café)
- Eating (if food mechanic)
- Positive events

**Decreases**:
- Stressful events
- Travel without rest
- Dangerous situations
- Illness events

**Game Over**: Health ≤ 0 triggers "The Lost" ending

#### Morale (0-100)
**Represents**: Mental/emotional state, hope
**Increases**:
- Positive NPC interactions
- Discovering clues
- Helping others
- Small victories

**Decreases**:
- Crisis events (news, economy worsening)
- Failed investigations
- Betrayals
- Loneliness

**Game Over**: Morale ≤ 0 triggers "The Lost" ending
**Impact**: Low morale limits dialogue options, affects NPC reactions

### Secondary Stats (Optional/Hidden)

#### Resources (Simple Economy)
**Optional mechanic**: Track basic money for travel, food
**Simple**: Just a number, not complex inventory
**Purpose**: Add survival tension without complexity

**Usage**:
- Travel between cities (costs resources)
- Buy information from NPCs
- Basic needs (food, shelter)

**Acquisition**:
- Starting amount (from backstory)
- Occasional events (find money, sell item)
- Help NPCs for payment (rare)

#### Suspicion (Hidden Stat)
**Tracks**: How much attention you've drawn from authorities/conspirators
**Increases**: Asking too many questions, exposing secrets
**Effects**: Certain NPCs become unavailable, dangerous events
**Visibility**: Player doesn't see number, only consequences

---

## Choice System

### Dialogue Choices

**Format**: 2-4 options per dialogue branch

**Types**:

1. **Information Gathering**:
   - "Tell me about the protocol"
   - "Who else knows about this?"
   - *Effect*: Learn clues, increase knowledge

2. **Relationship Shaping**:
   - "I trust you" vs. "I'm not sure about this"
   - *Effect*: Increase/decrease NPC relationship score

3. **Moral Dilemmas**:
   - "Expose the truth" vs. "Keep the secret"
   - *Effect*: Lock/unlock endings, change NPC behavior

4. **Survival Choices**:
   - "Rest" vs. "Investigate" vs. "Help NPC"
   - *Effect*: Modify stats, trigger events

### Choice Consequences

**Immediate**:
- Stat changes (+/-5 to +/-20)
- NPC reaction (dialogue response)
- Item/clue received

**Short-term** (same day or next):
- Follow-up event triggered
- NPC mentions your choice later
- New location unlocked

**Long-term** (many days later):
- Ending path locked/unlocked
- Major story branch
- NPC betrayal or loyalty

**Irreversible**:
- Some choices permanently close ending paths
- Game warns player ("This seems important...")

---

## Clue & Knowledge System

### Clue Types

#### 1. Physical Clues
**Examples**: Document fragments, Tamga symbols, photographs
**Acquisition**: Found at locations, given by NPCs
**Storage**: Inventory/journal (simple list)
**Usage**: Can show to NPCs for reactions

#### 2. Information Clues
**Examples**: Conversations, gossip, news
**Acquisition**: Dialogue, TV/newspaper events
**Storage**: Automatically tracked (player knowledge)
**Usage**: Unlocks new dialogue options

#### 3. Connection Clues
**Examples**: "Ali knows Mehmet", "Protocol created in 1992"
**Acquisition**: Putting pieces together
**Storage**: Visual web/graph (optional UI element)
**Usage**: Understanding the full picture

### Clue Discovery Rate

**Act 1 (Days 1-15)**: 2-3 major clues (20%)
**Act 2 (Days 16-35)**: 5-7 major clues (50%)
**Act 3 (Days 36-50)**: 3-5 connecting clues (30%)
**Act 4 (Days 51-60)**: Final pieces (if not found earlier)

**Total**: ~12-15 major clues to discover
**Minimum for "good" ending**: 70% (~10 clues)
**Maximum discovery**: 100% (requires thoroughness + luck)

### Journal System

**Simple UI**:
- **People**: List of NPCs met, relationship status
- **Clues**: List of discovered clues, descriptions
- **Places**: Cities visited, locations unlocked
- **Days**: Brief log of major events per day

**Purpose**: Help player track complex narrative without overwhelming

---

## NPC Relationship System

### Relationship Scores (Per NPC)

**Range**: -100 to +100
**Starting Value**: 0 (neutral)

**Relationship Tiers**:
- **+75 to +100**: Trusted Ally (reveals secrets)
- **+40 to +74**: Friendly (helpful)
- **+10 to +39**: Acquaintance (neutral)
- **-9 to +9**: Stranger (cautious)
- **-10 to -39**: Distrustful (unhelpful)
- **-40 to -74**: Hostile (obstructive)
- **-75 to -100**: Enemy (dangerous)

### Relationship Effects

**High Relationship (+75+)**:
- NPC shares secret information
- Provides unique clues
- Protects you from danger
- Unlocks special endings

**Low Relationship (-40 or below)**:
- NPC refuses to talk
- May lie or mislead
- Could betray you
- Blocks certain endings

### Knowledge Transfer

NPCs track what they know about you:

**Ali knows**:
- Which NPCs you've talked to (if you tell him)
- What clues you've found (if you share)
- Your suspicions about the protocol

**Consequences**:
- Tell Ali about Mehmet → Ali warns you
- Tell Zeynep about protocol → She wants to expose it
- Keep secrets → NPCs distrust you

**Strategy**: Balance sharing information (build trust) vs. keeping secrets (maintain control)

---

## Location & Travel System

### The Four Cities

**Starting Location**: İstanbul (Day 1)

**Travel Costs**:
- Time: 1 day to travel between cities (arrives next morning)
- Resources: Small cost (if economy mechanic)
- Health: -5 (travel fatigue)

**Travel Restrictions**:
- Can't travel during critical story moments
- Some locations only accessible with NPC guidance

### Locations per City

**İstanbul** (6 locations):
1. Apartment (player's base)
2. Grand Bazaar (Ali, general NPCs)
3. Café (social hub)
4. Ferry Terminal (travel, Zeynep)
5. Bookstore (optional)
6. Old Quarter (Fatma)

**Ankara** (4 locations):
1. Government District (Mehmet)
2. Café (bureaucrats gossip)
3. Bookstore (Tamga clue)
4. University (Zeynep sometimes)

**Muğla** (3 locations):
1. Coastal Café
2. Ruins (Ayşe, Tamga easter egg)
3. Fishing Village (Hasan)

**İzmir** (4 locations):
1. Port
2. Library (Derya, archives)
3. Workers' Café (Emre)
4. Warehouse District

---

## Event System

### Event Types

#### 1. Story Events (Mandatory)
**Trigger**: Specific day number
**Example**: Day 30 - Discover protocol fragment
**Purpose**: Drive main narrative forward
**Skippable**: No

#### 2. Conditional Events
**Trigger**: Flags + day range
**Example**: Days 20-25, if talked to Ali + has 3 clues
**Purpose**: Responsive storytelling
**Skippable**: Yes (if conditions not met)

#### 3. Random Events
**Trigger**: Random chance on free days
**Example**: "Encounter old friend" or "Economic news worsens"
**Purpose**: Variety, replayability
**Skippable**: Yes (by probability)

#### 4. Character Events
**Trigger**: High relationship + specific location
**Example**: Ali invites you to family dinner (relationship > 60)
**Purpose**: Deepen character connections
**Skippable**: Yes (if relationship too low)

### Event Structure (JSON)

```json
{
  "event_id": "day30_protocol_fragment",
  "day_trigger": 30,
  "required_flags": ["visited_ankara", "met_mehmet"],
  "location": "ankara_bookstore",
  "type": "story",
  "dialogue_file": "day30_discovery.json",
  "outcomes": {
    "clue_discovered": "protocol_fragment",
    "stat_changes": {"morale": +10},
    "flags_set": ["knows_about_protocol"]
  }
}
```

---

## Ending System

### How Endings Are Determined

**Calculation Timing**: End of Day 60

**Factors**:
1. **Clue Discovery** (%)
2. **NPC Relationships** (specific thresholds)
3. **Story Flags** (critical choices)
4. **Stats** (health, morale, suspicion)

**Example: "The Whistleblower" Ending**:
```
Requires:
- Clues discovered: ≥70%
- Zeynep relationship: ≥60
- Flags: "decided_to_expose", NOT "betrayed_zeynep"
- Morale: ≥40
```

### Ending Priority

If multiple endings qualified:
1. Check "critical choice" flags first (Day 58 decision)
2. Then check relationships (highest priority NPC)
3. Then check clue percentage
4. Fallback to "The Survivor" if nothing matches

### Ending Length

**Short Epilogue** (1-2 minutes):
- Narration text with static images
- Outcome for key NPCs
- Where protagonist ends up
- Impact of player's choices

**Unlockables**:
- Ending gallery (all discovered endings)
- Character dossiers (unlocked per ending)
- Concept art (bonus)

---

## UI/UX Flow

### Main Menu

```
THE TAMGA PROTOCOL
[NEW GAME]
[CONTINUE]
[ENDINGS] (if any unlocked)
[SETTINGS]
[QUIT]
```

### In-Game HUD (Minimal)

**Top Bar**:
- Day counter (e.g., "Day 15/60")
- Current location
- Time of day (Morning/Afternoon/Evening)

**Side Panel** (togglable):
- Health bar
- Morale bar
- [Journal Button]
- [Settings Button]

### Dialogue Screen

**Layout**:
```
┌──────────────────────────────────────┐
│ [NPC Portrait]  NPC Name             │
│                 Relationship: ♥♥♥♡♡  │
├──────────────────────────────────────┤
│ "Dialogue text appears here with     │
│  typewriter effect..."               │
│                                      │
│ → [Choice 1]                         │
│ → [Choice 2]                         │
│ → [Choice 3] (requires clue)         │
└──────────────────────────────────────┘
```

**Features**:
- Auto-advance option (settings)
- Dialogue history (scroll back)
- Skip (for replays)

### Day Transition

**End of Day Screen**:
```
DAY 15 SUMMARY

Health:     ████████░░ 80 (+5)
Morale:     ██████░░░░ 60 (-10)

Today's events:
- Met Zeynep at university
- Discovered "protocol" reference
- Ali seemed worried

[CONTINUE TO DAY 16]
```

---

## Progression & Pacing

### Act Pacing

**Act 1** (Days 1-15): **Slow** - Establish world, mechanics, NPCs
**Act 2** (Days 16-35): **Medium** - Investigation ramps up, travel
**Act 3** (Days 36-50): **Fast** - Revelations, tension peaks
**Act 4** (Days 51-60): **Climactic** - Final choices, resolution

### Player Agency vs. Story Beats

**Controlled Days** (story events): ~20/60 days
**Free Days** (player choice): ~40/60 days

**Balance**: Player feels in control while story stays coherent

---

## Replayability

### New Game+

**Unlocked after first ending**:
- Skip tutorial/intro
- Fast-forward through seen dialogue
- Clue discovery hints (if stuck)

### Incentives to Replay

1. **Multiple Endings**: 10+ to discover
2. **Different NPC Paths**: Trust Ali vs. Mehmet vs. Zeynep
3. **Clue Hunting**: Find all 12-15 clues
4. **Alternate Cities**: Different order of visits
5. **Relationship Variations**: Befriend different NPCs

### Speedrun Potential

**Minimal Ending Route**: ~60 minutes (skip dialogue, make quick choices)
**100% Completion**: ~5-6 hours (all endings, all clues)

---

## Technical Implementation Notes

### Using Framework Components

**GameState** (autoload):
- `current_day`: Track day number
- `story_flags`: Choice tracking
- `discovered_clues`: Clue array
- `relationships`: NPC relationship dict
- `player_stats`: Health, morale, resources

**DialogueManager**:
- Load dialogue JSON per event
- Handle choices, set flags
- Integrate with StoryState

**StoryState**:
- Track character knowledge
- Calculate ending scores
- Manage plot threads

**SaveSystem**:
- Auto-save end of each day
- Load game returns to start of last day

---

## Accessibility

### Settings Options

- **Text Size**: Small / Medium / Large
- **Text Speed**: Slow / Medium / Fast / Instant
- **Auto-Advance**: On / Off
- **Colorblind Mode**: Adjust palette (if needed)
- **Skip Seen Dialogue**: On / Off (for replays)

### Tutorial

**Day 1**: Integrated tutorial
- Explain stats (health, morale)
- Show dialogue choices
- Introduce journal
- Teach travel system

**Non-intrusive**: Part of natural gameplay

---

## Scope & Priorities

### Must-Have (MVP)

- ✅ 60-day cycle working
- ✅ Dialogue system with choices
- ✅ Clue discovery & journal
- ✅ NPC relationships
- ✅ At least 5 endings
- ✅ 4 cities with basic locations
- ✅ Save/load functionality

### Should-Have (Polish)

- Visual novel-style UI
- Character portraits for all main NPCs
- City background art
- Day transition animations
- Music & SFX
- 10+ endings

### Nice-to-Have (Post-Launch)

- Turkish language localization
- Voice acting (Turkish/English)
- Animated character sprites
- More random events
- Achievements

---

## Development Milestones

### Milestone 1: Core Systems (v0.2.0)
- Day cycle functional
- Dialogue system working
- Stats tracking
- Save/load

### Milestone 2: Content (v0.3.0)
- First 20 days of content
- 3 cities implemented
- 5 NPCs with dialogues
- Clue system working

### Milestone 3: Full Story (v0.4.0)
- All 60 days complete
- All 10+ endings
- All NPCs fully written
- Clue network complete

### Milestone 4: Polish (v0.9.0)
- All art assets
- Music & SFX
- UI polish
- Bug fixes
- Playtesting

### Milestone 5: Release (v1.0.0)
- Final balance tweaks
- Performance optimization
- Release build

---

## Version History

- v1.0 (2026-01-31): Initial game design document

---

**This is a living document. Update as gameplay evolves through playtesting.**
