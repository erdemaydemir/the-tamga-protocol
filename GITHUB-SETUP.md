# GitHub Repository Setup - The Tamga Protocol

## Step 1: Create Repository on GitHub

### Option A: Via GitHub Website (Recommended)

1. Go to https://github.com/new
2. **Repository name**: `the-tamga-protocol`
3. **Description**: `A story-driven survival game set in 1990s Turkey. Survive 60 days, uncover the mystery of the Tamga Protocol.`
4. **Visibility**: Public or Private (your choice)
5. **DO NOT** initialize with README, .gitignore, or license (we already have these)
6. Click **Create repository**

### Option B: Via GitHub CLI (if installed)

```bash
gh repo create the-tamga-protocol --public --description "A story-driven survival game set in 1990s Turkey" --source=. --remote=origin --push
```

## Step 2: Connect Local Repository to GitHub

After creating the repository on GitHub, run these commands:

```bash
cd E:/dev/game-ai

# Add remote origin
git remote add origin https://github.com/YOUR_USERNAME/the-tamga-protocol.git

# Or with SSH:
# git remote add origin git@github.com:YOUR_USERNAME/the-tamga-protocol.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 3: Verify

```bash
git remote -v
# Should show:
# origin  https://github.com/YOUR_USERNAME/the-tamga-protocol.git (fetch)
# origin  https://github.com/YOUR_USERNAME/the-tamga-protocol.git (push)
```

## Repository Information

**Repository Name**: `the-tamga-protocol`
**Current Branch**: `main`
**Current Commit**: `bef46d3` (feat: initial project setup with core systems)

**Topics to Add** (on GitHub):
- `godot`
- `godot-4`
- `game-development`
- `survival-game`
- `visual-novel`
- `pixel-art`
- `1990s`
- `turkey`
- `narrative-game`

## README Badge (Add to README.md later)

```markdown
![Version](https://img.shields.io/badge/version-0.1.0-blue)
![Godot](https://img.shields.io/badge/godot-4.2-blue)
![License](https://img.shields.io/badge/license-MIT-green)
```
