---
name: if-documentation-sync
description: Sincroniza documentación de Islas Fracturadas después de cambios funcionales, narrativos o estructurales sin exagerar el estado real. Usar al cerrar tareas que alteren contratos, responsabilidades, nombres, pruebas, hitos o canon.
---

# Sincronización documental

## Entradas

- Inspeccionar `git diff` y `git status --short`.
- Leer el índice, la fuente temática, arquitectura 18 y estado 19 cuando corresponda.

## Flujo

1. Mapear cada cambio a requisito, fuente, módulo, prueba y versión.
2. Actualizar la fuente principal y reducir duplicación contextual.
3. Corregir enlaces, anclas, nombres, responsabilidades y trazabilidad.
4. Conservar etiquetas de canon, propuesta, pendiente y nivel de conocimiento.
5. Actualizar estado solo con evidencia: artefacto, ejecución, RPT, 3DEN o gate.
6. Mantener `docs/` en un máximo de 20 documentos.

## Salida

Informar documentos revisados, cambios aplicados, enlaces validados, estados preservados, evidencia disponible y pendientes manuales. Ejecutar `git diff --check` y el conteo documental.
