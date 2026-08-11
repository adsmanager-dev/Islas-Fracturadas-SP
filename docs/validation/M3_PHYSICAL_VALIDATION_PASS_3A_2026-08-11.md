# Evidencia M3 — Physical Validation Pass 3A

> **Subfase:** normalización geográfica y límites preliminares
> **Fecha:** 2026-08-11
> **Estado del gate Pass 3A:** `PASS`
> **Estado de M3:** implementación técnica `PROBADA`; `M3 NO APROBADO`
> **Alcance acreditable:** normalización de los 9 centros ya `VALIDADO_3DEN`, propuesta de geometría para 9 límites y preparación conceptual de 9 conexiones para Pass 3B
> **No acredita:** límites o radios `VALIDADO_3DEN`, navegación IA, convoyes, tráfico, tiempos, capacidad, rendimiento, composiciones, coordenadas de transición ni campaña jugable

## 1. Fuentes y reglas de autoridad

Esta pasada consume como fuente física los nueve centros cerrados por la pasada 2
de [M3_STRATEGIC_WORLD_2026-08-07.md](M3_STRATEGIC_WORLD_2026-08-07.md). El
centro `VALIDADO_3DEN` no promueve el sector completo: los límites, radios y
rutas continúan en `VALIDACION_3DEN_EN_CURSO` o `POR_CALIBRAR`.

Rigen además:

