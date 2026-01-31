# AGENTS.md - The Tamga Protocol Agent Configuration

> This file defines ALL agent behavior for The Tamga Protocol project.
> NO agent may operate outside the rules defined in this file and its referenced documents.
>
> **Version**: 0.1.0
> **Last Updated**: 2026-01-31
> **Schema Version**: 1.0.0
> **Framework Version**: 1.0.0

## Project Overview

**Name**: The Tamga Protocol
**Type**: Story-Driven Survival (1990s Turkey)
**Primary Language**: GDScript
**Platform**: Windows (PC)
**Versioning**: Semantic Versioning (SemVer 2.0.0)
**Target Build Size**: <1GB
**Target Gameplay**: 60 days, 2-2.5 hour first playthrough, 10+ endings

## Game Context

### Setting
**Time Period**: 1990s Turkey (Economic/Social Crisis Era)
**Locations**: Ankara, İstanbul, Muğla, İzmir
**Theme**: Survival, Mystery, Historical Easter Eggs
**Art Style**: 2D Pixel Art (Authentic 90s Retro)

### Core Mechanics
- **60-Day Cycle**: Each day presents choices, events, and consequences
- **Multiple Endings**: 10+ endings based on player choices and discovered clues
- **Clue Network**: Interconnected clues reveal the "Tamga Protocol" mystery
- **Character Knowledge**: Track what each character knows
- **Göktürk Easter Eggs**: Ancient Turkic symbols (Tamga) hidden as 1-2 subtle clues

### Narrative Theme
**"The Tamga Protocol"**: An obscure reference to ancient Turkic runic symbols/seals. The game's mystery revolves around discovering what this protocol means and how it connects to the 1990s crisis. Players must research Göktürk heritage to understand hidden meanings.

## Agent Binding Rules

### Rule #1: Documentation Supremacy
All agents MUST:
1. Read this file before ANY action
2. Reference specific section when making decisions
3. Never deviate from documented rules
4. Request clarification rather than assume

### Rule #2: Validation Gate
All operations MUST pass validation BEFORE execution:
1. Structure Guard validates file operations
2. Documentation Guard validates content changes
3. Commit Guard validates version control operations
4. Story Validator validates narrative content

### Rule #3: Update Protocol
When rules need updating:
1. User provides new requirement
2. Plan Agent proposes documentation update
3. Update approved and committed
4. THEN behavior changes (not before)

### Rule #4: User Clarification Protocol
Agents MUST consult user when:
1. **Design Decisions**: Present 2-4 options with pros/cons
2. **Ambiguous Requirements**: Request clarification before proceeding
3. **Validation Failures**: Explain issue + propose solutions

## Registered Agents

### 1. Plan Agent (Meta-Orchestrator)
**Config**: `framework/config/agents/plan-agent.md`
**Responsibilities**:
- Orchestrate all other agents
- Maintain inter-agent communication
- Update planning documents
- Route questions to correct MD files
- Track all MD file dependencies
- **CRITICAL**: Enforce User Clarification Protocol

**Constraints**:
- MUST consult AGENTS.md before delegating
- MUST update planning docs in `docs/planning/`
- MUST validate all plan changes
- MUST ask user at Design Decisions, Ambiguities, Validation Failures

**Game-Specific Configuration**:
```yaml
planning_folder: "docs/planning/"
max_plan_complexity: 10
auto_archive_completed: true
game_title: "The Tamga Protocol"
game_theme: ["1990s Turkey", "Crisis", "Survival", "Mystery", "Göktürk Heritage"]
```

### 2. Story Agent (Narrative Designer)
**Config**: `framework/config/agents/story-agent.md`
**Responsibilities**:
- Generate dialogue trees based on story beats
- Create daily events for 60-day cycle
- Design character interactions across 4 cities
- Propose ending variants based on clue discovery
- Maintain narrative consistency with 1990s Turkey theme

**Constraints**:
- MUST reference `design/narrative/story_bible.md`
- MUST validate against Story Validator before committing
- MUST maintain character voice consistency
- MUST track timeline coherence across 60 days
- MUST ensure Göktürk easter eggs are subtle (1-2 clues only)

**Game-Specific Configuration**:
```yaml
story_bible: "design/narrative/story_bible.md"
output_format: "JSON"
validation_threshold: 75
max_daily_events: 5
dialogue_style: "conversational"
game_duration_days: 60
cities: ["Ankara", "İstanbul", "Muğla", "İzmir"]
historical_period: "1990s Turkey"
easter_egg_limit: 2  # Maximum Göktürk/Tamga references
easter_egg_subtlety: "high"  # Requires player research
```

### 3. Story Validator Agent
**Config**: `framework/config/agents/story-validator.md`
**Responsibilities**:
- Validate Story Agent output against quality criteria
- Score on: Character Consistency, Timeline Coherence, Theme Alignment, Quality
- Provide actionable feedback for revisions
- Ensure 1990s Turkey authenticity

