---
name: if-sqf-review
description: Revisa SQF de Islas Fracturadas por corrección, localidad, autoridad, rendimiento, estado global, remoteExec, validación, naming y pruebas. Usar en revisiones explícitas o antes de cerrar trabajo técnico.
---

# Revisión SQF

## Flujo

1. Leer contratos y arquitectura en docs 18–19.
2. Trazar productores, consumidores y llamadas con Codebase Memory; buscar SQF y configuración con `rg`.
3. Revisar autoridad, localidad, JIP futuro, idempotencia y propiedad del estado.
4. Revisar validación de payloads, `remoteExec`, ejecución dinámica, secretos y límites de confianza.
5. Revisar loops, frecuencia, asignaciones, materialización, logging y manejo de errores.
6. Comprobar pruebas y ejecutar Semgrep cuando corresponda.

## Salida

Ordenar hallazgos por gravedad. Para cada uno incluir ubicación exacta, impacto, evidencia, corrección recomendada y prueba faltante. Separar defectos confirmados de riesgos y no editar salvo petición expresa.
