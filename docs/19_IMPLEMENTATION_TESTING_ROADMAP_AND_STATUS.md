# Implementación, pruebas, hoja de ruta y estado

> **Estado del contenedor:** Fases 0–2 completadas; `M2` aprobado; Fase 3 en preparación; campaña jugable no iniciada
> **Fuente de verdad para:** estado, hoja de ruta, producción, pruebas, rendimiento y balance
> **Relacionados:** [18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-08-07

## Propósito

Centralizar estado, hoja de ruta, producción, pruebas, rendimiento y balance sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [Criterios de aceptación de dirección narrativa](#criterios-de-aceptacion-de-direccion-narrativa)
- [MASTER TESTING PERFORMANCE AND BALANCE SYSTEM](#fuente-master-testing-performance-and-balance-system)
- [MASTER IMPLEMENTATION AND PRODUCTION PLAN](#fuente-master-implementation-and-production-plan)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `MASTER_TESTING_PERFORMANCE_AND_BALANCE_SYSTEM.md`, `MASTER_IMPLEMENTATION_AND_PRODUCTION_PLAN.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

<a id="instantanea-autoritativa-del-estado-real"></a>
## Instantánea autoritativa del estado real

> **Clasificación de sección:** `DISEÑO_CONFIRMADO`
> **Fecha de corte:** 2026-08-07
> **Regla:** esta instantánea prevalece sobre ejemplos, planes o estados heredados que puedan interpretarse como implementación existente.

| Campo | Estado real |
| --- | --- |
| Fase actual | Fase 3 — preparación del mundo estratégico mínimo |
| Subfase | M2 cerrado; recepción y desglose de M3 pendientes |
| Último gate aprobado | `M2 — Campaña persistente mínima` |
| Hito técnico aprobado | `M2`, 2026-08-07 |
| Próximo hito | `M3 — Mundo estratégico mínimo` |
| Implementación jugable | Infraestructura M2 ejecutable y persistente en SP; campaña jugable todavía ausente |
| Entregables presentes | misión vanilla; núcleo M1; storage adapter; serialización canónica; checksum; envelopes schema 1; snapshots A/B; guardado manual y autosave; carga, recuperación y migración inicial; diagnóstico y test runner |
| Entregables ausentes | grafo estratégico, sectores simulados, frentes, facciones autónomas, economía, misiones y campaña jugable |
| Pruebas ejecutadas | suites estáticas M0/M1/M2 PASS, Semgrep sin hallazgos y 26 comprobaciones internas PASS en la regresión final de Arma 3 |
| Pruebas de Arma 3 | Arma 3 2.20.152984 x64; reinicio completo y regresión final registrados en [evidencia M2](validation/M2_CAMPAIGN_PERSISTENCE_2026-08-07.md) |
| Bloqueadores canónicos | Ninguno; `DEC-008` cierra el cambio de cabeza Azul y conserva Molos como entrada Roja |
| Bloqueadores técnicos posteriores | Ninguno para iniciar M3; completar validación física de Panochori antes de contenido territorial dependiente y medir rendimiento cuando exista carga estratégica representativa |
| Estado de Fase 0 | Completada; `M0 APROBADO` |
| Estado de Fase 1 | Completada; `M1 APROBADO` |
| Estado de Fase 2 | Completada; `M2 APROBADO` |

<a id="doc-gate-01"></a>
### DOC-GATE-01 — Integridad estructural documental

> **Estado:** aprobado el 2026-07-25.
> **Alcance:** integridad de la biblioteca, no implementación, 3DEN ni ejecución dentro de Arma 3.

Evidencia registrada:

- la biblioteca contiene exactamente 20 fuentes temáticas consolidadas; los anexos de evidencia se registran por separado;
- no existen enlaces locales a archivos ausentes;
- no existen anclas explícitas rotas ni IDs explícitos duplicados dentro de un archivo;
- los bloques de código Markdown están equilibrados;
- el estado real del repositorio se distingue del diseño previsto;
- las decisiones `DEC-001`–`DEC-008` tienen fuente, efecto y trazabilidad.

`DOC-GATE-01` no equivale a `M0`. `M0` exige misión iniciable, funciones registradas, bootstrap, logging verificable y un RPT sin errores críticos.

### M0 — Esqueleto técnico ejecutable

> **Estado:** `APROBADO` el 2026-08-06.
> **Alcance:** infraestructura mínima de Fase 0; no acredita campaña, persistencia, rendimiento ni validación geográfica completa.

| Criterio obligatorio | Evidencia | Resultado |
| --- | --- | --- |
| La misión inicia | dos arranques de `IslasFracturadas` y captura del jugador en mundo | `PASS` |
| `preInit` y `postInit` funcionan | secuencias diferenciadas en RPT, repetidas dos veces | `PASS` |
| Se genera un log estructurado | entradas `[IF][módulo][nivel][tiempo]` | `PASS` |
| Se ejecuta una función registrada | siete comprobaciones de `IF_fnc_smokeTest`, incluidas funciones e IDs | `PASS` |
| No hay errores críticos en RPT | cero candidatos de error o warning en la segunda ventana de misión | `PASS` |
| La estructura está documentada | arquitectura 18, README y prueba estática M0 | `PASS` |
| Existe commit estable | `4b0b1ba` sobre baseline `4150383` | `PASS` |

La evidencia repetible, versión, digest del RPT y límites se conservan en [M0_SMOKE_TEST_2026-08-06.md](validation/M0_SMOKE_TEST_2026-08-06.md). El aviso de ejecución x86 se acepta para esta prueba funcional; cualquier benchmark o presupuesto de rendimiento exige repetir en x64.

### M1 — Núcleo autoritativo estable

> **Estado:** `APROBADO` el 2026-08-06.
> **Alcance:** servicios autoritativos de Fase 1 en SP; no acredita persistencia, multijugador, campaña jugable ni rendimiento.

| Criterio obligatorio | Evidencia | Resultado |
| --- | --- | --- |
| Los servicios inician en orden | configuración, runtime, estado, scheduler y tests alcanzan `PHASE_90_RUNNING` | `PASS` |
| El estado se crea | `IF_campaignState` schema 1 y `hasCanonicalState == true` | `PASS` |
| Un command modifica estado | `M1 state.commandAndQuery` | `PASS` |
| Una query consulta | lectura del valor cambiado y copia defensiva | `PASS` |
| Un evento se procesa una vez | `event.persistent` y `event.repeatedOnce` | `PASS` |
| Una transacción revierte | `transaction.rollback` y restauración del reloj | `PASS` |
| Los tests pasan | diez comprobaciones M1 y siete smoke M0 | `PASS` |
| No existe dependencia de UI | revisión estática y ejecución SP sin consumidor UI | `PASS` |
| No hay errores de misión en RPT | cero candidatos en líneas 728–757 | `PASS` |
| Existe commit estable | `0dc846f` | `PASS` |

La evidencia repetible, digest del RPT, matriz y límites se conservan en [M1_AUTHORITATIVE_CORE_2026-08-06.md](validation/M1_AUTHORITATIVE_CORE_2026-08-06.md). La idempotencia acreditada es de sesión; persistir IDs procesados, snapshots y schema entre reinicios pertenece a M2.

### M2 — Campaña persistente mínima

> **Estado:** `APROBADO` el 2026-08-07.
> **Alcance:** persistencia mínima de campaña en SP; no acredita mundo estratégico, campaña jugable, MP/JIP ni rendimiento.

| Criterio obligatorio | Evidencia | Resultado |
| --- | --- | --- |
| Un estado modificado sobrevive al reinicio | guardado, cierre total y carga desde un proceso x64 nuevo | `PASS` |
| No se duplican efectos | `M2 event.noDuplicateAfterLoad` conserva el ID procesado | `PASS` |
| El snapshot anterior se conserva | rotación `AUTOSAVE_A/B` | `PASS` |
| Un save corrupto no sobrescribe uno válido | fallback a B, reparación del marcador activo y rotación posterior segura | `PASS` |
| El schema aparece en logs | envelopes y carga registran `schemaVersion=1` | `PASS` |
| Guardado manual y guards funcionan | manual válido; transacción abierta y estado incompleto rechazados | `PASS` |
| La migración inicial es segura | v0→v1 idempotente y original preservado | `PASS` |
| Los tests pasan | nueve M2, diez M1 y siete smoke M0 | `PASS` |
| No hay hallazgos estáticos | suites PowerShell, `git diff --check` y Semgrep sobre 61 archivos | `PASS` |
| Existe implementación estable | `5012cc9` y corrección `ded248a` | `PASS` |

La evidencia, los hashes de tres RPT, la matriz completa y los límites se conservan en [M2_CAMPAIGN_PERSISTENCE_2026-08-07.md](validation/M2_CAMPAIGN_PERSISTENCE_2026-08-07.md). El checksum acredita detección de corrupción accidental, no integridad criptográfica; M3 deberá consumir la persistencia sin convertirla en acceso directo desde dominios.

<a id="registro-autoritativo-de-decisiones"></a>
## Registro autoritativo de decisiones

> **Clasificación de sección:** `CANON_RECTOR` para `DEC-002`–`DEC-005` y `DEC-008`; `DISEÑO_CONFIRMADO` para `DEC-001`, `DEC-006` y `DEC-007`.

| ID | Decisión adoptada | Fuentes afectadas | Efecto verificable | Estado |
| --- | --- | --- | --- | --- |
| `DEC-001` | El proyecto separa diseño, implementación y prueba; ningún estado se promueve sin artefacto y evidencia. | 18, 19 y README | M0–M2 son `IMPLEMENTADO` y `PROBADO`; campaña jugable y sistemas posteriores permanecen sin implementar. | adoptada |
| `DEC-002` | La V1 es campaña individual; el cooperativo de un solo bando es una ampliación futura preparada arquitectónicamente. | 01, 15, 18 y 19 | Ningún requisito cooperativo bloquea Fase 0 ni la primera campaña SP. | adoptada |
| `DEC-003` | Una campaña puede demostrar Stratis activa, PHAROS, UMBRAL, HELIOS-CORE y una dirección clandestina; puede inferir a Vardis, pero no autenticar su presencia física ni capturarlo. | 03, 08, 09, 15–19 | `vardisConfirmed == false` durante una campaña aislada. | adoptada |
| `DEC-004` | Completar ambas campañas desbloquea Verdad Comparada, sala de dirección, confirmación física y desenlaces de captura, muerte, juicio, negociación o fuga de Vardis. | 03, 08, 09, 15–19 | Todo desenlace físico de Vardis exige `dualCampaignCompleted == true` y operación dual desbloqueada. | adoptada |
| `DEC-005` | No existe “equivalente excepcional” a completar ambas campañas en V1. | 03 y 09 | S4 solo se desbloquea al completar Azul y Rojo. | adoptada |
| `DEC-006` | Los 38 sectores son arquitectura territorial de diseño hasta validar coordenadas, límites, rutas y anclajes en 3DEN. | 10, 11, 18 y 19 | Ningún dato físico recibe `VALIDADO_3DEN` antes de evidencia de editor y motor. | adoptada |
| `DEC-007` | AZUR-1 y RUBÍ-1 no pasan a producción sin matriz vanilla completa y sustituciones sin DLC. | 13, 15 y 19 | Los perfiles protagonistas conservan `PROPUESTA` hasta aprobar la matriz. | adoptada |
| `DEC-008` | La cabeza de playa principal Azul cambia de Katalaki Bay–Neochori a Panochori Bay–Neri; Molos permanece como entrada principal Roja. | 00, 02, 08–19 y evidencia 3DEN | El Día Cero Azul comienza en la subzona operativa Panochori de `ALT_W_NERI_PANOCHORI`; no se crea un sector 39 y Katalaki queda como sector costero secundario. | adoptada |

### Evidencia y límite de `DEC-008`

El registro [3DEN_BLUE_PANOCHORI_BEACHHEAD.md](validation/3DEN_BLUE_PANOCHORI_BEACHHEAD.md) conserva escenario, motor, coordenadas, pruebas comunicadas y pendientes. La decisión de ubicación es canon rector; las coordenadas y rutas permanecen `VALIDACION_3DEN_EN_CURSO`. No se consideran validados todavía los carriles marítimos, lanchas, vehículo anfibio, profundidad, huella de módulos, alturas, estacionamiento múltiple ni impacto civil.

Toda modificación incompatible requiere actualizar este registro, las fuentes temáticas afectadas y las pruebas correspondientes. Una futura alternativa a la comparación dual requerirá una decisión nueva; no puede reactivar silenciosamente la redacción descartada por `DEC-005`.

<a id="backlog-ejecutable-inicial-de-fase-0"></a>
## Backlog ejecutable inicial de Fase 0

> **Clasificación de sección:** `DISEÑO_CONFIRMADO`
> **Estado global:** completado; evidencia consolidada en el gate M0.

| ID | Tarea | Dependencia | Propietario previsto | Requisito / prueba | Criterio de aceptación | Estado | Evidencia / versión |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `F0-001` | Registrar baseline del repositorio | Ninguna | raíz y documentación | `DEC-001`; inventario | Inventario y revisión inicial verificables sin descartar cambios preexistentes | completada | `4150383` |
| `F0-002` | Crear misión Altis en 3DEN | `F0-001` | `IslasFracturadas.Altis/mission.sqm` | flujo 3DEN; apertura de misión | Existe `mission.sqm`, generado por 3DEN, y abre sin error | completada | misión principal `IslasFracturadas`; jugador vanilla `B_Soldier_F`; prueba física separada |
| `F0-003` | Crear `description.ext` mínimo | `F0-002` | `IslasFracturadas.Altis/description.ext` | arquitectura 18; carga de configuración | Arma 3 reconoce la configuración sin error crítico | completada | título M0 visible; RPT limpio |
| `F0-004` | Crear estructura real de módulos SQF | `F0-001` | raíz de misión y módulos | arquitectura 18; inventario de archivos | Las carpetas necesarias dejan de depender solo de `.gitkeep` | completada | archivos funcionales en `cfg/`, `core/`, `diagnostics/` y `tests/` |
| `F0-005` | Configurar `CfgFunctions` | `F0-003`, `F0-004` | `cfg/` y `description.ext` | contrato de funciones; smoke unitario | Una función `IF_` registrada puede ejecutarse | completada | siete comprobaciones registradas PASS |
| `F0-006` | Crear bootstrap `preInit`/`postInit` | `F0-005` | `core/bootstrap/` | inicialización 18; prueba de ciclos | Ambos ciclos dejan evidencia diferenciada en RPT | completada | dos secuencias `preInit`/`postInit` en RPT |
| `F0-007` | Implementar logger mínimo | `F0-006` | `core/logging/` | logging 18; prueba RPT | Cada log incluye nivel, módulo y mensaje | completada | 24 líneas `[IF]` estructuradas |
| `F0-008` | Crear configuración y validación de IDs | `F0-004` | `core/ids/` y `data/` | IDs estables 18; prueba negativa | El validador detecta ID vacío o duplicado | completada | `ids.validAccepted` e `ids.invalidRejected`: PASS |
| `F0-009` | Crear modo diagnóstico | `F0-006`, `F0-007` | `diagnostics/` | diagnóstico 18; activación/desactivación | Puede activarse sin modificar la lógica normal | completada | modo BASIC e informe M0 en ambas ejecuciones |
| `F0-010` | Crear escenario smoke test | `F0-002`–`F0-009` | `tests/` y misión Altis | inicio, función y logging | Inicio, función registrada y logging pasan en una ejecución | completada | dos ejecuciones consecutivas PASS |
| `F0-011` | Ejecutar gate de RPT | `F0-010` | `tests/` y evidencia externa | criterios de salida de Fase 0 | No hay errores críticos ni funciones ausentes en RPT | completada | `arma3_2026-08-06_10-22-59.rpt`; ventana final sin candidatos |
| `F0-012` | Actualizar estado y evidencia | `F0-011` | documento 19 | trazabilidad y `M0` | Esta instantánea enlaza commit, RPT, versión y resultado | completada | `4b0b1ba`; [registro M0](validation/M0_SMOKE_TEST_2026-08-06.md) |

Cada tarea conservará ID, archivo o módulo propietario, requisitos relacionados, pruebas, estado, evidencia y versión o commit. Ninguna puede marcarse completada solo porque exista documentación de diseño.

<a id="criterios-de-aceptacion-de-direccion-narrativa"></a>
## Criterios de aceptación de dirección narrativa

> **Clasificación de sección:** `DISEÑO_CONFIRMADO`
> **Estado de implementación:** no iniciado.
> **Regla:** estos criterios son puertas futuras de contenido y sistema; su presencia documental no equivale a `IMPLEMENTADO` ni `PROBADO`.

### Gate documental `DOC-GATE-02`

> **Estado:** aprobado el 2026-07-25.
> **Alcance:** contratos y trazabilidad documental; no prueba ejecución, balance, guardado, SQF ni comportamiento dentro de Arma 3.

La capa directora queda documentalmente íntegra cuando:

- los actos I–VIII declaran fantasía, pregunta, cambio irreversible, mecánica, actores autónomos, decisión, escalada, revelación, duda, consecuencia diferida, salida y finales preparados;
- Verde y FIA poseen condiciones de entrada, iniciativa, influencia, ruptura, transición y huella de final;
- los siete relojes directores declaran fases, detonantes, escenas, crisis y resolución;
- cada familia pública de final tiene preparación, señales, bloqueos, representantes y advertencia previa al no retorno;
- progresión, inteligencia, misión y diálogo consumen la misma cadena causal;
- el índice permite trazar acto → facción → personaje → misión → consecuencia → final;
- ninguna afirmación eleva diseño a implementación o revela conocimiento de autor en contenido para jugador.

### Gate funcional narrativo del vertical slice

El vertical slice Azul no se aprueba solo por presentar voces y diálogo variable. Debe superar una prueba guardable y repetible con esta secuencia:

1. en Neochori, proteger civiles y perseguir Verde son alternativas reales con coste;
2. Ward, Hale, Laurent y Torres reaccionan de forma diferenciada y compatible con su conocimiento;
3. la comunidad cambia cooperación, agravio o miedo;
4. Verde ejecuta un plan de reorganización aunque el jugador no la persiga;
5. FIA ofrece información, exige una condición o se distancia;
6. `IF_B_A01_M04` cambia ruta, apoyo, riesgo o ventana;
7. una escena posterior recuerda el efecto, no solo la elección;
8. guardado/carga conserva detonante, estado parcial y consecuencias programadas;
9. el debriefing informa hechos observables sin exponer pesos;
10. al menos una relación y una contribución de final conservan trazabilidad de origen.

Se ejecutan dos perfiles principales, una omisión/expiración y una carga entre decisión y recordatorio. Un defecto en cualquier eslabón invalida la demostración narrativa aunque el combate termine correctamente.

### Matriz de pruebas causales

| Área | Preparación | Acción | Resultado verificable | Regresión obligatoria |
| --- | --- | --- | --- | --- |
| Agencia de facción | fijar recursos, objetivo y reloj; no aceptar la misión | avanzar tiempo estratégico | la facción actúa, consume recursos y genera noticia/misión transformada | guardar antes de expirar y cargar después |
| Evolución Verde/FIA | estado próximo a transición con un detonante ausente | aplicar o negar detonante | no cambia prematuramente; cambia una vez al completar condiciones | sustitución de líder y actor regional |
| Reloj personal | cooperación con señales acumuladas | provocar detonante de rivalidad/ruptura | escena, conducta, misión y mando cambian coherentemente | participante muerto usa sustituto funcional |
| Consecuencia diferida | registrar arma, promesa, herido o evidencia | alcanzar condición posterior | reaparece el mismo objeto/deuda/hecho con procedencia | carga, rama alternativa y expiración |
| Escalada | comparar dos actos consecutivos | ejecutar conjunto representativo | aumentan al menos dos ejes y existe recuperación tras pico | dificultad no borra coste moral/político |
| Revelación | evidencia incompleta y actores con accesos distintos | autenticar y distribuir selectivamente | cada actor conoce/reacciona solo a lo recibido | metaconocimiento y fuente contaminada |
| Progresión | capacidad formal sin confianza o información | intentar ordenar | obediencia, alternativa y explicación responden a ejes separados | ascenso no concede acceso indebido |
| Preparación de final | construir y bloquear una familia | cruzar no retorno | advertencia reconoce viabilidad; validador elige resultado coherente | perfiles dorados de las 14 familias |
| Diálogo | decisión con cuatro perspectivas | interrumpir o perder participante | función reaparece por fallback sin duplicarse | subtítulos, guardado y callback único |

### Trazabilidad mínima de evidencia

Cada caso futuro registra `testId`, versión, fixture, estado inicial, acción, resultado esperado/real, `missionId` o evento causal, variables modificadas, captura/RPT si aplica y defecto relacionado. Las pruebas documentales pueden comprobar contratos y enlaces; solo Arma 3 puede aportar evidencia funcional, de rendimiento o 3DEN.

## Contenido consolidado

<a id="fuente-master-testing-performance-and-balance-system"></a>
## Fuente integrada: `MASTER_TESTING_PERFORMANCE_AND_BALANCE_SYSTEM.md`

> **Procedencia:** contenido migrado de `MASTER_TESTING_PERFORMANCE_AND_BALANCE_SYSTEM.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-master-testing-performance-and-balance-system--islas-fracturadas"></a>
### ISLAS FRACTURADAS

<a id="src-master-testing-performance-and-balance-system--documento-1314-sistema-maestro-de-pruebas-rendimiento-y-balance"></a>
#### Documento 13/14 — Sistema maestro de pruebas, rendimiento y balance

**Versión:** 1.0
**Clasificación:** documento rector de validación, calidad, estabilidad y equilibrio
**Motor:** Arma 3 2.18
**Campañas:** Fuerza Azul y Fuerza Roja
**Territorios:** Altis y Stratis
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando, servidor dedicado y Headless Client opcional
**Estado:** canon previo a implementación y producción

> **Jerarquía documental:** este Documento 13/14 gobierna estrategia de pruebas, fixtures, defectos, regresión, métricas, presupuestos de rendimiento, balance, dificultad y puertas de aprobación. Cada documento de sistema conserva sus reglas e invariantes funcionales; [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture) conserva la arquitectura del runner y los adaptadores; [THREEDEN_GEOGRAPHY_AND_PHYSICAL_VALIDATION_GUIDE.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide), la validación física por sector; [MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md](13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md#fuente-military-system-order-of-battle-and-force-catalog), las cifras autoritativas de fuerzas y activos; y [MASTER_IMPLEMENTATION_AND_PRODUCTION_PLAN.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan), el calendario lógico de gates, suites y entregas. Los presupuestos aquí definidos son hipótesis iniciales hasta medirse en el vertical slice.

---

<a id="src-master-testing-performance-and-balance-system--1-propósito"></a>
### 1. Propósito

Este documento define cómo se verificará que Islas Fracturadas:

* funciona;
* conserva coherencia;
* no duplica estados;
* mantiene partidas persistentes;
* respeta la autoridad estratégica;
* presenta misiones causales;
* utiliza correctamente la virtualización;
* mantiene rendimiento aceptable;
* ofrece dificultad justa;
* equilibra fuerzas y recursos;
* reacciona a victorias y fracasos;
* evita bloqueos narrativos;
* mantiene consistencia entre Azul y Rojo;
* permite continuar la campaña después de errores recuperables;
* puede ampliarse sin destruir sistemas existentes.

También establece:

* niveles de pruebas;
* escenarios;
* matrices;
* métricas;
* presupuestos;
* criterios de aprobación;
* balance militar;
* balance logístico;
* balance civil;
* balance de inteligencia;
* dificultad;
* regresión;
* pruebas de guardado;
* validación 3DEN;
* pruebas de campaña completa;
* procesos de corrección.

<a id="src-master-testing-performance-and-balance-system--principio-central"></a>
#### Principio central

> Ningún sistema se considerará terminado porque funcione una vez en una situación ideal.

> Se considerará estable cuando funcione repetidamente, falle de forma controlada, conserve el estado correcto y continúe siendo comprensible bajo situaciones inesperadas.

---

<a id="src-master-testing-performance-and-balance-system--2-objetivos-de-calidad"></a>
### 2. Objetivos de calidad

La campaña deberá cumplir cinco condiciones generales.

<a id="src-master-testing-performance-and-balance-system--21-corrección"></a>
#### 2.1 Corrección

El estado final coincide con las reglas.

Ejemplos:

* un convoy descarga una sola vez;
* una baja se registra una sola vez;
* un sector tiene un único propietario;
* una evidencia no aparece después de destruirse.

<a id="src-master-testing-performance-and-balance-system--22-estabilidad"></a>
#### 2.2 Estabilidad

La campaña puede continuar durante muchas horas sin:

* corrupción;
* crecimiento incontrolado;
* errores acumulativos;
* pérdida de rendimiento extrema.

<a id="src-master-testing-performance-and-balance-system--23-coherencia"></a>
#### 2.3 Coherencia

Los sistemas reaccionan de forma lógica.

Ejemplos:

* una fuerza sin combustible pierde movilidad;
* un hospital sin personal no funciona;
* una autoridad muerta no ofrece misiones;
* una ruta destruida afecta convoyes.

<a id="src-master-testing-performance-and-balance-system--24-legibilidad"></a>
#### 2.4 Legibilidad

El jugador comprende:

* qué ocurrió;
* por qué;
* qué puede hacer;
* qué consecuencia tuvo.

<a id="src-master-testing-performance-and-balance-system--25-reproducibilidad"></a>
#### 2.5 Reproducibilidad

Los errores importantes pueden:

* repetirse;
* registrarse;
* aislarse;
* probarse después de corregirse.

---

<a id="src-master-testing-performance-and-balance-system--3-filosofía-de-pruebas"></a>
### 3. Filosofía de pruebas

Las pruebas seguirán cuatro principios.

1. Probar reglas antes de probar contenido.
2. Probar módulos aislados antes de campañas completas.
3. Probar fracasos además de éxitos.
4. Convertir cada error grave en una prueba de regresión.

<a id="src-master-testing-performance-and-balance-system--regla"></a>
#### Regla

No se ampliará a nuevos actos o regiones si el vertical slice todavía presenta:

* duplicación;
* corrupción;
* bloqueos;
* rendimiento inestable;
* lógica territorial inconsistente.

---

<a id="src-master-testing-performance-and-balance-system--4-pirámide-de-pruebas"></a>
### 4. Pirámide de pruebas

```text id="5dlk5d"
Pruebas unitarias
Pruebas de módulo
Pruebas de integración
Pruebas de sistema
Pruebas E2E
Pruebas de campaña completa
Pruebas de estrés y duración
Pruebas manuales y narrativas
```

Las capas inferiores deben ser numerosas y rápidas.

Las capas superiores serán menos frecuentes, pero más completas.

---

<a id="src-master-testing-performance-and-balance-system--5-pruebas-unitarias"></a>
### 5. Pruebas unitarias

Verifican funciones pequeñas y reglas aisladas.

Ejemplos:

* cálculo de profundidad del frente;
* reserva de recursos;
* validación de autoridad;
* envejecimiento de informes;
* actualización de confianza;
* puntuación de misión;
* selección de composición;
* resultado de una condición.

<a id="src-master-testing-performance-and-balance-system--características"></a>
#### Características

* datos controlados;
* sin objetos físicos cuando sea posible;
* resultados deterministas;
* ejecución rápida.

---

<a id="src-master-testing-performance-and-balance-system--6-pruebas-de-módulo"></a>
### 6. Pruebas de módulo

Verifican un sistema completo con adaptadores falsos.

Ejemplos:

<a id="src-master-testing-performance-and-balance-system--logística"></a>
#### Logística

* creación de convoy;
* reserva;
* llegada;
* pérdida;
* devolución.

<a id="src-master-testing-performance-and-balance-system--sectores"></a>
#### Sectores

* captura;
* profundidad;
* rol;
* estabilidad.

<a id="src-master-testing-performance-and-balance-system--fia"></a>
#### FIA

* reclutamiento;
* exposición;
* operación;
* contrainsurgencia.

<a id="src-master-testing-performance-and-balance-system--inteligencia"></a>
#### Inteligencia

* creación de informe;
* distribución;
* envejecimiento;
* contradicción.

---

<a id="src-master-testing-performance-and-balance-system--7-pruebas-de-integración"></a>
### 7. Pruebas de integración

Verifican la interacción entre dos o más módulos.

Ejemplos:

```text id="723d7x"
Logística + Misiones
Sectores + Construcción
Fuerzas + Virtualización
Civiles + Gobierno
Inteligencia + IA estratégica
Evidencia + Progresión
FIA + Civiles
Helios + Logística
```

---

<a id="src-master-testing-performance-and-balance-system--8-pruebas-de-sistema"></a>
### 8. Pruebas de sistema

Ejecutan una porción jugable con múltiples sistemas.

Ejemplo:

* captura de Neochori;
* administración municipal;
* demanda de combustible;
* convoy;
* emboscada;
* bajas;
* debriefing;
* guardado.

---

<a id="src-master-testing-performance-and-balance-system--9-pruebas-e2e"></a>
### 9. Pruebas E2E

Simulan el flujo completo del jugador.

```text id="r7rwfg"
Nueva campaña
→ briefing
→ misión
→ consecuencia
→ interfaz
→ guardado
→ carga
→ operación siguiente
```

<a id="src-master-testing-performance-and-balance-system--objetivo"></a>
#### Objetivo

Confirmar que el contenido visible corresponde al estado real autorizado.

---

<a id="src-master-testing-performance-and-balance-system--10-pruebas-de-campaña-completa"></a>
### 10. Pruebas de campaña completa

Verifican:

* progresión de actos;
* puntos de no retorno;
* estados alternativos;
* muertes;
* relaciones;
* finales;
* comparación Azul–Rojo.

Estas pruebas pueden utilizar:

* juego manual;
* herramientas de aceleración;
* fixtures;
* simulación abstracta.

---

<a id="src-master-testing-performance-and-balance-system--11-pruebas-de-larga-duración"></a>
### 11. Pruebas de larga duración

La campaña debe ejecutarse durante periodos prolongados para detectar:

* crecimiento de memoria;
* acumulación de eventos;
* pérdida de FPS;
* estados huérfanos;
* errores de scheduler;
* saves excesivamente grandes.

<a id="src-master-testing-performance-and-balance-system--escenarios"></a>
#### Escenarios

```text id="d6onqe"
8 horas de campaña simulada
24 horas estratégicas aceleradas
7 días estratégicos
Campaña completa con múltiples cargas
```

---

<a id="src-master-testing-performance-and-balance-system--12-pruebas-manuales"></a>
### 12. Pruebas manuales

Serán obligatorias para:

* IA;
* conducción;
* combate;
* diálogo;
* geografía;
* interfaz;
* ritmo;
* claridad;
* inmersión.

<a id="src-master-testing-performance-and-balance-system--regla-1"></a>
#### Regla

Una prueba automatizada puede demostrar que un convoy llega.

Solo una prueba manual puede determinar si:

* conduce de forma creíble;
* se atasca;
* aparece delante del jugador;
* resulta frustrante escoltarlo.

---

<a id="src-master-testing-performance-and-balance-system--13-estados-de-una-prueba"></a>
### 13. Estados de una prueba

```text id="xbwf33"
NOT_RUN
PASSED
FAILED
BLOCKED
SKIPPED
FLAKY
```

<a id="src-master-testing-performance-and-balance-system--flaky"></a>
#### FLAKY

Prueba con resultado inconsistente.

No se considerará aprobada hasta identificar:

* causa;
* condición;
* aleatoriedad;
* dependencia temporal.

---

<a id="src-master-testing-performance-and-balance-system--14-severidad-de-defectos"></a>
### 14. Severidad de defectos

```text id="zi8uet"
S0 — Bloqueador
S1 — Crítico
S2 — Importante
S3 — Moderado
S4 — Menor
```

<a id="src-master-testing-performance-and-balance-system--s0-bloqueador"></a>
#### S0 — Bloqueador

* corrupción de guardado;
* campaña no inicia;
* misión principal imposible;
* estado irrecuperable.

<a id="src-master-testing-performance-and-balance-system--s1-crítico"></a>
#### S1 — Crítico

* duplicación;
* pérdida grave de estado;
* autoridad rota;
* rendimiento injugable;
* final incorrecto.

<a id="src-master-testing-performance-and-balance-system--s2-importante"></a>
#### S2 — Importante

* sistema principal incorrecto;
* misión sin consecuencia;
* IA bloqueada;
* relación inconsistente.

<a id="src-master-testing-performance-and-balance-system--s3-moderado"></a>
#### S3 — Moderado

* interfaz confusa;
* diálogo incorrecto;
* balance puntual;
* animación.

<a id="src-master-testing-performance-and-balance-system--s4-menor"></a>
#### S4 — Menor

* texto;
* sonido;
* decoración;
* detalle visual.

---

<a id="src-master-testing-performance-and-balance-system--15-estado-de-corrección"></a>
### 15. Estado de corrección

```text id="5lyyz8"
OPEN
CONFIRMED
IN_PROGRESS
FIXED
VERIFIED
CLOSED
WONT_FIX
DEFERRED
```

<a id="src-master-testing-performance-and-balance-system--regla-2"></a>
#### Regla

`FIXED` significa que existe un cambio.

`VERIFIED` significa que la prueba original y la regresión pasan.

---

<a id="src-master-testing-performance-and-balance-system--16-ficha-de-defecto"></a>
### 16. Ficha de defecto

```text id="nrgeea"
Defect ID:
Versión:
Severidad:
Módulo:
Escenario:
Pasos:
Resultado esperado:
Resultado real:
Frecuencia:
Save adjunto:
RPT:
Captura o vídeo:
Semilla:
Estado:
```

---

<a id="src-master-testing-performance-and-balance-system--17-reproducción"></a>
### 17. Reproducción

Cada defecto complejo deberá registrar:

* versión;
* save;
* semilla;
* tiempo estratégico;
* sector;
* misión;
* entidades implicadas;
* configuración;
* dificultad.

---

<a id="src-master-testing-performance-and-balance-system--18-pruebas-deterministas"></a>
### 18. Pruebas deterministas

Los sistemas persistentes utilizarán semillas para poder repetir:

* batallas virtuales;
* eventos;
* selección de variantes;
* decisiones IA;
* generación de misiones.

<a id="src-master-testing-performance-and-balance-system--regla-3"></a>
#### Regla

No se cambiará aleatoriamente la semilla durante una repetición de depuración.

---

<a id="src-master-testing-performance-and-balance-system--19-fixtures"></a>
### 19. Fixtures

Se crearán estados mínimos conocidos.

```text id="ao3i8t"
FIXTURE_EMPTY_CAMPAIGN
FIXTURE_BLUE_BEACHHEAD
FIXTURE_NEOCHORI_CAPTURED
FIXTURE_CONVOY_READY
FIXTURE_GREEN_FRAGMENTED
FIXTURE_HELIOS_COMPROMISED
FIXTURE_STRATIS_ENTRY
```

---

<a id="src-master-testing-performance-and-balance-system--20-pruebas-de-invariantes"></a>
### 20. Pruebas de invariantes

Después de cada operación importante se comprobarán invariantes.

Ejemplos:

```text id="0x4we1"
Un solo propietario por sector.
Un activo no reservado dos veces.
Una misión no resuelta dos veces.
Un personaje no vivo y muerto.
Un convoy no en dos estados incompatibles.
```

---

<a id="src-master-testing-performance-and-balance-system--21-pruebas-del-bootstrap"></a>
### 21. Pruebas del bootstrap

<a id="src-master-testing-performance-and-balance-system--casos"></a>
#### Casos

1. Nueva campaña.
2. Carga válida.
3. Configuración faltante.
4. ID duplicado.
5. sector sin anclaje.
6. classname inválido.
7. módulo opcional ausente.
8. save incompatible.
9. editor preview.
10. servidor futuro.

<a id="src-master-testing-performance-and-balance-system--criterio"></a>
#### Criterio

El sistema debe:

* iniciar correctamente;
* fallar con mensaje claro;
* no continuar con estado corrupto.

---

<a id="src-master-testing-performance-and-balance-system--22-pruebas-de-configuración"></a>
### 22. Pruebas de configuración

Verificar:

* IDs únicos;
* dependencias;
* fallbacks;
* recursos;
* sectores;
* conexiones;
* composiciones;
* unidades;
* personajes;
* plantillas.

<a id="src-master-testing-performance-and-balance-system--error-crítico"></a>
#### Error crítico

Una referencia a un ID inexistente.

---

<a id="src-master-testing-performance-and-balance-system--23-pruebas-de-estado"></a>
### 23. Pruebas de estado

Verificar:

* campos obligatorios;
* tipos;
* rangos;
* referencias;
* estados permitidos;
* combinaciones incompatibles.

---

<a id="src-master-testing-performance-and-balance-system--24-pruebas-de-eventos"></a>
### 24. Pruebas de eventos

<a id="src-master-testing-performance-and-balance-system--casos-1"></a>
#### Casos

* publicación;
* entrega;
* handler inexistente;
* handler duplicado;
* procesamiento repetido;
* evento persistente;
* evento transitorio;
* orden de procesamiento;
* cola saturada.

<a id="src-master-testing-performance-and-balance-system--invariante"></a>
#### Invariante

Un evento idempotente produce una sola consecuencia.

---

<a id="src-master-testing-performance-and-balance-system--25-pruebas-del-scheduler"></a>
### 25. Pruebas del scheduler

Verificar:

* ejecución;
* prioridad;
* retraso;
* presupuesto;
* tareas deshabilitadas;
* cambio de tiempo;
* pausa;
* carga.

<a id="src-master-testing-performance-and-balance-system--estrés"></a>
#### Estrés

Registrar cientos de tareas sin bloquear el frame.

---

<a id="src-master-testing-performance-and-balance-system--26-pruebas-de-transacciones"></a>
### 26. Pruebas de transacciones

Casos:

1. Commit completo.
2. Fallo antes de reserva.
3. Fallo después de reserva.
4. Fallo durante materialización.
5. Rollback.
6. Carga con transacción abierta.
7. doble commit.
8. timeout.

<a id="src-master-testing-performance-and-balance-system--invariante-1"></a>
#### Invariante

Después de rollback, todos los recursos y activos vuelven a su estado anterior.

---

<a id="src-master-testing-performance-and-balance-system--27-pruebas-de-guardado"></a>
### 27. Pruebas de guardado

Deben cubrir:

* guardado manual;
* autosave;
* checkpoint;
* snapshot A/B;
* guardado durante misión;
* guardado tras captura;
* guardado con fuerzas virtuales;
* guardado con proyección activa.

---

<a id="src-master-testing-performance-and-balance-system--28-pruebas-de-carga"></a>
### 28. Pruebas de carga

Verificar:

* estado;
* relaciones;
* misiones;
* fuerzas;
* recursos;
* personajes;
* evidencia;
* tiempo;
* UI;
* semillas.

<a id="src-master-testing-performance-and-balance-system--regla-4"></a>
#### Regla

Cargar no debe volver a ejecutar consecuencias ya aplicadas.

---

<a id="src-master-testing-performance-and-balance-system--29-pruebas-de-corrupción"></a>
### 29. Pruebas de corrupción

Simular:

* payload incompleto;
* schema incorrecto;
* checksum inválido;
* snapshot A dañado;
* índice inconsistente.

<a id="src-master-testing-performance-and-balance-system--resultado"></a>
#### Resultado

* utilizar snapshot B;
* informar;
* no sobrescribir automáticamente el último save válido.

---

<a id="src-master-testing-performance-and-balance-system--30-pruebas-de-migración"></a>
### 30. Pruebas de migración

Para cada versión:

```text id="oq21lz"
Estado V1
→ migrar
→ validar V2
→ guardar
→ cargar V2
```

<a id="src-master-testing-performance-and-balance-system--pruebas-negativas"></a>
#### Pruebas negativas

* campo desconocido;
* dato ausente;
* versión no soportada;
* migración interrumpida.

---

<a id="src-master-testing-performance-and-balance-system--31-prueba-de-campaña-nueva-tras-actualización"></a>
### 31. Prueba de campaña nueva tras actualización

Una actualización no debe romper:

* creación de campaña;
* configuración inicial;
* vertical slice;
* UI;
* primer guardado.

---

<a id="src-master-testing-performance-and-balance-system--32-pruebas-territoriales"></a>
### 32. Pruebas territoriales

Casos:

* captura completa;
* captura parcial;
* retirada;
* recuperación;
* sector disputado;
* sector aislado;
* enclave;
* saliente;
* cambio de profundidad;
* nueva conexión.

---

<a id="src-master-testing-performance-and-balance-system--33-pruebas-de-control"></a>
### 33. Pruebas de control

Verificar diferencias entre:

* control militar;
* autoridad;
* estabilidad;
* presencia FIA;
* propietario formal.

<a id="src-master-testing-performance-and-balance-system--ejemplo"></a>
#### Ejemplo

Azul controla Neochori, pero el municipio sigue siendo autoridad reconocida.

---

<a id="src-master-testing-performance-and-balance-system--34-pruebas-de-fortificación"></a>
### 34. Pruebas de fortificación

Verificar:

* orientación;
* selección;
* capacidad;
* prohibiciones;
* construcción;
* daño;
* captura;
* reconstrucción.

---

<a id="src-master-testing-performance-and-balance-system--35-pruebas-de-construcción"></a>
### 35. Pruebas de construcción

Casos:

1. Recursos suficientes.
2. Recursos insuficientes.
3. anclaje ocupado.
4. sector P0.
5. módulo prohibido.
6. proyecto interrumpido.
7. captura durante construcción.
8. cancelación.
9. daño.
10. guardado.

---

<a id="src-master-testing-performance-and-balance-system--36-pruebas-de-profundidad-del-frente"></a>
### 36. Pruebas de profundidad del frente

Crear mapas controlados para comprobar:

* P0;
* P1;
* P2;
* P3;
* P4;
* sector aislado;
* sector cercado;
* cabeza de playa.

---

<a id="src-master-testing-performance-and-balance-system--37-pruebas-de-fuerzas"></a>
### 37. Pruebas de fuerzas

Verificar:

* creación;
* fuerza efectiva;
* bajas;
* heridas;
* reemplazos;
* moral;
* cohesión;
* suministro;
* asignación;
* retirada;
* destrucción.

---

<a id="src-master-testing-performance-and-balance-system--38-pruebas-de-reserva"></a>
### 38. Pruebas de reserva

Intentar utilizar:

* misma formación;
* mismo vehículo;
* misma artillería;
* misma escolta;

en dos operaciones simultáneas.

Resultado esperado:

* segundo compromiso rechazado o requiere cancelar el primero.

---

<a id="src-master-testing-performance-and-balance-system--39-pruebas-de-virtualización"></a>
### 39. Pruebas de virtualización

Casos:

1. V0 a V1.
2. V1 a V3.
3. V3 a V1.
4. entrada del jugador.
5. salida del jugador.
6. combate activo.
7. personaje presente.
8. vehículo único.
9. guardado.
10. carga.

---

<a id="src-master-testing-performance-and-balance-system--40-pruebas-de-duplicación-física"></a>
### 40. Pruebas de duplicación física

Verificar que:

* una formación no se materializa dos veces;
* un vehículo no aparece duplicado;
* una baja no se registra al morir y al reintegrar;
* un grupo eliminado no reaparece sin reserva.

---

<a id="src-master-testing-performance-and-balance-system--41-pruebas-de-desmaterialización"></a>
### 41. Pruebas de desmaterialización

Casos bloqueados:

* bajo fuego;
* visible;
* con jugador;
* durante diálogo;
* con vehículo explotando;
* con interacción.

Casos permitidos:

* lejos;
* no visible;
* fuera de combate;
* estado capturado.

---

<a id="src-master-testing-performance-and-balance-system--42-pruebas-de-batalla-virtual"></a>
### 42. Pruebas de batalla virtual

Validar:

* fases;
* fuerza;
* terreno;
* sorpresa;
* moral;
* suministros;
* retirada;
* persecución;
* resultados parciales.

---

<a id="src-master-testing-performance-and-balance-system--43-pruebas-de-entrada-tardía"></a>
### 43. Pruebas de entrada tardía

El jugador entra en una batalla:

* antes del contacto;
* durante combate;
* después de bajas;
* durante retirada.

<a id="src-master-testing-performance-and-balance-system--verificar"></a>
#### Verificar

* daño;
* munición;
* posiciones;
* restos;
* fuerzas disponibles.

---

<a id="src-master-testing-performance-and-balance-system--44-pruebas-de-retirada"></a>
### 44. Pruebas de retirada

Casos:

* ruta abierta;
* ruta bloqueada;
* moral baja;
* orden;
* persecución;
* dispersión.

<a id="src-master-testing-performance-and-balance-system--invariante-2"></a>
#### Invariante

Retirada no equivale a destrucción.

---

<a id="src-master-testing-performance-and-balance-system--45-pruebas-de-rendición"></a>
### 45. Pruebas de rendición

Verificar:

* señal;
* alto el fuego;
* desarme;
* registro;
* traslado;
* formación de origen;
* trato posterior.

---

<a id="src-master-testing-performance-and-balance-system--46-pruebas-de-vehículos"></a>
### 46. Pruebas de vehículos

Casos:

* daño ligero;
* daño pesado;
* inmovilización;
* abandono;
* recuperación;
* captura;
* reparación;
* destrucción;
* salvamento;
* cambio de propietario.

---

<a id="src-master-testing-performance-and-balance-system--47-pruebas-logísticas"></a>
### 47. Pruebas logísticas

Verificar:

* producción;
* almacenamiento;
* reserva;
* transporte;
* consumo;
* déficit;
* llegada;
* pérdida;
* captura.

---

<a id="src-master-testing-performance-and-balance-system--48-pruebas-de-convoy"></a>
### 48. Pruebas de convoy

Escenarios:

1. Ruta segura.
2. Ruta amenazada.
3. Emboscada.
4. desvío.
5. vehículo averiado.
6. carga parcial.
7. pérdida total.
8. llegada.
9. escolta retirada.
10. resolución virtual.

---

<a id="src-master-testing-performance-and-balance-system--49-pruebas-de-descarga"></a>
### 49. Pruebas de descarga

Intentar:

* descargar una vez;
* descargar dos veces;
* cargar después de llegar;
* destruir vehículo antes de descarga;
* guardar durante descarga.

<a id="src-master-testing-performance-and-balance-system--invariante-3"></a>
#### Invariante

La carga total nunca supera la cantidad original.

---

<a id="src-master-testing-performance-and-balance-system--50-pruebas-de-consumo"></a>
### 50. Pruebas de consumo

Verificar:

* estado IDLE;
* patrulla;
* movimiento;
* combate;
* reorganización.

<a id="src-master-testing-performance-and-balance-system--balance"></a>
#### Balance

La diferencia debe ser perceptible y razonable.

---

<a id="src-master-testing-performance-and-balance-system--51-pruebas-de-combustible"></a>
### 51. Pruebas de combustible

Comprobar:

* movimiento estratégico;
* vehículos físicos;
* reintegración;
* autonomía;
* combustible negativo;
* suministro parcial.

---

<a id="src-master-testing-performance-and-balance-system--52-pruebas-de-munición"></a>
### 52. Pruebas de munición

Separar:

* ligera;
* pesada;
* AT;
* AA;
* artillería.

<a id="src-master-testing-performance-and-balance-system--verificar-1"></a>
#### Verificar

Una fuerza puede tener munición ligera y carecer de capacidad antitanque.

---

<a id="src-master-testing-performance-and-balance-system--53-pruebas-de-mantenimiento"></a>
### 53. Pruebas de mantenimiento

Casos:

* desgaste;
* reparación ligera;
* reparación pesada;
* falta de repuestos;
* taller insuficiente;
* canibalización;
* recuperación.

---

<a id="src-master-testing-performance-and-balance-system--54-pruebas-de-economía-civil"></a>
### 54. Pruebas de economía civil

Verificar:

* mercado;
* precios;
* escasez;
* trabajadores;
* huelga;
* reconstrucción;
* requisición;
* compensación.

---

<a id="src-master-testing-performance-and-balance-system--55-pruebas-civiles"></a>
### 55. Pruebas civiles

Casos:

* control militar alto;
* confianza baja;
* apoyo alto;
* miedo alto;
* servicios colapsados;
* desplazamiento;
* protesta;
* retorno.

---

<a id="src-master-testing-performance-and-balance-system--56-pruebas-de-estabilidad"></a>
### 56. Pruebas de estabilidad

Crear sectores con:

* seguridad alta y servicios bajos;
* servicios altos y combate activo;
* obediencia por miedo;
* legitimidad alta y caos temporal.

<a id="src-master-testing-performance-and-balance-system--objetivo-1"></a>
#### Objetivo

Demostrar que estabilidad no se reduce a apoyo.

---

<a id="src-master-testing-performance-and-balance-system--57-pruebas-de-servicios"></a>
### 57. Pruebas de servicios

Para cada servicio:

* infraestructura;
* personal;
* recursos;
* seguridad;
* acceso.

<a id="src-master-testing-performance-and-balance-system--invariante-4"></a>
#### Invariante

Un edificio intacto sin personal no produce capacidad completa.

---

<a id="src-master-testing-performance-and-balance-system--58-pruebas-de-desplazamiento"></a>
### 58. Pruebas de desplazamiento

Verificar:

* salida;
* llegada;
* presión;
* campamento;
* retorno;
* población total.

<a id="src-master-testing-performance-and-balance-system--invariante-5"></a>
#### Invariante

La población desplazada no desaparece.

---

<a id="src-master-testing-performance-and-balance-system--59-pruebas-de-bajas-civiles"></a>
### 59. Pruebas de bajas civiles

Verificar:

* responsable real;
* responsable percibido;
* testigos;
* investigación;
* rumor;
* memoria;
* efecto político.

---

<a id="src-master-testing-performance-and-balance-system--60-pruebas-de-protestas"></a>
### 60. Pruebas de protestas

Casos:

* pacífica;
* tensa;
* violenta;
* negociada;
* reprimida;
* ignorada.

<a id="src-master-testing-performance-and-balance-system--verificar-2"></a>
#### Verificar

* causa;
* liderazgo;
* respuesta;
* consecuencia.

---

<a id="src-master-testing-performance-and-balance-system--61-pruebas-de-huelga"></a>
### 61. Pruebas de huelga

Verificar:

* trabajadores;
* servicio afectado;
* negociación;
* sustitución;
* militarización;
* radicalización.

---

<a id="src-master-testing-performance-and-balance-system--62-pruebas-de-gobierno"></a>
### 62. Pruebas de Gobierno

Casos:

* administración militar;
* municipio supervisado;
* consejo cooperador;
* Gobierno restaurado;
* autoridad dual;
* colapso.

---

<a id="src-master-testing-performance-and-balance-system--63-pruebas-de-promesas"></a>
### 63. Pruebas de promesas

Estados:

* activa;
* cumplida;
* retrasada;
* rota;
* imposible.

<a id="src-master-testing-performance-and-balance-system--verificar-3"></a>
#### Verificar

* memoria;
* relación;
* interfaz;
* epílogo.

---

<a id="src-master-testing-performance-and-balance-system--64-pruebas-fia"></a>
### 64. Pruebas FIA

Verificar:

* célula;
* apoyo público;
* apoyo privado;
* reclutamiento;
* armas;
* depósito;
* operación;
* exposición;
* retirada.

---

<a id="src-master-testing-performance-and-balance-system--65-pruebas-de-célula"></a>
### 65. Pruebas de célula

Casos:

* obediente;
* autónoma;
* comprometida;
* evacuada;
* destruida;
* infiltrada;
* control abierto.

---

<a id="src-master-testing-performance-and-balance-system--66-pruebas-de-apoyo-clandestino"></a>
### 66. Pruebas de apoyo clandestino

Crear sector con:

* obediencia alta a Azul;
* apoyo privado alto a FIA;
* miedo alto.

<a id="src-master-testing-performance-and-balance-system--verificar-4"></a>
#### Verificar

* ocultamiento;
* información;
* reclutamiento;
* detección.

---

<a id="src-master-testing-performance-and-balance-system--67-pruebas-de-contrainsurgencia"></a>
### 67. Pruebas de contrainsurgencia

Modelos:

* coercitivo;
* protección;
* inteligencia selectiva;
* militar de área.

<a id="src-master-testing-performance-and-balance-system--medir"></a>
#### Medir

* células descubiertas;
* falsos positivos;
* radicalización;
* confianza;
* coste.

---

<a id="src-master-testing-performance-and-balance-system--68-pruebas-markoukallas"></a>
### 68. Pruebas Markou–Kallas

Verificar:

* cooperación;
* tensión;
* división;
* hostilidad;
* sucesión;
* efectos en células.

---

<a id="src-master-testing-performance-and-balance-system--69-pruebas-de-némesis"></a>
### 69. Pruebas de Némesis

Casos:

* influencia baja;
* influencia alta;
* falsa bandera;
* exposición;
* escape;
* captura.

<a id="src-master-testing-performance-and-balance-system--regla-5"></a>
#### Regla

La evidencia debe permitir descubrirlo.

---

<a id="src-master-testing-performance-and-balance-system--70-pruebas-de-inteligencia"></a>
### 70. Pruebas de inteligencia

Verificar:

* observación;
* informe;
* evaluación;
* distribución;
* creencia;
* decisión.

---

<a id="src-master-testing-performance-and-balance-system--71-pruebas-de-precisión-y-confianza"></a>
### 71. Pruebas de precisión y confianza

Casos:

```text id="4x3fr2"
Precisión alta / confianza alta
Precisión alta / confianza baja
Precisión baja / confianza alta
Precisión baja / confianza baja
```

<a id="src-master-testing-performance-and-balance-system--objetivo-2"></a>
#### Objetivo

Confirmar que no se confunden.

---

<a id="src-master-testing-performance-and-balance-system--72-pruebas-de-envejecimiento"></a>
### 72. Pruebas de envejecimiento

Para:

* contacto;
* fuerza móvil;
* guarnición;
* fortificación;
* política.

<a id="src-master-testing-performance-and-balance-system--verificar-5"></a>
#### Verificar

* cambio de etiqueta;
* aumento de incertidumbre;
* marcadores;
* decisiones IA.

---

<a id="src-master-testing-performance-and-balance-system--73-pruebas-de-fuentes-dependientes"></a>
### 73. Pruebas de fuentes dependientes

Crear tres informes derivados del mismo dato.

Resultado esperado:

* una sola raíz;
* no aumentar confianza como tres fuentes independientes.

---

<a id="src-master-testing-performance-and-balance-system--74-pruebas-de-contradicción"></a>
### 74. Pruebas de contradicción

Generar informes incompatibles.

Verificar:

* estado `CONTESTED`;
* interfaz;
* requerimiento nuevo;
* decisión del comandante.

---

<a id="src-master-testing-performance-and-balance-system--75-pruebas-de-omnisciencia"></a>
### 75. Pruebas de omnisciencia

Escenario:

* jugador destruye convoy sin supervivientes;
* comunicaciones bloqueadas;
* nadie observa.

<a id="src-master-testing-performance-and-balance-system--resultado-esperado"></a>
#### Resultado esperado

El enemigo sabe:

* convoy no llegó;
* última posición.

No sabe inmediatamente:

* atacante;
* fuerza;
* ubicación exacta.

---

<a id="src-master-testing-performance-and-balance-system--76-pruebas-de-reacción"></a>
### 76. Pruebas de reacción

Medir tiempo entre:

```text id="ritcwm"
observación
→ transmisión
→ recepción
→ decisión
→ respuesta
```

<a id="src-master-testing-performance-and-balance-system--regla-6"></a>
#### Regla

La respuesta rápida debe tener una red capaz de producirla.

---

<a id="src-master-testing-performance-and-balance-system--77-pruebas-helios"></a>
### 77. Pruebas Helios

Casos:

* nodo operativo;
* degradado;
* aislado;
* comprometido;
* control físico distinto al digital;
* auditoría;
* destrucción;
* desconexión selectiva.

---

<a id="src-master-testing-performance-and-balance-system--78-pruebas-de-acceso"></a>
### 78. Pruebas de acceso

Verificar niveles:

* lectura;
* análisis;
* operación;
* administración;
* backdoor Argos.

<a id="src-master-testing-performance-and-balance-system--invariante-6"></a>
#### Invariante

Control físico no concede acceso integral.

---

<a id="src-master-testing-performance-and-balance-system--79-pruebas-de-integridad"></a>
### 79. Pruebas de integridad

Crear nodo:

* operativo;
* datos alterados;
* credencial comprometida;
* auditoría incompleta.

<a id="src-master-testing-performance-and-balance-system--verificar-6"></a>
#### Verificar

La interfaz no confunde funcionamiento con fiabilidad.

---

<a id="src-master-testing-performance-and-balance-system--80-pruebas-argos"></a>
### 80. Pruebas Argos

Verificar acciones:

* retraso;
* omisión;
* reclasificación;
* metadatos;
* corroboración artificial;
* falsa bandera.

<a id="src-master-testing-performance-and-balance-system--limitación"></a>
#### Limitación

Agotar:

* capacidad de intervención;
* operadores;
* acceso.

Argos no debe seguir interviniendo ilimitadamente.

---

<a id="src-master-testing-performance-and-balance-system--81-pruebas-de-misión-dinámica"></a>
### 81. Pruebas de misión dinámica

Cada plantilla debe probar:

```text id="0hz6cq"
Generación
Oferta
Aceptación
Delegación
Ignorada
Expirada
Transformada
Éxito
Parcial
Fracaso
```

---

<a id="src-master-testing-performance-and-balance-system--82-pruebas-de-causalidad"></a>
### 82. Pruebas de causalidad

Toda misión generada debe tener:

* necesidad;
* emisor;
* sector;
* consecuencia;
* plazo.

<a id="src-master-testing-performance-and-balance-system--defecto-grave"></a>
#### Defecto grave

Una misión aparece sin necesidad del mundo.

---

<a id="src-master-testing-performance-and-balance-system--83-pruebas-de-repetición"></a>
### 83. Pruebas de repetición

Generar múltiples misiones.

Medir:

* familias;
* sectores;
* emisores;
* estructuras;
* complicaciones.

<a id="src-master-testing-performance-and-balance-system--objetivo-3"></a>
#### Objetivo

Evitar secuencias repetitivas aunque cambien nombres.

---

<a id="src-master-testing-performance-and-balance-system--84-pruebas-de-expiración"></a>
### 84. Pruebas de expiración

Verificar transformaciones.

Ejemplo:

```text id="3u1bp8"
Escolta ignorada
→ convoy atacado
→ rescate
→ recuperación de carga
```

---

<a id="src-master-testing-performance-and-balance-system--85-pruebas-de-delegación"></a>
### 85. Pruebas de delegación

Asignar otra formación.

Verificar:

* reserva;
* resultado;
* coste;
* fuerza disponible;
* misión anterior;
* consecuencia.

---

<a id="src-master-testing-performance-and-balance-system--86-pruebas-de-offscreen-resolution"></a>
### 86. Pruebas de offscreen resolution

Comparar:

* resultado abstracto;
* fuerzas;
* terreno;
* inteligencia;
* suministro;
* semilla.

<a id="src-master-testing-performance-and-balance-system--objetivo-4"></a>
#### Objetivo

Evitar resultados arbitrarios o sesgados a favor del jugador.

---

<a id="src-master-testing-performance-and-balance-system--87-pruebas-de-personajes"></a>
### 87. Pruebas de personajes

Verificar:

* vida;
* heridas;
* muerte;
* captura;
* conocimiento;
* relaciones;
* diálogos;
* sustitución.

---

<a id="src-master-testing-performance-and-balance-system--88-pruebas-de-relación"></a>
### 88. Pruebas de relación

Casos:

* competencia alta;
* lealtad baja;
* confianza personal alta;
* confianza política baja.

<a id="src-master-testing-performance-and-balance-system--verificar-7"></a>
#### Verificar

La interfaz y diálogos reflejan dimensiones, no promedio simple.

---

<a id="src-master-testing-performance-and-balance-system--89-pruebas-de-progresión"></a>
### 89. Pruebas de progresión

Validar:

* rango;
* autoridad;
* delegación;
* capacidad;
* confianza;
* reputación;
* investigación.

---

<a id="src-master-testing-performance-and-balance-system--90-pruebas-de-autoridad"></a>
### 90. Pruebas de autoridad

Intentar acciones con:

* autoridad suficiente;
* insuficiente;
* delegación temporal;
* delegación expirada;
* cambio de mando.

---

<a id="src-master-testing-performance-and-balance-system--91-pruebas-de-capacidades"></a>
### 91. Pruebas de capacidades

Una capacidad desbloqueada puede estar:

* disponible;
* sin recursos;
* sin activo;
* sin comunicación;
* fuera de alcance;
* bloqueada políticamente.

---

<a id="src-master-testing-performance-and-balance-system--92-pruebas-anti-farmeo"></a>
### 92. Pruebas anti-farmeo

Repetir:

* misiones menores;
* rescates;
* entregas;
* eliminaciones.

<a id="src-master-testing-performance-and-balance-system--resultado-1"></a>
#### Resultado

La progresión no aumenta indefinidamente sin relevancia contextual.

---

<a id="src-master-testing-performance-and-balance-system--93-pruebas-de-evidencia"></a>
### 93. Pruebas de evidencia

Estados:

* descubierta;
* recuperada;
* dañada;
* autenticada;
* interpretada;
* correlacionada;
* entregada;
* publicada;
* destruida.

---

<a id="src-master-testing-performance-and-balance-system--94-pruebas-de-cadena-de-custodia"></a>
### 94. Pruebas de cadena de custodia

Transferir evidencia entre:

* jugador;
* analista;
* comandante;
* infiltrado.

<a id="src-master-testing-performance-and-balance-system--verificar-8"></a>
#### Verificar

* propietario;
* copias;
* autenticidad;
* pérdida;
* acceso.

---

<a id="src-master-testing-performance-and-balance-system--95-pruebas-de-conclusiones"></a>
### 95. Pruebas de conclusiones

Cada conclusión debe requerir:

* evidencias suficientes;
* autenticidad;
* interpretación;
* correlación.

<a id="src-master-testing-performance-and-balance-system--defecto-grave-1"></a>
#### Defecto grave

Una conclusión se desbloquea con una sola pista insuficiente.

---

<a id="src-master-testing-performance-and-balance-system--96-pruebas-de-campañas-azul-y-roja"></a>
### 96. Pruebas de campañas Azul y Roja

Verificar que:

* los hechos compartidos coinciden;
* la información recibida difiere;
* los tiempos son compatibles;
* los resultados no se contradicen sin explicación;
* la verdad comparada funciona;
* una campaña aislada mantiene `vardisConfirmed == false`;
* solo `dualCampaignCompleted == true` puede desbloquear `dualOperationUnlocked`, confirmar a Vardis y generar sus destinos físicos;
* snapshots incompatibles con esas precondiciones son rechazados.

---

<a id="src-master-testing-performance-and-balance-system--97-pruebas-de-eventos-sincronizados"></a>
### 97. Pruebas de eventos sincronizados

Ejemplos:

```text id="ecubp3"
05:40 desembarco Azul
05:52 desembarco Rojo
H+1 órdenes Verdes contradictorias
H+2 alteraciones Helios
Primera noche: señal Petrou
```

---

<a id="src-master-testing-performance-and-balance-system--98-pruebas-de-puntos-de-no-retorno"></a>
### 98. Pruebas de puntos de no retorno

Verificar:

* advertencia;
* operaciones pendientes;
* consecuencia;
* autosave;
* bloqueo de contenido;
* continuidad.

---

<a id="src-master-testing-performance-and-balance-system--99-pruebas-narrativas"></a>
### 99. Pruebas narrativas

Revisar:

* voz;
* conocimiento;
* relación;
* interrupción;
* subtítulo;
* fallback;
* efectos;
* continuidad.

---

<a id="src-master-testing-performance-and-balance-system--100-pruebas-de-interrupción"></a>
### 100. Pruebas de interrupción

Activar:

* combate;
* radio;
* explosión;
* muerte;
* alejamiento.

<a id="src-master-testing-performance-and-balance-system--verificar-9"></a>
#### Verificar

* pausa;
* reanudación;
* resumen;
* información crítica.

---

<a id="src-master-testing-performance-and-balance-system--101-pruebas-de-sustitución-narrativa"></a>
### 101. Pruebas de sustitución narrativa

Matar o incapacitar al emisor.

Verificar:

* sustituto;
* documento;
* grabación;
* misión no bloqueada.

---

<a id="src-master-testing-performance-and-balance-system--102-pruebas-de-metaconocimiento"></a>
### 102. Pruebas de metaconocimiento

Cada línea debe validarse contra:

* hechos conocidos;
* evidencia recibida;
* acto;
* relación.

---

<a id="src-master-testing-performance-and-balance-system--103-pruebas-de-diálogo-variable"></a>
### 103. Pruebas de diálogo variable

Reproducir con:

* relación alta;
* relación baja;
* evidencia;
* sin evidencia;
* autoridad;
* sin autoridad;
* miembro muerto.

---

<a id="src-master-testing-performance-and-balance-system--104-pruebas-de-radio"></a>
### 104. Pruebas de radio

Medir:

* inteligibilidad;
* prioridad;
* cola;
* duración;
* solapamiento;
* filtros.

---

<a id="src-master-testing-performance-and-balance-system--105-pruebas-de-subtítulos"></a>
### 105. Pruebas de subtítulos

Validar:

* identificación;
* canal;
* duración;
* resolución;
* texto grande;
* contraste;
* sincronización.

---

<a id="src-master-testing-performance-and-balance-system--106-pruebas-de-interfaz"></a>
### 106. Pruebas de interfaz

Verificar:

* conocimiento filtrado;
* capas;
* acciones;
* bloqueos;
* alertas;
* accesibilidad;
* rendimiento.

---

<a id="src-master-testing-performance-and-balance-system--107-pruebas-de-información-secreta"></a>
### 107. Pruebas de información secreta

El cliente o UI no debe recibir:

* fuerza real enemiga;
* infiltrados;
* precisión oculta;
* Argos;
* consecuencias no conocidas.

---

<a id="src-master-testing-performance-and-balance-system--108-pruebas-de-alertas"></a>
### 108. Pruebas de alertas

Casos:

* una alerta;
* varias relacionadas;
* crisis agrupada;
* expirada;
* transformada;
* resuelta.

---

<a id="src-master-testing-performance-and-balance-system--109-pruebas-de-acciones-bloqueadas"></a>
### 109. Pruebas de acciones bloqueadas

Cada bloqueo debe explicar:

* autoridad;
* recurso;
* activo;
* comunicación;
* conocimiento;
* restricción.

---

<a id="src-master-testing-performance-and-balance-system--110-pruebas-de-mapa"></a>
### 110. Pruebas de mapa

Con 38 sectores:

* capas;
* marcadores;
* incertidumbre;
* rutas;
* fuerzas;
* rendimiento.

---

<a id="src-master-testing-performance-and-balance-system--111-pruebas-de-accesibilidad"></a>
### 111. Pruebas de accesibilidad

Validar:

* tamaño;
* teclado;
* contraste;
* daltonismo;
* subtítulos;
* reducción de movimiento;
* ausencia de dependencia exclusiva del audio.

---

<a id="src-master-testing-performance-and-balance-system--112-pruebas-3den"></a>
### 112. Pruebas 3DEN

Cada sector debe validar:

* centro;
* límites;
* rutas;
* anclajes;
* spawns;
* retirada;
* civiles;
* módulos;
* rendimiento.

---

<a id="src-master-testing-performance-and-balance-system--113-pruebas-de-pathfinding"></a>
### 113. Pruebas de pathfinding

Para:

* infantería;
* transporte;
* camión;
* blindado;
* convoy;
* helicóptero;
* barco.

---

<a id="src-master-testing-performance-and-balance-system--114-pruebas-de-composición"></a>
### 114. Pruebas de composición

Cada composición:

* terreno;
* colisión;
* pathing;
* daño;
* captura;
* destrucción;
* presupuesto.

---

<a id="src-master-testing-performance-and-balance-system--115-pruebas-de-spawn"></a>
### 115. Pruebas de spawn

Verificar:

* fuera de visión;
* sin colisión;
* ruta válida;
* dirección;
* cámara;
* dron;
* altura.

---

<a id="src-master-testing-performance-and-balance-system--116-pruebas-de-captura-física"></a>
### 116. Pruebas de captura física

Validar:

* puntos;
* retirada;
* guarnición;
* propietario;
* construcción;
* UI;
* guardado.

---

<a id="src-master-testing-performance-and-balance-system--117-rendimiento-objetivos-generales"></a>
### 117. Rendimiento: objetivos generales

El rendimiento deberá evaluarse en:

* editor;
* SP;
* campaña extensa;
* combate;
* ciudades;
* aeropuertos;
* Stratis;
* UI abierta;
* guardado.

<a id="src-master-testing-performance-and-balance-system--principio"></a>
#### Principio

No se utilizará una cifra única como garantía universal.

Se medirán:

* FPS;
* frametime;
* tiempo de script;
* grupos;
* IA;
* objetos;
* memoria;
* tamaño de save.

---

<a id="src-master-testing-performance-and-balance-system--118-perfiles-de-hardware"></a>
### 118. Perfiles de hardware

Las pruebas deberán incluir al menos:

```text id="3nctdy"
Perfil mínimo objetivo
Perfil medio
Perfil alto
```

<a id="src-master-testing-performance-and-balance-system--perfil-mínimo"></a>
#### Perfil mínimo

Se definirá después del vertical slice mediante hardware realista y disponible.

<a id="src-master-testing-performance-and-balance-system--regla-7"></a>
#### Regla

No fijar requisitos definitivos antes de medir el vertical slice.

---

<a id="src-master-testing-performance-and-balance-system--119-escenarios-de-rendimiento"></a>
### 119. Escenarios de rendimiento

<a id="src-master-testing-performance-and-balance-system--p1-base-tranquila"></a>
#### P1 — Base tranquila

* 20–30 IA cercanas;
* pocos vehículos;
* UI cerrada.

<a id="src-master-testing-performance-and-balance-system--p2-operación-normal"></a>
#### P2 — Operación normal

* 50–80 IA;
* convoy;
* civiles;
* apoyo limitado.

<a id="src-master-testing-performance-and-balance-system--p3-batalla-grande"></a>
#### P3 — Batalla grande

* 100–160 IA;
* vehículos;
* artillería;
* composición.

<a id="src-master-testing-performance-and-balance-system--p4-ciudad"></a>
#### P4 — Ciudad

* entorno complejo;
* civiles;
* combate;
* tráfico.

<a id="src-master-testing-performance-and-balance-system--p5-campaña-larga"></a>
#### P5 — Campaña larga

* muchos estados;
* eventos;
* guardados.

---

<a id="src-master-testing-performance-and-balance-system--120-métricas-de-rendimiento"></a>
### 120. Métricas de rendimiento

```text id="jbvwq4"
averageFPS
minimumFPS
averageFrameTime
scriptFrameTime
activeAI
activeGroups
activeVehicles
dynamicObjects
eventQueueSize
schedulerTime
saveSize
saveDuration
loadDuration
```

---

<a id="src-master-testing-performance-and-balance-system--121-presupuesto-táctico-inicial"></a>
### 121. Presupuesto táctico inicial

Valores de partida, sujetos a validación:

```text id="oj3l9g"
IA activa normal:
70–110

Batalla grande:
120–160

Grupos tácticos:
12–24

Vehículos terrestres activos:
8–16

Aeronaves activas:
0–3
```

<a id="src-master-testing-performance-and-balance-system--regla-8"></a>
#### Regla

Estos valores son presupuestos de prueba, no promesas finales.

---

<a id="src-master-testing-performance-and-balance-system--122-presupuesto-de-script"></a>
### 122. Presupuesto de script

Los sistemas estratégicos no deben consumir de forma sostenida una porción elevada del frame.

Se medirá:

* tiempo por módulo;
* picos;
* frecuencia;
* cola.

<a id="src-master-testing-performance-and-balance-system--acción"></a>
#### Acción

Si un módulo excede presupuesto:

* dividir lotes;
* reducir frecuencia;
* crear índice;
* convertir a eventos;
* virtualizar.

---

<a id="src-master-testing-performance-and-balance-system--123-pruebas-de-scheduler-bajo-carga"></a>
### 123. Pruebas de scheduler bajo carga

Simular:

* 38 sectores;
* 100 formaciones;
* múltiples convoyes;
* eventos;
* misiones;
* población.

<a id="src-master-testing-performance-and-balance-system--verificar-10"></a>
#### Verificar

* cola estable;
* tareas ejecutadas;
* sin congelación;
* prioridades respetadas.

---

<a id="src-master-testing-performance-and-balance-system--124-pruebas-de-memoria"></a>
### 124. Pruebas de memoria

Detectar:

* arrays crecientes;
* eventos nunca eliminados;
* referencias de objetos;
* grupos huérfanos;
* logs excesivos;
* UI no liberada.

---

<a id="src-master-testing-performance-and-balance-system--125-pruebas-de-limpieza"></a>
### 125. Pruebas de limpieza

Después de varias misiones:

* grupos vacíos;
* objetos;
* cadáveres;
* restos;
* markers;
* handlers;
* registries.

<a id="src-master-testing-performance-and-balance-system--invariante-7"></a>
#### Invariante

El número de entidades huérfanas debe permanecer en cero.

---

<a id="src-master-testing-performance-and-balance-system--126-pruebas-de-guardado-largo"></a>
### 126. Pruebas de guardado largo

Después de:

* varias horas;
* múltiples sectores;
* cientos de eventos;
* personajes muertos;
* evidencia;
* convoyes.

Medir:

* tamaño;
* tiempo;
* carga;
* validación.

---

<a id="src-master-testing-performance-and-balance-system--127-presupuesto-de-save"></a>
### 127. Presupuesto de save

El tamaño final se determinará por medición.

<a id="src-master-testing-performance-and-balance-system--criterios"></a>
#### Criterios

* crecimiento controlado;
* compactación;
* no guardar objetos temporales;
* historial agregado.

---

<a id="src-master-testing-performance-and-balance-system--128-balance-definición"></a>
### 128. Balance: definición

Balance no significa que todos los bandos tengan la misma fuerza.

Significa que:

* cada recurso tiene utilidad;
* cada decisión tiene coste;
* ninguna estrategia domina siempre;
* el jugador comprende riesgos;
* la dificultad surge de sistemas y oposición.

---

<a id="src-master-testing-performance-and-balance-system--129-ejes-de-balance"></a>
### 129. Ejes de balance

```text id="eu9fsz"
Militar
Logístico
Territorial
Civil
Político
Inteligencia
Progresión
Temporal
Narrativo
```

---

<a id="src-master-testing-performance-and-balance-system--130-balance-militar"></a>
### 130. Balance militar

Debe considerar:

* personal;
* vehículos;
* doctrina;
* terreno;
* preparación;
* apoyo;
* reservas;
* suministro.

<a id="src-master-testing-performance-and-balance-system--no-se-balanceará-mediante"></a>
#### No se balanceará mediante

* salud excesiva;
* puntería sobrehumana;
* enemigos infinitos;
* aparición mágica.

---

<a id="src-master-testing-performance-and-balance-system--131-asimetría-azul"></a>
### 131. Asimetría Azul

Fortalezas:

* precisión;
* sensores;
* movilidad;
* apoyo técnico;
* mando flexible.

Debilidades:

* dependencia externa;
* pocas reservas;
* legitimidad inicial;
* presión logística.

---

<a id="src-master-testing-performance-and-balance-system--132-asimetría-roja"></a>
### 132. Asimetría Roja

Fortalezas:

* volumen;
* mecanización;
* continuidad institucional;
* fuerza de corredor.

Debilidades:

* consumo;
* rigidez;
* conflictos de mando;
* dependencia oriental.

---

<a id="src-master-testing-performance-and-balance-system--133-asimetría-verde"></a>
### 133. Asimetría Verde

Fortalezas:

* territorio;
* número;
* infraestructura;
* conocimiento local.

Debilidades:

* fragmentación;
* órdenes;
* moral;
* logística desigual.

---

<a id="src-master-testing-performance-and-balance-system--134-asimetría-fia"></a>
### 134. Asimetría FIA

Fortalezas:

* ocultamiento;
* apoyo local;
* información;
* flexibilidad.

Debilidades:

* armas;
* mantenimiento;
* capacidad abierta;
* división interna.

---

<a id="src-master-testing-performance-and-balance-system--135-asimetría-argos"></a>
### 135. Asimetría Argos

Fortalezas:

* información;
* infiltración;
* acceso;
* preparación.

Debilidades:

* poca fuerza territorial;
* capacidad limitada;
* exposición;
* dependencia de infraestructura.

---

<a id="src-master-testing-performance-and-balance-system--136-balance-de-primera-ola"></a>
### 136. Balance de primera ola

Fuerzas iniciales:

```text id="1j78zp"
Azul:
144 efectivos iniciales.

Rojo:
168 efectivos iniciales.
```

<a id="src-master-testing-performance-and-balance-system--objetivo-5"></a>
#### Objetivo

Permitir:

* desembarco;
* defensa;
* primera expansión;

sin convertir la cabeza de playa en una fuerza autosuficiente.

---

<a id="src-master-testing-performance-and-balance-system--137-balance-de-fuerzas-totales"></a>
### 137. Balance de fuerzas totales

Referencias estratégicas:

```text id="03vrk1"
Azul utilizable:
aproximadamente 720

Rojo utilizable:
aproximadamente 810

Verde activa:
aproximadamente 3.200

Verde inicialmente combat-ready:
aproximadamente 1.950

FIA inicial activa:
aproximadamente 220–280

Meridian armada:
aproximadamente 128
```

<a id="src-master-testing-performance-and-balance-system--regla-9"></a>
#### Regla

Estas cifras representan fuerza estratégica, no unidades físicas simultáneas.

---

<a id="src-master-testing-performance-and-balance-system--138-balance-de-refuerzos"></a>
### 138. Balance de refuerzos

Los refuerzos dependen de:

* puerto;
* pista;
* seguridad;
* autorización;
* tiempo;
* recursos;
* pérdidas.

<a id="src-master-testing-performance-and-balance-system--objetivo-6"></a>
#### Objetivo

Evitar que las bajas de los primeros actos se repongan instantáneamente.

---

<a id="src-master-testing-performance-and-balance-system--139-balance-de-guarniciones"></a>
### 139. Balance de guarniciones

Tiers:

```text id="yk7kvx"
G0
G1
G2
G3
G4
```

El tamaño debe relacionarse con:

* sector;
* amenaza;
* profundidad;
* recursos;
* población;
* rol.

---

<a id="src-master-testing-performance-and-balance-system--140-balance-de-qrf"></a>
### 140. Balance de QRF

La QRF debe ser valiosa y limitada.

<a id="src-master-testing-performance-and-balance-system--regla-10"></a>
#### Regla

No debe aparecer en todos los ataques.

Cuando se usa:

* deja otro sector sin reserva;
* consume combustible;
* necesita reorganización.

---

<a id="src-master-testing-performance-and-balance-system--141-balance-aéreo"></a>
### 141. Balance aéreo

Aeronaves:

* escasas;
* vulnerables;
* dependientes de pista;
* dependientes de mantenimiento;
* limitadas por AA.

<a id="src-master-testing-performance-and-balance-system--objetivo-7"></a>
#### Objetivo

El apoyo aéreo debe cambiar una operación, no reemplazar el combate terrestre.

---

<a id="src-master-testing-performance-and-balance-system--142-balance-de-artillería"></a>
### 142. Balance de artillería

Depende de:

* munición;
* observadores;
* comunicación;
* política;
* riesgo civil.

<a id="src-master-testing-performance-and-balance-system--objetivo-8"></a>
#### Objetivo

Poderosa, pero limitada y costosa.

---

<a id="src-master-testing-performance-and-balance-system--143-balance-antitanque"></a>
### 143. Balance antitanque

Debe impedir:

* dominio absoluto de blindados;
* saturación de misiles;
* inutilidad de infantería.

<a id="src-master-testing-performance-and-balance-system--variables"></a>
#### Variables

* disponibilidad;
* calidad;
* posición;
* inteligencia;
* terreno.

---

<a id="src-master-testing-performance-and-balance-system--144-balance-antiaéreo"></a>
### 144. Balance antiaéreo

Debe crear:

* zonas de riesgo;
* necesidad de reconocimiento;
* supresión;
* rutas alternativas.

No debe hacer que toda aviación sea siempre imposible.

---

<a id="src-master-testing-performance-and-balance-system--145-balance-logístico"></a>
### 145. Balance logístico

La logística debe:

* condicionar;
* no paralizar constantemente;
* producir decisiones;
* permitir recuperación.

<a id="src-master-testing-performance-and-balance-system--estados-esperados"></a>
#### Estados esperados

La mayoría de fuerzas deben operar normalmente en:

```text id="4jjfc3"
ADEQUATE
LOW
```

Los estados:

```text id="7zf2fw"
CRITICAL
EMPTY
```

deben ser consecuencias significativas, no permanentes.

---

<a id="src-master-testing-performance-and-balance-system--146-balance-de-consumo"></a>
### 146. Balance de consumo

El consumo debe ser suficientemente alto para importar y suficientemente bajo para permitir operaciones.

<a id="src-master-testing-performance-and-balance-system--método"></a>
#### Método

Medir:

* autonomía;
* frecuencia de convoy;
* recursos por misión;
* pérdidas;
* producción.

---

<a id="src-master-testing-performance-and-balance-system--147-balance-de-convoyes"></a>
### 147. Balance de convoyes

Objetivo:

* no requerir escoltar cada convoy;
* crear intervenciones cuando existe riesgo real;
* permitir resolución externa.

<a id="src-master-testing-performance-and-balance-system--proporción"></a>
#### Proporción

La mayoría de convoyes ordinarios deberían resolverse sin convertirse en misión del jugador.

---

<a id="src-master-testing-performance-and-balance-system--148-balance-de-construcción"></a>
### 148. Balance de construcción

La construcción debe obligar a elegir.

<a id="src-master-testing-performance-and-balance-system--evitar"></a>
#### Evitar

* construir todo;
* espera excesiva;
* proyectos irrelevantes;
* fortificación instantánea.

---

<a id="src-master-testing-performance-and-balance-system--149-balance-de-reconstrucción"></a>
### 149. Balance de reconstrucción

La reconstrucción compite con:

* guerra;
* logística;
* civiles;
* infraestructura.

Debe producir beneficios perceptibles:

* servicios;
* estabilidad;
* producción;
* rutas.

---

<a id="src-master-testing-performance-and-balance-system--150-balance-civil"></a>
### 150. Balance civil

El sistema civil debe reaccionar de forma gradual.

<a id="src-master-testing-performance-and-balance-system--evitar-1"></a>
#### Evitar

* pérdida total de apoyo por una acción menor;
* recuperación inmediata mediante una entrega;
* radicalización automática;
* estabilidad perpetuamente baja.

---

<a id="src-master-testing-performance-and-balance-system--151-decaimiento-civil"></a>
### 151. Decaimiento civil

Variables como miedo o agravio pueden tener:

* aumento rápido;
* recuperación lenta;
* memoria permanente para eventos graves.

---

<a id="src-master-testing-performance-and-balance-system--152-balance-de-protestas"></a>
### 152. Balance de protestas

Las protestas deben ser:

* significativas;
* no constantes;
* causales;
* variables.

<a id="src-master-testing-performance-and-balance-system--objetivo-9"></a>
#### Objetivo

No convertir el sistema civil en una cadena interminable de emergencias.

---

<a id="src-master-testing-performance-and-balance-system--153-balance-fia"></a>
### 153. Balance FIA

FIA debe poder crecer, pero no convertirse demasiado pronto en ejército convencional.

<a id="src-master-testing-performance-and-balance-system--controles"></a>
#### Controles

* armas;
* entrenamiento;
* exposición;
* apoyo;
* liderazgo;
* contrainsurgencia.

---

<a id="src-master-testing-performance-and-balance-system--154-balance-de-contrainsurgencia"></a>
### 154. Balance de contrainsurgencia

Ningún modelo debe ser universalmente superior.

<a id="src-master-testing-performance-and-balance-system--coercitivo"></a>
#### Coercitivo

* rápido;
* costoso políticamente.

<a id="src-master-testing-performance-and-balance-system--protección"></a>
#### Protección

* lento;
* sostenible.

<a id="src-master-testing-performance-and-balance-system--inteligencia-1"></a>
#### Inteligencia

* preciso;
* vulnerable a manipulación.

<a id="src-master-testing-performance-and-balance-system--militar"></a>
#### Militar

* visible;
* costoso en personal.

---

<a id="src-master-testing-performance-and-balance-system--155-balance-de-inteligencia"></a>
### 155. Balance de inteligencia

La información debe reducir incertidumbre sin eliminarla.

<a id="src-master-testing-performance-and-balance-system--demasiada-información"></a>
#### Demasiada información

* vuelve trivial la planificación.

<a id="src-master-testing-performance-and-balance-system--muy-poca"></a>
#### Muy poca

* produce frustración y sensación de azar.

---

<a id="src-master-testing-performance-and-balance-system--156-balance-helios"></a>
### 156. Balance Helios

Helios debe ser útil incluso después de descubrir su compromiso.

<a id="src-master-testing-performance-and-balance-system--objetivo-10"></a>
#### Objetivo

Crear una decisión real entre:

* usar;
* auditar;
* limitar;
* destruir.

---

<a id="src-master-testing-performance-and-balance-system--157-balance-argos"></a>
### 157. Balance Argos

Argos debe:

* influir;
* no controlar todo;
* poder cometer errores;
* perder capacidades;
* dejar rastros.

<a id="src-master-testing-performance-and-balance-system--defecto"></a>
#### Defecto

Si toda derrota se explica por Argos, las decisiones del jugador pierden valor.

---

<a id="src-master-testing-performance-and-balance-system--158-balance-de-progresión"></a>
### 158. Balance de progresión

El jugador debe adquirir más responsabilidad sin quedar obligado a microgestionar.

<a id="src-master-testing-performance-and-balance-system--indicador-de-exceso"></a>
#### Indicador de exceso

El jugador pasa más tiempo en paneles que jugando operaciones sin haberlo elegido.

---

<a id="src-master-testing-performance-and-balance-system--159-balance-de-autoridad"></a>
### 159. Balance de autoridad

La autoridad debe:

* abrir opciones;
* crear responsabilidad;
* no entregar control absoluto.

---

<a id="src-master-testing-performance-and-balance-system--160-balance-de-apoyos"></a>
### 160. Balance de apoyos

Cada apoyo debe tener:

* impacto;
* coste;
* límite;
* condición.

<a id="src-master-testing-performance-and-balance-system--defecto-1"></a>
#### Defecto

Un apoyo desbloqueado pero casi nunca utilizable.

<a id="src-master-testing-performance-and-balance-system--defecto-contrario"></a>
#### Defecto contrario

Un apoyo disponible siempre sin coste.

---

<a id="src-master-testing-performance-and-balance-system--161-balance-temporal"></a>
### 161. Balance temporal

Los plazos deben crear presión razonable.

<a id="src-master-testing-performance-and-balance-system--plazo-blando"></a>
#### Plazo blando

Permite adaptación.

<a id="src-master-testing-performance-and-balance-system--plazo-duro"></a>
#### Plazo duro

Solo cuando la situación realmente cambia.

<a id="src-master-testing-performance-and-balance-system--evitar-2"></a>
#### Evitar

Temporizadores arbitrarios para todas las misiones.

---

<a id="src-master-testing-performance-and-balance-system--162-balance-de-viaje"></a>
### 162. Balance de viaje

La escala de Altis no debe convertirse en tiempo muerto constante.

<a id="src-master-testing-performance-and-balance-system--herramientas"></a>
#### Herramientas

* operaciones regionales;
* transporte;
* delegación;
* misiones agrupadas;
* fast travel condicionado futuro si se decide.

---

<a id="src-master-testing-performance-and-balance-system--163-balance-narrativo"></a>
### 163. Balance narrativo

La narrativa debe alternar:

* acción;
* preparación;
* investigación;
* conversación;
* consecuencia.

<a id="src-master-testing-performance-and-balance-system--evitar-3"></a>
#### Evitar

* tres grandes revelaciones seguidas;
* tres ataques masivos seguidos;
* exposición después de cada misión.

---

<a id="src-master-testing-performance-and-balance-system--164-curva-de-dificultad"></a>
### 164. Curva de dificultad

La campaña deberá progresar en:

* responsabilidad;
* complejidad;
* oposición;
* incertidumbre;
* consecuencias.

No solo en cantidad de enemigos.

---

<a id="src-master-testing-performance-and-balance-system--165-etapas-de-dificultad"></a>
### 165. Etapas de dificultad

<a id="src-master-testing-performance-and-balance-system--acto-i"></a>
#### Acto I

* sistemas básicos;
* fuerzas limitadas;
* objetivos claros;
* incertidumbre controlada.

<a id="src-master-testing-performance-and-balance-system--actos-iiiii"></a>
#### Actos II–III

* frentes;
* logística;
* inteligencia;
* operaciones simultáneas.

<a id="src-master-testing-performance-and-balance-system--actos-ivv"></a>
#### Actos IV–V

* civiles;
* política;
* FIA;
* órdenes incompatibles.

<a id="src-master-testing-performance-and-balance-system--actos-vivii"></a>
#### Actos VI–VII

* Helios;
* Argos;
* guerra amplia;
* decisiones estratégicas.

<a id="src-master-testing-performance-and-balance-system--acto-viii"></a>
#### Acto VIII

* Stratis;
* múltiples capas;
* recursos acumulados;
* decisiones irreversibles.

---

<a id="src-master-testing-performance-and-balance-system--166-modos-de-dificultad"></a>
### 166. Modos de dificultad

Propuesta:

```text id="30g8it"
NARRATIVA
ESTÁNDAR
VETERANO
SIMULACIÓN
```

---

<a id="src-master-testing-performance-and-balance-system--167-narrativa"></a>
### 167. Narrativa

Características:

* información más clara;
* más tiempo;
* menor presión;
* mejores explicaciones;
* IA competente, pero menos agresiva;
* recuperación más accesible.

<a id="src-master-testing-performance-and-balance-system--regla-11"></a>
#### Regla

No convertirlo en modo sin consecuencias.

---

<a id="src-master-testing-performance-and-balance-system--168-estándar"></a>
### 168. Estándar

Experiencia recomendada.

* incertidumbre normal;
* recursos ajustados;
* IA estratégica completa;
* consecuencias persistentes.

---

<a id="src-master-testing-performance-and-balance-system--169-veterano"></a>
### 169. Veterano

* información menos frecuente;
* reacción enemiga más efectiva;
* recursos más limitados;
* menor tolerancia a pérdidas;
* menos ayudas.

---

<a id="src-master-testing-performance-and-balance-system--170-simulación"></a>
### 170. Simulación

* máxima persistencia;
* menor asistencia;
* logística exigente;
* guardado restringido opcional;
* información técnica completa, pero no omnisciente.

<a id="src-master-testing-performance-and-balance-system--regla-12"></a>
#### Regla

No aumentar dificultad mediante salud artificial.

---

<a id="src-master-testing-performance-and-balance-system--171-variables-de-dificultad"></a>
### 171. Variables de dificultad

Pueden modificar:

```text id="0y8lzw"
intelClarity
enemyReactionQuality
resourceAvailability
recoveryRate
missionDeadlineTolerance
civilRecoveryRate
supportAuthorization
uiAssistance
```

---

<a id="src-master-testing-performance-and-balance-system--172-variables-que-no-deben-modificarse-excesivamente"></a>
### 172. Variables que no deben modificarse excesivamente

* daño base;
* salud;
* precisión irreal;
* detección sin fuente;
* cantidad infinita;
* scripts de trampa.

---

<a id="src-master-testing-performance-and-balance-system--173-balance-adaptativo"></a>
### 173. Balance adaptativo

La campaña puede adaptar:

* frecuencia de eventos;
* tamaño de representación física;
* ritmo;
* claridad.

<a id="src-master-testing-performance-and-balance-system--no-debe-adaptar-secretamente"></a>
#### No debe adaptar secretamente

* reservas enemigas para contrarrestar siempre al jugador;
* resultados;
* recursos creados de la nada.

---

<a id="src-master-testing-performance-and-balance-system--174-ia-estratégica-y-dificultad"></a>
### 174. IA estratégica y dificultad

La dificultad puede alterar:

* calidad de planes;
* uso de reserva;
* reacción;
* engaño;
* retirada.

<a id="src-master-testing-performance-and-balance-system--no-debe-alterar"></a>
#### No debe alterar

La información disponible sin una fuente válida.

---

<a id="src-master-testing-performance-and-balance-system--175-telemetría-local-de-pruebas"></a>
### 175. Telemetría local de pruebas

Durante desarrollo se registrarán:

* decisiones;
* duración;
* bajas;
* recursos;
* misiones ignoradas;
* bloqueos;
* FPS;
* fallos.

<a id="src-master-testing-performance-and-balance-system--uso"></a>
#### Uso

* balance;
* detectar sistemas ignorados;
* comparar rutas.

---

<a id="src-master-testing-performance-and-balance-system--176-métricas-de-misión"></a>
### 176. Métricas de misión

```text id="15qetq"
completionRate
partialSuccessRate
failureRate
averageDuration
playerCasualties
friendlyLosses
civilianHarm
resourceCost
restartCount
```

---

<a id="src-master-testing-performance-and-balance-system--177-métricas-de-campaña"></a>
### 177. Métricas de campaña

```text id="vpk7fl"
actDuration
sectorChanges
missionFrequency
resourceCriticalTime
civilStability
fiaGrowth
playerAuthority
investigationLevel
performanceTrend
```

---

<a id="src-master-testing-performance-and-balance-system--178-señales-de-desbalance"></a>
### 178. Señales de desbalance

<a id="src-master-testing-performance-and-balance-system--militar-1"></a>
#### Militar

* una táctica domina todo;
* blindados inútiles o invencibles;
* apoyo constante.

<a id="src-master-testing-performance-and-balance-system--logístico"></a>
#### Logístico

* déficit permanente;
* convoyes repetitivos;
* recursos irrelevantes.

<a id="src-master-testing-performance-and-balance-system--civil"></a>
#### Civil

* apoyo imposible de recuperar;
* protestas continuas;
* decisiones sin efecto.

<a id="src-master-testing-performance-and-balance-system--narrativo"></a>
#### Narrativo

* jugador no entiende Argos;
* revelaciones demasiado tempranas;
* campañas redundantes.

---

<a id="src-master-testing-performance-and-balance-system--179-revisión-de-balance"></a>
### 179. Revisión de balance

Cada revisión debe responder:

1. ¿Qué decisión se pretendía crear?
2. ¿Qué opción domina?
3. ¿Por qué domina?
4. ¿El coste es visible?
5. ¿El jugador tiene información suficiente?
6. ¿El resultado es recuperable?
7. ¿Se repite demasiado?

---

<a id="src-master-testing-performance-and-balance-system--180-proceso-de-ajuste"></a>
### 180. Proceso de ajuste

1. Medir.
2. Reproducir.
3. Identificar regla.
4. Ajustar configuración.
5. Repetir pruebas.
6. Comparar.
7. Registrar cambio.

<a id="src-master-testing-performance-and-balance-system--regla-13"></a>
#### Regla

No ajustar balance únicamente por una anécdota aislada.

---

<a id="src-master-testing-performance-and-balance-system--181-pruebas-ciegas"></a>
### 181. Pruebas ciegas

Personas que no conocen la documentación deberán probar:

* onboarding;
* misión;
* interfaz;
* decisiones.

<a id="src-master-testing-performance-and-balance-system--objetivo-11"></a>
#### Objetivo

Detectar información que solo entiende el diseñador.

---

<a id="src-master-testing-performance-and-balance-system--182-pruebas-de-expertos"></a>
### 182. Pruebas de expertos

Jugadores familiarizados con Arma podrán evaluar:

* IA;
* controles;
* realismo;
* ritmo;
* equipo;
* dificultad.

---

<a id="src-master-testing-performance-and-balance-system--183-pruebas-narrativas"></a>
### 183. Pruebas narrativas

Jugadores centrados en historia evaluarán:

* personajes;
* comprensión;
* motivación;
* decisiones;
* revelaciones.

---

<a id="src-master-testing-performance-and-balance-system--184-pruebas-de-accesibilidad"></a>
### 184. Pruebas de accesibilidad

Personas con distintas necesidades evaluarán:

* subtítulos;
* contraste;
* interfaz;
* audio;
* controles.

---

<a id="src-master-testing-performance-and-balance-system--185-sesiones-de-prueba"></a>
### 185. Sesiones de prueba

Cada sesión debe tener objetivo concreto.

Ejemplo:

```text id="as0rhj"
Objetivo:
Validar convoy Panochori–Neri.

No evaluar:
Narrativa completa de Argos.
```

---

<a id="src-master-testing-performance-and-balance-system--186-cuestionario-posterior"></a>
### 186. Cuestionario posterior

Preguntas:

1. ¿Qué intentaba conseguir la misión?
2. ¿Qué información faltaba?
3. ¿Qué decisión resultó más difícil?
4. ¿Qué consecuencia percibió?
5. ¿Qué fue confuso?
6. ¿Qué pareció injusto?
7. ¿Qué repetiría de otra forma?

---

<a id="src-master-testing-performance-and-balance-system--187-criterios-de-vertical-slice"></a>
### 187. Criterios de vertical slice

El vertical slice Azul del Acto I no se aprobará hasta cumplir:

1. Inicio estable.
2. Nueve sectores registrados.
3. Desembarco funcional.
4. Consolidación de Panochori.
5. Administración de Neri.
6. Convoy persistente.
7. Contraataque Verde.
8. Virtualización y reintegración.
9. Construcción automática básica.
10. Civiles básicos.
11. Inteligencia básica.
12. Evidencia S-26.
13. Relaciones Ward–Hale.
14. UI funcional.
15. Guardado y carga.
16. RPT sin errores críticos.
17. Rendimiento aceptable.
18. Pruebas de fracaso y continuación.

---

<a id="src-master-testing-performance-and-balance-system--188-criterios-de-acto-i-azul"></a>
### 188. Criterios de Acto I Azul

Además del vertical slice:

* todas las misiones principales;
* opcionales mínimas;
* primera noche;
* consecuencias;
* progresión;
* estabilidad de campaña.

---

<a id="src-master-testing-performance-and-balance-system--189-criterios-para-iniciar-campaña-roja"></a>
### 189. Criterios para iniciar campaña Roja

No se iniciará producción completa Roja hasta que Azul valide:

* arquitectura;
* save;
* sectores;
* logística;
* táctico;
* misión;
* UI;
* rendimiento.

<a id="src-master-testing-performance-and-balance-system--razón"></a>
#### Razón

La campaña Roja debe reutilizar sistemas estables, no duplicar errores.

---

<a id="src-master-testing-performance-and-balance-system--190-criterios-para-ampliar-altis"></a>
### 190. Criterios para ampliar Altis

Antes de añadir una región:

* sector anterior finalizado;
* conexiones validadas;
* rendimiento estable;
* composiciones reutilizables;
* misión dinámica funcional.

---

<a id="src-master-testing-performance-and-balance-system--191-criterios-para-iniciar-stratis"></a>
### 191. Criterios para iniciar Stratis

Requisitos:

1. Altis funcional.
2. Helios funcional.
3. investigación funcional.
4. Argos funcional.
5. comparación Azul–Rojo definida.
6. rendimiento estable.
7. sistema de finales preparado.

---

<a id="src-master-testing-performance-and-balance-system--192-criterios-de-alfa-interna"></a>
### 192. Criterios de alfa interna

Debe permitir:

* campaña Azul parcial;
* guardado;
* múltiples sesiones;
* sistemas principales;
* errores conocidos no bloqueadores.

No requiere:

* audio final;
* todos los sectores;
* campaña Roja completa.

---

<a id="src-master-testing-performance-and-balance-system--193-criterios-de-alfa-jugable"></a>
### 193. Criterios de alfa jugable

Debe incluir:

* Azul Actos I–III;
* varios sectores;
* logística;
* civiles;
* FIA básica;
* UI;
* rendimiento.

---

<a id="src-master-testing-performance-and-balance-system--194-criterios-de-beta"></a>
### 194. Criterios de beta

Debe incluir:

* campañas completas;
* Stratis;
* finales;
* audio casi completo;
* migraciones;
* balance general.

<a id="src-master-testing-performance-and-balance-system--no-debe-tener"></a>
#### No debe tener

* defectos S0;
* defectos S1 conocidos sin solución.

---

<a id="src-master-testing-performance-and-balance-system--195-criterios-de-release-candidate"></a>
### 195. Criterios de release candidate

Requisitos:

* campaña completa jugada varias veces;
* saves estables;
* finales correctos;
* RPT limpio;
* rendimiento validado;
* localización revisada;
* regresiones completas;
* documentación actualizada.

---

<a id="src-master-testing-performance-and-balance-system--196-matriz-de-aprobación-por-módulo"></a>
### 196. Matriz de aprobación por módulo

Cada módulo debe cumplir:

```text id="846mxr"
Documentación
Configuración
Pruebas unitarias
Pruebas de integración
Persistencia
Logging
Diagnóstico
Rendimiento
UI
Regresión
```

---

<a id="src-master-testing-performance-and-balance-system--197-definition-of-done"></a>
### 197. Definition of Done

Una funcionalidad está terminada cuando:

1. Cumple el diseño aprobado.
2. Tiene validaciones.
3. Tiene logs.
4. Se guarda.
5. Se carga.
6. Tiene pruebas.
7. Tiene regresión si corrige error.
8. No rompe rendimiento.
9. Tiene UI o feedback.
10. Está documentada.

---

<a id="src-master-testing-performance-and-balance-system--198-informe-de-versión"></a>
### 198. Informe de versión

Cada build de prueba deberá incluir:

```text id="nprjdy"
Versión
Contenido
Módulos modificados
Migración
Pruebas ejecutadas
Defectos conocidos
Rendimiento
Saves compatibles
```

---

<a id="src-master-testing-performance-and-balance-system--199-suite-mínima-por-commit-importante"></a>
### 199. Suite mínima por commit importante

1. Configuración.
2. Estado.
3. Guardado.
4. módulo afectado.
5. regresiones relacionadas.
6. escenario rápido en 3DEN.
7. revisión RPT.

---

<a id="src-master-testing-performance-and-balance-system--200-suite-diaria-o-de-integración"></a>
### 200. Suite diaria o de integración

1. Todas las pruebas de dominio.
2. Integraciones.
3. carga de fixtures.
4. creación de campaña.
5. guardado y carga.
6. vertical slice automatizable.
7. rendimiento rápido.

---

<a id="src-master-testing-performance-and-balance-system--201-suite-de-release"></a>
### 201. Suite de release

1. Campaña Azul completa.
2. Campaña Roja completa.
3. comparación.
4. todos los finales.
5. múltiples dificultades.
6. saves antiguos soportados.
7. larga duración.
8. accesibilidad.
9. localización.
10. rendimiento en perfiles.

---

<a id="src-master-testing-performance-and-balance-system--202-automatización-futura"></a>
### 202. Automatización futura

Cuando sea viable, se automatizará:

* inicio de escenario;
* ejecución de comandos;
* validación;
* exportación de logs;
* comparación de snapshots.

<a id="src-master-testing-performance-and-balance-system--límite"></a>
#### Límite

No se intentará automatizar completamente:

* calidad de diálogo;
* pathfinding real;
* ritmo;
* legibilidad visual.

---

<a id="src-master-testing-performance-and-balance-system--203-funciones-conceptuales-de-pruebas"></a>
### 203. Funciones conceptuales de pruebas

```text id="xf7k2h"
IF_fnc_testRunSuite
IF_fnc_testRunCase
IF_fnc_testAssert
IF_fnc_testAssertEqual
IF_fnc_testAssertState
IF_fnc_testLoadFixture
IF_fnc_testResetWorld
IF_fnc_testCreateReport
IF_fnc_testRecordPerformance
IF_fnc_testRunRegression
IF_fnc_balanceCaptureMetrics
IF_fnc_balanceCompareRuns
```

---

<a id="src-master-testing-performance-and-balance-system--204-modelo-de-caso-de-prueba"></a>
### 204. Modelo de caso de prueba

```sqf id="h6d6fl"
IF_testCase = createHashMapFromArray [
    ["id", "TEST_LOGISTICS_CONVOY_DOUBLE_UNLOAD"],
    ["suite", "LOGISTICS"],
    ["description", "A convoy must unload only once."],
    ["fixtureId", "FIXTURE_CONVOY_READY"],
    ["steps", []],
    ["expected", []],
    ["status", "NOT_RUN"],
    ["severityIfFailed", "S1"]
];
```

---

<a id="src-master-testing-performance-and-balance-system--205-modelo-de-resultado"></a>
### 205. Modelo de resultado

```sqf id="jyi5qe"
IF_testResult = createHashMapFromArray [
    ["testId", "TEST_LOGISTICS_CONVOY_DOUBLE_UNLOAD"],
    ["status", "PASSED"],
    ["startedAt", 0],
    ["duration", 0],
    ["assertions", []],
    ["errors", []],
    ["seed", 48115],
    ["gameVersion", "0.1.0"]
];
```

---

<a id="src-master-testing-performance-and-balance-system--206-invariantes-generales-de-calidad"></a>
### 206. Invariantes generales de calidad

1. Ninguna consecuencia se aplica dos veces.
2. Ningún recurso surge sin origen.
3. Ninguna fuerza surge sin reserva.
4. Ningún personaje actúa después de morir.
5. Ninguna misión existe sin causa.
6. Ninguna reacción enemiga existe sin información.
7. Ninguna construcción aparece sin anclaje.
8. Ningún sector cambia sin validación.
9. Ningún save sobrescribe el último válido sin verificación.
10. Ningún cliente futuro recibe realidad secreta.
11. Ninguna interfaz muestra información no conocida.
12. Ningún final ignora decisiones principales.
13. Ninguna campaña contradice la otra sin explicación.
14. Ningún error crítico se cierra sin regresión.
15. Ninguna ampliación se aprueba sobre una base inestable.

---

<a id="src-master-testing-performance-and-balance-system--207-errores-que-deben-evitarse"></a>
### 207. Errores que deben evitarse

1. Probar solo el camino exitoso.
2. Balancear por sensaciones sin métricas.
3. Ajustar cinco variables a la vez.
4. Ignorar errores intermitentes.
5. Corregir sin crear regresión.
6. Añadir contenido con sistemas rotos.
7. Medir FPS sin contexto.
8. Probar solo en editor.
9. Probar solo con un save nuevo.
10. Ignorar saves largos.
11. Considerar una campaña jugable porque inicia.
12. Confundir dificultad con cantidad.
13. Hacer enemigos más resistentes para compensar IA.
14. Crear recursos al jugador para resolver bloqueos.
15. Reducir consecuencias para evitar frustración.
16. Hacer todas las misiones urgentes.
17. Hacer todos los sectores críticos.
18. Ajustar narrativa sin revisar estado.
19. Ocultar errores en logs.
20. Aprobar un módulo sin documentación.
21. No probar personajes muertos.
22. No probar rutas bloqueadas.
23. No probar fallos de red futuros.
24. Ignorar accesibilidad.
25. Crear Stratis antes de estabilizar Altis.

---

<a id="src-master-testing-performance-and-balance-system--208-principios-obligatorios-finales"></a>
### 208. Principios obligatorios finales

1. Las pruebas comienzan con el primer módulo.
2. Cada regla importante tendrá prueba.
3. Cada defecto grave tendrá regresión.
4. El vertical slice es la primera puerta de calidad.
5. Las campañas completas se prueban con victorias y fracasos.
6. El guardado es un sistema crítico.
7. La migración es obligatoria.
8. La virtualización se prueba contra duplicación.
9. Las batallas virtuales son reproducibles.
10. La IA no utiliza omnisciencia.
11. La logística se balancea por autonomía y decisiones.
12. Los civiles se balancean por memoria y recuperación.
13. FIA conserva asimetría.
14. Helios aporta utilidad y riesgo.
15. Argos tiene límites.
16. La autoridad no elimina restricciones.
17. La dificultad no rompe reglas.
18. El rendimiento se mide por escenarios.
19. El presupuesto físico no cambia reservas reales.
20. El scheduler se prueba bajo carga.
21. Los saves se prueban después de muchas horas.
22. La UI se prueba con información incompleta.
23. Los diálogos se prueban con interrupciones.
24. Los personajes muertos tienen sustitutos.
25. Las decisiones irreversibles tienen validación.
26. Azul se estabiliza antes de escalar Rojo.
27. Altis se estabiliza antes de construir Stratis.
28. Ningún módulo está terminado sin persistencia.
29. Ninguna versión se aprueba con defectos bloqueadores.
30. La calidad se demuestra mediante resultados repetibles.

---

<a id="src-master-testing-performance-and-balance-system--209-definición-final"></a>
### 209. Definición final

Islas Fracturadas no podrá validarse únicamente jugando una misión y comprobando que aparecen enemigos y objetivos.

La campaña será correcta cuando pueda demostrar que:

* una fuerza existe antes de materializarse;
* combate sin duplicarse;
* se retira sin desaparecer;
* consume recursos reales;
* conserva sus bajas;
* modifica sectores;
* produce consecuencias civiles;
* cambia relaciones;
* genera nuevas necesidades;
* puede guardarse;
* puede cargarse;
* puede continuar después de un fracaso.

El balance no consistirá en conseguir que Azul, Rojo, Verde y FIA posean la misma fuerza.

Consistirá en conseguir que cada uno pueda utilizar sus ventajas, sufrir sus debilidades y obligar al jugador a tomar decisiones diferentes.

El rendimiento no consistirá en ocultar menos unidades dentro de una distancia corta.

Consistirá en hacer que toda la guerra continúe estratégicamente mientras solo la parte necesaria se convierte en simulación física.

Una versión no se aprobará porque sus sistemas parezcan prometedores.

Se aprobará cuando sus pruebas demuestren:

* qué funciona;
* qué falla;
* cómo falla;
* cómo se recupera;
* qué coste tiene;
* qué resultado conserva.

> **Una campaña persistente no se rompe solamente cuando aparece un error. Se rompe cuando el error deja al sistema sin una forma de saber qué ocurrió realmente.**

> **Las pruebas deberán proteger la verdad del estado del mismo modo que la narrativa investiga la verdad de la guerra.**

> **Islas Fracturadas será equilibrada cuando ninguna decisión sea siempre correcta, será justa cuando sus reglas puedan comprenderse y será estable cuando cada consecuencia sobreviva exactamente una vez.**

<a id="src-master-testing-performance-and-balance-system--estado-actualizado"></a>
#### Estado actualizado

El [Documento 14/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan) convierte todos los documentos anteriores en fases, entregables, dependencias, orden de desarrollo, vertical slice, hitos, control de alcance y lista ejecutable de trabajo. La colección rectora queda completa.

---

<a id="fuente-master-implementation-and-production-plan"></a>
## Fuente integrada: `MASTER_IMPLEMENTATION_AND_PRODUCTION_PLAN.md`

> **Procedencia:** contenido migrado de `MASTER_IMPLEMENTATION_AND_PRODUCTION_PLAN.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-master-implementation-and-production-plan--islas-fracturadas"></a>
### ISLAS FRACTURADAS

<a id="src-master-implementation-and-production-plan--documento-1414-plan-maestro-de-implementación-y-producción"></a>
#### Documento 14/14 — Plan maestro de implementación y producción

**Versión:** 1.0
**Clasificación:** documento rector de ejecución, producción, alcance y entregables
**Motor:** Arma 3 2.18
**Herramientas principales:** Editor 3DEN, Visual Studio Code, Git y SQF
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando
**Territorios:** Altis y Stratis
**Estado:** canon de producción listo para convertir en backlog técnico

> **Jerarquía documental:** este Documento 14/14 gobierna orden de implementación, alcance, prioridades, fases, dependencias, hitos, puertas, entregables, riesgos y flujo de producción. Los Documentos 1/14–13/14 conservan autoridad sobre sus respectivos requisitos narrativos, sistémicos, técnicos, físicos y de calidad. Una tarea de producción no puede simplificar un contrato rector sin actualizar el documento afectado, sus pruebas y un ADR cuando corresponda.

---

<a id="src-master-implementation-and-production-plan--1-propósito"></a>
### 1. Propósito

Este documento convierte el diseño completo de Islas Fracturadas en un plan ejecutable.

Establece:

* orden de desarrollo;
* dependencias;
* fases;
* hitos;
* entregables;
* vertical slice;
* criterios de entrada y salida;
* control de alcance;
* organización de archivos;
* flujo de trabajo;
* validación;
* documentación;
* versiones;
* riesgos;
* prioridades;
* procesos de corrección;
* condiciones para ampliar contenido;
* ruta desde prototipo hasta lanzamiento.

<a id="src-master-implementation-and-production-plan--principio-central"></a>
#### Principio central

> Islas Fracturadas no se construirá intentando implementar toda la campaña al mismo tiempo.

> Se construirá mediante una base pequeña, verificable y persistente que se ampliará únicamente cuando cada sistema anterior haya demostrado que funciona.

---

<a id="src-master-implementation-and-production-plan--2-resultado-final-esperado"></a>
### 2. Resultado final esperado

La versión inicial completa deberá ofrecer:

* campaña individual Azul;
* campaña individual Roja;
* Altis persistente;
* Stratis final;
* selección inicial de bando;
* guerra territorial;
* IA estratégica;
* fuerzas virtualizadas;
* combate táctico físico;
* logística;
* construcción automática;
* población;
* Gobierno;
* FIA;
* inteligencia;
* Helios;
* Argos;
* relaciones;
* progresión;
* misiones dinámicas;
* finales variables;
* comparación posterior de ambas campañas.

<a id="src-master-implementation-and-production-plan--exclusión-inicial"></a>
#### Exclusión inicial

La primera versión completa no requerirá:

* PvP;
* jugadores humanos en bandos enfrentados;
* colocación manual de bases;
* mods obligatorios;
* dependencia de Headless Client;
* servidor dedicado obligatorio;
* generación narrativa mediante IA externa;
* editor estratégico externo.

---

<a id="src-master-implementation-and-production-plan--3-estrategia-de-producción"></a>
### 3. Estrategia de producción

La producción seguirá este orden:

```text
BASE TÉCNICA
→ MUNDO MÍNIMO
→ SISTEMAS ESTRATÉGICOS BÁSICOS
→ VERTICAL SLICE AZUL
→ ACTO I AZUL
→ CAMPAÑA AZUL
→ CAMPAÑA ROJA
→ HELIOS Y ARGOS COMPLETOS
→ STRATIS
→ FINALES
→ BALANCE Y LANZAMIENTO
```

<a id="src-master-implementation-and-production-plan--regla"></a>
#### Regla

No se desarrollará la campaña Roja completa mientras el Acto I Azul todavía presente problemas estructurales.

No se desarrollará Stratis completamente mientras Altis no pueda sostener una campaña persistente estable.

---

<a id="src-master-implementation-and-production-plan--4-modelo-de-producción-incremental"></a>
### 4. Modelo de producción incremental

Cada incremento debe producir una versión jugable.

<a id="src-master-implementation-and-production-plan--incremento-válido"></a>
#### Incremento válido

Debe permitir:

* iniciar;
* ejecutar una función concreta;
* observar resultado;
* guardar;
* cargar;
* registrar errores;
* volver a probar.

<a id="src-master-implementation-and-production-plan--incremento-inválido"></a>
#### Incremento inválido

Un conjunto de archivos que:

* compila;
* no puede probarse;
* depende de cinco sistemas incompletos;
* modifica el estado sin persistencia;
* no tiene criterios de aprobación.

---

<a id="src-master-implementation-and-production-plan--5-puertas-de-calidad"></a>
### 5. Puertas de calidad

Cada fase tendrá una puerta obligatoria.

```text
GATE 0 — Arquitectura preparada
GATE 1 — Estado persistente estable
GATE 2 — Mundo estratégico mínimo
GATE 3 — Simulación militar básica
GATE 4 — Vertical slice funcional
GATE 5 — Acto I Azul completo
GATE 6 — Campaña Azul escalable
GATE 7 — Campaña Roja funcional
GATE 8 — Helios y Argos integrados
GATE 9 — Stratis completo
GATE 10 — Beta
GATE 11 — Release candidate
```

No se cruza una puerta con defectos bloqueadores abiertos.

---

<a id="src-master-implementation-and-production-plan--6-prioridades-de-implementación"></a>
### 6. Prioridades de implementación

Se utilizarán cuatro niveles.

```text
P0 — Obligatorio para que funcione la base
P1 — Obligatorio para el vertical slice
P2 — Obligatorio para campaña completa
P3 — Mejora posterior
```

<a id="src-master-implementation-and-production-plan--ejemplos-p0"></a>
#### Ejemplos P0

* bootstrap;
* estado;
* IDs;
* guardado;
* sectores;
* logging.

<a id="src-master-implementation-and-production-plan--ejemplos-p1"></a>
#### Ejemplos P1

* convoy;
* captura;
* construcción básica;
* misión;
* UI mínima.

<a id="src-master-implementation-and-production-plan--ejemplos-p2"></a>
#### Ejemplos P2

* FIA completa;
* Helios avanzado;
* comparación de campañas;
* finales.

<a id="src-master-implementation-and-production-plan--ejemplos-p3"></a>
#### Ejemplos P3

* Headless Client;
* perfiles con mods;
* cooperativo;
* herramientas externas.

---

<a id="src-master-implementation-and-production-plan--7-control-de-alcance"></a>
### 7. Control de alcance

Todo nuevo requisito deberá clasificarse como:

```text
CORE
REQUIRED_LATER
OPTIONAL
OUT_OF_SCOPE
```

<a id="src-master-implementation-and-production-plan--core"></a>
#### CORE

Necesario para la experiencia principal.

<a id="src-master-implementation-and-production-plan--requiredlater"></a>
#### REQUIRED_LATER

Necesario, pero no para la fase actual.

<a id="src-master-implementation-and-production-plan--optional"></a>
#### OPTIONAL

Mejora que puede eliminarse sin romper la campaña.

<a id="src-master-implementation-and-production-plan--outofscope"></a>
#### OUT_OF_SCOPE

No pertenece a la versión inicial.

---

<a id="src-master-implementation-and-production-plan--8-regla-de-cambio-de-alcance"></a>
### 8. Regla de cambio de alcance

Una nueva funcionalidad solo entra en la fase actual si:

1. Resuelve un bloqueo.
2. Es indispensable para el objetivo del hito.
3. No requiere reescribir la base.
4. Puede probarse.
5. Tiene impacto y coste documentados.

En caso contrario pasa al backlog posterior.

---

<a id="src-master-implementation-and-production-plan--9-roles-de-producción"></a>
### 9. Roles de producción

Aunque el proyecto pueda desarrollarse principalmente por una persona con asistencia de IA, las responsabilidades deben separarse.

```text
Dirección de diseño
Arquitectura técnica
Programación SQF
Edición 3DEN
Diseño de sistemas
Narrativa
UI
Pruebas
Balance
Documentación
Audio
```

<a id="src-master-implementation-and-production-plan--regla-1"></a>
#### Regla

Una misma persona puede cumplir varios roles.

La responsabilidad debe seguir siendo explícita.

---

<a id="src-master-implementation-and-production-plan--10-uso-de-asistentes-de-ia"></a>
### 10. Uso de asistentes de IA

Los asistentes pueden ayudar a:

* analizar código;
* generar esqueletos;
* documentar;
* revisar dependencias;
* proponer pruebas;
* detectar duplicaciones;
* preparar configuraciones.

No deben decidir sin verificación:

* coordenadas;
* classnames;
* comportamiento real de IA;
* rendimiento;
* estado físico del editor;
* validez de una composición.

<a id="src-master-implementation-and-production-plan--regla-2"></a>
#### Regla

Todo código generado debe:

* revisarse;
* ejecutarse;
* probarse;
* documentarse;
* integrarse siguiendo la arquitectura.

---

<a id="src-master-implementation-and-production-plan--11-herramientas-de-trabajo"></a>
### 11. Herramientas de trabajo

<a id="src-master-implementation-and-production-plan--editor-3den"></a>
#### Editor 3DEN

Para:

* geografía;
* anclajes;
* composiciones;
* pruebas físicas;
* escenas.

<a id="src-master-implementation-and-production-plan--visual-studio-code"></a>
#### Visual Studio Code

Para:

* SQF;
* configuración;
* documentación;
* control de versiones;
* revisión.

<a id="src-master-implementation-and-production-plan--git"></a>
#### Git

Para:

* ramas;
* commits;
* regresiones;
* restauración;
* versiones.

<a id="src-master-implementation-and-production-plan--rpt"></a>
#### RPT

Para:

* errores;
* diagnóstico;
* rendimiento;
* eventos.

---

<a id="src-master-implementation-and-production-plan--12-repositorio"></a>
### 12. Repositorio

Estructura recomendada:

```text
islas-fracturadas/
├── mission/
├── tools/
├── tests/
├── docs/
├── assets-source/
├── exports/
├── releases/
└── README.md
```

Dentro de `mission/` se mantiene la estructura definida en el documento técnico.

---

<a id="src-master-implementation-and-production-plan--13-estrategia-de-ramas"></a>
### 13. Estrategia de ramas

```text
main
develop
feature/*
fix/*
release/*
```

<a id="src-master-implementation-and-production-plan--main"></a>
#### `main`

Solo versiones estables.

<a id="src-master-implementation-and-production-plan--develop"></a>
#### `develop`

Integración validada.

<a id="src-master-implementation-and-production-plan--feature"></a>
#### `feature/*`

Una funcionalidad o módulo.

<a id="src-master-implementation-and-production-plan--fix"></a>
#### `fix/*`

Corrección aislada.

<a id="src-master-implementation-and-production-plan--release"></a>
#### `release/*`

Preparación de versión.

---

<a id="src-master-implementation-and-production-plan--14-convención-de-commits"></a>
### 14. Convención de commits

Ejemplos:

```text
feat(sectors): add Neochori strategic state
fix(logistics): prevent convoy double unload
test(save): add snapshot fallback regression
docs(architecture): update module contracts
refactor(events): separate persistent queue
```

<a id="src-master-implementation-and-production-plan--regla-3"></a>
#### Regla

Evitar commits con cambios no relacionados.

---

<a id="src-master-implementation-and-production-plan--15-flujo-de-una-tarea"></a>
### 15. Flujo de una tarea

```text
READY
→ IN_PROGRESS
→ CODE_REVIEW
→ TESTING
→ VALIDATED
→ DONE
```

Estados adicionales:

```text
BLOCKED
DEFERRED
REOPENED
```

---

<a id="src-master-implementation-and-production-plan--16-definition-of-ready"></a>
### 16. Definition of Ready

Una tarea está lista cuando tiene:

* propósito;
* módulo propietario;
* dependencias;
* criterios de aceptación;
* datos necesarios;
* pruebas previstas;
* alcance limitado.

---

<a id="src-master-implementation-and-production-plan--17-definition-of-done"></a>
### 17. Definition of Done

Una tarea termina cuando:

1. Implementa el comportamiento.
2. Respeta contratos.
3. Tiene validación.
4. Produce logs.
5. Se guarda cuando corresponde.
6. Se carga correctamente.
7. Tiene prueba.
8. No rompe regresiones.
9. Está documentada.
10. Fue validada en Arma 3 cuando implica motor o geografía.

---

<a id="src-master-implementation-and-production-plan--18-fase-0-preparación-del-proyecto"></a>
### 18. Fase 0 — Preparación del proyecto

<a id="src-master-implementation-and-production-plan--objetivo"></a>
#### Objetivo

Crear una base de trabajo limpia y verificable.

<a id="src-master-implementation-and-production-plan--entregables"></a>
#### Entregables

* repositorio;
* misión vacía de Altis;
* estructura de carpetas;
* `description.ext`;
* `CfgFunctions`;
* logger mínimo;
* convenciones;
* documentación inicial;
* escenario de prueba.

<a id="src-master-implementation-and-production-plan--tareas"></a>
#### Tareas

```text
P0 Crear repositorio
P0 Crear misión base
P0 Crear estructura
P0 Configurar CfgFunctions
P0 Configurar logging
P0 Configurar IDs
P0 Crear README
P0 Crear changelog
P0 Crear plantilla de función
P0 Crear modo de diagnóstico
```

---

<a id="src-master-implementation-and-production-plan--19-criterios-de-salida-de-fase-0"></a>
### 19. Criterios de salida de Fase 0

* la misión inicia;
* preInit y postInit funcionan;
* se genera un log;
* se ejecuta una función registrada;
* no hay errores críticos en RPT;
* la estructura está documentada;
* existe commit estable.

<a id="src-master-implementation-and-production-plan--hito"></a>
#### Hito

```text
M0 — Esqueleto técnico ejecutable
```

---

<a id="src-master-implementation-and-production-plan--20-fase-1-núcleo-autoritativo"></a>
### 20. Fase 1 — Núcleo autoritativo

<a id="src-master-implementation-and-production-plan--objetivo-1"></a>
#### Objetivo

Crear servicios fundamentales.

<a id="src-master-implementation-and-production-plan--módulos"></a>
#### Módulos

* bootstrap;
* configuración;
* estado;
* eventos;
* scheduler;
* transacciones;
* errores;
* IDs;
* reloj.

<a id="src-master-implementation-and-production-plan--entregables-1"></a>
#### Entregables

* `IF_campaignState`;
* `IF_runtime`;
* bus de eventos;
* scheduler;
* commands y queries;
* validación;
* test runner.

---

<a id="src-master-implementation-and-production-plan--21-orden-de-fase-1"></a>
### 21. Orden de Fase 1

1. Constantes.
2. Logger.
3. Errores.
4. IDs.
5. Configuración.
6. Estado.
7. Validadores.
8. Eventos.
9. Scheduler.
10. Transacciones.
11. Reloj.
12. Tests.

---

<a id="src-master-implementation-and-production-plan--22-pruebas-de-fase-1"></a>
### 22. Pruebas de Fase 1

* estado nuevo;
* ID duplicado;
* evento persistente;
* evento repetido;
* tarea programada;
* rollback;
* avance de tiempo;
* error crítico.

---

<a id="src-master-implementation-and-production-plan--23-criterios-de-salida-de-fase-1"></a>
### 23. Criterios de salida de Fase 1

* los servicios inician en orden;
* el estado se crea;
* un command modifica estado;
* un query consulta;
* un evento se procesa una vez;
* una transacción revierte;
* los tests pasan;
* no hay dependencia de UI.

<a id="src-master-implementation-and-production-plan--hito-1"></a>
#### Hito

```text
M1 — Núcleo autoritativo estable
```

---

<a id="src-master-implementation-and-production-plan--24-fase-2-persistencia"></a>
### 24. Fase 2 — Persistencia

<a id="src-master-implementation-and-production-plan--objetivo-2"></a>
#### Objetivo

Guardar y cargar una campaña mínima.

<a id="src-master-implementation-and-production-plan--módulos-1"></a>
#### Módulos

* storage adapter;
* serializer;
* snapshots;
* checksum;
* validación;
* migración inicial.

<a id="src-master-implementation-and-production-plan--entregables-2"></a>
#### Entregables

* nueva campaña;
* guardado manual;
* autosave básico;
* snapshot A/B;
* carga;
* recuperación;
* schema versionado.

---

<a id="src-master-implementation-and-production-plan--25-pruebas-de-fase-2"></a>
### 25. Pruebas de Fase 2

* guardar;
* cargar;
* guardar dos veces;
* snapshot A corrupto;
* usar B;
* migración;
* estado incompleto;
* transacción abierta.

---

<a id="src-master-implementation-and-production-plan--26-criterios-de-salida-de-fase-2"></a>
### 26. Criterios de salida de Fase 2

* un estado modificado sobrevive al reinicio;
* no se duplican efectos;
* el snapshot anterior se conserva;
* save corrupto no sobrescribe uno válido;
* schema aparece en logs.

<a id="src-master-implementation-and-production-plan--hito-2"></a>
#### Hito

```text
M2 — Campaña persistente mínima
```

---

<a id="src-master-implementation-and-production-plan--27-fase-3-mundo-estratégico-mínimo"></a>
### 27. Fase 3 — Mundo estratégico mínimo

<a id="src-master-implementation-and-production-plan--objetivo-3"></a>
#### Objetivo

Crear el grafo básico del vertical slice.

<a id="src-master-implementation-and-production-plan--sectores"></a>
#### Sectores

1. Neri–Panochori.
2. primer enlace del corredor occidental.
3. Stavros–Whiskey.
4. Lakka.
5. AAC.
6. Poliakko–Therisa.
7. Xirolimni–Zaros.
8. Airport West.
9. Airport Terminal.

<a id="src-master-implementation-and-production-plan--entregables-3"></a>
#### Entregables

* configuración;
* regiones;
* conexiones;
* propietarios;
* estados;
* anclajes iniciales;
* vista diagnóstica.

---

<a id="src-master-implementation-and-production-plan--28-trabajo-3den-de-fase-3"></a>
### 28. Trabajo 3DEN de Fase 3

* capas;
* anclajes centrales;
* límites preliminares;
* rutas;
* puntos logísticos;
* spawns;
* zonas civiles;
* exclusiones;
* nodos Helios básicos.

---

<a id="src-master-implementation-and-production-plan--29-pruebas-de-fase-3"></a>
### 29. Pruebas de Fase 3

* validar IDs;
* recorrer conexiones;
* cambiar propietario;
* calcular profundidad;
* guardar;
* cargar;
* mostrar diagnóstico.

---

<a id="src-master-implementation-and-production-plan--30-criterios-de-salida-de-fase-3"></a>
### 30. Criterios de salida de Fase 3

* los nueve sectores están registrados;
* las conexiones son transitables;
* la profundidad se calcula;
* las coordenadas proceden de 3DEN;
* ningún sector crítico carece de anclaje;
* la UI diagnóstica identifica el estado.

<a id="src-master-implementation-and-production-plan--hito-3"></a>
#### Hito

```text
M3 — Frente centro-occidental registrado
```

---

<a id="src-master-implementation-and-production-plan--31-fase-4-facciones-personajes-y-fuerzas"></a>
### 31. Fase 4 — Facciones, personajes y fuerzas

<a id="src-master-implementation-and-production-plan--objetivo-4"></a>
#### Objetivo

Crear actores persistentes básicos.

<a id="src-master-implementation-and-production-plan--incluye"></a>
#### Incluye

* Azul;
* Verde;
* FIA mínima;
* civiles agregados;
* personajes del Acto I;
* formaciones iniciales.

<a id="src-master-implementation-and-production-plan--entregables-4"></a>
#### Entregables

* facciones;
* relaciones;
* personajes;
* fuerzas;
* vehículos persistentes;
* fuerza efectiva;
* reservas.

---

<a id="src-master-implementation-and-production-plan--32-fuerzas-iniciales-de-fase-4"></a>
### 32. Fuerzas iniciales de Fase 4

<a id="src-master-implementation-and-production-plan--azul"></a>
#### Azul

* grupo de desembarco;
* AZUR-1;
* pelotón;
* transporte;
* apoyo limitado.

<a id="src-master-implementation-and-production-plan--verde"></a>
#### Verde

* guarniciones;
* patrulla;
* QRF;
* mando local.

<a id="src-master-implementation-and-production-plan--fia"></a>
#### FIA

* una célula;
* un contacto;
* un depósito.

---

<a id="src-master-implementation-and-production-plan--33-pruebas-de-fase-4"></a>
### 33. Pruebas de Fase 4

* crear formación;
* reservar;
* sufrir bajas;
* cambiar moral;
* personaje herido;
* vehículo dañado;
* guardar;
* cargar.

---

<a id="src-master-implementation-and-production-plan--34-criterios-de-salida-de-fase-4"></a>
### 34. Criterios de salida de Fase 4

* fuerzas tienen IDs;
* ningún activo se duplica;
* los personajes sobreviven al guardado;
* los vehículos mantienen estado;
* las relaciones iniciales se cargan.

<a id="src-master-implementation-and-production-plan--hito-4"></a>
#### Hito

```text
M4 — Actores persistentes operativos
```

---

<a id="src-master-implementation-and-production-plan--35-fase-5-virtualización-táctica"></a>
### 35. Fase 5 — Virtualización táctica

<a id="src-master-implementation-and-production-plan--objetivo-5"></a>
#### Objetivo

Convertir fuerzas estratégicas en unidades físicas y reintegrarlas.

<a id="src-master-implementation-and-production-plan--entregables-5"></a>
#### Entregables

* proyecciones;
* reservas;
* paquetes tácticos;
* registros;
* Event Handlers;
* bajas;
* reintegración;
* retirada;
* limpieza.

---

<a id="src-master-implementation-and-production-plan--36-escenarios-de-fase-5"></a>
### 36. Escenarios de Fase 5

1. Materializar una escuadra.
2. Matar unidades.
3. Retirar supervivientes.
4. Reintegrar.
5. Guardar.
6. Volver a materializar.
7. Confirmar que no reaparecen muertos.

---

<a id="src-master-implementation-and-production-plan--37-dynamic-simulation"></a>
### 37. Dynamic Simulation

Se añade después de validar:

* materialización;
* localidad;
* grupos;
* limpieza.

No se utilizará para ocultar errores de virtualización.

---

<a id="src-master-implementation-and-production-plan--38-criterios-de-salida-de-fase-5"></a>
### 38. Criterios de salida de Fase 5

* una formación aparece una sola vez;
* las bajas se conservan;
* los grupos se limpian;
* la retirada funciona;
* no hay entidades huérfanas;
* el presupuesto físico se respeta.

<a id="src-master-implementation-and-production-plan--hito-5"></a>
#### Hito

```text
M5 — Puente estratégico-táctico estable
```

---

<a id="src-master-implementation-and-production-plan--39-fase-6-captura-y-control-territorial"></a>
### 39. Fase 6 — Captura y control territorial

<a id="src-master-implementation-and-production-plan--objetivo-6"></a>
#### Objetivo

Permitir que una operación física modifique un sector.

<a id="src-master-implementation-and-production-plan--entregables-6"></a>
#### Entregables

* puntos esenciales;
* captura;
* disputa;
* consolidación;
* guarnición;
* retirada Verde;
* cambio visual;
* eventos.

---

<a id="src-master-implementation-and-production-plan--40-estados-de-captura-iniciales"></a>
### 40. Estados de captura iniciales

```text
C0 — Enemigo presente
C1 — Objetivos atacados
C2 — Defensa rota
C3 — Control táctico
C4 — Consolidación
C5 — Control estratégico
```

---

<a id="src-master-implementation-and-production-plan--41-pruebas-de-fase-6"></a>
### 41. Pruebas de Fase 6

* matar defensores sin ocupar;
* ocupar punto;
* permitir retirada;
* capturar;
* perder sector;
* recapturar;
* guardar.

---

<a id="src-master-implementation-and-production-plan--42-criterios-de-salida-de-fase-6"></a>
### 42. Criterios de salida de Fase 6

* eliminar enemigos no basta;
* el sector cambia mediante command;
* se crea guarnición;
* se actualizan conexiones;
* se emiten eventos;
* la UI refleja el cambio.

<a id="src-master-implementation-and-production-plan--hito-6"></a>
#### Hito

```text
M6 — Guerra territorial mínima
```

---

<a id="src-master-implementation-and-production-plan--43-fase-7-logística-básica"></a>
### 43. Fase 7 — Logística básica

<a id="src-master-implementation-and-production-plan--objetivo-7"></a>
#### Objetivo

Crear existencias, rutas y convoyes.

<a id="src-master-implementation-and-production-plan--recursos-iniciales"></a>
#### Recursos iniciales

* combustible;
* munición ligera;
* medicina;
* construcción;
* repuestos.

<a id="src-master-implementation-and-production-plan--entregables-7"></a>
#### Entregables

* stocks;
* demandas;
* reservas;
* rutas;
* convoyes;
* carga;
* descarga;
* pérdida;
* consumo.

---

<a id="src-master-implementation-and-production-plan--44-primer-flujo-logístico"></a>
### 44. Primer flujo logístico

```text
Panochori
→ convoy
→ Neri
→ descarga
→ nueva autonomía
```

<a id="src-master-implementation-and-production-plan--variantes"></a>
#### Variantes

* llega completo;
* llega parcial;
* se pierde;
* se desvía;
* jugador interviene.

---

<a id="src-master-implementation-and-production-plan--45-criterios-de-salida-de-fase-7"></a>
### 45. Criterios de salida de Fase 7

* la carga tiene origen;
* se reserva;
* se transporta;
* se descarga una sola vez;
* la pérdida afecta al sector;
* el convoy puede resolverse virtual o físicamente.

<a id="src-master-implementation-and-production-plan--hito-7"></a>
#### Hito

```text
M7 — Logística persistente funcional
```

---

<a id="src-master-implementation-and-production-plan--46-fase-8-construcción-automática-básica"></a>
### 46. Fase 8 — Construcción automática básica

<a id="src-master-implementation-and-production-plan--objetivo-8"></a>
#### Objetivo

Permitir evolución defensiva sin colocación manual.

<a id="src-master-implementation-and-production-plan--módulos-iniciales"></a>
#### Módulos iniciales

* mando provisional;
* puesto de suministro;
* puesto médico;
* defensa de infantería;
* puesto AT;
* control de carretera.

---

<a id="src-master-implementation-and-production-plan--47-trabajo-de-fase-8"></a>
### 47. Trabajo de Fase 8

* anclajes;
* catálogo;
* selección;
* validación;
* reservas;
* fases;
* materialización;
* daño;
* captura.

---

<a id="src-master-implementation-and-production-plan--48-criterios-de-salida-de-fase-8"></a>
### 48. Criterios de salida de Fase 8

* el jugador selecciona prioridad;
* la IA propone módulo;
* el terreno se valida;
* se descuentan recursos;
* la construcción progresa;
* el módulo se guarda;
* no bloquea rutas.

<a id="src-master-implementation-and-production-plan--hito-8"></a>
#### Hito

```text
M8 — Primer sector evolutivo
```

---

<a id="src-master-implementation-and-production-plan--49-fase-9-misiones"></a>
### 49. Fase 9 — Misiones

<a id="src-master-implementation-and-production-plan--objetivo-9"></a>
#### Objetivo

Implementar el ciclo de misión.

<a id="src-master-implementation-and-production-plan--entregables-8"></a>
#### Entregables

* plantilla;
* registro;
* estados;
* aceptación;
* delegación;
* expiración;
* objetivos;
* resultados;
* efectos.

---

<a id="src-master-implementation-and-production-plan--50-misiones-iniciales"></a>
### 50. Misiones iniciales

<a id="src-master-implementation-and-production-plan--principales"></a>
#### Principales

* desembarco;
* consolidación de Panochori;
* contacto con Neri;
* primer convoy;
* defensa.

<a id="src-master-implementation-and-production-plan--dinámicas"></a>
#### Dinámicas

* patrulla;
* reconocimiento;
* entrega;
* rescate;
* defensa local.

---

<a id="src-master-implementation-and-production-plan--51-criterios-de-salida-de-fase-9"></a>
### 51. Criterios de salida de Fase 9

* una misión surge de estado;
* puede aceptarse;
* puede ignorarse;
* puede delegarse;
* aplica consecuencias;
* no se resuelve dos veces;
* se guarda.

<a id="src-master-implementation-and-production-plan--hito-9"></a>
#### Hito

```text
M9 — Ciclo completo de misión
```

---

<a id="src-master-implementation-and-production-plan--52-fase-10-población-y-gobierno-básicos"></a>
### 52. Fase 10 — Población y Gobierno básicos

<a id="src-master-implementation-and-production-plan--objetivo-10"></a>
#### Objetivo

Dar consecuencias civiles al control militar.

<a id="src-master-implementation-and-production-plan--sistemas-iniciales"></a>
#### Sistemas iniciales

* población;
* servicios;
* obediencia;
* confianza;
* estabilidad;
* municipio;
* demanda;
* promesa.

---

<a id="src-master-implementation-and-production-plan--53-neochori-como-prueba-civil"></a>
### 53. Neochori como prueba civil

Debe permitir:

* mantener consejo;
* supervisar;
* requisar;
* prometer servicio;
* responder a demanda;
* generar consecuencia.

---

<a id="src-master-implementation-and-production-plan--54-criterios-de-salida-de-fase-10"></a>
### 54. Criterios de salida de Fase 10

* control militar y Gobierno están separados;
* una promesa se registra;
* un servicio necesita recursos;
* civiles reaccionan;
* la interfaz muestra causa.

<a id="src-master-implementation-and-production-plan--hito-10"></a>
#### Hito

```text
M10 — Primer municipio persistente
```

---

<a id="src-master-implementation-and-production-plan--55-fase-11-inteligencia-básica"></a>
### 55. Fase 11 — Inteligencia básica

<a id="src-master-implementation-and-production-plan--objetivo-11"></a>
#### Objetivo

Crear observaciones, informes y conocimiento parcial.

<a id="src-master-implementation-and-production-plan--entregables-9"></a>
#### Entregables

* fuentes;
* informes;
* confianza;
* antigüedad;
* contradicción;
* marcadores;
* requerimientos.

---

<a id="src-master-implementation-and-production-plan--56-casos-iniciales"></a>
### 56. Casos iniciales

* guarnición de Stavros;
* posible equipo AT;
* señal S-26;
* informe alterado por prioridad;
* testimonio civil.

---

<a id="src-master-implementation-and-production-plan--57-criterios-de-salida-de-fase-11"></a>
### 57. Criterios de salida de Fase 11

* la realidad no se envía directamente a UI;
* los informes envejecen;
* fuentes pueden contradecirse;
* comandante actúa sobre creencia;
* el jugador puede verificar.

<a id="src-master-implementation-and-production-plan--hito-11"></a>
#### Hito

```text
M11 — Niebla de guerra funcional
```

---

<a id="src-master-implementation-and-production-plan--58-fase-12-progresión-y-relaciones-básicas"></a>
### 58. Fase 12 — Progresión y relaciones básicas

<a id="src-master-implementation-and-production-plan--objetivo-12"></a>
#### Objetivo

Registrar cómo el mando reacciona al jugador.

<a id="src-master-implementation-and-production-plan--personajes-iniciales"></a>
#### Personajes iniciales

* Ward;
* Hale;
* Rourke;
* Kessler;
* Shaw;
* miembros AZUR-1.

<a id="src-master-implementation-and-production-plan--entregables-10"></a>
#### Entregables

* confianza;
* autoridad;
* prestigio;
* capacidades;
* relación;
* explicación.

---

<a id="src-master-implementation-and-production-plan--59-criterios-de-salida-de-fase-12"></a>
### 59. Criterios de salida de Fase 12

* victoria y obediencia son diferentes;
* un fracaso responsable puede mantener confianza;
* Ward y Hale reaccionan distinto;
* una capacidad depende de activo;
* las relaciones se guardan.

<a id="src-master-implementation-and-production-plan--hito-12"></a>
#### Hito

```text
M12 — Progresión institucional mínima
```

---

<a id="src-master-implementation-and-production-plan--60-fase-13-ui-del-vertical-slice"></a>
### 60. Fase 13 — UI del vertical slice

<a id="src-master-implementation-and-production-plan--objetivo-13"></a>
#### Objetivo

Permitir comprender y utilizar los sistemas anteriores.

<a id="src-master-implementation-and-production-plan--pantallas-mínimas"></a>
#### Pantallas mínimas

* centro de mando;
* mapa;
* sector;
* fuerzas;
* logística;
* misión;
* inteligencia;
* progresión;
* archivo.

---

<a id="src-master-implementation-and-production-plan--61-prioridad-de-ui"></a>
### 61. Prioridad de UI

Primero:

* información;
* acciones;
* feedback.

Después:

* estilo;
* animaciones;
* refinamiento visual.

---

<a id="src-master-implementation-and-production-plan--62-criterios-de-salida-de-fase-13"></a>
### 62. Criterios de salida de Fase 13

* cada acción bloqueada explica motivo;
* no muestra secretos;
* las alertas se agrupan;
* los informes muestran antigüedad;
* el jugador comprende la situación;
* la UI no modifica estado directamente.

<a id="src-master-implementation-and-production-plan--hito-13"></a>
#### Hito

```text
M13 — Centro de mando funcional
```

---

<a id="src-master-implementation-and-production-plan--63-fase-14-narrativa-del-vertical-slice"></a>
### 63. Fase 14 — Narrativa del vertical slice

<a id="src-master-implementation-and-production-plan--objetivo-14"></a>
#### Objetivo

Integrar historia, personajes y contexto.

<a id="src-master-implementation-and-production-plan--contenido"></a>
#### Contenido

* apertura Azul;
* Ward y Hale;
* Rourke;
* Neochori;
* Shaw;
* Reed;
* Petrou;
* primera noche;
* evidencia inicial.

---

<a id="src-master-implementation-and-production-plan--64-requisitos-narrativos"></a>
### 64. Requisitos narrativos

* briefings;
* subtítulos;
* radio;
* interrupciones;
* debriefings;
* documento;
* variantes;
* fallback.

---

<a id="src-master-implementation-and-production-plan--65-criterios-de-salida-de-fase-14"></a>
### 65. Criterios de salida de Fase 14

* las líneas respetan conocimiento;
* una conversación puede interrumpirse;
* la información crítica queda registrada;
* los personajes suenan distintos;
* el estado modifica el diálogo.

<a id="src-master-implementation-and-production-plan--hito-14"></a>
#### Hito

```text
M14 — Historia integrada en sistemas
```

---

<a id="src-master-implementation-and-production-plan--66-gate-4-aprobación-del-vertical-slice"></a>
### 66. GATE 4 — Aprobación del vertical slice

El vertical slice debe incluir:

1. Nueva campaña Azul.
2. Desembarco en Panochori.
3. Captura.
4. Neochori.
5. Municipio.
6. Convoy.
7. Logística.
8. Construcción.
9. Contraataque.
10. Virtualización.
11. Inteligencia.
12. Relaciones.
13. Primera noche.
14. Evidencia S-26.
15. Guardado.
16. Carga.
17. UI.
18. Rendimiento.
19. Fracaso con continuidad.

<a id="src-master-implementation-and-production-plan--condición"></a>
#### Condición

Todos los sistemas principales deben existir en versión mínima, no simulados mediante atajos específicos de misión.

---

<a id="src-master-implementation-and-production-plan--67-prohibiciones-antes-de-aprobar-el-vertical-slice"></a>
### 67. Prohibiciones antes de aprobar el vertical slice

No desarrollar:

* campaña Roja completa;
* 38 sectores detallados;
* Stratis completo;
* Helios avanzado;
* todos los finales;
* doblaje completo;
* cooperativo.

---

<a id="src-master-implementation-and-production-plan--68-fase-15-acto-i-azul-completo"></a>
### 68. Fase 15 — Acto I Azul completo

<a id="src-master-implementation-and-production-plan--objetivo-15"></a>
#### Objetivo

Completar todas las misiones y opciones del primer acto.

<a id="src-master-implementation-and-production-plan--incluye-1"></a>
#### Incluye

* B-P00;
* B-I01 a B-I06;
* opcionales seleccionadas;
* consecuencias;
* variantes;
* fallos;
* delegaciones.

---

<a id="src-master-implementation-and-production-plan--69-ampliación-sistémica-del-acto-i"></a>
### 69. Ampliación sistémica del Acto I

Se completan:

* guarniciones;
* QRF;
* construcción L1;
* civiles básicos;
* misiones dinámicas;
* economía inicial;
* debriefings.

---

<a id="src-master-implementation-and-production-plan--70-gate-5-acto-i-azul"></a>
### 70. GATE 5 — Acto I Azul

Debe poder jugarse:

* de principio a fin;
* con más de una ruta;
* con fracaso parcial;
* con bajas;
* con save/load;
* sin estados imposibles.

<a id="src-master-implementation-and-production-plan--hito-15"></a>
#### Hito

```text
M15 — Primera versión jugable de campaña
```

---

<a id="src-master-implementation-and-production-plan--71-fase-16-actos-ii-y-iii-azul"></a>
### 71. Fase 16 — Actos II y III Azul

<a id="src-master-implementation-and-production-plan--objetivo-16"></a>
#### Objetivo

Ampliar reconocimiento, frente, logística y aeropuerto.

<a id="src-master-implementation-and-production-plan--nuevos-sistemas"></a>
#### Nuevos sistemas

* inteligencia avanzada;
* varias operaciones;
* planificación regional;
* mayor construcción;
* fuerzas mecanizadas;
* AAC;
* Airport West;
* Airport Terminal.

---

<a id="src-master-implementation-and-production-plan--72-nuevos-sectores"></a>
### 72. Nuevos sectores

* Aeropuerto Militar;
* Kavala parcial;
* corredores occidentales;
* centro.

<a id="src-master-implementation-and-production-plan--regla-4"></a>
#### Regla

Cada nuevo sector reutiliza sistemas existentes.

No se crean reglas especiales salvo necesidad documentada.

---

<a id="src-master-implementation-and-production-plan--73-fase-17-actos-iv-y-v-azul"></a>
### 73. Fase 17 — Actos IV y V Azul

<a id="src-master-implementation-and-production-plan--objetivo-17"></a>
#### Objetivo

Integrar política, FIA y fragmentación Verde.

<a id="src-master-implementation-and-production-plan--sistemas"></a>
#### Sistemas

* Gobierno avanzado;
* municipios;
* protestas;
* Markou;
* Kallas;
* células;
* contrainsurgencia;
* cooperación Verde;
* conflicto Ward–Hale.

---

<a id="src-master-implementation-and-production-plan--74-fase-18-actos-vi-y-vii-azul"></a>
### 74. Fase 18 — Actos VI y VII Azul

<a id="src-master-implementation-and-production-plan--objetivo-18"></a>
#### Objetivo

Integrar Helios, infiltración y guerra de nodos.

<a id="src-master-implementation-and-production-plan--sistemas-1"></a>
#### Sistemas

* acceso Helios;
* auditoría;
* Shaw;
* Argos inicial;
* PHAROS;
* evidencias;
* nodos;
* decisiones operacionales.

---

<a id="src-master-implementation-and-production-plan--75-gate-6-campaña-azul-escalable"></a>
### 75. GATE 6 — Campaña Azul escalable

La campaña Azul deberá demostrar:

* persistencia de actos;
* mapa amplio;
* relaciones;
* finales provisionales de Altis;
* paso hacia Stratis;
* estabilidad de larga duración.

<a id="src-master-implementation-and-production-plan--hito-16"></a>
#### Hito

```text
M16 — Campaña Azul de Altis completa
```

---

<a id="src-master-implementation-and-production-plan--76-fase-19-base-de-campaña-roja"></a>
### 76. Fase 19 — Base de campaña Roja

<a id="src-master-implementation-and-production-plan--objetivo-19"></a>
#### Objetivo

Reutilizar la arquitectura validada y añadir asimetría Roja.

<a id="src-master-implementation-and-production-plan--trabajo"></a>
#### Trabajo

* configuración Roja;
* personajes;
* RUBÍ-1;
* fuerza;
* doctrina;
* logística oriental;
* UI temática;
* vocabulario.

---

<a id="src-master-implementation-and-production-plan--77-vertical-slice-rojo"></a>
### 77. Vertical slice Rojo

Sectores:

* Molos;
* Molos Airfield;
* Sofia;
* Pefkas;
* corredor oriental.

<a id="src-master-implementation-and-production-plan--flujo"></a>
#### Flujo

* desembarco;
* Asterión;
* control dual;
* códigos;
* corredor;
* primera noche.

---

<a id="src-master-implementation-and-production-plan--78-regla-de-reutilización"></a>
### 78. Regla de reutilización

La campaña Roja debe reutilizar:

* sectores;
* misión;
* logística;
* construcción;
* inteligencia;
* UI;
* progresión;
* persistencia.

No debe crear una segunda arquitectura paralela.

---

<a id="src-master-implementation-and-production-plan--79-gate-7-campaña-roja-funcional"></a>
### 79. GATE 7 — Campaña Roja funcional

Requisitos:

* Acto I Rojo completo;
* Navid y Vahid diferenciados;
* Volkov;
* Sadeq;
* enlace Verde;
* logística oriental;
* resultados persistentes.

---

<a id="src-master-implementation-and-production-plan--80-fase-20-campaña-roja-completa"></a>
### 80. Fase 20 — Campaña Roja completa

<a id="src-master-implementation-and-production-plan--objetivo-20"></a>
#### Objetivo

Desarrollar los actos equivalentes con su propia perspectiva.

<a id="src-master-implementation-and-production-plan--prioridades"></a>
#### Prioridades

* no duplicar misiones Azul;
* mostrar consecuencias distintas;
* ampliar Asterión;
* Gobierno;
* corredores;
* Convoy de los Muertos;
* Aurora Negra.

<a id="src-master-implementation-and-production-plan--hito-17"></a>
#### Hito

```text
M17 — Campaña Roja de Altis completa
```

---

<a id="src-master-implementation-and-production-plan--81-fase-21-helios-y-argos-completos"></a>
### 81. Fase 21 — Helios y Argos completos

<a id="src-master-implementation-and-production-plan--objetivo-21"></a>
#### Objetivo

Cerrar las siete líneas investigativas.

```text
LÁZARO
PHAROS
ESPEJO AZUL
ASTERIÓN
ESCUDO ROTO
FARO NEGRO
UMBRAL
```

<a id="src-master-implementation-and-production-plan--entregables-11"></a>
#### Entregables

* evidencias;
* autenticidad;
* cadena de custodia;
* conclusiones;
* infiltrados;
* reacciones Argos;
* acceso Stratis.

---

<a id="src-master-implementation-and-production-plan--82-límites-de-argos"></a>
### 82. Límites de Argos

Antes de integrar manipulaciones se debe comprobar:

* acceso;
* presupuesto;
* operador;
* riesgo;
* rastros.

<a id="src-master-implementation-and-production-plan--prohibición"></a>
#### Prohibición

No usar Argos como explicación genérica para corregir incoherencias de diseño.

---

<a id="src-master-implementation-and-production-plan--83-gate-8-verdad-investigable"></a>
### 83. GATE 8 — Verdad investigable

Debe ser posible:

* sospechar;
* verificar;
* equivocarse;
* entregar evidencia;
* perder evidencia;
* exponer infiltrados;
* llegar a conclusiones diferentes.

<a id="src-master-implementation-and-production-plan--hito-18"></a>
#### Hito

```text
M18 — Sistema de investigación integral
```

---

<a id="src-master-implementation-and-production-plan--84-fase-22-preparación-de-stratis"></a>
### 84. Fase 22 — Preparación de Stratis

<a id="src-master-implementation-and-production-plan--objetivo-22"></a>
#### Objetivo

Diseñar el teatro final con base en el estado de ambas campañas.

<a id="src-master-implementation-and-production-plan--trabajo-3den"></a>
#### Trabajo 3DEN

* sectores;
* puertos;
* rutas;
* S-26;
* HELIOS-CORE;
* PHAROS;
* Meridian;
* guarnición Verde;
* civiles;
* escapes.

---

<a id="src-master-implementation-and-production-plan--85-sectores-de-stratis"></a>
### 85. Sectores de Stratis

La lista definitiva se cerrará durante esta fase.

Debe incluir al menos:

* zona de llegada;
* defensa exterior;
* instalación militar;
* área civil;
* S-26;
* PHAROS;
* HELIOS-CORE;
* extracción.

---

<a id="src-master-implementation-and-production-plan--86-preparación-sistémica-de-stratis"></a>
### 86. Preparación sistémica de Stratis

* fuerzas acumuladas;
* personajes vivos;
* evidencia;
* nivel de acceso;
* relaciones;
* recursos;
* rutas finales.

---

<a id="src-master-implementation-and-production-plan--87-fase-23-acto-viii"></a>
### 87. Fase 23 — Acto VIII

<a id="src-master-implementation-and-production-plan--objetivo-23"></a>
#### Objetivo

Implementar Regreso a Stratis.

<a id="src-master-implementation-and-production-plan--variantes-1"></a>
#### Variantes

* asalto ciego;
* acceso parcial;
* operación informada;
* operación integral;
* verdad comparada.

---

<a id="src-master-implementation-and-production-plan--88-operación-azul"></a>
### 88. Operación Azul

```text
Faro Abierto
```

<a id="src-master-implementation-and-production-plan--operación-roja"></a>
#### Operación Roja

```text
Aurora Negra
```

Ambas compartirán:

* geografía;
* sistemas;
* actores.

Cambiarán:

* mando;
* objetivos;
* relaciones;
* acceso;
* decisiones.

---

<a id="src-master-implementation-and-production-plan--89-gate-9-stratis-completo"></a>
### 89. GATE 9 — Stratis completo

Requisitos:

* entrada;
* múltiples rutas;
* Petrou;
* PHAROS;
* dirección clandestina e identidad probable de Vardis;
* Mercer;
* nodos;
* decisiones;
* salida;
* guardado;
* rendimiento.

<a id="src-master-implementation-and-production-plan--hito-19"></a>
#### Hito

```text
M19 — Operación final completa
```

---

<a id="src-master-implementation-and-production-plan--90-fase-24-finales-y-epílogos"></a>
### 90. Fase 24 — Finales y epílogos

<a id="src-master-implementation-and-production-plan--objetivo-24"></a>
#### Objetivo

Resolver consecuencias acumuladas.

<a id="src-master-implementation-and-production-plan--variables"></a>
#### Variables

* bando;
* control;
* Gobierno;
* FIA;
* Verde;
* Helios;
* Vardis;
* Mercer;
* evidencia;
* relaciones;
* civiles;
* autoridad.

---

<a id="src-master-implementation-and-production-plan--91-familias-de-finales"></a>
### 91. Familias de finales

```text
Helios destruido
Helios controlado militarmente
Helios transferido
Helios auditado
Argos parcialmente expuesto
Argos destruido
Argos fragmentado
Vardis capturado
Vardis muerto
Vardis escapa
```

Las familias físicas de Vardis solo se generan en la variante comparada cuando `dualCampaignCompleted == true` y `dualOperationUnlocked == true`. Una campaña aislada registra `Vardis no confirmado` y resuelve Helios, Argos y Stratis sin asignarle destino físico. Las familias válidas se combinarán con resultados políticos.

---

<a id="src-master-implementation-and-production-plan--92-comparación-de-campañas"></a>
### 92. Comparación de campañas

Después de completar ambas:

* identificar evidencias compartidas;
* mostrar contradicciones;
* desbloquear conclusión S4;
* confirmar físicamente a Vardis y desbloquear la sala de dirección;
* presentar epílogo comparado y, cuando corresponda, captura, muerte, juicio, negociación o fuga.

<a id="src-master-implementation-and-production-plan--regla-5"></a>
#### Regla

Completar una campaña no invalida sus decisiones al jugar la otra.

---

<a id="src-master-implementation-and-production-plan--93-fase-25-contenido-opcional-completo"></a>
### 93. Fase 25 — Contenido opcional completo

<a id="src-master-implementation-and-production-plan--incluye-2"></a>
#### Incluye

* misiones de personajes;
* operaciones civiles;
* FIA;
* rutas alternativas;
* documentos;
* escenas ambientales;
* misiones emergentes adicionales.

<a id="src-master-implementation-and-production-plan--regla-6"></a>
#### Regla

Solo después de asegurar la ruta principal.

---

<a id="src-master-implementation-and-production-plan--94-fase-26-audio"></a>
### 94. Fase 26 — Audio

<a id="src-master-implementation-and-production-plan--orden"></a>
#### Orden

1. Guion final.
2. Tabla de líneas.
3. casting o voces temporales.
4. grabación.
5. limpieza.
6. integración.
7. subtítulos.
8. mezcla.
9. pruebas.

---

<a id="src-master-implementation-and-production-plan--95-voces-temporales"></a>
### 95. Voces temporales

Durante desarrollo se pueden usar:

* texto;
* TTS temporal local autorizado;
* tonos;
* audio de referencia.

No se debe bloquear la programación esperando audio final.

---

<a id="src-master-implementation-and-production-plan--96-fase-27-arte-y-pulido-visual"></a>
### 96. Fase 27 — Arte y pulido visual

<a id="src-master-implementation-and-production-plan--incluye-3"></a>
#### Incluye

* composiciones;
* iluminación;
* efectos;
* iconos;
* UI;
* transiciones;
* identidad de facciones.

<a id="src-master-implementation-and-production-plan--regla-7"></a>
#### Regla

El pulido no debe ocultar errores de funcionalidad.

---

<a id="src-master-implementation-and-production-plan--97-fase-28-balance"></a>
### 97. Fase 28 — Balance

<a id="src-master-implementation-and-production-plan--rondas"></a>
#### Rondas

```text
Balance de sistemas
Balance del Acto I
Balance de campaña Azul
Balance de campaña Roja
Balance de Stratis
Balance de dificultades
```

---

<a id="src-master-implementation-and-production-plan--98-método-de-balance"></a>
### 98. Método de balance

1. Crear hipótesis.
2. Medir.
3. Comparar.
4. Cambiar una familia de variables.
5. Repetir.
6. Registrar.

---

<a id="src-master-implementation-and-production-plan--99-fase-29-optimización"></a>
### 99. Fase 29 — Optimización

<a id="src-master-implementation-and-production-plan--prioridad"></a>
#### Prioridad

1. errores;
2. duplicaciones;
3. scripts lentos;
4. IA física;
5. objetos;
6. interfaz;
7. memoria;
8. saves.

<a id="src-master-implementation-and-production-plan--regla-8"></a>
#### Regla

No optimizar prematuramente funciones no medidas.

---

<a id="src-master-implementation-and-production-plan--100-fase-30-beta"></a>
### 100. Fase 30 — Beta

<a id="src-master-implementation-and-production-plan--objetivo-25"></a>
#### Objetivo

Validar campañas completas con jugadores externos.

<a id="src-master-implementation-and-production-plan--incluye-4"></a>
#### Incluye

* tutorial;
* campañas;
* finales;
* audio casi completo;
* accesibilidad;
* saves;
* migración.

---

<a id="src-master-implementation-and-production-plan--101-pruebas-beta"></a>
### 101. Pruebas beta

Perfiles:

* jugador nuevo de Arma;
* jugador experimentado;
* jugador narrativo;
* jugador estratégico;
* hardware medio;
* hardware mínimo objetivo.

---

<a id="src-master-implementation-and-production-plan--102-gate-10-beta-aprobada"></a>
### 102. GATE 10 — Beta aprobada

No debe haber:

* defectos S0;
* corrupción conocida;
* bloqueos de campaña;
* finales inaccesibles por error;
* degradación extrema de rendimiento.

---

<a id="src-master-implementation-and-production-plan--103-fase-31-release-candidate"></a>
### 103. Fase 31 — Release candidate

<a id="src-master-implementation-and-production-plan--trabajo-1"></a>
#### Trabajo

* congelar alcance;
* resolver defectos;
* ejecutar regresión;
* validar saves;
* revisar textos;
* comprobar audio;
* revisar licencias;
* construir paquete.

---

<a id="src-master-implementation-and-production-plan--104-congelación-de-contenido"></a>
### 104. Congelación de contenido

Después del RC:

* no añadir sistemas;
* no reestructurar estados;
* no cambiar IDs;
* no añadir grandes sectores.

Solo:

* correcciones;
* balance;
* accesibilidad;
* rendimiento;
* textos.

---

<a id="src-master-implementation-and-production-plan--105-gate-11-release-candidate-aprobado"></a>
### 105. GATE 11 — Release candidate aprobado

Requisitos:

* campañas completas;
* todos los finales;
* RPT limpio;
* rendimiento aceptable;
* instalación verificada;
* documentación;
* changelog;
* save nuevo;
* migración soportada.

---

<a id="src-master-implementation-and-production-plan--106-versionado-de-producción"></a>
### 106. Versionado de producción

Propuesta:

```text
0.0.x — núcleo
0.1.0 — mundo mínimo
0.2.0 — simulación táctica
0.3.0 — logística y sectores
0.4.0 — vertical slice
0.5.0 — Acto I Azul
0.6.0 — campaña Azul parcial
0.7.0 — campaña Roja parcial
0.8.0 — Altis completo
0.9.0 — beta con Stratis
1.0.0 — lanzamiento
```

---

<a id="src-master-implementation-and-production-plan--107-compatibilidad-de-guardados"></a>
### 107. Compatibilidad de guardados

Cada versión debe indicar:

```text
Compatible
Compatible con migración
No compatible
```

<a id="src-master-implementation-and-production-plan--regla-9"></a>
#### Regla

Las versiones de desarrollo pueden romper saves únicamente si se documenta antes.

---

<a id="src-master-implementation-and-production-plan--108-backlog-maestro-por-épicas"></a>
### 108. Backlog maestro por épicas

```text
EPIC-CORE
EPIC-PERSISTENCE
EPIC-WORLD
EPIC-SECTORS
EPIC-FORCES
EPIC-TACTICAL
EPIC-LOGISTICS
EPIC-CONSTRUCTION
EPIC-MISSIONS
EPIC-CIVILIANS
EPIC-FIA
EPIC-INTELLIGENCE
EPIC-HELIOS
EPIC-EVIDENCE
EPIC-PROGRESSION
EPIC-UI
EPIC-NARRATIVE
EPIC-BLUE
EPIC-RED
EPIC-STRATIS
EPIC-ENDINGS
EPIC-TESTS
EPIC-PERFORMANCE
```

---

<a id="src-master-implementation-and-production-plan--109-formato-de-tarea"></a>
### 109. Formato de tarea

```text
ID:
Épica:
Título:
Prioridad:
Objetivo:
Dependencias:
Archivos:
Criterios de aceptación:
Pruebas:
Persistencia:
UI:
Riesgos:
Estado:
```

---

<a id="src-master-implementation-and-production-plan--110-ejemplo-de-tarea"></a>
### 110. Ejemplo de tarea

```text
ID:
LOG-014

Épica:
EPIC-LOGISTICS

Título:
Crear convoy estratégico Panochori–Neri

Prioridad:
P1

Objetivo:
Reservar carga, vehículos y escolta, crear convoy y registrar su estado.

Dependencias:
Estado, fuerzas, rutas, transacciones y eventos.

Criterios:
• No duplica carga.
• Puede cancelarse.
• Puede materializarse.
• Se guarda.
• Publica CONVOY_CREATED.

Pruebas:
• Éxito.
• Fallo de reserva.
• Descarga doble.
• Guardado en ruta.
```

---

<a id="src-master-implementation-and-production-plan--111-matriz-de-dependencias"></a>
### 111. Matriz de dependencias

<a id="src-master-implementation-and-production-plan--core-1"></a>
#### Core

No depende de sistemas de campaña.

<a id="src-master-implementation-and-production-plan--persistencia"></a>
#### Persistencia

Depende de Core.

<a id="src-master-implementation-and-production-plan--mundo"></a>
#### Mundo

Depende de Core y configuración.

<a id="src-master-implementation-and-production-plan--sectores-1"></a>
#### Sectores

Depende de Mundo.

<a id="src-master-implementation-and-production-plan--fuerzas"></a>
#### Fuerzas

Depende de Facciones y Sectores.

<a id="src-master-implementation-and-production-plan--logística"></a>
#### Logística

Depende de Fuerzas, Sectores y transacciones.

<a id="src-master-implementation-and-production-plan--construcción"></a>
#### Construcción

Depende de Sectores y Logística.

<a id="src-master-implementation-and-production-plan--misiones"></a>
#### Misiones

Depende de módulos mediante contratos.

<a id="src-master-implementation-and-production-plan--ui"></a>
#### UI

Depende de view models, no del estado interno.

<a id="src-master-implementation-and-production-plan--campañas"></a>
#### Campañas

Dependen de todos los sistemas estabilizados.

---

<a id="src-master-implementation-and-production-plan--112-riesgo-de-dependencias-circulares"></a>
### 112. Riesgo de dependencias circulares

Antes de añadir una dependencia debe preguntarse:

1. ¿Puede resolverse con un evento?
2. ¿Puede resolverse con una query?
3. ¿Pertenece la coordinación a Application?
4. ¿El dato está en el módulo correcto?

---

<a id="src-master-implementation-and-production-plan--113-riesgos-principales-del-proyecto"></a>
### 113. Riesgos principales del proyecto

```text
Alcance excesivo
Acoplamiento técnico
Rendimiento
Pathfinding
Persistencia
Narrativa demasiado grande
IA estratégica injusta
Demasiado contenido antes de estabilizar
Falta de herramientas de prueba
Duplicación Azul–Rojo
```

---

<a id="src-master-implementation-and-production-plan--114-riesgo-alcance-excesivo"></a>
### 114. Riesgo — Alcance excesivo

<a id="src-master-implementation-and-production-plan--mitigación"></a>
#### Mitigación

* vertical slice;
* puertas;
* prioridades;
* exclusiones;
* backlog posterior;
* congelación de fases.

---

<a id="src-master-implementation-and-production-plan--115-riesgo-rendimiento"></a>
### 115. Riesgo — Rendimiento

<a id="src-master-implementation-and-production-plan--mitigación-1"></a>
#### Mitigación

* virtualización;
* presupuestos;
* scheduler;
* medición;
* lotes;
* Dynamic Simulation selectiva;
* pruebas en hardware real.

---

<a id="src-master-implementation-and-production-plan--116-riesgo-persistencia"></a>
### 116. Riesgo — Persistencia

<a id="src-master-implementation-and-production-plan--mitigación-2"></a>
#### Mitigación

* schema;
* snapshots;
* validadores;
* migraciones;
* saves de prueba;
* regresiones.

---

<a id="src-master-implementation-and-production-plan--117-riesgo-pathfinding"></a>
### 117. Riesgo — Pathfinding

<a id="src-master-implementation-and-production-plan--mitigación-3"></a>
#### Mitigación

* rutas 3DEN;
* pruebas de convoy;
* anclajes;
* alternativas;
* virtualización lejana.

---

<a id="src-master-implementation-and-production-plan--118-riesgo-narrativa-bloqueante"></a>
### 118. Riesgo — Narrativa bloqueante

<a id="src-master-implementation-and-production-plan--mitigación-4"></a>
#### Mitigación

* sustitutos;
* documentos;
* fallbacks;
* información crítica registrada;
* personajes no obligatoriamente inmortales.

---

<a id="src-master-implementation-and-production-plan--119-riesgo-argos-omnipotente"></a>
### 119. Riesgo — Argos omnipotente

<a id="src-master-implementation-and-production-plan--mitigación-5"></a>
#### Mitigación

* presupuesto;
* acceso;
* operadores;
* evidencias;
* límites;
* consecuencias.

---

<a id="src-master-implementation-and-production-plan--120-riesgo-campaña-roja-duplicada"></a>
### 120. Riesgo — Campaña Roja duplicada

<a id="src-master-implementation-and-production-plan--mitigación-6"></a>
#### Mitigación

* reutilizar sistemas;
* diseñar perspectiva;
* nuevas rutas;
* distintos conflictos;
* mismos hechos compartidos.

---

<a id="src-master-implementation-and-production-plan--121-riesgo-desarrollo-prematuro-de-stratis"></a>
### 121. Riesgo — Desarrollo prematuro de Stratis

<a id="src-master-implementation-and-production-plan--mitigación-7"></a>
#### Mitigación

No producir contenido final de Stratis hasta aprobar:

* Altis;
* investigación;
* Helios;
* ambas campañas;
* rendimiento.

---

<a id="src-master-implementation-and-production-plan--122-control-documental"></a>
### 122. Control documental

Los 14 documentos rectores serán la base del proyecto.

Todo cambio importante debe actualizar:

* documento afectado;
* ADR;
* configuración;
* backlog;
* pruebas.

---

<a id="src-master-implementation-and-production-plan--123-índice-de-documentos"></a>
### 123. Índice de documentos

```text
DOC-01 Campañas
DOC-02 Evidencias
DOC-03 Misiones
DOC-04 Civiles
DOC-05 FIA
DOC-06 Helios e inteligencia
DOC-07 Táctico
DOC-08 Progresión
DOC-09 Interfaz
DOC-10 Arquitectura
DOC-11 3DEN
DOC-12 Narrativa
DOC-13 Pruebas
DOC-14 Producción
```

---

<a id="src-master-implementation-and-production-plan--124-matriz-de-trazabilidad"></a>
### 124. Matriz de trazabilidad

Cada funcionalidad debe vincular:

```text
Requisito
→ Documento
→ Épica
→ Tarea
→ Código
→ Prueba
→ Versión
```

<a id="src-master-implementation-and-production-plan--ejemplo"></a>
#### Ejemplo

```text
Construcción automática
→ DOC-11 / sistema territorial
→ EPIC-CONSTRUCTION
→ CON-004
→ modules/construction
→ TEST_CONSTRUCTION_FRONTLINE
→ 0.3.0
```

---

<a id="src-master-implementation-and-production-plan--125-documentación-viva"></a>
### 125. Documentación viva

Después de cada hito se debe revisar:

* arquitectura;
* estado;
* API;
* configuración;
* pruebas;
* 3DEN;
* narrativa;
* changelog.

<a id="src-master-implementation-and-production-plan--regla-10"></a>
#### Regla

El código implementado y la documentación no pueden describir sistemas distintos.

---

<a id="src-master-implementation-and-production-plan--126-registro-de-decisiones"></a>
### 126. Registro de decisiones

Toda excepción importante requiere ADR.

Ejemplos:

* cambiar almacenamiento;
* modificar IDs;
* añadir Headless Client;
* cambiar modelo territorial;
* separar campañas en misiones diferentes.

---

<a id="src-master-implementation-and-production-plan--127-flujo-de-revisión-por-módulo"></a>
### 127. Flujo de revisión por módulo

1. Revisar diseño.
2. Revisar estado propietario.
3. Revisar API.
4. Revisar persistencia.
5. Revisar localidad.
6. Revisar rendimiento.
7. Revisar pruebas.
8. Revisar documentación.

---

<a id="src-master-implementation-and-production-plan--128-flujo-de-integración-3den"></a>
### 128. Flujo de integración 3DEN

Para cada sector:

1. Definir función.
2. Crear anclajes.
3. Validar rutas.
4. Probar IA.
5. Crear composición.
6. Registrar.
7. Integrar estado.
8. Probar captura.
9. Guardar.
10. Documentar.

---

<a id="src-master-implementation-and-production-plan--129-flujo-de-integración-de-misión"></a>
### 129. Flujo de integración de misión

1. Definir causa.
2. Definir intención.
3. Definir actores.
4. Definir objetivos.
5. Definir consecuencias.
6. Definir estados.
7. Definir variantes.
8. Integrar táctica.
9. Integrar UI.
10. Integrar narrativa.
11. Probar.
12. Guardar.

---

<a id="src-master-implementation-and-production-plan--130-flujo-de-corrección"></a>
### 130. Flujo de corrección

1. Reproducir.
2. Clasificar.
3. Capturar save y RPT.
4. Identificar propietario.
5. Añadir prueba.
6. Corregir.
7. Ejecutar regresión.
8. Verificar.
9. Documentar.

---

<a id="src-master-implementation-and-production-plan--131-flujo-de-balance"></a>
### 131. Flujo de balance

1. Definir problema.
2. Recoger métricas.
3. Identificar variable.
4. Cambiar configuración.
5. Repetir escenario.
6. Comparar.
7. Aprobar o revertir.

---

<a id="src-master-implementation-and-production-plan--132-hitos-resumidos"></a>
### 132. Hitos resumidos

```text
M0 Esqueleto técnico
M1 Núcleo autoritativo
M2 Persistencia
M3 Mundo mínimo
M4 Fuerzas
M5 Virtualización
M6 Territorio
M7 Logística
M8 Construcción
M9 Misiones
M10 Civiles
M11 Inteligencia
M12 Progresión
M13 UI
M14 Narrativa
M15 Acto I Azul
M16 Campaña Azul
M17 Campaña Roja
M18 Investigación completa
M19 Stratis
M20 Beta
M21 Lanzamiento
```

---

<a id="src-master-implementation-and-production-plan--133-orden-obligatorio-de-hitos"></a>
### 133. Orden obligatorio de hitos

```text
M0
→ M1
→ M2
→ M3
→ M4
→ M5
→ M6
→ M7
→ M8
→ M9
→ M10
→ M11
→ M12
→ M13
→ M14
→ M15
```

Después de M15 pueden existir algunos trabajos paralelos controlados.

---

<a id="src-master-implementation-and-production-plan--134-trabajo-paralelo-permitido"></a>
### 134. Trabajo paralelo permitido

Después del núcleo estable pueden trabajarse en paralelo:

* composiciones 3DEN;
* UI visual;
* escritura;
* audio temporal;
* documentación.

<a id="src-master-implementation-and-production-plan--condición-1"></a>
#### Condición

No deben asumir APIs no aprobadas.

---

<a id="src-master-implementation-and-production-plan--135-trabajo-paralelo-prohibido"></a>
### 135. Trabajo paralelo prohibido

No conviene desarrollar simultáneamente versiones diferentes de:

* estado;
* persistencia;
* captura;
* logística;
* virtualización.

Estos sistemas necesitan una fuente única.

---

<a id="src-master-implementation-and-production-plan--136-entregable-del-vertical-slice"></a>
### 136. Entregable del vertical slice

Debe incluir un paquete con:

```text
Misión jugable
Save inicial
Save posterior
RPT limpio
Documento de pruebas
Vídeo de flujo
Capturas de UI
Estado de defectos
Métricas de rendimiento
```

---

<a id="src-master-implementation-and-production-plan--137-entregable-de-cada-versión"></a>
### 137. Entregable de cada versión

```text
Archivo de misión
Número de versión
Changelog
Compatibilidad de saves
Pruebas
Defectos conocidos
Documentación actualizada
```

---

<a id="src-master-implementation-and-production-plan--138-criterios-para-descartar-una-funcionalidad"></a>
### 138. Criterios para descartar una funcionalidad

Puede descartarse si:

* duplica otra;
* no afecta decisiones;
* consume demasiado rendimiento;
* requiere microgestión contraria al diseño;
* no puede probarse;
* bloquea el hito;
* solo añade decoración sistémica.

---

<a id="src-master-implementation-and-production-plan--139-elementos-que-deben-permanecer-simples"></a>
### 139. Elementos que deben permanecer simples

Durante V1:

* árbol tecnológico;
* economía financiera;
* diplomacia internacional;
* producción industrial detallada;
* personal individual genérico;
* cooperativo;
* soporte de mods.

---

<a id="src-master-implementation-and-production-plan--140-elementos-que-no-pueden-simplificarse-incorrectamente"></a>
### 140. Elementos que no pueden simplificarse incorrectamente

* persistencia;
* autoridad;
* origen de recursos;
* reservas;
* bajas;
* conocimiento parcial;
* control territorial;
* relaciones;
* consecuencias.

---

<a id="src-master-implementation-and-production-plan--141-contenido-mínimo-viable-de-v1-interna"></a>
### 141. Contenido mínimo viable de V1 interna

Una primera versión interna útil puede limitarse a:

* Azul;
* Panochori;
* Neri;
* corredor occidental;
* convoy;
* captura;
* guardado;
* UI mínima;
* una decisión civil;
* una evidencia.

<a id="src-master-implementation-and-production-plan--objetivo-26"></a>
#### Objetivo

Demostrar la estructura completa en pequeño.

---

<a id="src-master-implementation-and-production-plan--142-contenido-mínimo-viable-jugable"></a>
### 142. Contenido mínimo viable jugable

Debe incluir:

* Acto I Azul;
* varios resultados;
* persistencia;
* sistemas principales;
* narrativa;
* rendimiento.

---

<a id="src-master-implementation-and-production-plan--143-contenido-completo-10"></a>
### 143. Contenido completo 1.0

* ambas campañas;
* Altis;
* Stratis;
* principales misiones;
* sistemas completos;
* finales;
* documentación;
* accesibilidad;
* balance.

---

<a id="src-master-implementation-and-production-plan--144-cooperativo-futuro"></a>
### 144. Cooperativo futuro

Se considera fase posterior a 1.0.

<a id="src-master-implementation-and-production-plan--preparación-desde-ahora"></a>
#### Preparación desde ahora

* servidor autoritativo;
* requests;
* IDs;
* sincronización;
* localidad;
* no depender de cliente.

<a id="src-master-implementation-and-production-plan--implementación-posterior"></a>
#### Implementación posterior

* lobby;
* roles;
* JIP;
* decisión compartida;
* guardado del servidor;
* pruebas de red.

---

<a id="src-master-implementation-and-production-plan--145-mods-futuros"></a>
### 145. Mods futuros

Se añadirán mediante perfiles.

<a id="src-master-implementation-and-production-plan--requisitos"></a>
#### Requisitos

* aliases;
* class validation;
* fallbacks;
* compatibilidad;
* pruebas;
* no cambiar lógica de campaña.

---

<a id="src-master-implementation-and-production-plan--146-headless-client-futuro"></a>
### 146. Headless Client futuro

Solo se añade cuando:

* SP funciona;
* servidor funciona;
* localidad está probada;
* rendimiento demuestra necesidad.

---

<a id="src-master-implementation-and-production-plan--147-servidor-dedicado-futuro"></a>
### 147. Servidor dedicado futuro

La campaña deberá poder migrarse mediante adaptador de almacenamiento.

No se diseñará una segunda campaña separada.

---

<a id="src-master-implementation-and-production-plan--148-indicadores-de-salud-del-proyecto"></a>
### 148. Indicadores de salud del proyecto

```text
Defectos S0 y S1
Pruebas aprobadas
RPT
Tiempo de guardado
Tamaño de save
FPS
Tareas bloqueadas
Deuda técnica
Documentación desactualizada
```

---

<a id="src-master-implementation-and-production-plan--149-revisión-semanal-o-por-ciclo"></a>
### 149. Revisión semanal o por ciclo

Debe revisar:

1. Qué terminó.
2. Qué quedó bloqueado.
3. Qué defectos aparecieron.
4. Qué documentación cambió.
5. Qué sistema está creciendo demasiado.
6. Qué puede eliminarse.
7. Qué puerta sigue pendiente.

---

<a id="src-master-implementation-and-production-plan--150-revisión-de-alcance-por-hito"></a>
### 150. Revisión de alcance por hito

Antes de iniciar un nuevo hito:

* cerrar defectos críticos;
* actualizar backlog;
* confirmar dependencias;
* identificar riesgos;
* congelar contenido del hito.

---

<a id="src-master-implementation-and-production-plan--151-criterios-de-parada"></a>
### 151. Criterios de parada

Debe detenerse la ampliación cuando:

* los saves se corrompen;
* aparecen duplicaciones;
* el rendimiento cae progresivamente;
* el estado no puede explicarse;
* la documentación contradice el código;
* las pruebas no pueden reproducirse.

<a id="src-master-implementation-and-production-plan--acción"></a>
#### Acción

Regresar al último hito estable.

---

<a id="src-master-implementation-and-production-plan--152-criterios-de-éxito-del-proyecto"></a>
### 152. Criterios de éxito del proyecto

Islas Fracturadas será técnicamente exitosa cuando:

1. La campaña pueda mantenerse durante muchas sesiones.
2. El mundo cambie sin perder coherencia.
3. Las fuerzas puedan existir virtualmente.
4. Las batallas tengan consecuencias persistentes.
5. Los sectores evolucionen.
6. La logística condicione decisiones.
7. Los civiles recuerden.
8. FIA tenga comportamiento propio.
9. La inteligencia sea parcial.
10. Helios sea útil y peligroso.
11. Argos pueda descubrirse.
12. Las campañas Azul y Roja sean distintas.
13. Stratis cierre lo construido.
14. Los finales reflejen decisiones.
15. Los sistemas sean mantenibles.

---

<a id="src-master-implementation-and-production-plan--153-principios-obligatorios-de-producción"></a>
### 153. Principios obligatorios de producción

1. Construir pequeño antes de escalar.
2. Validar arquitectura antes de contenido.
3. Guardar desde las primeras fases.
4. Probar fracasos.
5. No duplicar sistemas por campaña.
6. Reutilizar configuraciones.
7. Validar geografía en 3DEN.
8. Medir rendimiento.
9. Documentar contratos.
10. Mantener autoridad.
11. Usar IDs estables.
12. Proteger saves.
13. Crear regresiones.
14. Evitar trabajo no verificable.
15. Separar pulido de funcionalidad.
16. Congelar alcance por hito.
17. No crear Stratis prematuramente.
18. No añadir cooperativo antes de estabilizar.
19. No depender de mods.
20. No ocultar deuda técnica.
21. Cada nueva misión debe tener causa.
22. Cada consecuencia debe aplicarse una vez.
23. Cada módulo debe poseer su estado.
24. Cada fase debe producir una versión jugable.
25. Cada puerta debe tener criterios.
26. Cada error grave debe poder reproducirse.
27. Cada cambio mayor debe tener ADR.
28. Cada entrega debe indicar compatibilidad.
29. Cada sistema debe tener fallback.
30. El lanzamiento no se define por cantidad de contenido, sino por estabilidad y coherencia.

---

<a id="src-master-implementation-and-production-plan--154-errores-de-producción-que-deben-evitarse"></a>
### 154. Errores de producción que deben evitarse

1. Crear los 38 sectores antes de probar nueve.
2. Escribir todos los diálogos antes de cerrar misiones.
3. Crear toda la UI antes de tener contratos.
4. Hacer campaña Roja en una arquitectura separada.
5. Crear Stratis como mapa independiente sin estado acumulado.
6. Añadir mods en la base.
7. Depender de Headless Client.
8. Guardar solo al final del desarrollo.
9. Corregir duplicaciones manualmente.
10. Introducir sistemas sin pruebas.
11. Crear contenido para ocultar falta de profundidad.
12. Hacer refactors masivos durante beta.
13. Cambiar IDs después de crear saves.
14. Ignorar RPT.
15. Optimizar sin medir.
16. Usar scripts específicos para falsificar sistemas.
17. Permitir que la IA generativa escriba canon sin revisión.
18. Mantener documentación desactualizada.
19. Aceptar defectos intermitentes como normales.
20. Continuar ampliando sobre una base inestable.

---

<a id="src-master-implementation-and-production-plan--155-primer-backlog-ejecutable"></a>
### 155. Primer backlog ejecutable

> **Trazabilidad:** esta lista heredada conserva el alcance maestro. Para Fase 0, su desglose operativo vigente es el [backlog `F0-001`–`F0-012`](#backlog-ejecutable-inicial-de-fase-0), que añade dependencias, propietario, prueba, estado y evidencia.

<a id="src-master-implementation-and-production-plan--bloque-a-repositorio"></a>
#### Bloque A — Repositorio

* [ ] Crear repositorio.
* [ ] Crear misión Altis vacía.
* [ ] Crear carpetas.
* [ ] Añadir README.
* [ ] Añadir changelog.
* [ ] Añadir plantillas.

<a id="src-master-implementation-and-production-plan--bloque-b-core"></a>
#### Bloque B — Core

* [x] Logger.
* [x] Error service.
* [x] IDs.
* [x] Bootstrap.
* [x] Config loader.
* [x] Estado.
* [x] Event bus.
* [x] Scheduler.
* [x] Transacciones.
* [x] Test runner.

<a id="src-master-implementation-and-production-plan--bloque-c-persistencia"></a>
#### Bloque C — Persistencia

* [x] Storage adapter.
* [x] Save envelope.
* [x] Snapshot A/B.
* [x] Validación.
* [x] Migración inicial.

<a id="src-master-implementation-and-production-plan--bloque-d-vertical-slice-3den"></a>
#### Bloque D — Vertical slice 3DEN

* [ ] Capas.
* [ ] Neri–Panochori.
* [ ] primer enlace del corredor occidental.
* [ ] Stavros.
* [ ] Rutas.
* [ ] Anclajes.
* [ ] Spawns.
* [ ] Zonas civiles.

---

<a id="src-master-implementation-and-production-plan--156-primera-secuencia-técnica-exacta"></a>
### 156. Primera secuencia técnica exacta

```text
1. Crear misión base.
2. Registrar IF_fnc_bootstrapPreInit.
3. Registrar IF_fnc_bootstrapPostInit.
4. Crear IF_logWrite.
5. Crear IF_errorCreate.
6. Crear IF_config.
7. Crear IF_campaignState.
8. Crear validador mínimo.
9. Crear test runner.
10. Crear primer save.
11. Cargar save.
12. Registrar `ALT_W_NERI_PANOCHORI`.
13. Mostrar Neri–Panochori en diagnóstico.
14. Cambiar propietario por command.
15. Guardar.
16. Cargar y confirmar.
```

<a id="src-master-implementation-and-production-plan--resultado"></a>
#### Resultado

Al terminar esta secuencia ya existirá la primera demostración completa de:

* arquitectura;
* estado;
* command;
* persistencia;
* mundo.

---

<a id="src-master-implementation-and-production-plan--157-primer-escenario-jugable-técnico"></a>
### 157. Primer escenario jugable técnico

Después de la secuencia anterior:

1. Materializar AZUR-1.
2. Materializar una escuadra Verde.
3. Ejecutar combate.
4. Registrar bajas.
5. Consolidar Panochori.
6. Reintegrar.
7. Guardar.
8. Cargar.
9. Confirmar control y bajas.

Este escenario debe aprobarse antes de crear el convoy.

---

<a id="src-master-implementation-and-production-plan--158-segundo-escenario-jugable-técnico"></a>
### 158. Segundo escenario jugable técnico

1. Crear stock en Panochori.
2. Crear demanda en Neri.
3. Reservar carga.
4. Crear convoy.
5. Materializarlo.
6. Escoltar.
7. Descargar.
8. Actualizar Neochori.
9. Guardar.
10. Cargar.

---

<a id="src-master-implementation-and-production-plan--159-tercer-escenario-jugable-técnico"></a>
### 159. Tercer escenario jugable técnico

1. Capturar Neochori.
2. Mantener consejo municipal.
3. Crear promesa.
4. Establecer prioridad.
5. Construir puesto médico.
6. Generar demanda civil.
7. Cambiar relación.
8. Guardar.
9. Cargar.

---

<a id="src-master-implementation-and-production-plan--160-cuarto-escenario-jugable-técnico"></a>
### 160. Cuarto escenario jugable técnico

1. Crear informe sobre Stavros.
2. Añadir contradicción.
3. Alterar prioridad mediante Shaw.
4. Entregar informe a Ward.
5. Crear creencia.
6. Generar misión.
7. Resolver.
8. Registrar resultado.

---

<a id="src-master-implementation-and-production-plan--161-resultado-del-plan-maestro"></a>
### 161. Resultado del plan maestro

Cuando se siga este plan, la producción avanzará en el siguiente sentido:

```text
Código demostrable
→ sistema persistente
→ mundo pequeño
→ operación jugable
→ acto completo
→ campaña completa
→ segunda perspectiva
→ teatro final
→ lanzamiento
```

En ningún momento será necesario implementar la totalidad de Islas Fracturadas para comprobar si la arquitectura funciona.

---

<a id="src-master-implementation-and-production-plan--162-definición-final"></a>
### 162. Definición final

El mayor riesgo de Islas Fracturadas no es que una función SQF falle.

Es que la cantidad de sistemas, personajes, sectores, misiones y consecuencias lleve a desarrollar muchas partes aisladas sin una base capaz de conectarlas.

Este plan evita ese resultado mediante una regla simple:

> **Nada se amplía hasta que la versión pequeña del mismo problema funciona, se guarda, se carga y puede probarse.**

Primero debe existir un sector.

Después una conexión.

Después una fuerza.

Después una batalla.

Después una consecuencia.

Después una misión.

Después un acto.

Solo entonces se amplía a una campaña.

La campaña Roja no se construirá copiando la Azul.

Se construirá utilizando los mismos sistemas para demostrar cómo otra cadena de mando, otra doctrina y otra información producen una guerra diferente.

Stratis no se construirá como un capítulo final añadido.

Se construirá como la consecuencia técnica, logística, política, narrativa e investigativa de todo lo ocurrido en Altis.

> **El vertical slice no será una demostración temporal que se desecha. Será el primer fragmento real de la campaña completa.**

> **Cada hito deberá dejar el proyecto más jugable, más verificable y más fácil de comprender.**

> **Islas Fracturadas estará lista no cuando todo lo imaginado haya sido añadido, sino cuando cada sistema necesario funcione, cada consecuencia sobreviva y cada expansión pueda construirse sin romper lo anterior.**

<a id="src-master-implementation-and-production-plan--estado-final-de-documentación"></a>
#### Estado final de documentación

La colección rectora queda completa, `DOC-GATE-01` está aprobado y el backlog inicial de Fase 0 ya se encuentra numerado como `F0-001`–`F0-012`. El siguiente paso operativo es iniciar `F0-001` sin atribuir a la documentación ningún estado de implementación.
