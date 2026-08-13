---
name: if-sqf-module
description: Implementa módulos SQF aprobados de Islas Fracturadas respetando contratos, autoridad, localidad, eventos, persistencia y prefijo IF_. Usar solo cuando el usuario solicite implementación funcional explícita y exista diseño aprobado.
---

# Implementación de módulo SQF

## Precondiciones

- Confirmar autorización de implementación y fuente de verdad en docs 18–19.
- Verificar que el trabajo no exige editar `mission.sqm` manualmente.
- Localizar consumidores con Codebase Memory, símbolos con Serena y SQF/literales con `rg`.

## Flujo

1. Definir propietario de estado y separar comandos, consultas y eventos.
2. Especificar entradas, salidas, errores, localidad, idempotencia y logging.
3. Implementar el cambio mínimo bajo `IslasFracturadas.Altis/` con prefijo `IF_`.
4. Validar entradas y evitar compilación o ejecución dinámica insegura.
5. Añadir pruebas disponibles y fallbacks; preservar preparación SP/servidor.
6. Ejecutar Semgrep, comprobaciones específicas y sincronización documental.

## Salida

Informar archivos, contratos, localidad, pruebas, Semgrep, limitaciones de motor y evidencia. No declarar `PROBADO` sin ejecución repetible.
