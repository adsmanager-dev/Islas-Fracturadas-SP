# Evidencia M3 — Physical Validation Pass 3B

> **Subfase:** validación de rutas y convoyes
> **Fecha de apertura:** 2026-08-11
> **Estado del gate Pass 3B:** `PENDIENTE_EJECUCION_MANUAL`
> **Estado de M3:** implementación técnica `PROBADA`; `M3 NO APROBADO`
> **Alcance actual:** paquete reproducible para validar las nueve conexiones M3 y sus dieciocho sentidos candidatos
> **No acredita:** ninguna ruta, transición, dirección, tiempo, capacidad, convoy, navegación IA, tráfico, bound o alternativa como `VALIDADO_3DEN`

## 1. Objetivo y límites

Pass 3A está aprobado y conserva la topología estratégica de nueve conexiones. Esta
pasada debe demostrar físicamente, para cada sentido aplicable:

```text
sector A → transición de salida → ruta física → transición de entrada → sector B
```

La prueba se detiene al cerrar Pass 3B. No inicia Pass 3C ni M4, no expande el
alcance a los 38 sectores y no modifica topología estratégica por inferencia. Una
ruta candidata solo puede recibir `VALIDADO_3DEN` después de ejecución humana
documentada en Editor 3DEN y Arma 3 con capturas, versión y RPT.

Fuentes rectoras:

