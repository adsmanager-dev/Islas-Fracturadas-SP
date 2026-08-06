---
name: if-performance-budget
description: Define y revisa presupuestos de rendimiento de Islas Fracturadas para loops, materialización, grupos, objetos, scheduler, guardado y red. Usar al diseñar sistemas costosos o analizar mediciones de Arma 3/RPT.
---

# Presupuesto de rendimiento

## Flujo

1. Definir escenario, hardware, versión, duración y métricas comparables.
2. Identificar loops, frecuencias, tamaños máximos, materialización y tráfico.
3. Asignar presupuesto por sistema sin inventar umbrales no medidos.
4. Proponer instrumentación, baseline y perfil representativo/peor caso.
5. Comparar mediciones repetidas y aislar variable modificada.
6. Recomendar degradación elegante, virtualización o límites configurables.

## Salida

Entregar tabla de presupuesto, supuestos, puntos de instrumentación, datos reales, desviaciones, cuello de botella probable y experimento siguiente. Etiquetar cifras sin medir como hipótesis.
