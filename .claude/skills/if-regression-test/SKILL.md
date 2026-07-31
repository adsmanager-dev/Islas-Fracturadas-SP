---
name: if-regression-test
description: Deriva pruebas de regresión reproducibles a partir de defectos corregidos en Islas Fracturadas. Usar al reparar bugs de SQF, persistencia, misión, narrativa, configuración o comportamiento 3DEN.
---

# Prueba de regresión

## Flujo

1. Capturar reproducción mínima que falle antes de la corrección.
2. Identificar contrato, estado inicial, acción y resultado observable.
3. Elegir el nivel más bajo fiable: estático, función, integración, Arma 3 o 3DEN.
4. Añadir casos límite de localidad, repetición, guardado/carga y fallback pertinentes.
5. Ejecutar contra la corrección y verificar que habría detectado el defecto original.
6. Vincular prueba, defecto, requisito, módulo y versión.

## Salida

Entregar ID de prueba, fixture, pasos, aserciones, resultado, evidencia y cobertura residual. Si no puede automatizarse, producir procedimiento manual repetible sin afirmar ejecución.
