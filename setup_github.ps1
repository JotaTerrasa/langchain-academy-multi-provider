# PowerShell script to help set up the GitHub repository

Write-Host "🚀 Setting up GitHub repository for LangChain Academy with multi-provider support" -ForegroundColor Cyan
Write-Host ""

# Check if gh CLI is installed
try {
    $null = gh --version
} catch {
    Write-Host "❌ GitHub CLI (gh) is not installed." -ForegroundColor Red
    Write-Host "Please install it from: https://cli.github.com/" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Alternatively, you can create the repository manually:" -ForegroundColor Yellow
    Write-Host "1. Go to https://github.com/new" -ForegroundColor Yellow
    Write-Host "2. Create a new public repository" -ForegroundColor Yellow
    Write-Host "3. Run these commands:" -ForegroundColor Yellow
    Write-Host "   git remote add origin https://github.com/jotaterrasa/YOUR_REPO_NAME.git" -ForegroundColor Yellow
    Write-Host "   git push -u origin main" -ForegroundColor Yellow
    Write-Host "   git push -u origin cerebras" -ForegroundColor Yellow
    Write-Host "   git push -u origin gemini" -ForegroundColor Yellow
    exit 1
}

# Check if user is logged in
try {
    $null = gh auth status 2>&1
} catch {
    Write-Host "❌ You are not logged in to GitHub CLI." -ForegroundColor Red
    Write-Host "Please run: gh auth login" -ForegroundColor Yellow
    exit 1
}

# Get repository name
$REPO_NAME = Read-Host "Enter your GitHub repository name (e.g., langchain-academy-multi-provider)"

# Create the repository
Write-Host ""
Write-Host "Creating public repository: $REPO_NAME" -ForegroundColor Cyan
gh repo create "$REPO_NAME" --public --source=. --remote=origin --push

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Repository created successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Pushing all branches..." -ForegroundColor Cyan
    git push -u origin main
    git push -u origin cerebras
    git push -u origin gemini
    Write-Host ""
    Write-Host "🎉 Done! Opening repository in browser..." -ForegroundColor Green
    gh repo view --web
} else {
    Write-Host "❌ Failed to create repository. Please check your GitHub credentials and try again." -ForegroundColor Red
    exit 1
}
