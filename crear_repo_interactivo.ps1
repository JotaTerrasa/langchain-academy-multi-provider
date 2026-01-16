# Script para crear repositorio en GitHub con autenticación interactiva
param(
    [string]$RepoName = "langchain-academy-multi-provider"
)

Write-Host "🚀 Creando repositorio en GitHub para jotaterrasa" -ForegroundColor Cyan
Write-Host ""

# Intentar usar GitHub CLI si está disponible
$ghAvailable = $false
try {
    $null = gh --version 2>$null
    $ghAvailable = $true
} catch {
    $ghAvailable = $false
}

if ($ghAvailable) {
    Write-Host "✅ GitHub CLI detectado" -ForegroundColor Green
    Write-Host ""
    
    # Verificar autenticación
    $authStatus = gh auth status 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "⚠️  No estás autenticado en GitHub CLI" -ForegroundColor Yellow
        Write-Host "Abriendo proceso de autenticación..." -ForegroundColor Cyan
        gh auth login --web
        Start-Sleep -Seconds 2
    }
    
    Write-Host "Creando repositorio: $RepoName" -ForegroundColor Cyan
    gh repo create $RepoName --public --description "LangChain Academy with multi-provider LLM support (OpenAI, Cerebras, Gemini)" --source=. --remote=origin --push
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Repositorio creado exitosamente!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Subiendo todas las ramas..." -ForegroundColor Cyan
        git push -u origin cerebras
        git push -u origin gemini
        Write-Host ""
        Write-Host "🎉 ¡Todo listo!" -ForegroundColor Green
        gh repo view --web
    } else {
        Write-Host "❌ Error al crear el repositorio" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "⚠️  GitHub CLI no está instalado" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Instalando GitHub CLI..." -ForegroundColor Cyan
    Write-Host "Por favor, sigue las instrucciones en: https://cli.github.com/" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "O crea el repositorio manualmente:" -ForegroundColor Yellow
    Write-Host "1. Ve a https://github.com/new" -ForegroundColor White
    Write-Host "2. Nombre: $RepoName" -ForegroundColor White
    Write-Host "3. Public" -ForegroundColor White
    Write-Host "4. NO marques 'Add a README'" -ForegroundColor White
    Write-Host "5. Crea el repositorio" -ForegroundColor White
    Write-Host ""
    Write-Host "Luego ejecuta:" -ForegroundColor Cyan
    Write-Host "  .\subir_a_github.ps1 -RepoName `"$RepoName`"" -ForegroundColor White
}
