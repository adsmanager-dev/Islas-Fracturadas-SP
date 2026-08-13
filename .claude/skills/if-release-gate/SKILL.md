---
name: if-release-gate
description: Evalúa una fase, hito o entrega de Islas Fracturadas contra criterios, pruebas, evidencia y bloqueadores. Usar para DOC-GATE, M0–M21, vertical slices, beta o lanzamiento.
---

# Puerta de entrega

## Flujo

1. Leer el gate autoritativo y su alcance en doc 19.
2. Inventariar criterios obligatorios y evidencia aceptable para cada uno.
3. Verificar artefactos, pruebas, RPT, 3DEN, rendimiento, documentación y defectos.
4. Rechazar evidencia indirecta: ejemplos, pseudocódigo, checklists vacíos o carpetas.
5. Clasificar cada criterio como aprobado, fallido, bloqueado o no ejecutado.
6. Identificar bloqueadores, propietario, acción y evidencia necesaria.

## Salida

Emitir decisión `APROBADO` o `NO APROBADO`, matriz criterio-evidencia, defectos críticos, riesgos aceptados y pendientes. No aprobar parcialmente una puerta indivisible ni sustituir pruebas de motor con revisión estática.
