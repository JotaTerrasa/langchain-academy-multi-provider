import subprocess
import sys
import os

os.chdir(os.path.dirname(os.path.abspath(__file__)))

print("=" * 60)
print("HACIENDO PUSH DE CAMBIOS")
print("=" * 60)

try:
    # Verificar estado
    print("\n[1] Verificando estado...")
    result = subprocess.run(["git", "status", "--short"], capture_output=True, text=True, check=True)
    if result.stdout.strip():
        print("Cambios detectados:")
        print(result.stdout)
    else:
        print("No hay cambios en el working directory")
    
    # Rama actual
    branch_result = subprocess.run(["git", "branch", "--show-current"], capture_output=True, text=True, check=True)
    current_branch = branch_result.stdout.strip()
    print(f"\nRama actual: {current_branch}")
    
    # Agregar cambios
    print("\n[2] Agregando cambios...")
    subprocess.run(["git", "add", "-A"], check=True)
    print("    ✓ OK")
    
    # Commit
    print("\n[3] Haciendo commit...")
    commit_msg = "Verificación y actualización del repositorio - todas las ramas operativas"
    subprocess.run(["git", "commit", "-m", commit_msg], check=True)
    print("    ✓ OK")
    
    # Push
    print(f"\n[4] Haciendo push a {current_branch}...")
    subprocess.run(["git", "push", "origin", current_branch], check=True)
    print("    ✓ OK")
    
    print("\n" + "=" * 60)
    print("PROCESO COMPLETADO EXITOSAMENTE")
    print("=" * 60)
    
except subprocess.CalledProcessError as e:
    print(f"\n✗ Error: {e}")
    if e.stderr:
        print(f"   {e.stderr}")
    sys.exit(1)
except Exception as e:
    print(f"\n✗ Error inesperado: {e}")
    sys.exit(1)
