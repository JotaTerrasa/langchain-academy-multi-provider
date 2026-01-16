# Script para subir el código a GitHub después de crear el repositorio
param(
    [Parameter(Mandatory=$true)]
    [string]$RepoName
)

Write-Host "🚀 Subiendo código a GitHub (jotaterrasa/$RepoName)" -ForegroundColor Cyan
Write-Host ""

# Verificar si ya existe el remote
$existingRemote = git remote get-url origin 2>$null
if ($existingRemote) {
    Write-Host "⚠️  Ya existe un remote 'origin': $existingRemote" -ForegroundColor Yellow
    Write-Host "¿Deseas reemplazarlo? (S/N)" -ForegroundColor Yellow
    $replace = Read-Host
    if ($replace -eq "S" -or $replace -eq "s") {
        git remote remove origin
        Write-Host "✅ Remote anterior eliminado" -ForegroundColor Green
    } else {
        Write-Host "❌ Operación cancelada." -ForegroundColor Red
        exit 1
    }
}

# Agregar el remote
$repoUrl = "https://github.com/jotaterrasa/$RepoName.git"
Write-Host "Agregando remote: $repoUrl" -ForegroundColor Cyan
git remote add origin $repoUrl

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Remote agregado correctamente" -ForegroundColor Green
} else {
    Write-Host "❌ Error al agregar remote" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Subiendo ramas..." -ForegroundColor Cyan
Write-Host ""

# Subir main
Write-Host "📤 Subiendo rama 'main'..." -ForegroundColor Yellow
git push -u origin main
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Rama 'main' subida correctamente" -ForegroundColor Green
} else {
    Write-Host "❌ Error al subir rama 'main'" -ForegroundColor Red
}

Write-Host ""
Write-Host "📤 Subiendo rama 'cerebras'..." -ForegroundColor Yellow
git push -u origin cerebras
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Rama 'cerebras' subida correctamente" -ForegroundColor Green
} else {
    Write-Host "❌ Error al subir rama 'cerebras'" -ForegroundColor Red
}

Write-Host ""
Write-Host "📤 Subiendo rama 'gemini'..." -ForegroundColor Yellow
git push -u origin gemini
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Rama 'gemini' subida correctamente" -ForegroundColor Green
} else {
    Write-Host "❌ Error al subir rama 'gemini'" -ForegroundColor Red
}

Write-Host ""
Write-Host "🎉 ¡Proceso completado!" -ForegroundColor Green
Write-Host ""
Write-Host "Tu repositorio está disponible en:" -ForegroundColor Cyan
Write-Host "https://github.com/jotaterrasa/$RepoName" -ForegroundColor White
Write-Host ""
