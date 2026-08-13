---
name: if-event-contract
description: Crea o modifica contratos de eventos de Islas Fracturadas y sus payloads sin acoplar módulos. Usar para integración entre dominios, cambios de esquema de evento o revisión de productores y consumidores.
---

# Contratos de eventos

## Fuentes

Leer arquitectura 18, estado 19 y las fuentes temáticas de los módulos participantes.

## Flujo

1. Nombrar el evento con prefijo `IF_` y describir hecho pasado, no orden encubierta.
2. Definir productor, consumidores, localidad, orden, cardinalidad y versión.
3. Especificar payload mínimo, tipos, IDs, campos opcionales, defaults y validación.
4. Definir idempotencia, reintentos, errores, observabilidad y compatibilidad.
5. Evitar que consumidores muten estado ajeno o dependan de orden accidental.
6. Trazar migración y pruebas de contrato si el evento ya existe.

## Salida

Entregar contrato, ejemplos válidos/inválidos, invariantes, matriz productor-consumidor, estrategia de compatibilidad y pruebas. No implementar sin autorización explícita.
