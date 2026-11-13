#!/bin/bash

echo "Iniciando la compilación de los documentos principales..."
echo "----------------------------------------------------"

# Compila solo documentos independientes; los demás .tex son fragmentos incluidos.
for archivo in ./main.tex ./Clases/ActividadesClase0.tex ./Tareas/TareaClase0.tex ./Diapositivas/Clase0_IntroduccionAlGrupoDeEstudio.tex; do
    # Obtiene la carpeta donde está el archivo y el nombre del archivo
    directorio=$(dirname "$archivo")
    nombre_archivo=$(basename "$archivo")
    
    echo "Compilando: $archivo"
    
    # Entra a la carpeta del archivo y ejecuta latexmk -pdf una sola vez
    # -interaction=nonstopmode evita que se congele si hay un error de sintaxis en algún archivo
    (cd "$directorio" && latexmk -pdf -interaction=nonstopmode "$nombre_archivo" > /dev/null 2>&1)
    
    # Verifica si la compilación fue exitosa o si hubo algún error
    if [ $? -eq 0 ]; then
        echo "  [OK] PDF generado correctamente."
    else
        echo "  [ERROR] Hubo un problema compilando $archivo (revisa su archivo .log)."
    fi
done

echo "----------------------------------------------------"
echo "¡Proceso terminado!"
