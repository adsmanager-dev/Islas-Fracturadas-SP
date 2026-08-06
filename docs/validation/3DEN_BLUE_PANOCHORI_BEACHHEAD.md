# Validación 3DEN — Cabeza de playa Azul en Panochori

> **Estado:** `VALIDACION_3DEN_EN_CURSO`
> **Fecha de registro:** 2026-08-06
> **Fuente:** ejecución manual comunicada por el responsable del proyecto y escenario 3DEN importado sin editar `mission.sqm`.
> **Relacionados:** [decisión `DEC-008`](../19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#registro-autoritativo-de-decisiones); [geografía operacional](../10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md); [validación física](../11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md).

## Escenario de evidencia

`IF_00_Validacion_Cabeza_Playa_Azul.Altis`

El `mission.sqm` binarizado importado desde 3DEN registra el escenario `IF_00_Validacion_Cabeza_Playa_Azul`, los cinco marcadores indicados abajo y objetos de prueba Hunter/HEMTT. No se modificó manualmente.

## Motor probado

Arma 3 2.20.

No se adjuntaron captura, vídeo ni RPT a este registro. La evidencia disponible permite conservar resultados parciales, no declarar validación completa.

## Sector estratégico

`ALT_W_NERI_PANOCHORI`

La cabeza de playa es una subzona operativa del sector existente. No crea un sector territorial número 39.

## Puntos registrados

| Función | Variable | Posición |
| --- | --- | --- |
| Carril occidental | `IF_BLUE_LANDING_ALPHA` | `[4414.902, 10201.400, 0]` |
| Carril principal | `IF_BLUE_LANDING_BRAVO` | `[4527.117, 10163.956, 0]` |
| Carril oriental | `IF_BLUE_LANDING_CHARLIE` | `[4674.484, 10014.150, 0]` |
| Centro candidato FOB | `IF_BLUE_FOB_CANDIDATE` | `[4828.627, 10611.693, 0]` |
| Llegada logística | `IF_BLUE_FOB_LOGISTICS_ENTRY` | `[4878.441, 10518.442, 0]` |

Los valores consumibles por programación se centralizan provisionalmente en [`IslasFracturadas.Altis/config/sectors.hpp`](../../IslasFracturadas.Altis/config/sectors.hpp). Esta tabla conserva la evidencia humana y no constituye una segunda fuente de configuración.

## Pruebas completadas

- El jugador aparece correctamente en terreno firme.
- El Hunter sale de la playa y alcanza la red vial.
- El HEMTT pesado completa el recorrido.
- Hunter y HEMTT funcionan como convoy.
- La IA encuentra una ruta válida sin necesitar puntos en cada curva.
- La entrada logística no coincide con el centro de la FOB.
- Los vehículos se detienen correctamente al finalizar sus órdenes.

## Regla de navegación adoptada

Los waypoints expresan etapas operacionales, no la trayectoria exacta.

La IA de Arma 3 calcula la ruta local. Solo se añaden puntos obligatorios para:

- salida de playa;
- puentes;
- pasos estrechos;
- accesos únicos;
- entrada logística;
- destino operacional.

## Pendientes

- probar tres carriles marítimos;
- probar lanchas con pasajeros;
- probar vehículo anfibio;
- comprobar profundidad y rocas sumergidas;
- validar giro y estacionamiento de varios HEMTT;
- medir observación desde alturas dominantes;
- probar huella física de módulos de la FOB;
- separar combustible, munición, sanidad y mando;
- comprobar impacto sobre viviendas y circulación civil;
- conservar capturas o vídeo y RPT de una repetición documentada.

## Restricción

No declarar `VALIDADO_3DEN` completo hasta cerrar todos los pendientes. La configuración es provisional y no está cargada todavía por `description.ext` ni por un sistema SQF.
