@echo off
cd /d "%~dp0"
echo ============================================================
echo HACIENDO PUSH DE CAMBIOS
echo ============================================================
echo.

echo [1] Verificando estado...
git status --short
echo.

echo [2] Agregando cambios al staging...
git add -A
if %ERRORLEVEL% EQU 0 (
    echo     OK - Cambios agregados
) else (
    echo     ERROR al agregar cambios
    pause
    exit /b 1
)
echo.

echo [3] Verificando cambios para commit...
git diff --cached --quiet
if %ERRORLEVEL% NEQ 0 (
    echo [4] Haciendo commit...
    git commit -m "Verificación y actualización del repositorio - todas las ramas operativas"
    if %ERRORLEVEL% EQU 0 (
        echo     OK - Commit realizado
    ) else (
        echo     ERROR al hacer commit
        pause
        exit /b 1
    )
) else (
    echo [3] No hay cambios nuevos para commitear
)
echo.

echo [5] Obteniendo rama actual...
for /f "tokens=*" %%i in ('git branch --show-current') do set CURRENT_BRANCH=%%i
echo     Rama actual: %CURRENT_BRANCH%
echo.

echo [6] Haciendo push a %CURRENT_BRANCH%...
git push origin %CURRENT_BRANCH%
if %ERRORLEVEL% EQU 0 (
    echo     OK - Push completado
) else (
    echo     ERROR al hacer push
    pause
    exit /b 1
)
echo.

echo ============================================================
echo PROCESO COMPLETADO
echo ============================================================
pause
