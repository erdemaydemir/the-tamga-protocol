# Art Style Guide - The Tamga Protocol

**Version**: 1.0
**Last Updated**: 2026-01-31
**Art Direction**: Retro Pixel Art (1990s Aesthetic)

---

## Visual Identity

### Core Aesthetic
**1990s Retro Pixel Art** with warm, earthy tones evoking the atmosphere of crisis-era Turkey.

**Inspirations**:
- Papers, Please (UI style, bureaucratic feel)
- Return of the Obra Dinn (limited palette mastery)
- 60 Parsecs (survival mechanics UI)
- Early 90s PC adventure games

**NOT**:
- Modern pixel art (no gradients, no smooth anti-aliasing)
- Neon cyberpunk aesthetics
- High fantasy or anime styles

---

## Technical Specifications

### Resolution & Grid

**Game Resolution**: 1280x720 (16:9)
**Pixel Grid**: 8x8 base unit
**Scaling**: Integer scaling only (no sub-pixel positioning)

**All assets MUST align to 8x8 grid**:
- Characters: 8, 16, 24, 32, 40, 48, 56, 64px dimensions
- UI elements: Multiples of 8px
- Backgrounds: 1280x720 or scaled versions

### Color Palette

**Strictly 16 colors** (see `color_palette.md` for full specs)

**Primary Palette**:
```
#8B4513 #D2691E #F4A460 (Browns)
#2F4F4F #696969 #A9A9A9(Grays)
#B8860B #FFE4B5 #DEB887 (Warm accents)
#CD853F #8FBC8F #556B2F (Earth tones)
#B22222 #4682B4 (Special: Red/Blue)
#000000 #FFFFFF (Black/White)
```

**File Format**: PNG indexed color mode

---

## Character Art

### Portraits (64x64px)

**Specifications**:
- Dimensions: 64x64px exactly
- Grid: 8x8
- Colors: 8-12 colors from palette
- Style: Front-facing, slight 3/4 view
- Expression: Neutral (variations for emotions)

**Anatomy Guidelines**:
- Head: ~40px tall
- Eyes: 2-3px each
- Nose: Minimal (1-2px suggestion)
- Mouth: 3-5px
- Details: Minimal but expressive

**Example Breakdown (Ali - Merchant)**:
```
Colors used (10):
- Skin: #DEB887, #CD853F, #F4A460
- Hair/Mustache: #2F4F4F, #696969
- Clothing: #8B4513, #D2691E
- Eyes: #000000, #FFE4B5
- Outline: #000000
```

**Expressions** (separate files):
- `character_name_neutral.png`
- `character_name_happy.png`
- `character_name_sad.png`
- `character_name_angry.png`
- `character_name_surprised.png`

### Character Sprites (32x48px or 48x64px)

**Specifications**:
- Small sprites: 32x48px (background NPCs)
- Main sprites: 48x64px (important characters)
- Grid: 8x8
- Colors: 6-10 colors from palette

**States** (if animated):
- Idle: 1-2 frames
- Walk: 2-4 frames
- Talk: 2 frames (subtle animation)

**Simplification**:
- Less detail than portraits
- Readable at distance
- Clear silhouette
- Minimal animation (this is not an action game)

---

## UI Design

### Buttons

**Standard Button**: 96x32px

**States**:
1. Normal: Base colors
2. Hover: Lighter shade
3. Pressed: Darker shade
4. Disabled: Grayscale version

**Structure**:
```
┌─────────────────────┐
│  ┌───────────────┐  │  ← 2px border (#2F4F4F)
│  │   [TEXT]      │  │  ← Inner fill (#8B4513)
│  └───────────────┘  │  ← Text (#FFE4B5)
└─────────────────────┘
```

**Text**:
- Font: Pixel font, 8px or 16px
- Color: #FFE4B5 (Moccasin) on dark background
- Alignment: Center
- Language: English (Turkish words for flavor)

### Panels & Windows

**Style**: Retro computer interface, 1990s OS feel

**Structure**:
```
┌─────────────────────────────┐
│ ▓▓▓ PANEL TITLE ▓▓▓         │  ← Title bar (#8B4513)
├─────────────────────────────┤
│                             │
│    Panel content area       │  ← Content (#D2691E)
│                             │
└─────────────────────────────┘
```

