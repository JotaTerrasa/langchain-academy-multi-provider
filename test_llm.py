"""
Script de prueba para verificar que llm_factory funciona correctamente.
Ejecutar desde la raíz del repositorio:
    python test_llm.py
"""

import os
import sys


def _ensure_env():
    """Ensure provider + API key exist in environment."""
    provider = os.getenv("LLM_PROVIDER", "gemini").lower()
    os.environ["LLM_PROVIDER"] = provider

    if provider == "gemini":
        # Support GEMINI_API_KEY alias for convenience.
        if not os.getenv("GOOGLE_API_KEY") and os.getenv("GEMINI_API_KEY"):
            os.environ["GOOGLE_API_KEY"] = os.getenv("GEMINI_API_KEY")
        if not os.getenv("GOOGLE_API_KEY"):
            raise RuntimeError("GOOGLE_API_KEY is required for Gemini.")
    elif provider == "cerebras":
        if not os.getenv("CEREBRAS_API_KEY"):
            raise RuntimeError("CEREBRAS_API_KEY is required for Cerebras.")
    else:
        raise RuntimeError("LLM_PROVIDER must be 'cerebras' or 'gemini'.")


_ensure_env()

print("=" * 50)
print("TEST: Verificando llm_factory")
print("=" * 50)

# Test 1: Import
print("\n[1] Probando import...")
try:
    from llm_factory import get_llm
    print("    ✓ Import OK!")
except ImportError as e:
    print(f"    ✗ Error en import: {e}")
    sys.exit(1)

# Test 2: Crear LLM
print("\n[2] Creando instancia de LLM...")
try:
    llm = get_llm()
    print(f"    ✓ LLM creado: {type(llm).__name__}")
except Exception as e:
    print(f"    ✗ Error creando LLM: {e}")
    sys.exit(1)

# Test 3: Invocar LLM
print("\n[3] Probando invocación...")
try:
    response = llm.invoke("Di 'Hola, funciono correctamente!' en español")
    print(f"    ✓ Respuesta: {response.content}")
except Exception as e:
    print(f"    ✗ Error en invocación: {e}")
    sys.exit(1)

print("\n" + "=" * 50)
print("¡TODOS LOS TESTS PASARON! ✓")
print("=" * 50)
