---
name: if-config-review
description: Revisa description.ext, CfgFunctions, CfgRemoteExec, CfgSounds y configuración relacionada de Islas Fracturadas. Usar para auditorías de carga, exposición remota, rutas, nombres, duplicados y compatibilidad.
---

# Revisión de configuración

## Flujo

1. Leer arquitectura 18 y el estado real en 19.
2. Buscar clases, macros, rutas y literales con `rg`; localizar consumidores.
3. Revisar sintaxis, herencia, duplicados, mayúsculas, rutas y orden de inicialización.
4. Verificar `CfgFunctions` contra archivos reales y contratos `preInit`/`postInit`.
5. Aplicar mínimo privilegio a `CfgRemoteExec`, targets, JIP y validación del receptor.
6. Revisar sonidos/UI y fallbacks sin asumir assets ausentes.
7. Ejecutar Semgrep y pruebas de carga disponibles.

## Salida

Entregar hallazgos priorizados con ubicación, impacto, corrección y validación necesaria en Arma 3. No confundir revisión estática con carga exitosa del motor.