**Elements**:
- Outer border: 2px, #2F4F4F
- Title bar: #8B4513
- Content area: #D2691E or #F4A460
- Text: #FFE4B5 or #000000 (depending on contrast)

### Icons (24x24px or 32x32px)

**Specifications**:
- Simple, clear silhouettes
- Maximum 6 colors
- 2px outline for clarity
- Easily recognizable at small size

**Examples**:
- Inventory item: 24x24px
- UI icon (settings, save): 32x32px
- Status icon (health, morale): 24x24px

---

## Backgrounds

### City Scenes (1280x720px)

**Composition**:
- Foreground: Detailed (where player interacts)
- Midground: Medium detail
- Background: Simplified, atmospheric

**Perspective**:
- Slight isometric OR
- Straight-on 2D (like Papers, Please)
- **Consistent throughout game**

**Detail Level**:
- NOT photorealistic
- Stylized, simplified
- Focus on mood and atmosphere
- Recognizable landmarks (subtle, not tourist-focused)

**Color Usage**:
- Use full 16-color palette
- Warm tones dominant
- Muted, not saturated
- Create depth through value (light/dark)

### Interior Scenes

**Style**: Cozy, cramped, authentic 1990s

**Elements to Include**:
- Period-appropriate furniture
- CRT TV (if applicable)
- Rotary phone
- Patterned carpets/wallpaper (Turkish style)
- Cluttered but organized

