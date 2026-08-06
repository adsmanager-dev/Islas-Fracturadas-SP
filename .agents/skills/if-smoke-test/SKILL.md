---
name: if-smoke-test
description: Define y ejecuta el conjunto mínimo de validaciones disponible para un hito de Islas Fracturadas. Usar tras cambios funcionales, de configuración o integración y antes de una puerta de entrega.
---

# Prueba de humo

## Flujo

1. Leer criterios del hito en doc 19 y seleccionar solo funciones afectadas.
2. Comprobar archivos, configuración, registro de funciones, bootstrap y logging aplicables.
3. Ejecutar validaciones estáticas y Semgrep tras cambios de código.
4. Preparar pasos de Arma 3/3DEN para lo que no pueda automatizarse.
5. Registrar entorno, versión, fixture, esperado, real y evidencia.
6. Fallar ante error crítico, función ausente o evidencia obligatoria inexistente.

## Salida

Entregar matriz `PASS`/`FAIL`/`BLOCKED`/`NOT_RUN`, comandos, evidencias y bloqueadores. `NOT_RUN` o `BLOCKED` nunca equivalen a aprobado.
