#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Uso: $0 <directorio_origen> <directorio_destino>"
  exit 1
fi

ORIGEN="$1"
DESTINO="$2"
LOG="movimientos.log"

if [ ! -d "$ORIGEN" ]; then
  echo "El directorio de origen no existe."
  exit 1
fi

if [ ! -d "$DESTINO" ]; then
  echo "El directorio de destino no existe, creándolo..."
  mkdir -p "$DESTINO"
fi

archivos_txt=$(find "$ORIGEN" -maxdepth 1 -type f -name "*.txt")

if [ -z "$archivos_txt" ]; then
  echo "No se encontraron archivos .txt en '$ORIGEN'"
else
  echo "Moviendo archivos..."

  echo "----" >> "$LOG"
  echo "Fecha: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG"
  echo "Origen: $ORIGEN" >> "$LOG"
  echo "Destino: $DESTINO" >> "$LOG"
  echo "Archivos movidos:" >> "$LOG"

  contador=0

  find "$ORIGEN" -maxdepth 1 -type f -name "*.txt" | while read -r archivo; do
    nombre=$(basename "$archivo")
    if mv "$archivo" "$DESTINO"; then
      echo "$nombre" >> "$LOG"
      ((contador++))
    fi
  done

  echo "$contador archivos movidos correctamente."
  echo "INFO en $LOG."
fi
