#!/bin/bash
# Script to help set up the GitHub repository

echo "🚀 Setting up GitHub repository for LangChain Academy with multi-provider support"
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "Please install it from: https://cli.github.com/"
    echo ""
    echo "Alternatively, you can create the repository manually:"
    echo "1. Go to https://github.com/new"
    echo "2. Create a new public repository"
    echo "3. Run these commands:"
    echo "   git remote add origin https://github.com/jotaterrasa/YOUR_REPO_NAME.git"
    echo "   git push -u origin main"
    echo "   git push -u origin cerebras"
    echo "   git push -u origin gemini"
    exit 1
fi

# Check if user is logged in
if ! gh auth status &> /dev/null; then
    echo "❌ You are not logged in to GitHub CLI."
    echo "Please run: gh auth login"
    exit 1
fi

# Get repository name
read -p "Enter your GitHub repository name (e.g., langchain-academy-multi-provider): " REPO_NAME

# Create the repository
echo ""
echo "Creating public repository: $REPO_NAME"
gh repo create "$REPO_NAME" --public --source=. --remote=origin --push

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Repository created successfully!"
    echo ""
    echo "Pushing all branches..."
    git push -u origin main
    git push -u origin cerebras
    git push -u origin gemini
    echo ""
    echo "🎉 Done! Your repository is available at:"
    gh repo view --web
else
    echo "❌ Failed to create repository. Please check your GitHub credentials and try again."
    exit 1
fi