**Lighting**:
- Warm interior light (#F4A460, #FFE4B5)
- Shadows (#2F4F4F, #696969)
- Windows showing exterior (#4682B4 for sky)

---

## Environmental Details

### 1990s Turkey Authenticity

**Urban Elements**:
- Old cars (boxy 80s/90s models)
- Analog traffic lights
- Hand-painted signs
- Street vendors
- Cobblestone streets (İstanbul)
- Apartment buildings (balconies with laundry)

**Color Palette per City**:

**Ankara** (Political):
- Grays and browns (#696969, #8B4513)
- Formal, structured
- Government buildings (beige/gray)

**İstanbul** (Cultural):
- Warm, colorful
- Market reds (#B22222), golds (#B8860B)
- Blue (#4682B4) for Bosphorus

**Muğla** (Coastal):
- Blues and greens (#4682B4, #8FBC8F)
- Sandy tones (#F4A460)
- Relaxed, natural

**İzmir** (Industrial):
- Grays and dark greens (#696969, #556B2F)
- Gritty, working-class
- Port cranes, warehouses

---

## Text & Typography

### Font Guidelines

**Pixel Font Required**:
- 8px for small text (UI hints)
- 16px for dialogue
- 24px for titles

**Recommended Fonts**:
- "Press Start 2P" (free, Google Fonts)
- "Dogica" (free, pixel font)
- Custom pixel font (if created)

**Readability**:
- High contrast with background
- Never use pure black on pure white (too harsh)
- Preferred: #FFE4B5 on #2F4F4F or vice versa

### Dialogue Display

**Style**: Visual novel-style text box

**Layout**:
```
┌──────────────────────────────────────────┐
│ [PORTRAIT]  Ali (The Merchant)          │
│  64x64px    ───────────────              │
│             "Kardeşim, you look tired.   │
│              Let me make you some çay."  │
│                                          │
│             [Choice 1] [Choice 2]        │
└──────────────────────────────────────────┘
```

**Text Speed**: Typewriter effect (adjustable in settings)

---

## Animation Guidelines

### Principles

**Minimal Animation**:
- This is a narrative game, not an action game
- Subtle animations for polish
- 2-4 frames maximum for most animations

**Frame Rate**:
- UI: 60 FPS (smooth)
- Character animations: 8-12 FPS (pixel art style)

### Common Animations

**UI**:
- Button hover: Color shift (instant or 2 frames)
- Panel open/close: Slide or fade (8-12 frames)
- Text typewriter: 1 character per frame

**Characters**:
- Idle breathing: 2 frames, slow loop
- Walk cycle: 4 frames
- Talk: 2 frames (mouth open/closed)

**Environment**:
- Flags waving: 3 frames
- Water ripples: 4 frames
- Lights blinking: 2 frames (slow)

---

## Asset Creation Workflow

### Step 1: Concept
1. Check story bible for context
2. Reference 1990s Turkey photos (Google Images)
3. Sketch rough concept (digital or paper)

### Step 2: Creation

**Option A: AI Generation (MidJourney/DALL-E)**
1. Request detailed prompt from UI Design Agent
2. Generate asset in AI tool
3. Export at high resolution

**Post-Processing (MANDATORY)**:
1. Open in Aseprite or GIMP
2. Resize to exact dimensions (nearest neighbor)
3. Convert to indexed color mode
4. Load 16-color palette
5. Reduce colors to 16 max
6. Clean up artifacts
7. Export as PNG

**Option B: Manual Pixel Art (Aseprite)**
1. Create new file with exact dimensions
2. Set to indexed color mode
3. Load 16-color palette
4. Draw using 8x8 grid guides
5. Export as PNG

### Step 3: Validation
1. Drop in `asset-inbox/pending/`
2. Asset Manager Agent validates
3. If rejected, check report and fix
4. If validated, await user approval for import

---

## Do's and Don'ts

### Visual Style ✅ DO

- ✅ Use exactly 16 colors from palette
- ✅ Align everything to 8x8 grid
- ✅ Create clear, readable silhouettes
- ✅ Reference real 1990s Turkey photos
- ✅ Keep style consistent across all assets
- ✅ Use dithering sparingly (only for texture)
- ✅ Test assets at game resolution (1280x720)

### Visual Style ❌ DON'T

- ❌ Add colors outside the 16-color palette
- ❌ Use gradients or smooth shading
- ❌ Create modern or futuristic designs
- ❌ Ignore the 8x8 grid
- ❌ Make assets too detailed (less is more)
- ❌ Use anti-aliasing (hard pixels only)
- ❌ Mix art styles (consistency is key)

### Cultural ✅ DO

- ✅ Research 1990s Turkey authentically
- ✅ Show everyday life (not tourist spots)
- ✅ Include period-correct technology
- ✅ Use Turkish patterns (carpets, tiles)
- ✅ Respect cultural sensitivity

### Cultural ❌ DON'T

- ❌ Use stereotypes or caricatures
- ❌ Show modern landmarks anachronistically
- ❌ Ignore economic crisis atmosphere
- ❌ Use overly political imagery
- ❌ Include anachronisms (2000s+ tech/fashion)

---

## Reference Images

### Required Reference Research

Before creating assets, research:

1. **1990s Turkey Photos**:
   - Street scenes from Ankara, İstanbul, İzmir, Muğla
   - 1990s Turkish fashion
   - Old cars (popular models)
   - Vintage Turkish interiors

2. **Technology**:
   - Rotary phones
   - CRT TVs
   - 1990s appliances
   - Cassette players

3. **Architecture**:
   - Turkish apartment buildings
   - Bazaar structures
   - 1990s storefronts
   - Government buildings (exteriors)

4. **Cultural Elements**:
   - Turkish carpets and patterns
   - Traditional çay glasses
   - Street vendor carts
   - Turkish newspapers (1990s layout)

**Use references, don't copy directly**

---

## Quality Checklist

Before submitting asset:

**Technical**:
- [ ] Correct dimensions (exact pixels)
- [ ] Aligned to 8x8 grid
- [ ] Indexed color mode (PNG)
- [ ] ≤16 colors from palette
- [ ] File size within limits

**Style**:
- [ ] Matches retro pixel art aesthetic
- [ ] Consistent with existing assets
- [ ] Clear, readable silhouette
- [ ] Appropriate detail level

**Authenticity**:
- [ ] Period-appropriate (1990s)
- [ ] Culturally authentic
- [ ] No anachronisms
- [ ] Researched reference material

**Validation**:
- [ ] Passes Asset Manager validation
- [ ] Approved by UI Design Agent
- [ ] Tested in-game at correct resolution

---

## Examples & Templates

### Character Portrait Template (64x64px)

```
Color allocation guide:
- 3 colors: Skin tones
- 2 colors: Hair
- 3 colors: Clothing
- 2 colors: Eyes/details
- 1 color: Outline (black)
Total: 11 colors (within 16 limit)
```

### UI Button Template (96x32px)

```
File structure:
ui_button_[name]_normal.png
ui_button_[name]_hover.png
ui_button_[name]_pressed.png
ui_button_[name]_disabled.png
```

---

## Version History

- v1.0 (2026-01-31): Initial style guide created

---

**Remember**: Consistency > Individual perfection. Every asset should feel like it belongs in The Tamga Protocol universe.
