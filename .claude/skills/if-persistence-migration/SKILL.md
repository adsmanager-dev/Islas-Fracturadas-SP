---
name: if-persistence-migration
description: Diseña, implementa o revisa migraciones del estado persistente de Islas Fracturadas con versión, defaults, validación, compatibilidad y recuperación. Usar al cambiar esquemas de guardado o cargar versiones anteriores.
---

# Migración de persistencia

## Precondiciones

Leer docs 18–19, identificar versión origen/destino y exigir fixtures o muestras anonimizadas cuando existan.

## Flujo

1. Inventariar campos añadidos, eliminados, renombrados y reinterpretados.
2. Definir defaults deterministas e invariantes antes y después.
3. Diseñar migraciones secuenciales, idempotentes y sin saltos implícitos.
4. Validar envelope, versión, IDs, referencias y datos corruptos antes de mutar.
5. Preservar copia recuperable y estrategia de fallo/rollback.
6. Probar carga antigua, migración, nueva carga, repetición, corrupción y ramas opcionales.

## Salida

Entregar matriz de cambios, algoritmo, compatibilidad, riesgos, fixtures y resultados. No declarar compatibilidad de saves sin pruebas reales conservadas.
