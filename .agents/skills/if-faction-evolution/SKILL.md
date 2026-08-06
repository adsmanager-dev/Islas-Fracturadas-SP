---
name: if-faction-evolution
description: Convierte facciones y actores de Islas Fracturadas en máquinas de estados autónomas con iniciativa, recursos, transiciones y huella de final. Usar al diseñar o revisar evolución de Verde, FIA, Gobierno o actores externos.
---

# Evolución de facciones

## Fuentes

Leer `docs/04_INVADING_FORCES_BLUE_AND_RED.md`, 05, 06, 08, 10, 14 y 16 según la facción.

## Flujo

1. Definir estado inicial, objetivos, recursos, restricciones y conocimiento.
2. Especificar estados nominales, de crisis, ruptura y resolución.
3. Para cada transición, indicar condiciones conjuntas, detonante, consumo y efecto.
4. Añadir iniciativa autónoma y evolución por omisión o expiración del jugador.
5. Definir sustituciones de liderazgo y fallbacks cuando un actor no esté disponible.
6. Trazar efectos territoriales, políticos, militares, narrativos y de final.

## Salida

Entregar tabla de estados y transiciones, eventos emitidos/consumidos, invariantes, casos límite, señales al jugador, pruebas futuras y etiqueta de autoridad. No presentar la máquina como implementada.
