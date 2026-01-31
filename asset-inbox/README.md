# Asset Inbox - The Tamga Protocol

This folder manages the asset import workflow for The Tamga Protocol, a 1990s Turkey survival game with retro pixel art aesthetic.

## 📁 Folder Structure

```
asset-inbox/
├── README.md (this file)
├── pending/     ← DROP NEW ASSETS HERE
├── validated/   ← Passed validation, ready for import
└── rejected/    ← Failed validation + reports
```

## 🎯 How to Import Assets

### Step 1: Get Asset Specification

UI Design Agent will generate detailed prompts for you:

```markdown
# ASSET REQUEST: Character Portrait - Player

## AI Tool Prompt
"Pixel art portrait, 64x64, 16 colors, retro 90s style..."

## Technical Specs
- Format: PNG indexed
- Resolution: 64x64
- Colors: ≤ 16
- Grid: 16x16
- Background: Transparent

## Post-Processing
1. Export from AI tool
2. Open in Aseprite/GIMP
3. Resize to 64x64 (nearest neighbor)
4. Convert to indexed color (16 colors)
5. Save as PNG

## Delivery
Filename: char_player_portrait.png
Place in: asset-inbox/pending/
```

### Step 2: Create Asset

Use recommended AI tool or pixel art editor:
- **MidJourney/DALL-E**: Generate initial image
- **Aseprite**: Create pixel art directly
- **GIMP**: Post-process and convert

### Step 3: Drop in Pending

1. Save file with exact name specified
2. Place in `asset-inbox/pending/`
3. Asset Manager automatically detects and validates

### Step 4: Review Validation

**If PASS ✓**:
```
✅ Asset Validation: PASSED

File: char_player_portrait.png
✓ Format: PNG indexed
✓ Dimensions: 64x64
✓ Colors: 14/16
✓ File Size: 38 KB

Moved to: asset-inbox/validated/
Import to project? [Yes/No]
```

**If FAIL ❌**:
```
❌ Asset Validation: FAILED

File: char_player_portrait.png
✓ Format: OK
❌ Dimensions: 128x128 (expected 64x64)
❌ Colors: 256 (expected ≤16)

Report: asset-inbox/rejected/char_player_portrait_report.txt
Fix and re-submit
```

### Step 5: Import

Once validated:
1. Agent asks: "Import to project?"
2. You confirm: Yes
3. Asset moved to correct `assets/` folder
4. Godot import config created
5. Asset registry updated

## 🎨 Common Asset Types

### Character Sprite
```
Format: PNG indexed
Size: 64x64
Colors: ≤16
Grid: 16x16
Name: char_[name]_[state].png
Example: char_player_idle.png
```

### UI Button
```
Format: PNG indexed
Size: variable
Colors: ≤8
Grid: 8x8
States: _normal, _hover, _pressed
Example: ui_button_continue_normal.png
```

### Background
```
Format: PNG
Size: 320x240
Colors: ≤64
Name: bg_[location].png
Example: bg_shelter_interior.png
```

### Music
```
Format: OGG Vorbis
Bitrate: 128kbps
Loopable: Yes
Name: music_[track].ogg
Example: music_shelter_ambient.ogg
```

### SFX
```
Format: WAV
Sample Rate: 44100Hz
Channels: Mono
Duration: < 3s
Name: sfx_[action].wav
Example: sfx_door_open.wav
```

## ⚠️ Common Issues

### "Too many colors"
**Problem**: Image not in indexed color mode
**Fix**:
1. Open in GIMP
2. Image → Mode → Indexed
3. Choose palette (16 colors)
4. Export as PNG

### "Wrong dimensions"
**Problem**: Image size doesn't match spec
**Fix**:
1. Image → Scale Image
2. Set exact dimensions (e.g., 64x64)
3. Interpolation: None (nearest neighbor)
4. Scale

### "File size too large"
**Problem**: Exceeds size limit
**Fix**:
1. Reduce colors (fewer colors = smaller file)
2. Use indexed mode
3. Optimize PNG (pngcrush, optipng)

### "Wrong format"
**Problem**: JPEG instead of PNG, MP3 instead of OGG
**Fix**: Convert using appropriate tool
- Images: GIMP, Aseprite
- Audio: Audacity (WAV ↔ OGG)

## 📊 Validation Reports

When asset fails, check report in `rejected/`:

```
ASSET VALIDATION REPORT
=======================

File: char_player_sprite.jpg
Result: REJECTED

✅ Naming: OK
❌ Format: FAIL (expected PNG, got JPEG)
❌ Dimensions: FAIL (expected 64x64, got 128x128)
❌ Colors: FAIL (expected ≤16, got 256)

RECOMMENDED ACTIONS:
1. Convert to PNG
2. Resize to 64x64
3. Reduce to 16 colors
4. Re-submit

REFERENCE:
- Spec: config/schemas/asset-spec.json
- Guide: design/art/pixel_art_guide.md
```

## 🔄 Re-submission

After fixing:
1. Save with SAME filename
2. Drop in `pending/` again
3. Validation re-runs automatically

## 📝 Asset Registry

All imported assets tracked in `asset-registry.json`:

```json
{
  "char_player_idle": {
    "source": "asset-inbox/validated/char_player_idle.png",
    "imported_to": "assets/2d/characters/char_player_idle.png",
    "timestamp": "2026-01-31T15:30:00Z",
    "metadata": {
      "resolution": "64x64",
      "colors": 14,
      "file_size_kb": 38
    }
  }
}
```

## 🎯 Best Practices

1. **Follow naming conventions** exactly
2. **Process in batches** (create multiple assets, drop all at once)
3. **Check validation report** immediately
4. **Keep originals** (save high-res versions separately)
5. **Test in-game** after import

## 🆘 Need Help?

1. **Asset specifications unclear?**
   → Ask UI Design Agent for clarification

2. **Validation keeps failing?**
   → Check detailed report in `rejected/`
   → Compare with spec in `config/schemas/asset-spec.json`

3. **Not sure about art style?**
   → Check `design/art/pixel_art_guide.md`
   → Look at existing assets in `assets/`

---

**Asset Manager Agent monitors this folder automatically. Just drop and go!**
