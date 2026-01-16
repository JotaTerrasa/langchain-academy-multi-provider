# Setup Instructions for GitHub Repository

This guide will help you create and push your repository to GitHub.

## Prerequisites

- Git installed and configured
- GitHub account
- (Optional) GitHub CLI (`gh`) installed for easier setup

## Option 1: Using GitHub CLI (Recommended)

If you have GitHub CLI installed:

### Windows (PowerShell):
```powershell
.\setup_github.ps1
```

### Mac/Linux:
```bash
chmod +x setup_github.sh
./setup_github.sh
```

The script will:
1. Check if GitHub CLI is installed
2. Prompt you for a repository name
3. Create a public repository on GitHub
4. Push all branches (main, cerebras, gemini)

## Option 2: Manual Setup

### Step 1: Create Repository on GitHub

1. Go to [https://github.com/new](https://github.com/new)
2. Repository name: Choose a name (e.g., `langchain-academy-multi-provider`)
3. Description: "LangChain Academy with multi-provider LLM support (OpenAI, Cerebras, Gemini)"
4. Set to **Public**
5. **DO NOT** initialize with README, .gitignore, or license (we already have these)
6. Click "Create repository"

### Step 2: Connect and Push

Run these commands in your terminal:

```bash
# Add your GitHub repository as remote
# Replace YOUR_REPO_NAME with your chosen repository name
git remote add origin https://github.com/jotaterrasa/YOUR_REPO_NAME.git

# Push main branch
git push -u origin main

# Push cerebras branch
git push -u origin cerebras

# Push gemini branch
git push -u origin gemini
```

Replace:
- `YOUR_USERNAME` with your GitHub username
- `YOUR_REPO_NAME` with the repository name you chose

## Verify

After pushing, verify all branches are on GitHub:

```bash
git remote show origin
```

You should see all three branches listed.

## Repository Structure

Your repository now has:
- **main**: Default branch with OpenAI support
- **cerebras**: Branch configured for Cerebras provider
- **gemini**: Branch configured for Gemini provider

All branches contain the same code, but you can configure each branch differently by setting the `LLM_PROVIDER` environment variable or modifying the default provider in `llm_factory.py`.
