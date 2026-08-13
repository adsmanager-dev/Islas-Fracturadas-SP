---
name: if-mission-consequence
description: Especifica contratos de misión de Islas Fracturadas con éxito, resultado parcial, fracaso, expiración y consecuencias diferidas. Usar al crear o revisar misiones, eventos emergentes y cadenas causales.
---

# Consecuencias de misión

## Fuentes

Leer `docs/08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md`, 15, 16, 17 y las fuentes de facción afectadas.

## Flujo

1. Definir causa, intención, actores, conocimiento, precondiciones y ventana temporal.
2. Especificar objetivos observables sin exponer pesos internos.
3. Modelar éxito, parcial, fracaso, abandono y expiración como resultados válidos.
4. Enumerar cambios de estado, recursos, relaciones, inteligencia y territorio.
5. Programar consecuencias diferidas con origen, condición, idempotencia y fallback.
6. Vincular debriefing, diálogo posterior, guardado/carga y contribuciones de final.

## Salida

Entregar contrato con ID, estados, transiciones, payloads conceptuales, consecuencias, mensajes al jugador, trazabilidad y matriz de pruebas. Mantenerlo como diseño hasta existir evidencia funcional.
