---
name: if-task-intake
description: Clasifica encargos de Islas Fracturadas, localiza fuentes de verdad, delimita alcance y define aceptación. Usar al iniciar tareas ambiguas, extensas, documentales, narrativas, técnicas, 3DEN, de validación o de entrega.
---

# Recepción de tareas

## Entradas

- Recibir la solicitud, archivos señalados y restricciones.
- Leer `AGENTS.md`, `docs/00_INDEX_AND_DOCUMENTATION_MAP.md` y la fuente temática.
- Revisar `git status --short` y conservar cambios preexistentes.

## Flujo

1. Clasificar como `DOC_REVIEW`, `DOC_CHANGE`, `CANON_CHANGE`, `DESIGN_CHANGE`, `IMPLEMENTATION`, `THREEDEN_WORK`, `VALIDATION` o `RELEASE_GATE`.
2. Separar lo pedido de ampliaciones no autorizadas.
3. Comprobar el estado real antes de asumir artefactos o pruebas.
4. Localizar dependencias con Codebase Memory; usar Serena para símbolos y `rg` para SQF, literales y configuración.
5. Enumerar criterios verificables, validaciones aplicables y acciones manuales.
6. Detener cambios de canon incompatibles para decisión humana.

## Salida

Entregar clasificación, alcance, fuentes, artefactos afectados, criterios de aceptación, riesgos y validaciones. No convertir diseño o carpetas vacías en implementación.
