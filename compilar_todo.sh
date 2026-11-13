#!/bin/bash

echo "Iniciando la compilación de todos los archivos .tex..."
echo "----------------------------------------------------"

# Busca recursivamente todos los archivos terminados en .tex
find . -type f -name "*.tex" | while read -r archivo; do
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
