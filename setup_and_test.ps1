# Script para configurar entorno virtual, instalar dependencias y probar
Write-Host "=" * 50
Write-Host "CONFIGURACION Y PRUEBA DE LANGCHAIN ACADEMY"
Write-Host "=" * 50

# 1. Crear entorno virtual
Write-Host "`n[1] Creando entorno virtual..."
if (Test-Path "lc-academy-env") {
    Write-Host "    Entorno ya existe, eliminando..."
    Remove-Item -Recurse -Force "lc-academy-env"
}
python -m venv lc-academy-env
Write-Host "    OK - Entorno virtual creado"

# 2. Activar entorno virtual
Write-Host "`n[2] Activando entorno virtual..."
& ".\lc-academy-env\Scripts\Activate.ps1"
Write-Host "    OK - Entorno activado"

# 3. Instalar dependencias
Write-Host "`n[3] Instalando dependencias..."
pip install --upgrade pip
pip install -r requirements.txt
Write-Host "    OK - Dependencias instaladas"

# 4. Configurar variables de entorno
Write-Host "`n[4] Configurando variables de entorno..."

# Cargar .env si existe
if (Test-Path ".env") {
    Get-Content ".env" | ForEach-Object {
        if ($_ -match "^\s*#") { return }
        if ($_ -match "^\s*$") { return }
        $parts = $_.Split("=", 2)
        if ($parts.Length -eq 2) {
            $key = $parts[0].Trim()
            $val = $parts[1].Trim()
            $env:$key = $val
        }
    }
}

if (-not $env:LLM_PROVIDER) {
    $env:LLM_PROVIDER = "gemini"
}

# Aceptar GEMINI_API_KEY como alias
if (-not $env:GOOGLE_API_KEY -and $env:GEMINI_API_KEY) {
    $env:GOOGLE_API_KEY = $env:GEMINI_API_KEY
}

Write-Host "    OK - Variables configuradas (LLM_PROVIDER=$env:LLM_PROVIDER)"

# 5. Ejecutar prueba
Write-Host "`n[5] Ejecutando prueba..."
python test_llm.py

Write-Host "`n" + "=" * 50
Write-Host "PROCESO COMPLETADO"
Write-Host "=" * 50
