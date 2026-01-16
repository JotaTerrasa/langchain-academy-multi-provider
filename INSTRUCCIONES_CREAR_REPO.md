# Instrucciones para crear el repositorio en GitHub

## Paso 1: Crear el repositorio en GitHub

1. Ve a: **https://github.com/new**
2. Asegúrate de estar logueado como **jotaterrasa**
3. Configuración:
   - **Repository name**: `langchain-academy-multi-provider` (o el nombre que prefieras)
   - **Description**: `LangChain Academy with multi-provider LLM support (OpenAI, Cerebras, Gemini)`
   - **Visibility**: Selecciona **Public** ✅
   - **IMPORTANTE**: NO marques ninguna de estas opciones:
     - ❌ Add a README file
     - ❌ Add .gitignore
     - ❌ Choose a license
4. Haz clic en **"Create repository"**

## Paso 2: Conectar y subir el código

Una vez creado el repositorio, ejecuta estos comandos en PowerShell:

```powershell
cd "E:\Dev\Curso Langgraph\langchain-academy"

# Reemplaza 'langchain-academy-multi-provider' con el nombre que elegiste
git remote add origin https://github.com/jotaterrasa/langchain-academy-multi-provider.git

# Sube todas las ramas
git push -u origin main
git push -u origin cerebras
git push -u origin gemini
```

## ¡Listo! 🎉

Tu repositorio estará disponible en:
`https://github.com/jotaterrasa/langchain-academy-multi-provider`
