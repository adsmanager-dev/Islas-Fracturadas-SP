# Módulo `WORLD` — contrato M3

Estado: `IMPLEMENTADO_PENDIENTE_VALIDACION_3DEN`.

El módulo posee las raíces persistentes `world`, `regions`, `sectors` y
`connections`. Materializa exactamente nueve sectores del vertical slice sin
crear un sector adicional. `DEC-009` confirma `ALT_W_AGIOS_DIONYSIOS` y
`CONN_M3_NERI_AGIOS` como diseño del enlace interior principal desde Neri;
Neochori conserva sus funciones civiles/logísticas y una ruta alternativa. Los
nueve centros guardados en Eden están migrados a configuración; los seis de la
pasada 2 conservan `VALIDACION_3DEN_EN_CURSO`. Nueve radios y cuatro conexiones
`PROPUESTA_M3` siguen pendientes.

## API pública

- Command: `IF_fnc_worldInitialize` instala el grafo solo en servidor y no
  reemplaza un estado M3 ya cargado; si encuentra un mundo completo, lo valida
  y ejecuta la reconciliación física aditiva.
- Command: `IF_fnc_worldReconcilePhysicalMetadata` completa desde `IF_config`
  solo `positionATL`, `flags.anchorPositionATL` vacíos y las transiciones
  seguras de `flags.anchorStatus`/`flags.validationStatus` desde
  `POR_CALIBRAR` a `VALIDACION_3DEN_EN_CURSO`. Devuelve
  `[success, changed, changes, reason]`.
- Command: `IF_fnc_worldCommandSetSectorOwner` cambia únicamente
  `militaryOwner` dentro de una transacción y publica el evento de dominio.
- Query: `IF_fnc_worldQueryGetSector` devuelve una copia del sector.
- Query: `IF_fnc_worldQueryGetNeighbors` devuelve pares sector/conexión.
- Query: `IF_fnc_worldQueryFindPath` recorre conexiones lógicas no bloqueadas.
- Query: `IF_fnc_worldQueryCalculateDepth` calcula profundidad por BFS sin
  persistir el dato derivado.
- Validación: `IF_fnc_worldValidate` comprueba IDs, referencias, tipos,
  membresía regional, simetría sector-conexión y conectividad del grafo.
- Diagnóstico: `IF_fnc_worldDiagnosticsReport` expone estado, propietario,
  profundidad y pendientes de anclaje en el RPT.

## Evento de dominio

`IF_EVENT_SECTOR_MILITARY_OWNER_CHANGED` versión 1:

- productor: `WORLD` / `IF_fnc_worldCommandSetSectorOwner`;
- autoridad: servidor;
- persistencia: sí;
- payload: `sectorId`, `oldOwner`, `newOwner`, `commandId`;
- consumidores obligatorios en M3: ninguno;
- idempotencia: un command que solicita el propietario ya instalado no publica
  otro evento; si hay `commandId`, este deriva un `eventId` estable.

## Persistencia y compatibilidad

El formato continúa en `schemaVersion = 1`: M2 ya reservaba las cuatro raíces.
Un save M2 con las cuatro raíces vacías recibe los defaults M3 al arrancar. Un
estado parcial o un grafo no válido se rechaza y nunca se sobrescribe de forma
silenciosa. Un save M3 anterior, cuyo grafo ya existe pero conserva posiciones
físicas vacías, se reconcilia dentro de una transacción sin reconstruir sectores
ni reemplazar las raíces. Una posición persistida válida de tres componentes
siempre prevalece sobre la configuración.

La reconciliación prepara todos los cambios, valida antes y después de
aplicarlos, revierte ante fallo y registra una sola entrada
`PHYSICAL_METADATA_RECONCILIATION` en `meta.migrationHistory` cuando existe un
cambio real. La auditoría conserva tipo, sectores, campos y cantidad. Una
segunda ejecución devuelve `success = true`, `changed = false` y no escribe
otra entrada. Las raíces parciales se rechazan antes de abrir la transacción.

No puede modificar propietario/control militar, guarnición, fuerzas,
preparación, moral, recursos, suministro, producción, daño, niveles
estructurales o de fortificación, relaciones, influencia, misiones, eventos,
logística, actividad ni estado político. Profundidades e índices derivados se
reconstruyen tras cada carga.

## Límites verificables

Las posiciones o anclas vacías y los radios o distancias `-1` significan
`POR_CALIBRAR`. Los nueve centros tienen posición; `VALIDADO_3DEN` en los tres
anclajes de la pasada 1 acredita solo el centro observado. Los seis restantes
están colocados con `VALIDACION_3DEN_EN_CURSO`, pero pendientes de validación
física completa. El diagnóstico separa `9/0` colocados/pendientes de colocación
de `3/6` validados/pendientes de validación. Los nueve radios permanecen
`POR_CALIBRAR`. El módulo no
acredita navegación IA, escala, cobertura, coste de materialización ni validez
geográfica total; esas pruebas requieren Editor 3DEN, Arma 3 y evidencia RPT.
