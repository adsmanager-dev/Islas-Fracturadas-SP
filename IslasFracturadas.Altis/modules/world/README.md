# Módulo `WORLD` — contrato M3

Estado: `IMPLEMENTADO_PENDIENTE_VALIDACION_3DEN`.

El módulo posee las raíces persistentes `world`, `regions`, `sectors` y
`connections`. Materializa exactamente nueve sectores del vertical slice sin
crear un sector adicional. `DEC-009` confirma `ALT_W_AGIOS_DIONYSIOS` y
`CONN_M3_NERI_AGIOS` como diseño del enlace interior principal desde Neri;
Neochori conserva sus funciones civiles/logísticas y una ruta alternativa. Los
tres centros observados en Eden están migrados a configuración; seis centros,
nueve radios y cuatro conexiones `PROPUESTA_M3` siguen pendientes.

## API pública

- Command: `IF_fnc_worldInitialize` instala el grafo solo en servidor y no
  reemplaza un estado M3 ya cargado.
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
silenciosa. Profundidades e índices derivados se reconstruyen tras cada carga.

## Límites verificables

Las posiciones o anclas vacías y los radios o distancias `-1` significan
`POR_CALIBRAR`. `VALIDADO_3DEN` en los tres anclajes presentes acredita solo el
centro observado, no el sector completo. El módulo no acredita navegación IA,
escala, cobertura, coste de materialización ni validez geográfica total; esas
pruebas requieren Editor 3DEN, Arma 3 y evidencia RPT.