**Constraints**:
- MUST use scoring system (0-100 per category)
- MUST provide specific violation examples
- MUST suggest fixes for failures
- Approval threshold: **75-85%**

**Game-Specific Configuration**:
```yaml
min_approval_score: 75
auto_approve_score: 85
rejection_score: 50

weights:
  character_consistency: 0.25
  timeline_coherence: 0.25
  theme_alignment: 0.25
  narrative_quality: 0.25

theme_keywords:
  - "1990s Turkey"
  - "economic crisis"
  - "retro"
  - "survival"
  - "mystery"
  - "Tamga"
  - "Göktürk"
  - "Ankara"
  - "İstanbul"
  - "Muğla"
  - "İzmir"

authenticity_requirements:
  - "1990s Turkish cultural references accurate"
  - "No anachronisms (modern tech, slang, events)"
  - "Göktürk references obscure and require research"
  - "No overtly political or divisive content"
```

### 4. UI Design Agent
**Config**: `framework/config/agents/ui-design-agent.md`
**Responsibilities**:
- Generate detailed asset prompts for 90s retro pixel art
- Enforce visual consistency across all assets
- Validate assets against style guide
- Maintain color palette and typography standards
- Create prompts for MidJourney/DALL-E/Aseprite

**Constraints**:
- MUST reference `design/art/style_guide.md`
- MUST use approved 16-color retro palette
- MUST generate prompts with technical specifications
- MUST validate imported assets

**Game-Specific Configuration**:
```yaml
art_style: "pixel_art"
style_guide: "design/art/style_guide.md"
color_palette_file: "design/art/color_palette.md"

ui_grid_size: "8x8"
max_colors: 16
asset_formats:
  sprites: "PNG indexed"
  ui: "PNG indexed"
  backgrounds: "PNG indexed"

consistency_rules:
  enforce_single_style: true
  require_palette_compliance: true
  era: "1990s retro"
  reference_games: ["60 Parsecs", "Papers Please", "Return of the Obra Dinn"]
```

### 5. Asset Manager Agent
**Config**: `framework/config/agents/asset-manager-agent.md`
**Responsibilities**:
- Monitor `asset-inbox/pending/` folder
- Validate assets against 16-color pixel art specifications
- Convert formats if needed
- Move validated assets to project folders
- Update asset registry

**Constraints**:
- MUST validate BEFORE importing
- MUST move rejected assets to `asset-inbox/rejected/`
- MUST create validation reports
- MUST ask user approval before final import

**Game-Specific Configuration**:
```yaml
inbox_folder: "asset-inbox/"
validation_schema: "framework/config/schemas/asset-spec.json"

auto_import_validated: false
create_godot_import_files: true

max_sprite_size_kb: 50
max_ui_element_kb: 30
max_background_kb: 200
max_audio_size_kb: 3000
max_music_size_kb: 5000

pixel_art_validation:
  max_colors: 16
  indexed_color: required
  transparency: allowed
  dimensions_multiple_of: 8
```

### 6. Github Committer Agent
**Config**: `framework/config/agents/github-committer.md`
**Responsibilities**:
- Generate conventional commit messages
- Manage semantic versioning
- Update CHANGELOG.md
- Handle branch operations

**Constraints**:
- MUST follow Conventional Commits 1.0.0
- MUST update version per SemVer rules
- MUST reference issue/task in commit
- MUST generate CHANGELOG.md on release

**Game-Specific Configuration**:
```yaml
default_scope: "tamga-protocol"
require_issue_reference: false
generate_changelog: true

initial_version: "0.1.0"
pre_release_tag: "alpha"

workflow_type: "git_flow"
main_branch: "main"
develop_branch: "develop"
```

### 7. Structure Guard Agent
**Config**: `framework/config/agents/structure-guard.md`
**Responsibilities**:
- Validate ALL file operations before execution
- Enforce project structure rules
- Block non-compliant operations
- Log violation attempts

**Constraints**:
- MUST run before file creation/move/delete
- MUST reference `framework/config/schemas/project-structure.json`
- CANNOT be bypassed
- Logs to `docs/guards/violation-log.md`

**Game-Specific Configuration**:
```yaml
structure_schema: "framework/config/schemas/project-structure.json"
game_specific_dirs:
  - "godot/scenes/"
  - "godot/scripts/"
  - "data/narrative/"
  - "data/events/"
  - "design/"

mode: "strict"
allow_user_override: false
```

## Build & Test Commands

### Development
```bash
# Godot editor (Windows)
godot -e --path ./godot

# Run game
godot --path ./godot

# Run in headless mode (testing)
godot --headless --path ./godot
```

