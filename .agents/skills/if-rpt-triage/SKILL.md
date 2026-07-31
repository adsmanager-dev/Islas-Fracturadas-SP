---
name: if-rpt-triage
description: Analiza RPT de Arma 3 para errores, warnings, stack traces, configuración e inicialización de Islas Fracturadas. Usar ante fallos reproducibles, arranques sucios o regresiones observadas en el motor.
---

# Triaje de RPT

## Entradas

Solicitar RPT completo o ventana suficiente, versión, escenario, pasos, mods, hora del fallo y resultado esperado.

## Flujo

1. Preservar el archivo original y localizar el primer error causal.
2. Agrupar repeticiones sin ocultar frecuencia ni orden temporal.
3. Separar errores del proyecto, motor, mods y síntomas secundarios.
4. Correlacionar función, archivo, línea, inicialización y acción del usuario.
5. Formular hipótesis con evidencia y comprobación discriminante.
6. Proponer reproducción mínima y regresión; no corregir sin autorización.

## Salida

Entregar resumen, causa probable con confianza, errores primarios/secundarios, ubicación, reproducción, siguiente comprobación y evidencia faltante. No declarar resuelto sin un RPT posterior limpio para el caso.
