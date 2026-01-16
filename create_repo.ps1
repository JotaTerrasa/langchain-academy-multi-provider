# Script para crear el repositorio en GitHub usando la API
param(
    [string]$RepoName = "langchain-academy-multi-provider",
    [string]$GitHubToken = ""
)

Write-Host "🚀 Creando repositorio en GitHub para jotaterrasa" -ForegroundColor Cyan
Write-Host ""

# Si no se proporciona token, pedirlo
if ([string]::IsNullOrEmpty($GitHubToken)) {
    Write-Host "Necesitas un Personal Access Token (PAT) de GitHub." -ForegroundColor Yellow
    Write-Host "Si no tienes uno, créalo en: https://github.com/settings/tokens" -ForegroundColor Yellow
    Write-Host "Necesitas el permiso 'repo' para crear repositorios." -ForegroundColor Yellow
    Write-Host ""
    $GitHubToken = Read-Host "Ingresa tu GitHub Personal Access Token (o presiona Enter para crear manualmente)"
    
    if ([string]::IsNullOrEmpty($GitHubToken)) {
        Write-Host ""
        Write-Host "⚠️  No se proporcionó token. Creando repositorio manualmente..." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Por favor:" -ForegroundColor Yellow
        Write-Host "1. Ve a https://github.com/new" -ForegroundColor Yellow
        Write-Host "2. Nombre del repositorio: $RepoName" -ForegroundColor Yellow
        Write-Host "3. Selecciona 'Public'" -ForegroundColor Yellow
        Write-Host "4. NO marques 'Add a README file'" -ForegroundColor Yellow
        Write-Host "5. Haz clic en 'Create repository'" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Luego ejecuta estos comandos:" -ForegroundColor Cyan
        Write-Host "  git remote add origin https://github.com/jotaterrasa/$RepoName.git" -ForegroundColor White
        Write-Host "  git push -u origin main" -ForegroundColor White
        Write-Host "  git push -u origin cerebras" -ForegroundColor White
        Write-Host "  git push -u origin gemini" -ForegroundColor White
        exit 0
    }
}

# Crear el repositorio usando la API de GitHub
$headers = @{
    "Authorization" = "token $GitHubToken"
    "Accept" = "application/vnd.github.v3+json"
}

$body = @{
    name = $RepoName
    description = "LangChain Academy with multi-provider LLM support (OpenAI, Cerebras, Gemini)"
    private = $false
} | ConvertTo-Json

try {
    Write-Host "Creando repositorio: $RepoName" -ForegroundColor Cyan
    $response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $body -ContentType "application/json"
    
    Write-Host ""
    Write-Host "✅ Repositorio creado exitosamente!" -ForegroundColor Green
    Write-Host "   URL: $($response.html_url)" -ForegroundColor Cyan
    Write-Host ""
    
    # Agregar el remote y hacer push
    Write-Host "Configurando remote y subiendo código..." -ForegroundColor Cyan
    
    # Verificar si ya existe el remote
    $existingRemote = git remote get-url origin 2>$null
    if ($existingRemote) {
        Write-Host "⚠️  Ya existe un remote 'origin'. ¿Deseas reemplazarlo? (S/N)" -ForegroundColor Yellow
        $replace = Read-Host
        if ($replace -eq "S" -or $replace -eq "s") {
            git remote remove origin
        } else {
            Write-Host "❌ Operación cancelada." -ForegroundColor Red
            exit 1
        }
    }
    
    git remote add origin $response.clone_url
    Write-Host "✅ Remote agregado" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "Subiendo ramas..." -ForegroundColor Cyan
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Rama 'main' subida" -ForegroundColor Green
    }
    
    git push -u origin cerebras
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Rama 'cerebras' subida" -ForegroundColor Green
    }
    
    git push -u origin gemini
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Rama 'gemini' subida" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "🎉 ¡Todo listo! Repositorio disponible en:" -ForegroundColor Green
    Write-Host "   $($response.html_url)" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Abre el repositorio en el navegador? (S/N)" -ForegroundColor Yellow
    $open = Read-Host
    if ($open -eq "S" -or $open -eq "s") {
        Start-Process $response.html_url
    }
    
} catch {
    Write-Host ""
    Write-Host "❌ Error al crear el repositorio:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Write-Host "Verifica:" -ForegroundColor Yellow
    Write-Host "1. Que el token tenga permisos 'repo'" -ForegroundColor Yellow
    Write-Host "2. Que el nombre del repositorio no esté ya en uso" -ForegroundColor Yellow
    Write-Host "3. Que estés autenticado como 'jotaterrasa'" -ForegroundColor Yellow
    exit 1
}