- [documento 10, reglas territoriales](../10_STRATEGIC_CAMPAIGN_AND_TERRITORIAL_SYSTEM.md#src-altis-geography-and-sector-map--12-reglas-de-implementación): las rutas representan capacidad y riesgo, y las fronteras siguen provisionales hasta probar navegación, visibilidad, densidad y rendimiento;
- [documento 11, límites](../11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#src-threeden-geography-and-physical-validation-guide--10-capa-if02sectorbounds): los bordes deben seguir relieve, carreteras, cauces secos, costa, núcleos y barreras naturales sin dividir una localidad funcional;
- [documento 11, conexiones](../11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#src-threeden-geography-and-physical-validation-guide--13-capa-if03connections): una conexión es una vía operacional entre sectores, no una única carretera física;
- `IslasFracturadas.Altis/config/sectors.hpp`: verdad estratégica de IDs, regiones, tipos y topología M3;
- `mission.sqm`: fuente física estable de centros. No fue modificado en esta pasada.

Convención de coordenadas: el SQM serializa `[x, elevación, y]`; la configuración
usa ATL `[x, y, z]`. Los centros normalizados conservan `z = 0` ATL. Cuando la
pasada no dispone de una observación exacta para un borde o punto de ruta se usa
literalmente `PENDIENTE_COORDENADA_3DEN`.

## 2. NORMALIZACIÓN — config frente a 3DEN

No cambian IDs, regiones, tipos, roles ni las nueve conexiones. Cinco centros ya
coincidían. Cuatro posiciones estratégicas se alinean con el centro final
validado en 3DEN; el delta es `3DEN - config anterior` en el plano horizontal.

| Sector | Config anterior ATL `[x,y,z]` | Centro 3DEN final ATL `[x,y,z]` | Δx / Δy / distancia | Acción Pass 3A | Estado del centro |
| --- | --- | --- | --- | --- | --- |
| `ALT_W_NERI_PANOCHORI` | `[5063.221,11300.441,0]` | `[5059.8296,11299.381,0]` | `-3.3914 / -1.0600 / 3.5532 m` | normalizar `positionATL` y `anchorPositionATL` | `VALIDADO_3DEN` |
| `ALT_W_AGIOS_DIONYSIOS` | `[9366.566,15884.586,0]` | `[9366.166,15886.582,0]` | `-0.4000 / +1.9960 / 2.0357 m` | normalizar `positionATL` y `anchorPositionATL` | `VALIDADO_3DEN` |
| `ALT_CW_STAVROS_WHISKEY` | `[12948.381,15032.742,0]` | `[12948.381,15032.742,0]` | `0 / 0 / 0 m` | conservar | `VALIDADO_3DEN` |
| `ALT_CW_LAKKA` | `[12360.689,15630.738,0]` | `[12359.11,15630.292,0]` | `-1.5790 / -0.4460 / 1.6408 m` | normalizar `positionATL` y `anchorPositionATL` | `VALIDADO_3DEN` |
| `ALT_CW_AAC` | `[11479.819,11632.228,0]` | `[11479.819,11632.228,0]` | `0 / 0 / 0 m` | conservar | `VALIDADO_3DEN` |
| `ALT_CW_POLIAKKO_THERISA` | `[10966.956,13436.86,0]` | `[11246.036,13627.0205,0]` | `+279.0800 / +190.1605 / 337.7132 m` | normalizar `positionATL` y `anchorPositionATL` | `VALIDADO_3DEN` |
| `ALT_CW_XIROLIMNI_ZAROS` | `[9138.721,13938.911,0]` | `[9138.721,13938.911,0]` | `0 / 0 / 0 m` | conservar | `VALIDADO_3DEN` |
| `ALT_C_AIRPORT_WEST` | `[14383.358,15922.19,0]` | `[14383.358,15922.19,0]` | `0 / 0 / 0 m` | conservar | `VALIDADO_3DEN` |
| `ALT_C_AIRPORT_TERMINAL` | `[15185.31,16774.15,0]` | `[15185.31,16774.15,0]` | `0 / 0 / 0 m` | conservar | `VALIDADO_3DEN` |

Resultado declarativo comprobado estáticamente después de reconciliar configuración y saves M3
anteriores: `placed/pendingPlacement/validated/pendingValidation = 9/0/9/0` para
centros. Este diagnóstico no cuenta límites ni rutas.

## 3. BOUNDS — límites preliminares 9/9

Todos los límites de esta tabla son `PROPUESTA_PASS_3A` y
`PENDIENTE_VALIDACION_3DEN`. El radio de referencia sirve para encuadrar la
primera inspección; **no es una frontera**, no sustituye la geometría indicada y
no cambia todavía `radius = -1` en configuración.

| Sector | Tipo preliminar | Radio orientativo | Bordes N / S / E / O para trazar en 3DEN | Rasgos e inclusiones funcionales | Exclusiones explícitas | Estado |
| --- | --- | ---: | --- | --- | --- | --- |
| Neri–Panochori | `COMPOSITE` | `900 m` | N: cierre tras el núcleo de Neri; S: costa y salida de Panochori Bay; E: transición a la red occidental hacia Agios; O: costa y límite de la subzona de desembarco | núcleo de Neri, playa operativa, candidato FOB, entrada logística y salida terrestre | mar abierto, carriles navales no comprobados y localidades vecinas completas | `PROPUESTA_PASS_3A`; `PENDIENTE_VALIDACION_3DEN` |
| Agios Dionysios | `POLYGON` | `700 m` | N/S: laderas o cambios de cuenca que cierren el paso; E: salida vial hacia Lakka; O: entrada desde Neri | núcleo del paso, carretera operacional y terreno defensivo inmediato | corredores rurales laterales no observados y núcleos Kore–Topolia | `PROPUESTA_PASS_3A`; `PENDIENTE_VALIDACION_3DEN` |
| Stavros–Whiskey | `COMPOSITE` | `750 m` | N: salida hacia Lakka; S: cierre tras la posición militar; E/O: barreras de relieve o separación clara entre población y base | base/FOB Whiskey, accesos, defensa inmediata y zona de retirada | núcleo civil ajeno, campos sin función militar y corredor completo hacia Poliakko | `PROPUESTA_PASS_3A`; `PENDIENTE_VALIDACION_3DEN` |
| Lakka | `POLYGON` | `650 m` | N: aproximación desde Agios; S: ramales hacia AAC/Poliakko; E: salida al aeropuerto; O: acceso hacia Stavros | núcleo funcional del cruce, reserva/QRF y accesos mecanizados inmediatos | extensiones de carretera que pertenecen a sectores vecinos y áreas civiles no necesarias | `PROPUESTA_PASS_3A`; `PENDIENTE_VALIDACION_3DEN` |
| AAC Airfield | `RECTANGLE` | `700 m` | N: acceso hacia Lakka; S: cierre de cabecera/aproximación; E: enlace rural hacia Poliakko; O: borde exterior de la instalación | pista ligera, hangares, combustible/reparación candidatos y acceso terrestre | aproximaciones aéreas no medidas y terrenos agrícolas sin función del aeródromo | `PROPUESTA_PASS_3A`; `PENDIENTE_VALIDACION_3DEN` |
| Poliakko–Therisa | `COMPOSITE` | `950 m` | N: salida hacia Stavros/Lakka; S: transición rural hacia AAC; E: cierre tras los núcleos funcionales; O: corredor hacia Xirolimni | núcleos y granjas funcionales, caminos rurales y logística alternativa | campos periféricos sin uso, rutas clandestinas no probadas y localidades completas ajenas | `PROPUESTA_PASS_3A`; `PENDIENTE_VALIDACION_3DEN` |
| Xirolimni–Zaros | `COMPOSITE` | `1100 m` | N: transición hacia Poliakko; S: cierre por cambio de cuenca; E/O: relieve, infraestructura y caminos que separen las subzonas | infraestructura de agua/energía, núcleos rurales asociados, cruces y zonas abiertas funcionales | cuenca completa sin función, aproximación aeroportuaria no observada y rutas alternativas no probadas | `PROPUESTA_PASS_3A`; `PENDIENTE_VALIDACION_3DEN` |
| Airport West | `POLYGON` | `900 m` | N/E: transición controlada hacia Terminal; S/O: líneas exteriores de aproximación y barreras del recinto | hangares/base occidental, defensa exterior, accesos y espacios abiertos de aproximación | terminal civil, pista completa y complejo militar/Helios ajeno al sector | `PROPUESTA_PASS_3A`; `PENDIENTE_VALIDACION_3DEN` |
| Airport Terminal | `COMPOSITE` | `1200 m` | N/S: extremos funcionales de pista/recinto; E: cierre tras terminal y servicios; O: transición con Airport West | terminal, caminos interiores, infraestructura aeroportuaria y área funcional de Helios-0 prevista | Airport West, complejo militar separado y aproximaciones aéreas no medidas | `PROPUESTA_PASS_3A`; `PENDIENTE_VALIDACION_3DEN` |

### Criterios manuales para promover un límite

En 3DEN se debe trazar cada propuesta sobre `IF_02_SECTOR_BOUNDS` y registrar:

1. geometría final y vértices/ejes exactos;
2. continuidad con cada vecino sin huecos operacionales ni solapamiento arbitrario;
3. núcleo funcional, carreteras, relieve, costa, infraestructura y barreras usadas;
4. inclusiones/exclusiones verificadas y ausencia de división arbitraria de localidades;
5. navegación, visibilidad, densidad de objetos, impacto civil y coste de materialización;
6. captura general y por transición, versión de misión, RPT y resultado.

Hasta completar esos pasos, ningún bound ni radio recibe `VALIDADO_3DEN`.

## 4. TRANSICIONES — puntos de borde para levantar en 3DEN

Cada fila describe una transición **conceptual** desde el sector indicado. La
posición exacta de `ENTRY`, `EXIT`, `CHECKPOINT`, `BOTTLENECK`, `STAGING AREA`,
`DIVERSION` y `DESTINATION` queda para Pass 3B. No se han creado marcadores.

| Sector | Vecino | Rasgo físico candidato | ENTRY / EXIT | CHECKPOINT / BOTTLENECK | STAGING AREA / DIVERSION / DESTINATION | `TRANSITION_XY` | Estado |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Neri–Panochori | Agios Dionysios | salida terrestre hacia la red vial occidental | entrada tras logística; salida del borde interior | control antes de abandonar la subzona; estrechamiento por verificar | staging fuera del núcleo/FOB; desvío por vía secundaria; destino acceso occidental de Agios | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Agios Dionysios | Neri–Panochori | aproximación occidental al paso | entrada desde Neri; salida hacia el núcleo del paso | control defensivo; cuello del paso por localizar | staging antes de la zona defendida; retorno/desvío occidental; destino Neri | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Agios Dionysios | Lakka | carretera principal de salida oriental | entrada desde el paso; salida a la aproximación de Lakka | control en cambio de terreno; cuello vial por localizar | staging fuera de Agios; ramal alternativo por verificar; destino cruce de Lakka | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Lakka | Agios Dionysios | aproximación occidental/noroccidental al cruce | entrada desde Agios; salida al núcleo de Lakka | control previo al cruce; acceso defensivo | staging fuera del área civil; retorno por ruta segura; destino Agios | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Lakka | Stavros–Whiskey | ramal occidental hacia posición militar | entrada desde el cruce; salida hacia Stavros | control de frente; cuello Lakka–Stavros | staging QRF fuera del cruce; desvío rural por verificar; destino acceso de Whiskey | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Stavros–Whiskey | Lakka | acceso desde base al corredor de Lakka | entrada desde posición militar; salida de la base | control perimetral; zona de emboscada por verificar | staging de retirada/QRF; desvío defensivo; destino borde de Lakka | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Lakka | AAC Airfield | ramal secundario hacia el aeródromo | entrada desde Lakka; salida hacia acceso AAC | control de cruce; estrechamiento rural por verificar | staging de convoy fuera de población; desvío hacia red rural; destino puerta terrestre AAC | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| AAC Airfield | Lakka | acceso terrestre desde el norte | entrada al recinto; salida hacia Lakka | control de instalación; puerta/perímetro | staging logístico sin invadir pista; retorno rural; destino aproximación de Lakka | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Stavros–Whiskey | Poliakko–Therisa | ruta secundaria de flanco/retirada | entrada desde base; salida al corredor rural | control perimetral; punto de emboscada por verificar | staging de retirada; desvío rural; destino núcleo funcional Poliakko–Therisa | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Poliakko–Therisa | Stavros–Whiskey | acceso rural hacia la posición militar | entrada desde caminos rurales; salida hacia Whiskey | control antes de la base; estrechamiento por verificar | staging fuera de granjas; desvío por camino alternativo; destino acceso Stavros | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| AAC Airfield | Poliakko–Therisa | enlace rural oriental/nororiental | entrada desde instalación; salida al corredor agrícola | control de perímetro; cruce rural | staging logístico fuera de pista; desvío por red secundaria; destino Poliakko–Therisa | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Poliakko–Therisa | AAC Airfield | camino de acceso al aeródromo ligero | entrada desde corredor rural; salida hacia AAC | control de aproximación; puerta del recinto | staging de camiones fuera de núcleo civil; desvío rural; destino acceso AAC | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Poliakko–Therisa | Xirolimni–Zaros | corredor rural hacia infraestructura de agua/energía | entrada desde núcleos rurales; salida hacia Xirolimni | control de cruce; cuello por relieve/infraestructura | staging fuera de granjas; ruta alternativa por verificar; destino acceso Xirolimni–Zaros | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Xirolimni–Zaros | Poliakko–Therisa | salida desde cuenca e infraestructura | entrada desde zona mixta; salida al corredor rural | control de infraestructura; cruce/relieve por verificar | staging de apoyo; desvío por camino alternativo; destino Poliakko–Therisa | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Lakka | Airport West | eje principal hacia el aeropuerto | entrada desde cruce; salida a aproximación occidental | control antes de espacios abiertos; cuello de acceso aeroportuario | staging QRF fuera del cruce; desvío por red secundaria; destino perímetro Airport West | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Airport West | Lakka | aproximación occidental desde el aeropuerto | entrada desde perímetro; salida hacia Lakka | control exterior; exposición en espacio abierto | staging cubierto fuera de pista; desvío de seguridad; destino cruce de Lakka | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Airport West | Airport Terminal | red interna/perimetral del aeropuerto | entrada desde base occidental; salida al área terminal | control de seguridad; paso condicionado por estado del recinto | staging fuera de pista activa; desvío perimetral; destino acceso funcional Terminal | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |
| Airport Terminal | Airport West | red interna desde terminal al oeste | entrada desde terminal; salida hacia base occidental | control de seguridad; cuello entre áreas funcionales | staging técnico sin bloquear caminos; desvío perimetral; destino Airport West | `PENDIENTE_COORDENADA_3DEN` | `PENDIENTE_PASS_3B` |

## 5. CONEXIONES — preparación candidata para Pass 3B

La clase de esta tabla (`PRIMARY`, `SECONDARY`, `ALTERNATIVE`, `CONDITIONAL`) es
una prioridad de validación física Pass 3B y no reemplaza todavía
`connectionType` de configuración. La dirección es igualmente candidata.

| ID | Ruta física candidata | Clase | Dirección candidata | Puntos que debe fijar Pass 3B | Estado |
| --- | --- | --- | --- | --- | --- |
| `CONN_M3_NERI_AGIOS` | salida logística Neri/Panochori → red vial occidental → acceso al paso de Agios | `PRIMARY` | `BIDIRECTIONAL` | entry/exit de ambos bounds, control previo al paso, cuello, staging fuera de Neri, desvío secundario y destino Agios | diseño confirmado; transitabilidad manual limitada previa; `PENDIENTE_IA_CONVOY_PASS_3B` |
| `CONN_M3_AGIOS_LAKKA` | salida oriental de Agios → carretera principal → aproximación al cruce de Lakka | `PRIMARY` | `BIDIRECTIONAL` | bordes, control defensivo, cuello del paso, staging, ramal de desvío y destino Lakka | transitabilidad manual limitada previa; `PENDIENTE_IA_CONVOY_PASS_3B` |
| `CONN_M3_LAKKA_STAVROS` | ramal del cruce de Lakka → corredor hacia posición Stavros–Whiskey | `PRIMARY` | `BIDIRECTIONAL` | accesos al cruce/base, checkpoint de frente, emboscada/cuello, staging QRF, retirada y destinos | `PENDIENTE_VALIDACION_3DEN_PASS_3B` |
| `CONN_M3_LAKKA_AAC` | ramal secundario de Lakka → acceso terrestre de AAC | `SECONDARY` | `BIDIRECTIONAL` | cruce de salida, puerta AAC, cuello rural, staging de convoy, desvío y destino de instalación | `PENDIENTE_VALIDACION_3DEN_PASS_3B` |
| `CONN_M3_STAVROS_POLIAKKO` | salida de flanco/retirada de Whiskey → caminos rurales → Poliakko–Therisa | `ALTERNATIVE` | `CONDITIONAL_DIRECTION` | perímetro de base, accesos rurales, emboscada, staging de retirada, desvíos y destino | `PENDIENTE_VALIDACION_3DEN_PASS_3B` |
| `CONN_M3_AAC_POLIAKKO` | acceso AAC → red rural → corredor Poliakko–Therisa | `SECONDARY` | `BIDIRECTIONAL` | puerta de instalación, cruces rurales, control de camiones, staging, desvío y destino | `PENDIENTE_VALIDACION_3DEN_PASS_3B` |
| `CONN_M3_POLIAKKO_XIROLIMNI` | corredor rural Poliakko–Therisa → acceso a infraestructura Xirolimni–Zaros | `ALTERNATIVE` | `BIDIRECTIONAL` | bordes de núcleos/cuenca, cruces, cuello de infraestructura, staging, ruta alternativa y destino | `PENDIENTE_VALIDACION_3DEN_PASS_3B` |
| `CONN_M3_LAKKA_AIRPORT_WEST` | eje principal desde Lakka → aproximación occidental → perímetro Airport West | `PRIMARY` | `BIDIRECTIONAL` | salida de Lakka, entrada al recinto, exposición/AT, checkpoint, staging QRF, desvío y destino | `PENDIENTE_VALIDACION_3DEN_PASS_3B` |
| `CONN_M3_AIRPORT_WEST_TERMINAL` | red interna/perimetral Airport West → Terminal | `CONDITIONAL` | `CONDITIONAL_DIRECTION` | controles de seguridad, límites de pista, cuello entre áreas, staging técnico, desvío perimetral y destino terminal | `PENDIENTE_VALIDACION_3DEN_PASS_3B` |

La propiedad histórica `BlueBeachhead.convoyRouteValidated = 1` acredita solo el
tramo de salida de playa que ya tenía evidencia específica. No valida estas nueve
conexiones, un convoy completo ni navegación IA en ambos sentidos.

## 6. Pauta manual reproducible para Pass 3B

Pass 3A no inicia automáticamente Pass 3B. Cuando se autorice:

1. guardar y cerrar 3DEN; comprobar Sync y trabajar desde la copia más reciente;
2. trazar bounds y puntos de transición en capas de desarrollo, sin marcadores improvisados;
3. registrar XY exacta de cada punto, dirección, captura, rasgo físico y bound asociado;
4. recorrer cada ruta en ambos sentidos cuando su dirección candidata sea bidireccional;
5. probar por separado vehículo ligero, pesado, convoy e IA; una prueba conducida por jugador no sustituye las otras;
6. verificar puentes, pendientes, giros, anchura, tráfico, obstáculos, desvíos, staging, checkpoints y destinos;
7. probar bloqueos/daño pertinentes para rutas `ALTERNATIVE` o `CONDITIONAL`;
8. guardar, sincronizar, revisar RPT y registrar `PASS`, `PARCIAL` o `FAIL` por conexión y sentido.

## 7. Gate Pass 3A

Pass 3A solo puede declararse `PASS` cuando se confirme conjuntamente:

- 9/9 centros comparados y cuatro divergencias normalizadas;
- 9/9 tipos de límite propuestos, con radio solo orientativo e inclusiones/exclusiones;
- transiciones identificadas para todos los extremos de las nueve conexiones;
- 9/9 conexiones preparadas con ruta, clase, dirección y puntos conceptuales;
- ninguna coordenada de transición inventada y ningún cambio en `mission.sqm`;
- IDs, regiones, tipos y topología de nueve conexiones intactos;
- reconciliación aditiva y pruebas M0–M3 superadas;
- Semgrep y `git diff --check` sin hallazgos;
- diff completo revisado y Sync Push `-WhatIf`/Push completados sin `-AllowMissionSqm`;
- documentación e índice sincronizados.

Aunque Pass 3A alcance `PASS`, M3 permanece `NO APROBADO`: bounds, radios, rutas,
convoy/IA, UI diagnóstica y prueba runtime posterior conservan sus gates propios.

## 8. Validaciones de cierre

| Comprobación | Resultado |
| --- | --- |
| M0–M3 y Sync | `PASS`: cinco scripts PowerShell ejecutados el 2026-08-11 |
| Semgrep | `PASS`: 3 reglas, 72 archivos, 0 hallazgos |
| `git diff --check` | `PASS`; solo avisos informativos LF→CRLF |
| revisión explícita del diff | `PASS`: 9 sectores, 9 conexiones, 9 radios `-1`, 9 anclajes `VALIDADO_3DEN`; IDs, regiones, tipos, roles y topología iguales a `HEAD` |
| Sync Push `-WhatIf` / Push sin `-AllowMissionSqm` | `PASS`: 3 copias no-SQM, 58 iguales y 1 protegido; estado posterior igual salvo `mission.sqm` `EditorMasNuevo` |
| integridad de `mission.sqm` durante Push | `PASS`: repo `839070F9…F9366` y 3DEN `BF81A768…54160`, ambos sin cambio antes/después; comparación estructural previa `functional_equal=true` |
| suite SQF M3 en Arma 3 y RPT posteriores a la normalización | `PENDIENTE_MANUAL`; no bloquea el gate documental Pass 3A, sí cualquier promoción runtime |

## 9. Veredicto

**Pass 3A: `PASS`.** Se cerraron la normalización de centros y la preparación
preliminar requerida para bounds, transiciones y conexiones sin inventar XY ni
modificar `mission.sqm`. No se inicia Pass 3B automáticamente.

**M3: `NO APROBADO`.** Los bounds y radios siguen `POR_CALIBRAR` /
`PENDIENTE_VALIDACION_3DEN`; las nueve conexiones conservan validación física,
convoy e IA pendientes. La suite SQF modificada aún debe ejecutarse en Arma 3 y
revisarse en RPT antes de acreditar el comportamiento runtime posterior a Pass 3A.