- [Pass 3A](M3_PHYSICAL_VALIDATION_PASS_3A_2026-08-11.md), para las nueve rutas, clases, direcciones y transiciones candidatas;
- [documento 10](../10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md), para la topología y el significado operacional de las conexiones;
- [documento 11](../11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#src-threeden-geography-and-physical-validation-guide--17-validación-de-rutas), para anclajes, rutas, cuellos, IA y convoyes;
- `IslasFracturadas.Altis/config/sectors.hpp`, para IDs, regiones, tipos y topología;
- `mission.sqm`, para coordenadas observadas y estructura física estable, después de resolver su autoridad frente a la copia abierta por 3DEN.

Convención: `mission.sqm` usa `[x, elevación, y]`; las fichas ATL usan
`[x, y, z]`. No se reutiliza el centro de un sector como transición salvo que la
observación física demuestre que ambos puntos coinciden.

## 2. Precondición bloqueante de autoridad

El último `Sync-MissionWorkspace.ps1 -Action Status` disponible marcó
`mission.sqm = EditorMasNuevo`. Por tanto, antes de crear capas, anclajes o
coordenadas:

1. guardar el escenario en 3DEN y cerrar el editor;
2. ejecutar `./tools/Sync-MissionWorkspace.ps1 -Action Status`;
3. si 3DEN continúa siendo la copia más nueva, ejecutar `Pull` y comprobar el diff;
4. comparar estructuralmente repositorio y workspace y resolver cualquier cambio funcional;
5. crear backup fechado con SHA-256 antes de cualquier escritura;
6. solo después crear `IF_04_ROADS_AND_ROUTES` si sigue ausente;
7. abrir de nuevo la misión y comprobar carga, conteos y capa en 3DEN.

No se modifica `mission.sqm` mientras esta precondición siga abierta. La herramienta
`arma_sqm_add_layer` ya está implementada y probada sobre fixtures, pero el servidor
MCP conectado debe reiniciarse para exponerla y su uso real sigue condicionado por
la sincronización anterior. La capa vacía no acredita rutas ni autoriza añadir
lógicas con coordenadas inventadas.

## 3. Medios de prueba

### 3.1 Entorno que debe registrarse

| Campo | Valor de ejecución |
| --- | --- |
| Arma 3 / build | `PENDIENTE_EJECUCION_MANUAL` |
| Editor / mapa | Editor 3DEN / Altis |
| Misión / revisión Git | `PENDIENTE_EJECUCION_MANUAL` |
| Fecha, hora y operador | `PENDIENTE_EJECUCION_MANUAL` |
| Modo | un jugador; sin mods personalizados |
| Clima / hora / tráfico civil | `PENDIENTE_EJECUCION_MANUAL` |
| Hash inicial de `mission.sqm` | `PENDIENTE_EJECUCION_MANUAL` |
| RPT y SHA-256 | `PENDIENTE_EJECUCION_MANUAL` |

Mantener clima, hora y tráfico iguales entre sentidos comparables. Si una prueba
requiere una condición distinta, registrarla como variante y no mezclar su tiempo
con la línea base.

### 3.2 Vehículos vanilla exactos

| Prueba | Clase | Uso |
| --- | --- | --- |
| ligero | `B_MRAP_01_F` — Hunter | recorrido conducido y recorrido IA |
| pesado | `B_Truck_01_mover_F` — HEMTT Mover | anchura, giro, pendiente, puente y recorrido IA |
| blindado | `B_APC_Wheeled_01_cannon_F` — AMV-7 Marshall | rutas `PRIMARY` y cualquier candidata cuyo cuello pueda limitar fuerzas mecanizadas; si no corresponde, registrar `N/A_JUSTIFICADO` |
| convoy líder | `B_MRAP_01_F` — Hunter | formación y guía IA |
| transportes | 3 × `B_Truck_01_transport_F` — HEMTT Transport | convoy estándar mínimo |
| escolta final | `B_MRAP_01_hmg_F` — Hunter HMG | cierre y observación de separación |

El convoy estándar de esta pasada es `1 líder + 3 transportes + 1 escolta` (cinco
vehículos), dentro del contrato rector de `1 + 3–5 + 1–2`. No sustituir clases a
mitad de una comparación. Toda sustitución debe registrarse con causa y repetir
ambos sentidos afectados.

## 4. Anclajes y evidencia física

La capa prevista es `IF_04_ROADS_AND_ROUTES`. Los nombres usan:

```text
IF_ROUTE_{ROUTE_ID}_{TYPE}_{NUMBER}
```

Para cada conexión se requieren, como mínimo:

- `ROUTE_ENTRY_01` y `ROUTE_EXIT_01`, fijados sobre transiciones observadas;
- `ROUTE_CHECKPOINT_01`, y más si hay cruces o cambios de corredor;
- `ROUTE_CONVOY_STAGING_01`, fuera del núcleo civil o de la pista activa;
- `ROUTE_HOLDING_01`, para detención y reagrupación;
- `ROUTE_DIVERSION_01` cuando exista alternativa real;
- `ROUTE_AMBUSH_01` cuando el terreno produzca un cuello o una zona de exposición.

`TYPE` conserva el token conceptual completo definido por la fuente rectora
(`ROUTE_ENTRY`, `ROUTE_EXIT`, etc.); no se abrevia a `ENTRY` o `EXIT`. `ROUTE_ID`
usa el ID de conexión sin el prefijo `CONN_M3_`; por ejemplo,
`IF_ROUTE_NERI_AGIOS_ROUTE_ENTRY_01`. Cada anclaje debe registrar:

| Dato | Requisito |
| --- | --- |
| nombre y tipo | único, conforme a convención |
| posición SQM | `[x, elevación, y]` copiada de 3DEN |
| posición ATL | `[x, y, z]` derivada sin intercambiar ejes |
| dirección | azimut observado hacia el corredor |
| sector/bound asociado | origen, destino o transición |
| rasgo físico | carretera, cruce, puente, puerta, pendiente, cuello, pista o camino rural |
| captura | vista de mapa y vista de terreno con el anclaje identificable |
| estado | `PENDIENTE`, `OBSERVADO`, `BLOQUEADO` o `VALIDADO_3DEN` |

No añadir lógicas hasta haber observado y transcrito sus coordenadas en 3DEN.

## 5. Protocolo por conexión y sentido

Ejecutar cada fila de la matriz de la sección 6 en este orden:

1. **Reconocimiento a pie/manual:** confirmar sector A, transición de salida,
   continuidad de carretera o camino, transición de entrada y sector B. Fijar
   `ENTRY`, `EXIT`, checkpoints, staging, holding y rasgos críticos.
2. **Hunter conducido:** recorrer sin teletransporte; registrar tiempo de movimiento
   y tiempo total, detenciones, daño, salida de calzada y necesidad de maniobra.
3. **HEMTT conducido:** repetir; comprobar radios de giro, ancho útil, pendiente,
   puentes, muros, cruces, vuelco y espacio de reagrupación.
4. **Marshall conducido cuando corresponda:** obligatorio para `PRIMARY`; en las
   demás rutas, ejecutarlo si el diseño pretende acceso mecanizado. Registrar
   `N/A_JUSTIFICADO` solo cuando la propia función candidata excluya blindados.
5. **IA individual:** ordenar al Hunter y al HEMTT recorrer el trayecto completo;
   no conducirlos ni recolocarlos. Registrar pérdida de ruta, conducción fuera de
   carretera, bucles, detención mayor de 30 s, colisión y llegada.
6. **Convoy IA:** formar los cinco vehículos en `CONVOY_STAGING`, dar destino más
   allá de la transición de entrada y observar separación, reagrupación,
   colisiones, vehículos perdidos, detenciones y llegada completa.
7. **Sentido inverso:** repetir las pruebas para toda candidata `BIDIRECTIONAL`. En
   `CONDITIONAL_DIRECTION`, probar también el inverso; si falla, registrar la
   condición física exacta en vez de asumir unilateralidad por diseño.
8. **Alternativa/bloqueo:** en rutas `ALTERNATIVE` o `CONDITIONAL`, bloquear de
   forma reproducible el cuello principal o aplicar el estado previsto, probar el
   desvío y después retirar la fixture temporal.
9. **Tráfico civil limitado:** repetir al menos la navegación IA y el convoy con la
   condición civil registrada; no mezclarla con la línea base sin tráfico.
10. **Cierre:** guardar capturas, anotar tiempos, salir de la misión, localizar RPT,
    calcular SHA-256 y clasificar el sentido.

### Umbrales de clasificación de una ejecución

| Resultado | Criterio |
| --- | --- |
| `PASS` | llega todo el conjunto exigido sin intervención, pérdida de ruta, vuelco o bloqueo sostenido; las incidencias menores quedan registradas |
| `PARCIAL` | el corredor existe, pero falta una prueba exigida o hay una incidencia repetible que reduce capacidad sin impedir todo tránsito |
| `FAIL` | no existe continuidad física, una clase exigida no puede pasar, la IA no completa el trayecto o el convoy queda bloqueado/perdido |
| `BLOQUEADO` | no pudo ejecutarse por autoridad del SQM, carga de misión, fixture, RPT o entorno; no equivale a fallo físico |
| `PENDIENTE_EJECUCION_MANUAL` | no se ha aportado ejecución humana documentada |

La conexión solo puede cerrarse `VALIDADO_3DEN` si sus sentidos exigidos y todas
las pruebas aplicables están documentados. `PARCIAL` no se redondea a `PASS`.

## 6. Matriz maestra — nueve conexiones / dieciocho sentidos

Todas las filas se abren en `PENDIENTE_EJECUCION_MANUAL`; no contienen resultados
inferidos de las pruebas históricas Hunter/HEMTT.

| # | Conexión / sentido | Clase | Dirección candidata | Ligero | HEMTT | Blindado | IA individual | Convoy IA | Civil | Tiempo | Alternativa | Resultado |
| ---: | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1A | `CONN_M3_NERI_AGIOS`: Neri → Agios | `PRIMARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 1B | `CONN_M3_NERI_AGIOS`: Agios → Neri | `PRIMARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 2A | `CONN_M3_AGIOS_LAKKA`: Agios → Lakka | `PRIMARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 2B | `CONN_M3_AGIOS_LAKKA`: Lakka → Agios | `PRIMARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 3A | `CONN_M3_LAKKA_STAVROS`: Lakka → Stavros | `PRIMARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 3B | `CONN_M3_LAKKA_STAVROS`: Stavros → Lakka | `PRIMARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 4A | `CONN_M3_LAKKA_AAC`: Lakka → AAC | `SECONDARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 4B | `CONN_M3_LAKKA_AAC`: AAC → Lakka | `SECONDARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 5A | `CONN_M3_STAVROS_POLIAKKO`: Stavros → Poliakko | `ALTERNATIVE` | `CONDITIONAL_DIRECTION` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 5B | `CONN_M3_STAVROS_POLIAKKO`: Poliakko → Stavros | `ALTERNATIVE` | `CONDITIONAL_DIRECTION` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 6A | `CONN_M3_AAC_POLIAKKO`: AAC → Poliakko | `SECONDARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 6B | `CONN_M3_AAC_POLIAKKO`: Poliakko → AAC | `SECONDARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 7A | `CONN_M3_POLIAKKO_XIROLIMNI`: Poliakko → Xirolimni | `ALTERNATIVE` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 7B | `CONN_M3_POLIAKKO_XIROLIMNI`: Xirolimni → Poliakko | `ALTERNATIVE` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 8A | `CONN_M3_LAKKA_AIRPORT_WEST`: Lakka → Airport West | `PRIMARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 8B | `CONN_M3_LAKKA_AIRPORT_WEST`: Airport West → Lakka | `PRIMARY` | `BIDIRECTIONAL` | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 9A | `CONN_M3_AIRPORT_WEST_TERMINAL`: Airport West → Terminal | `CONDITIONAL` | `CONDITIONAL_DIRECTION` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |
| 9B | `CONN_M3_AIRPORT_WEST_TERMINAL`: Terminal → Airport West | `CONDITIONAL` | `CONDITIONAL_DIRECTION` | pendiente | pendiente | pendiente/N/A justificado | pendiente | pendiente | pendiente | pendiente | pendiente | `PENDIENTE_EJECUCION_MANUAL` |

## 7. Ficha por sentido

Duplicar esta ficha para cada fila `1A`–`9B`:

```text
CONEXIÓN / SENTIDO:
OPERADOR / FECHA / BUILD / REVISIÓN:
CLIMA / HORA / TRÁFICO:

SECTOR A:
ENTRY SQM [x,elevación,y] / ATL [x,y,z] / DIR:
CHECKPOINTS:
CUELLOS, PUENTES, CURVAS, PENDIENTES Y CRUCES:
DIVERSION / CONDICIÓN DE USO:
EXIT SQM [x,elevación,y] / ATL [x,y,z] / DIR:
SECTOR B:

MANUAL A PIE: PASS/PARCIAL/FAIL/BLOQUEADO — notas
HUNTER CONDUCIDO: tiempo movimiento / total — incidencias
HEMTT CONDUCIDO: tiempo movimiento / total — incidencias
MARSHALL: tiempo / N/A justificado — incidencias
HUNTER IA: resultado / tiempo / intervención
HEMTT IA: resultado / tiempo / intervención
CONVOY IA: 5/5 llegados; separación; colisiones; pérdidas; detenciones; tiempo
TRÁFICO CIVIL LIMITADO: condición y resultado
ALTERNATIVA/BLOQUEO: fixture, desvío y resultado

CAPTURAS: mapa general; entry; cada rasgo crítico; staging; exit; llegada convoy
RPT: ruta / SHA-256 / errores y warnings pertinentes
RESULTADO DEL SENTIDO:
CAUSA SI NO PASS:
CORRECCIÓN FÍSICA PROPUESTA:
REPETICIÓN NECESARIA:
```

## 8. Causas de fallo y corrección física

Si una conexión falla, usar una o más categorías y proponer una corrección física
reversible. No corregir cambiando topología estratégica sin decisión humana.

| Código | Causa | Evidencia mínima | Correcciones físicas candidatas |
| --- | --- | --- | --- |
| `GEOMETRY_DISCONTINUITY` | no existe continuidad entre transiciones | captura y coordenadas del corte | mover transición observada, seleccionar acceso real o documentar bloqueo topológico para decisión humana |
| `WIDTH_TURN_RADIUS` | HEMTT/Marshall no supera ancho o giro | clase, posición y captura | retirar/mover obstáculo, ampliar acceso, definir holding o restringir clase con aprobación |
| `GRADE_ROLLOVER` | pendiente o peralte produce atasco/vuelco | dirección, clase, repetición | escoger variante física, suavizar composición o limitar uso bajo condición explícita |
| `BRIDGE_DEPENDENCY` | puente impide clase, sentido o desvío | puente, carga y aproximaciones | corregir aproximación, hallar desvío real o registrar dependencia/condición |
| `AI_PATHFINDING` | conductor IA abandona, oscila o no termina | waypoint, tiempo y RPT | ajustar puntos de guía/holding, evitar cruce ambiguo o seleccionar corredor físicamente legible |
| `CONVOY_CAPACITY` | ruta individual pasa, convoy no | posición de cola, separación y bloqueo | staging mayor, checkpoints, separación, velocidad o desvío probado |
| `CIVIL_CONFLICT` | tráfico/núcleo civil bloquea o vuelve insegura la ruta | densidad y momento | horario/condición, holding exterior, acceso alternativo o mitigación física |
| `SECURITY_CONDITION` | puerta, pista, frente o estado impide tránsito | condición reproducida | ruta perimetral, lógica de apertura futura o mantener `CONDITIONAL` |
| `EDITOR_OR_RUNTIME` | misión, fixture o RPT impide probar | mensaje/RPT | corregir entorno y repetir; no cuenta como fallo de ruta |

Toda propuesta queda `PROPUESTA_CORRECCION_FISICA` hasta aplicarse y repetirse. Si
la única solución exige cambiar extremos o eliminar/añadir una conexión, detenerse
y elevar la decisión: Pass 3B no tiene autoridad para alterar la topología.

## 9. Paquete de evidencia y cierre

Por sentido conservar:

- una captura de mapa con origen, corredor, transición y destino;
- capturas de `ENTRY`, `EXIT`, puentes, curvas, pendientes, cruces, cuellos,
  staging, holding y alternativa;
- captura del convoy formado y de la llegada completa;
- ficha de sección 7 completa;
- RPT de la sesión, ruta local y SHA-256;
- revisión Git y hash de `mission.sqm` usado;
- resultado `PASS`, `PARCIAL`, `FAIL` o `BLOQUEADO`.

Después de cualquier cambio validado en `mission.sqm`: comprobar parseo,
`items`, `ItemN`, IDs únicos y `ItemIDProvider.nextID`; abrir/guardar en 3DEN;
revisar RPT; ejecutar Sync Push `-AllowMissionSqm -WhatIf` y luego Push real; y
revisar el diff. Las herramientas automáticas no sustituyen esta verificación.

### Gate Pass 3B

Pass 3B solo puede cerrarse cuando:

- las nueve conexiones tienen resultado físico exacto, o bloqueo exacto que
  impida validarlas;
- los dieciocho sentidos candidatos están probados o tienen condición justificada;
- ligero, HEMTT, blindado aplicable, IA, convoy y tráfico civil están registrados;
- tiempos, puentes, curvas, pendientes, cruces, cuellos, alternativas y capacidad
  de convoy están documentados;
- coordenadas y anclajes proceden de 3DEN, no de inferencia;
- capturas y RPT con hash acompañan las fichas;
- toda corrección física aplicada fue repetida;
- topología, M4 y los 38 sectores permanecen fuera de alcance.

## 10. Estado al abrir la pasada

| Métrica | Estado |
| --- | --- |
| conexiones con `VALIDADO_3DEN` nuevo | `0/9` |
| sentidos ejecutados con evidencia Pass 3B | `0/18` |
| transiciones con coordenada Pass 3B observada | `0/18` |
| pruebas Hunter/HEMTT/Marshall/IA/convoy nuevas | `0`; `PENDIENTE_EJECUCION_MANUAL` |
| capturas y RPT Pass 3B | `0`; `PENDIENTE_EJECUCION_MANUAL` |
| `mission.sqm` modificado en esta apertura | no |
| autoridad SQM | `BLOQUEADO_HASTA_GUARDAR_CERRAR_3DEN_Y_SINCRONIZAR` |
| Pass 3B | `PENDIENTE_EJECUCION_MANUAL` |
| M3 | `NO APROBADO` |