### Testing
```bash
# Run all validation guards
python framework/config/validation/guard-runner.py --all

# Run structure validation
python framework/config/validation/validate-structure.py

# Run documentation validation
python framework/config/validation/validate-docs.py

# Run linter
gdlint godot/
```

### Build
```bash
# Export Windows build
godot --export-release "Windows Desktop" ./builds/windows/TheTamgaProtocol.exe --headless --path ./godot
```

## Architecture Overview

**Reference**: `framework/docs/ARCHITECTURE.md`

**Key Principles**:
1. **Markdown-Driven**: ALL rules in MD files
2. **Validation-First**: Guard before execute
3. **Documentation-Code Sync**: Docs lead, code follows
4. **Immutable Rules**: Changes tracked in git
5. **Component-Based**: Hybrid Godot Nodes + Components
6. **SOLID + CLEAN CODE**: Enforced via linting + reviews

**Data Flow**:
```
User Request → Plan Agent → Check AGENTS.md → Consult Agent Config →
  → Apply Rules → Run Guards → Execute → Update Docs → Commit
```

## Coding Style

**Reference**: `framework/config/rules/clean-code.md`

**GDScript**:
- PascalCase for classes: `DialogueManager`
- snake_case for functions/variables: `get_current_day()`
- UPPER_SNAKE_CASE for constants: `MAX_DAYS = 60`

**SOLID Principles**: Enforced
**CLEAN CODE**: Enforced via gdlint

## Git Workflow

**Reference**: `framework/config/rules/commit-workflow.md`

**Branch Strategy**: Git Flow
- `main`: Production releases only
- `develop`: Integration branch
- `feature/*`: New features
- `bugfix/*`: Bug fixes
- `release/*`: Release preparation
- `hotfix/*`: Urgent production fixes

**Commit Format**: Conventional Commits 1.0.0
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types**: feat, fix, docs, style, refactor, test, build, ci, chore, perf, revert

## User Clarification Protocol

**Reference**: `framework/config/rules/user-clarification-protocol.md`

**Mandatory Triggers**:
1. **Design Decisions**
   - Character designs, UI layouts, gameplay mechanics, city representations
   - Action: Present 2-4 options with pros/cons
   - Format: Multiple choice with mockups if possible

2. **Ambiguous Requirements**
   - Unclear or contradictory specifications
   - Action: Request specific clarification
   - Format: Pointed question with context

3. **Validation Failures**
   - Story Validator <75%, Structure Guard violations
   - Action: Explain issue + propose solutions (A/B/C)
   - Format: Problem description + solution options

**CRITICAL RULE**: Agents NEVER proceed with assumptions. When in doubt, ASK user.

## Game-Specific Notes

### Narrative Design Constraints
1. **60-Day Structure**: Each day must have 1-5 events
2. **Multiple Endings**: Minimum 10 endings based on:
   - Clues discovered
   - Character relationships
   - City visited
   - Player choices
3. **Character Knowledge System**: Track what each NPC knows
4. **Clue Network**: Interconnected clues that reveal the Tamga Protocol
5. **Göktürk Easter Eggs**: Maximum 2 subtle references requiring research

### Visual Style Requirements
1. **2D Pixel Art**: 8x8 grid, 16-color palette
2. **1990s Aesthetic**: CRT monitor effects, retro UI
3. **Turkish Cultural Elements**: Authentic 1990s Turkey visuals
4. **Color Palette**: Warm earth tones + muted colors (no neon)

### Audio Requirements
1. **Music**: 90s Turkish instrumental (no vocals to avoid copyright)
2. **SFX**: Retro 8-bit/16-bit style
3. **Ambiance**: City sounds (traffic, bazaar, etc.)

### Localization (Future)
- Primary: English
- Planned: Turkish (post-release)
- UI must support UTF-8 for Turkish characters (ğ, ü, ş, ı, ö, ç)

### Custom Agents
None currently. All agents use framework defaults.

### Workflow Overrides
None currently. Standard Git Flow workflow applies.

### Additional Rules

#### Rule: Tamga Symbol Usage
- Tamga symbols (ᛏᛆᛘᚵᚨ / Göktürk runes) MUST be:
  - Obscure (not immediately recognizable)
  - Limited to 1-2 appearances
  - Require player research to understand
  - Connected to ending revelation

#### Rule: Historical Accuracy
- 1990s Turkey cultural references MUST be researched and accurate
- No anachronisms (modern tech, slang, events after 1999)
- Economic crisis context must be respectful and educational

#### Rule: City Representation
- Each city (Ankara, İstanbul, Muğla, İzmir) must have:
  - Unique visual style
  - Distinct NPCs
  - City-specific events
  - Cultural landmarks (subtle, not tourist-focused)

---

**Version History**:
- v0.1.0 (2026-01-31): Initial configuration for The Tamga Protocol
