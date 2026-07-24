# Arquitectura de las campañas Azul y Roja

> **Estado:** diseño confirmado y diseño en desarrollo
> **Fuente de verdad para:** estructura de campañas, finales y reglas de rejugabilidad
> **Relacionados:** [07_CHARACTERS_COMMAND_AND_RELATIONSHIPS.md](07_CHARACTERS_COMMAND_AND_RELATIONSHIPS.md); [09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-07-24

## Propósito

Centralizar estructura de campañas, finales y reglas de rejugabilidad sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [BLUE RED CAMPAIGN ARCHITECTURE](#fuente-blue-red-campaign-architecture)
- [MODULAR ENDINGS AND EPILOGUES MATRIX](#fuente-modular-endings-and-epilogues-matrix)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `BLUE_RED_CAMPAIGN_ARCHITECTURE.md`, `MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

## Contenido consolidado

<a id="fuente-blue-red-campaign-architecture"></a>
## Fuente integrada: `BLUE_RED_CAMPAIGN_ARCHITECTURE.md`

> **Procedencia:** contenido migrado de `BLUE_RED_CAMPAIGN_ARCHITECTURE.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-blue-red-campaign-architecture--documento-114-arquitectura-de-las-campañas-azul-y-roja"></a>
### Documento 1/14 — Arquitectura de las campañas Azul y Roja

> **Estado:** canon narrativo, estratégico y de producción previo a implementación.
> **Campañas:** Fuerza Azul y Fuerza Roja.
> **Inicio:** 24 de junio de 2042, Hora H 05:40.
> **Terrenos:** Altis y Stratis.
> **Modalidad inicial:** un jugador; futuro cooperativo de un solo bando.
> **Persistencia:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).
> **Fundamento narrativo:** [NARRATIVE_ACTS_AND_MISSION_SYSTEM.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-narrative-acts-and-mission-system).

<a id="src-blue-red-campaign-architecture--1-autoridad"></a>
#### 1. Autoridad

Este documento fija la columna vertebral jugable, las puertas entre actos, los puntos de no retorno, el contrato de misión y el Acto I detallado de ambas campañas.

Los documentos narrativos anteriores conservan premisa, revelaciones, personajes y sistemas; si existe conflicto sobre orden, condición de avance o misión del Acto I, esta arquitectura prevalece.

<a id="src-blue-red-campaign-architecture--2-estructura-híbrida"></a>
#### 2. Estructura híbrida

> Actos narrativos definidos + guerra territorial persistente + operaciones dinámicas + investigaciones opcionales + decisiones irreversibles.

Cada acto contiene situación estratégica, objetivos narrativos, misiones principales, operaciones emergentes, investigaciones, conflictos, condiciones de cierre y estado transferido.

No es una secuencia rígida de escenarios independientes ni un mundo abierto sin dirección.

<a id="src-blue-red-campaign-architecture--3-forma-completa"></a>
#### 3. Forma completa

Cada campaña posee:

- prólogo;
- Actos I–VII en Altis;
- Acto VIII, operación final en Stratis;
- Acto IX, epílogo modular no abierto.

Las ocho fases jugables principales incluyen Stratis. El Acto IX es resolución reactiva.

<a id="src-blue-red-campaign-architecture--4-identidad-de-campaña"></a>
#### 4. Identidad de campaña

| Eje | Azul | Rojo |
|---|---|---|
| Justificación | intervención preventiva | asistencia solicitada |
| Temor | expansión Roja | cambio de régimen Azul |
| Dilema | legitimidad frente a control | alianza frente a subordinación |
| Mando | Ward frente a Hale | Navid frente a Vahid |
| Archivo | ESPEJO AZUL | ASTERIÓN |
| Responsabilidad | intervenir sin toda la verdad | expandir una invitación limitada |
| Logística inicial | Katalaki y acceso futuro | Molos y corredor de Sofia |

Las campañas comparten hechos, pero no geografía, ritmo, relaciones, información ni misiones idénticas.

<a id="src-blue-red-campaign-architecture--5-duración-y-mezcla"></a>
#### 5. Duración y mezcla

Objetivo por campaña: 28–40 horas. Ambas: 60–85 horas con comparación, secretos y finales.

| Contenido | Proporción |
|---|---:|
| Misiones principales | 40 % |
| Guerra y operaciones | 25 % |
| Investigación | 15 % |
| Política, civiles y relaciones | 10 % |
| Logística, preparación y mando | 10 % |

<a id="src-blue-red-campaign-architecture--6-familias-de-misión"></a>
#### 6. Familias de misión

| Tipo | Función |
|---|---|
| Principal `M` | avanza acto, conflicto o revelación |
| Investigación `I` | evidencia, testigo, señal o archivo |
| Personaje `C` | confianza, lealtad, secreto y supervivencia |
| Política/civil `P` | población, negociación, administración o prisioneros |
| Operación `O` | necesidad estratégica del mundo |
| Emergencia `E` | crisis urgente y caducable |
| Oportunidad | iniciativa descubierta fuera del mando |

Esta taxonomía describe la función dentro de los actos. Las 16 familias ejecutables, sus variantes y reglas de generación se rigen por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-dynamic-missions-and-emergent-events).

<a id="src-blue-red-campaign-architecture--7-éxito-y-fracaso"></a>
#### 7. Éxito y fracaso

| Resultado | Efecto |
|---|---|
| Éxito | intención y restricciones cumplidas |
| Parcial | intención lograda con pérdidas o coste |
| Fracaso operacional | cambia frente, recursos, información o plan |
| Desastre | altera de forma mayor fuerza, ciudad, alianza o mando |
| Derrota de campaña | no queda vía razonable de continuar |

> Perder una misión cambia la guerra; no obliga siempre a repetirla.

Derrota exige destrucción/evacuación irreversible, pérdida total de base logística, unidad sin sucesión o colapso final.

<a id="src-blue-red-campaign-architecture--8-núcleo-fijo-y-variante"></a>
#### 8. Núcleo fijo y variante

Toda misión principal conserva personaje, propósito, revelación y consecuencia narrativa.

Puede variar sector, ruta, guarnición, clima, aliados, infraestructura, inserción y resultado territorial.

ESPEJO siempre revela versiones incompatibles; el archivo puede aparecer en estación, convoy, técnico o nodo según el mundo.

<a id="src-blue-red-campaign-architecture--9-puertas-entre-actos"></a>
#### 9. Puertas entre actos

| Puerta | Regla |
|---|---|
| Dura | condición obligatoria |
| Alternativa | varias soluciones equivalentes |
| Acumulación | progreso suficiente entre opciones |
| Temporal | el mundo avanza aunque el jugador espere |
| No retorno | cierra contenido y transfiere consecuencias |

La transición puede exigir narrativa, territorio, logística, decisión y tiempo.

<a id="src-blue-red-campaign-architecture--10-puntos-de-no-retorno"></a>
#### 10. Puntos de no retorno

| ID | Punto |
|---|---|
| PNR-1 | cabeza de playa consolidada |
| PNR-2 | apertura de la guerra territorial |
| PNR-3 | crisis urbana |
| PNR-4 | fragmentación Verde |
| PNR-5 | confirmación de Stratis |
| PNR-6 | guerra de los nodos |
| PNR-7 | partida hacia Stratis |
| PNR-8 | decisión sobre HELIOS-CORE |

PNR-7 obliga a seleccionar fuerza, cerrar urgencias, aceptar pendientes y guardar el estado completo.

<a id="src-blue-red-campaign-architecture--11-arquitectura-de-actos"></a>
#### 11. Arquitectura de actos

| Fase | Función | Revelación |
|---|---|---|
| Prólogo — La señal | versión oficial, unidad, tutorial y contradicción | señal previa |
| I — Dos mareas | desembarcos, Verde, civiles, Helios y logística | Petrou: S-26 / mando |
| II — Los ojos de la isla | inteligencia, drones, nodos y confianza | Helios anticipa decisiones |
| III — Tierra prestada | territorio, administración y corredores | contingencia presentada como certeza |
| IV — Las ciudades recuerdan | Kavala, Pyrgos, sindicatos, hospitales y PHAROS | muertos reciben pagos |
| V — El ejército dividido | fractura Verde, alianzas y golpes | órdenes válidas incompatibles |
| VI — La voz de Stratis | Petrou, Damaris, S-26 y convoyes | HELIOS-CORE sigue activo |
| VII — Guerra de los nodos | acceso físico/digital, perfiles y Argos | Validación Integral de Teatro |
| VIII — Regreso a Stratis | Meridian, PHAROS, Vardis y HELIOS-CORE | decisión final |
| IX — Lo que queda | territorio, Gobierno, Helios, Argos y epílogos | síntesis de campaña |

<a id="src-blue-red-campaign-architecture--12-campaña-azul-por-actos"></a>
#### 12. Campaña Azul por actos

| Fase | Teatro y propósito | Conflicto |
|---|---|---|
| Prólogo | Orden Horizonte Seguro | prevención basada en ESPEJO |
| I | Katalaki–Neochori | Ward consolida; Hale avanza |
| II | Stavros–Whiskey–AAC | Shaw parece demasiado precisa |
| III | Lakka–aeropuerto | velocidad frente a Laurent y servicios |
| IV | Kavala y oeste | aliado, protector, ocupante o enemigo FIA |
| V | centro y Verde | Ward/Hale pueden romper |
| VI | manifiestos y ruta a Stratis | preservar frente a controlar |
| VII | nodos y Shaw | Coalición exige apropiación |
| VIII | Operación Faro Abierto | entrada anfibia, aérea, clandestina o aliada |

El final resuelve Vardis, Mercer, Arendt, HELIOS-CORE, Argos y permanencia Azul.

<a id="src-blue-red-campaign-architecture--13-campaña-roja-por-actos"></a>
#### 13. Campaña Roja por actos

| Fase | Teatro y propósito | Conflicto |
|---|---|---|
| Prólogo | Escudo de la Aurora | asistencia basada en Asterión |
| I | Molos–Sofia | Navid alía; Vahid impone |
| II | Sofia–Paros | Volkov acelera; Sadeq duda |
| III | llanura–Telos | asistencia parece ocupación |
| IV | Pyrgos | Khoury busca legalidad; Vahid control |
| V | alianza Verde rota | Navid puede perder autoridad |
| VI | convoy de los muertos | ocultar verdad o posición |
| VII | comandante como variable | Navid/Vahid disputan mando |
| VIII | Operación Aurora Negra | asalto, infiltración, Verde, técnica o aire |

El final resuelve alianza/Estado cliente, Helios, Vardis, Argos y Gobierno.

<a id="src-blue-red-campaign-architecture--14-eventos-sincronizados"></a>
#### 14. Eventos sincronizados

| Hora | Evento |
|---|---|
| 05:40 | Azul inicia Katalaki |
| 05:52 | Rojo entra en Molos |
| H+01:00 aprox. | Verde activa órdenes incompatibles |
| H+02:00 | apagones y bloqueos Helios |
| H+05:00 | Argos marca UMBRAL completado |
| primera noche | Petrou transmite 90 segundos |

Las consecuencias varían; la secuencia central no.

<a id="src-blue-red-campaign-architecture--15-doble-campaña"></a>
#### 15. Doble campaña

Cada campaña guarda su propia cronología. Completar ambas crea `IF_DUAL_CAMPAIGN_STATE`.

```text
sharedEvidence differences decisions survivors endings comparableFiles
```

Desbloquea análisis, escena secreta, archivos UMBRAL, contexto AZUR/RUBÍ y encuentro completo con Vardis.

No fusiona partidas, declara una falsa ni borra finales.

<a id="src-blue-red-campaign-architecture--16-volumen-orientativo"></a>
#### 16. Volumen orientativo

Por campaña:

- prólogo de 2–3 segmentos;
- Actos I–VII con 2–3 principales, una investigación, 2–6 operaciones y 0–2 misiones de personaje;
- Acto VIII con 3–5 fases;
- Acto IX con un epílogo modular.

Total aproximado: 25–32 principales/semiprincipales, 35–70 operaciones, 8–14 investigaciones y 10–18 eventos de personaje o civiles.

<a id="src-blue-red-campaign-architecture--17-estado-de-misión"></a>
#### 17. Estado de misión

```text
LOCKED AVAILABLE OFFERED ACCEPTED ACTIVE SUCCEEDED PARTIAL
FAILED EXPIRED ABORTED RESOLVED_OFFSCREEN
```

`FAILED` implica intento fallido; `EXPIRED`, ausencia antes del límite; `RESOLVED_OFFSCREEN`, ejecución de otra fuerza con resultado propio.

<a id="src-blue-red-campaign-architecture--18-contrato-narrativo-de-misión"></a>
#### 18. Contrato narrativo de misión

```text
missionId campaignSide act title missionType
narrativePurpose strategicPurpose
triggerConditions expirationConditions characters sectorIds
requiredSystems mainObjectives optionalObjectives variants
successState partialState failureState ignoredState
evidence relationshipEffects territorialEffects economicEffects
followUpMissions dialogueRequirements cinematicRequirements
```

Las condiciones usan IDs y expresiones validadas, no código arbitrario dentro del guardado.

<a id="src-blue-red-campaign-architecture--19-identificadores-estables"></a>
#### 19. Identificadores estables

```text
IF_{CAMPAIGN}_{ACT}_{TYPE}_{NUMBER}
```

Campaña: `B`, `R`, `S`. Tipo: `M`, `I`, `C`, `P`, `O`, `E`.

```text
IF_B_P00
IF_B_A01_M01
IF_B_A01_I01
IF_B_A01_O01
IF_R_P00
IF_R_A01_M01
IF_S_EVT_FIRST_NIGHT
IF_S_EVT_PETROU_SIGNAL
```

Los rótulos históricos `B-I01`/`R-I01` quedan retirados porque `I` se reserva para investigación.

<a id="src-blue-red-campaign-architecture--20-acto-i-azul-situación-y-cierre"></a>
#### 20. Acto I Azul: situación y cierre

Hora 05:40. Azul comienza sin territorio, con 144 efectivos estratégicos, AZUR-1, lanchas, dos Marshall, Hunter, recursos limitados y aire ligero; sin artillería, puerto ni hospital regional.

Objetivos: sobrevivir, asegurar Katalaki, conectar Neochori, gestionar población, activar logística, resistir Verde, interpretar Helios y decidir consolidación/avance.

| Ruta | Condición |
|---|---|
| A — completa | Katalaki, Neochori, hub, contraataque y fuerza viable |
| B — reducida | Katalaki, Neochori disputada/neutral y logística temporal |
| C — reubicación | Katalaki dañada, base alternativa y supervivencia |
| D — crisis | presencia mínima; Acto II abre recuperación |
| Derrota | acceso marítimo perdido y fuerza sin alternativa |

<a id="src-blue-red-campaign-architecture--21-ifbp00-orden-horizonte-seguro"></a>
#### 21. IF_B_P00 — Orden Horizonte Seguro

Prólogo/tutorial con Ward, Hale, Rourke, Kessler, Shaw y AZUR-1.

Enseña movimiento, interacción, equipo, radio, mapa y escuadra. Shaw presenta riesgo Rojo y aeropuerto. Reed detecta:

```text
...S-26...
...continuidad...
...enlace no autorizado...
```

El jugador informa formalmente, comparte con Reed o ignora. No cambia el desembarco; modifica confianza y conocimiento.

<a id="src-blue-red-campaign-architecture--22-ifba01m01-costa-ciega"></a>
#### 22. IF_B_A01_M01 — Costa ciega

**Hora:** 05:40–06:30.
**Sectores:** `ALT_CW_KATALAKI` y acceso a Neochori.
**Propósito:** abrir descarga y mostrar discrepancia de inteligencia.

Variantes: limpio, observado, bajo fuego o con civiles. Objetivos opcionales: observadores, ingenieros, ruta, civiles y comunicaciones.

Evidencia: `E-B-ES-001` — omisión costera, conforme al Documento 2/14.

| Resultado | Consecuencia |
|---|---|
| Éxito | descarga, ingenieros y evidencia |
| Parcial | carga/observadores/evidencia degradados |
| Fracaso | playa secundaria, menos recursos y vehículos |

<a id="src-blue-red-campaign-architecture--23-ifba01m02-la-arena-no-es-territorio"></a>
#### 23. IF_B_A01_M02 — La arena no es territorio

Introduce sectores, módulos, prioridades, logística, guarnición y frente.

Ward exige consolidar; Hale pide reconocimiento inmediato. El jugador consolida, reconoce, solicita fuerza separada o avanza.

- consolidar mejora defensa y Ward;
- reconocer mejora información con riesgo;
- avanzar habilita sorpresa, expone playa y favorece a Hale.

<a id="src-blue-red-campaign-architecture--24-ifba01m03-neochori-no-está-vacía"></a>
#### 24. IF_B_A01_M03 — Neochori no está vacía

Objetivo: acceso funcional a Neochori, no necesariamente conquista por asalto.

Métodos: asalto, negociación, infiltración, cerco o cooperación civil.

Opcionales: clínica, saqueo, depósito, armas FIA y prisioneros.

| Estado | Efecto |
|---|---|
| Cooperadora | administración, logística y legitimidad |
| Ocupada | control con inestabilidad y sabotaje |
| Dañada | desplazamiento y capacidad médica reducida |
| No capturada | ruta o hub alternativo |

<a id="src-blue-red-campaign-architecture--25-ifba01m04-el-primer-convoy"></a>
#### 25. IF_B_A01_M04 — El primer convoy

Conecta Katalaki con Neochori o el hub alternativo. Transporta combustible, medicina, munición y construcción.

El jugador escolta, despeja, desvía, engaña o divide. Éxito activa centro; parcial entrega parte; fracaso reduce defensa y abre recuperación. Ignorada, otra unidad la resuelve según ruta, escolta y amenaza.

<a id="src-blue-red-campaign-architecture--26-ifba01m05-primera-línea"></a>
#### 26. IF_B_A01_M05 — Primera línea

Verde contraataca desde Stavros, Whiskey, Lakka o combinación según reconocimiento, Argos y Neochori.

Objetivo: conservar una conexión logística. El jugador prioriza orientación, reserva, vehículo, evacuación y medicina, sin colocar objetos.

Resultados: victoria mueve frente; defensa costosa daña logística; retirada conserva fuerza; ruptura abre emergencia.

<a id="src-blue-red-campaign-architecture--27-ifba01m06-la-primera-noche"></a>
#### 27. IF_B_A01_M06 — La primera noche

Petrou transmite `S-26 ACTIVA` con coordenadas incompletas y autenticación Verde.

El jugador protege/rastrea y entrega `E-S-FN-002A` a Rourke, Kessler, Ward, Shaw o AZUR-1. Su contraparte Roja `E-S-FN-002B` permite reconstruir la advertencia completa.

- Shaw puede clasificarlo;
- Kessler abre análisis;
- Ward se alarma;
- ocultarlo da ventaja privada y riesgo disciplinario.

<a id="src-blue-red-campaign-architecture--28-operaciones-azul"></a>
#### 28. Operaciones Azul

| ID | Operación |
|---|---|
| `IF_B_A01_O01` | Pescadores entre dos fuegos |
| `IF_B_A01_O02` | El puesto que no respondió |
| `IF_B_A01_O03` | Heridos en la carretera |
| `IF_B_A01_O04` | Carga perdida |
| `IF_B_A01_O05` | Ruta de Poliakko |
| `IF_B_A01_O06` | Dron caído |
| `IF_B_A01_O07` | Prisioneros de la primera hora |

<a id="src-blue-red-campaign-architecture--29-estado-de-salida-azul"></a>
#### 29. Estado de salida Azul

```text
blueBeachheadState katalakiControl neochoriControl
firstConvoyResult greenCounterattackResult blueCasualtiesAct1
civilianDamageAct1 wardTrust haleTrust rourkeTrust
shawSuspicion s26FragmentKnown coastEvidenceState
blueLogisticsLevel
```

<a id="src-blue-red-campaign-architecture--30-acto-i-rojo-situación-y-cierre"></a>
#### 30. Acto I Rojo: situación y cierre

Hora 05:52. Rojo llega con 168 efectivos, RUBÍ-1, Ifrit, Marid, Kamysh, lanchas y AA ligera; sin artillería pesada. Tiene autorización formal confusa y un corredor estrecho.

Objetivos: Molos, aeródromo, Asterión, Verde, puerto, Sofia, corredor y Petrou.

| Ruta | Condición |
|---|---|
| A — alianza | Molos, aeródromo, Verde cooperante y paso |
| B — militar | Molos/aeródromo y preparación contra Sofia |
| C — enclave | corredor bloqueado y logística marítima |
| D — legal sin control | documentos válidos, rechazo local |
| Derrota | Molos/aeródromo perdidos y fuerza sin evacuación |

<a id="src-blue-red-campaign-architecture--31-ifrp00-escudo-de-la-aurora"></a>
#### 31. IF_R_P00 — Escudo de la Aurora

Prólogo con Navid, Vahid, Khadem, Sadeq, Khoury, Volkov y RUBÍ-1.

Khoury presenta solicitud y Asterión; Vahid, Molos y Sofia. Farouk detecta dos códigos Verdes válidos incompatibles.

Informar a Khadem, Sadeq, Volkov o guardar copia modifica confianza, interpretación y control de evidencia.

<a id="src-blue-red-campaign-architecture--32-ifra01m01-asterión"></a>
#### 32. IF_R_A01_M01 — Asterión

**Hora:** 05:52–06:45.
**Sectores:** Molos Bay, Molos y aeródromo.
**Propósito:** asegurar desembarco y probar que la invitación no explica todo.

Variantes: coordinada, dividida, emboscada o puerto desorganizado.

Evidencia: `E-R-AS-001` — órdenes Asterión de Molos, dos órdenes auténticas con horas y destinatarios distintos.

| Resultado | Consecuencia |
|---|---|
| Éxito | contacto, evidencia y pocas bajas |
| Parcial | puerto con alianza/códigos inciertos |
| Fracaso | descarga desviada, aeródromo aislado y hostilidad |

<a id="src-blue-red-campaign-architecture--33-ifra01m02-molos-espera"></a>
#### 33. IF_R_A01_M02 — Molos espera

Convierte el desembarco en enclave. Asegura muelle, depósito, comunicaciones y orden.

Khoury conserva administración; Vahid militariza puerto/combustible; Navid busca equilibrio.

El jugador administra, militariza, requisa, compensa o cambia descarga. Afecta trabajadores, logística, civiles, FIA y Gobierno.

<a id="src-blue-red-campaign-architecture--34-ifra01m03-dos-códigos"></a>
#### 34. IF_R_A01_M03 — Dos códigos

RUBÍ-1 contacta puesto, oficial, estación o convoy para determinar la cadena Verde en Sofia.

La unidad puede ser gubernamental, soberanista, confundida o infiltrada. El jugador negocia, espera, desarma, rodea, arresta o intercambia códigos.

El resultado fija la primera relación Rojo–Verde.

<a id="src-blue-red-campaign-architecture--35-ifra01m04-el-corredor-de-molos"></a>
#### 35. IF_R_A01_M04 — El corredor de Molos

Conecta puerto, aeródromo y vanguardia con combustible, munición, comunicaciones y medicina.

Opciones: pesado, convoyes pequeños, costa, aire limitado o espera.

Determina expansión, libertad de Vahid, dependencia marítima y disponibilidad blindada.

<a id="src-blue-red-campaign-architecture--36-ifra01m05-la-puerta-de-sofia"></a>
#### 36. IF_R_A01_M05 — La puerta de Sofia

Sofia puede cooperar, ser neutral, estar dividida, fortificada, soberanista o manipulada.

Métodos: tratado, integración, ultimátum, flanqueo, asalto o infiltración.

| Resultado | Efecto |
|---|---|
| Cooperación | logística y legitimidad; limita a Vahid |
| Subordinación | control rápido y resentimiento |
| Destrucción | paso abierto, infraestructura perdida y guerra soberanista |
| Bloqueo | enclave oriental |

<a id="src-blue-red-campaign-architecture--37-ifra01m06-la-primera-noche"></a>
#### 37. IF_R_A01_M06 — La primera noche

Petrou transmite `MANDO COMPROMETIDO` y `...VARD...`.

El jugador protege/rastrea y entrega a Khadem, Sadeq, Volkov, Navid o RUBÍ-1.

Volkov puede clasificar/modificar; Sadeq investiga; Navid revisa alianza; ocultar preserva copia privada.

<a id="src-blue-red-campaign-architecture--38-operaciones-rojas"></a>
#### 38. Operaciones Rojas

| ID | Operación |
|---|---|
| `IF_R_A01_O01` | Pescadores de Molos |
| `IF_R_A01_O02` | El enlace perdido |
| `IF_R_A01_O03` | Munición sin destinatario |
| `IF_R_A01_O04` | Heridos Verdes |
| `IF_R_A01_O05` | Radar oriental |
| `IF_R_A01_O06` | Ruta del cabo |
| `IF_R_A01_O07` | El primer desertor |

<a id="src-blue-red-campaign-architecture--39-estado-de-salida-rojo"></a>
#### 39. Estado de salida Rojo

```text
redBeachheadState molosControl molosAirfieldState sofiaRelation
firstRedConvoyResult greenCooperationLevel redCasualtiesAct1
civilianDamageAct1 navidTrust vahidTrust khademTrust
volkovSuspicion s26FragmentKnown asterionEvidenceState
redLogisticsLevel
```

<a id="src-blue-red-campaign-architecture--40-comparación-del-acto-i"></a>
#### 40. Comparación del Acto I

| Elemento | Azul | Rojo |
|---|---|---|
| Necesidad | crear acceso | mantener corredor |
| Verde | hostil/incierta | aliada/contradictoria |
| Mando | consolidar/avanzar | cooperar/imponer |
| Riesgo | playa vulnerable | corredor estrecho |
| Anomalía | posiciones omitidas | órdenes duplicadas |
| Petrou | S-26 activa | mando comprometido |
| Técnica | Reed/Kessler | Farouk/Sadeq |
| Infiltrado | Shaw | Volkov |

<a id="src-blue-red-campaign-architecture--41-estado-de-personajes"></a>
#### 41. Estado de personajes

Azul registra Ward/Hale, Rourke/jugador, Reed/Shaw, Okafor/heridos, Ruiz/agresión y Torres/unidad.

Rojo registra Navid/Vahid, Khadem/jugador, Sadeq/Volkov, Farouk/secretos, Nasser/población y Kerim/hostilidad.

Cada conflicto ofrece prioridades incompatibles; el jugador no satisface a todos.

<a id="src-blue-red-campaign-architecture--42-cierre-hacia-acto-ii"></a>
#### 42. Cierre hacia Acto II

Azul necesita base logística, supervivientes, frente y ruta a Stavros, Lakka o AAC. Neochori no es obligatoria.

Rojo necesita Molos o aeródromo, logística marítima/terrestre, relación Verde y plan a Sofia o alternativa.

La señal de Petrou siempre existe como recuperada, perdida, clasificada o conocida indirectamente.

<a id="src-blue-red-campaign-architecture--43-niveles-de-conocimiento-para-stratis"></a>
#### 43. Niveles de conocimiento para Stratis

| Nivel | Operación |
|---|---|
| S0 | asalto ciego |
| S1 | objetivo técnico |
| S2 | PHAROS y Meridian conocidos |
| S3 | Argos, Vardis y accesos comprendidos |
| S4 | verdad comparada de ambas campañas |

Modifican rutas, aliados, objetivos, diálogos, decisiones y captura de Vardis. Investigar no es obligatorio para terminar.

<a id="src-blue-red-campaign-architecture--44-vertical-slice-narrativo"></a>
#### 44. Vertical slice narrativo

Primero se implementa solo la rama Azul del Acto I:

1. prólogo abreviado;
2. Costa ciega;
3. cabeza de playa;
4. Neochori;
5. convoy;
6. contraataque;
7. primera noche.

Incluye persistencia, sectores, fuerzas virtuales, construcción, logística, civiles, relaciones, evidencia, guardado y variantes.

Excluye temporalmente Rojo, Stratis, finales, economía nacional, ciudades mayores, FIA avanzada y Argos completo.

<a id="src-blue-red-campaign-architecture--45-puerta-de-producción"></a>
#### 45. Puerta de producción

No comienza Acto II hasta demostrar:

- desembarco estable;
- guardado/carga;
- captura persistente;
- convoy sin duplicación;
- guarnición automática;
- parcial y fracaso persistentes;
- relaciones;
- movimiento de frente;
- evidencia;
- rendimiento aceptable.

Si seis misiones conectadas fallan, dos campañas completas también.

<a id="src-blue-red-campaign-architecture--46-estructura-de-archivos"></a>
#### 46. Estructura de archivos

```text
campaign/
├── shared/
│   ├── acts/
│   ├── events/
│   ├── evidence/
│   └── transitions/
├── blue/
│   ├── prologue/
│   ├── act01/ ... act08/
│   └── epilogue/
├── red/
│   ├── prologue/
│   ├── act01/ ... act08/
│   └── epilogue/
└── dual/
    ├── comparison/
    └── secretEnding/
```

<a id="src-blue-red-campaign-architecture--47-funciones-conceptuales"></a>
#### 47. Funciones conceptuales

```text
IF_fnc_campaignEvaluateAct
IF_fnc_campaignAdvanceAct
IF_fnc_campaignCheckGate
IF_fnc_campaignRegisterPointOfNoReturn
IF_fnc_missionEvaluateAvailability
IF_fnc_missionOffer
IF_fnc_missionAccept
IF_fnc_missionStart
IF_fnc_missionResolve
IF_fnc_missionExpire
IF_fnc_missionResolveOffscreen
IF_fnc_missionApplyConsequences
IF_fnc_campaignBuildTransition
IF_fnc_campaignSaveCheckpoint
```

<a id="src-blue-red-campaign-architecture--48-invariantes-narrativas"></a>
#### 48. Invariantes narrativas

1. Azul desembarca a las 05:40; Rojo, doce minutos después.
2. Ninguno declara formalmente la guerra.
3. Ambos reaccionan a amenazas presentadas como inminentes.
4. Kouris solicitó ayuda Roja limitada.
5. Azul poseía contingencias reales.
6. Verde recibe órdenes válidas incompatibles.
7. Argos manipula presentación/distribución, no ordena directamente invasiones.
8. Petrou transmite la primera noche.
9. Helios nació en Altis; HELIOS-CORE está en Stratis.
10. Vardis vive, pero el jugador no lo sabe en el Acto I.
11. Shaw, Volkov y Rallis conservan coberturas.
12. FIA y población no son bloques uniformes.
13. La guerra continúa sin el jugador.
14. Cada acto conserva consecuencias.

<a id="src-blue-red-campaign-architecture--49-prohibiciones"></a>
#### 49. Prohibiciones

No se permite duplicar campañas con uniformes distintos, exigir victoria ideal, reiniciar historia tras fracaso, revelar Argos temprano, convertir Helios en conciencia, cambiar globalmente a Verde, olvidar logística/civiles, concentrar decisiones al final, separar operaciones de narrativa, permitir espera infinita, crear misiones sin impacto, matar roles sin sucesión, reducir Stratis a una base, exigir toda investigación, conceder final por una sola elección, contradecir horarios o producir todos los actos antes del slice.

<a id="src-blue-red-campaign-architecture--50-principios-vinculantes"></a>
#### 50. Principios vinculantes

1. Cada campaña tiene identidad propia.
2. Cada acto posee función narrativa y sistémica.
3. Cada misión cambia estado.
4. El fracaso produce contenido y consecuencias.
5. Narrativa, territorio y economía están conectados.
6. Misiones principales admiten variantes.
7. Investigación modifica Stratis.
8. Puertas y puntos de no retorno son explícitos.
9. El mundo resuelve operaciones sin el jugador.
10. Ambas campañas comparten hechos, no experiencias.
11. Acto I introduce los pilares.
12. Azul valida sistemas antes de producir Rojo.
13. Stratis y epílogo dependen del estado acumulado.

<a id="src-blue-red-campaign-architecture--51-definición-final"></a>
#### 51. Definición final

Azul comienza creyendo que impide una ocupación; Rojo, que impide un cambio de régimen. Ambos encuentran pruebas auténticas presentadas para que solo una decisión pareciera razonable.

Cada acto abre una parte de la guerra. Cada misión decide qué queda disponible cuando se cierra. Stratis es la operación que toda la campaña anterior hizo posible.

<a id="src-blue-red-campaign-architecture--52-continuación-de-la-serie"></a>
#### 52. Continuación de la serie

El [Documento 2/14](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-investigation-revelation-matrix) fija la matriz definitiva de revelaciones, evidencias e investigación de Argos.

El [Documento 3/14](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-dynamic-missions-and-emergent-events) fija las necesidades causales, plantillas, transformaciones, resolución externa y ritmo del contenido dinámico.

El [Documento 4/14](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-civil-municipal-political-stability-system) fija población, administración, autoridad, legitimidad, estabilidad y política.

El [Documento 5/14](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-fia-insurgency-and-clandestine-war-system) fija células, redes de apoyo, guerra clandestina, contrainsurgencia y evolución política de FIA.

El [Documento 6/14](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-helios-intelligence-and-fog-of-war-system) fija conocimiento por actor, informes, nodos, accesos, recomendaciones, manipulación y niebla de guerra.

El [Documento 7/14](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system) fija formaciones, proyecciones, materialización, reintegración, batalla virtual y rendimiento.

El [Documento 8/14](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-progression-authority-and-unlocks-system) fija rango, autoridad, confianza, reputación, capacidades y desbloqueos.

El [Documento 9/14](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system) fija la presentación del conocimiento, el centro de mando, el mapa, los paneles, las alertas, la accesibilidad y la experiencia táctica y estratégica.

El [Documento 10/14](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture) fija capas, módulos, contratos, inicialización, persistencia técnica, red, seguridad y pruebas.

El [Documento 11/14](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-threeden-geography-and-physical-validation-guide) fija el trabajo físico en 3DEN, límites, rutas, anclajes, zonas, navegación, rendimiento y criterios de aprobación geográfica.

El [Documento 12/14](17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md#fuente-dialogue-radio-briefing-audio-and-cinematics-system) fija voces, canales, prioridades, diálogos, briefings, radio, documentos, audio, música, escenas y cinematografía reactiva.

El [Documento 13/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system) fija pruebas, fixtures, defectos, regresión, métricas, presupuestos, balance, dificultad y puertas de aprobación.

El [Documento 14/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan) fija alcance, prioridades, fases, dependencias, hitos, puertas, entregables y riesgos. La colección rectora queda completa. Los Actos II–VII no se producen en detalle antes de validar el Acto I Azul.

---

<a id="fuente-modular-endings-and-epilogues-matrix"></a>
## Fuente integrada: `MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md`

> **Procedencia:** contenido migrado de `MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-modular-endings-and-epilogues-matrix--matriz-modular-de-finales-y-epílogos"></a>
### Matriz modular de finales y epílogos

> **Estado:** canon rector de autor, narrativa, sistemas y producción.
> **Campañas:** Azul y Roja.
> **Terrenos:** Altis y Stratis.
> **Continuidad:** prevalece el canon revisado: Helios nació en Altis; Vardis fingió su muerte y trasladó clandestinamente el núcleo a Stratis.
> **Propósito:** representar toda la campaña sin producir miles de finales independientes.
> **Entrada de campaña:** actos, PNR-7/PNR-8 y comparación Azul/Roja se rigen por [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md#fuente-blue-red-campaign-architecture).
> **Entrada investigativa:** autenticidad, publicación, S0–S4, exposición de Argos y captura de Vardis se rigen por [INVESTIGATION_REVELATION_MATRIX.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-investigation-revelation-matrix).
> **Entrada civil:** condición civil, orden político, legitimidad gubernamental, reconciliación nativa y ocupación extranjera se rigen por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-civil-municipal-political-stability-system).
> **Entrada FIA:** legitimidad política, relación Markou–Kallas, Frente Negro, Némesis, control abierto y desarme se rigen por [FIA_INSURGENCY_AND_CLANDESTINE_WAR_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-fia-insurgency-and-clandestine-war-system).
> **Entrada Helios:** control físico/digital, integridad, auditoría, acceso Argos, preservación y desconexión se rigen por [HELIOS_INTELLIGENCE_AND_FOG_OF_WAR_SYSTEM.md](09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md#fuente-helios-intelligence-and-fog-of-war-system).
> **Entrada militar:** supervivientes, pérdidas, prisioneros, vehículos, retiradas y resultados de batalla proceden de [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system).
> **Entrada del jugador:** rango final, autoridad, relaciones, escuadra, reputaciones, disciplina y perfil de decisión proceden de [PLAYER_PROGRESSION_AUTHORITY_AND_UNLOCKS_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-player-progression-authority-and-unlocks-system).

<a id="src-modular-endings-and-epilogues-matrix--1-modelo-delta-modular"></a>
#### 1. Modelo Delta Modular

El desenlace se resuelve mediante:

> **Familia principal derivada del mundo + decisión viable sobre Helios + resolución de Argos + epílogos modulares.**

No habrá puntuación moral, elección final capaz de borrar la campaña, árbol completo por combinación ni cinemáticas idénticas con otro color.

El resultado tiene cuatro niveles:

1. familia militar y política;
2. resolución de Helios y Argos;
3. condición de la nación;
4. epílogos de regiones, facciones, personajes y unidad protagonista.

Habrá **14 familias públicas** y un **decimoquinto módulo secreto superpuesto**, «La señal continúa». Este último contamina cualquier familia compatible, pero nunca reemplaza quién ganó o quién gobierna.

<a id="src-modular-endings-and-epilogues-matrix--2-ecuación-conceptual"></a>
#### 2. Ecuación conceptual

```text
FINAL =
resultado militar
+ orden político
+ condición civil
+ destino de Helios
+ destino de Argos
+ presencia extranjera
+ verdad pública
+ estabilidad
+ módulos regionales
+ módulos de facción
+ módulos de personajes
+ legado de la unidad
```

No es una suma moral. Cada resolvedor clasifica una dimensión y el validador elimina combinaciones imposibles.

<a id="src-modular-endings-and-epilogues-matrix--3-principios-inviolables"></a>
#### 3. Principios inviolables

1. La última elección no borra la campaña.
2. No existe una puntuación universal de bondad.
3. Estabilidad y justicia son dimensiones diferentes.
4. Una paz represiva puede ser estable.
5. Una democracia puede comenzar siendo frágil.
6. Victoria militar no equivale a éxito político.
7. Destruir Helios puede derrotar a Argos y dañar a la población.
8. Preservarlo puede salvar servicios y conservar dominación.
9. La verdad completa no garantiza reconciliación.
10. Ocultarla puede reducir el pánico y permitir que Argos sobreviva.
11. Descubrir la manipulación no absuelve a ninguna facción.
12. Los muertos no reaparecen para cerrar sus arcos.
13. Los sustitutos no ofrecen exactamente el mismo resultado.
14. Cada región conserva consecuencias propias.
15. Los finales Azul y Rojo tienen identidad diferente.
16. Completar ambas campañas añade contexto sin invalidar sus finales.
17. No hay una solución perfecta disponible siempre.
18. El final refleja acciones, no solamente declaraciones.
19. La estabilidad debe derivarse de condiciones demostrables.
20. Argos puede perder sin desaparecer completamente.

<a id="src-modular-endings-and-epilogues-matrix--4-variables-rectoras"></a>
#### 4. Variables rectoras

El estado final conserva agregados útiles, no una variable por cada decisión.

<a id="src-modular-endings-and-epilogues-matrix--militar"></a>
##### Militar

```text
blueMilitaryPower redMilitaryPower greenMilitaryPower fiaArmedPower
blueTerritory redTerritory greenTerritory contestedTerritory
blueLogistics redLogistics greenCohesion
```

<a id="src-modular-endings-and-epilogues-matrix--política"></a>
##### Política

```text
governmentLegitimacy governmentCohesion constitutionalAuthority
unityCoalitionSupport municipalAutonomy
bluePoliticalDependency redPoliticalDependency
fiaPoliticalInfluence greenPoliticalInfluence
```

<a id="src-modular-endings-and-epilogues-matrix--civil"></a>
##### Civil

```text
civilianSecurity essentialServices infrastructureIntegrity
civilianDisplacement civilianCasualties economicActivity
communityCohesion radicalization
```

<a id="src-modular-endings-and-epilogues-matrix--helios"></a>
##### Helios

```text
heliosPhysicalControl heliosDigitalAccess heliosNetworkIntegrity
heliosCivilFunctions heliosMilitaryFunctions argosBackdoorAccess
technicalStaffSurvival
```

<a id="src-modular-endings-and-epilogues-matrix--investigación"></a>
##### Investigación

```text
evidenceTechnical evidencePolitical evidenceHuman evidenceOperational
argosExposure vardisConfirmed truthPublished dualCampaignComparison
```

<a id="src-modular-endings-and-epilogues-matrix--presencia-extranjera"></a>
##### Presencia extranjera

```text
blueOccupationIntent redOccupationIntent
blueBasePresence redBasePresence
blueWithdrawalPressure redWithdrawalPressure internationalPressure
```

<a id="src-modular-endings-and-epilogues-matrix--personajes"></a>
##### Personajes

```text
alive loyaltyState trustPlayer politicalPosition evidenceKnown finalAlignment
```

No existirán `goodEndingPoints`, `evilPoints`, `heroScore`, `correctFaction` ni `perfectEndingUnlocked`. La sociedad tampoco se resume en `civilianReputation`: confianza, miedo, legitimidad, dependencia, seguridad y radicalización permanecen separadas.

<a id="src-modular-endings-and-epilogues-matrix--5-resultado-militar"></a>
#### 5. Resultado militar

| Código | Resultado | Condición resumida |
|---|---|---|
| M1 | Dominio Azul | Rojo pierde capacidad ofensiva; Azul conserva logística y fuerza de teatro |
| M2 | Dominio Rojo | Azul no puede sostenerse; Rojo conserva corredores, reservas y administración aliada |
| M3 | Ascenso nativo | Los invasores se retiran o quedan incapaces; una coalición nativa conserva fuerza y autoridad |
| M4 | Guerra congelada | Ningún actor domina; persisten territorios conectados y líneas logísticas rivales |
| M5 | Colapso mutuo | Fuerzas, infraestructura y Estado pierden capacidad para imponer paz |

El ascenso nativo no equivale automáticamente a democracia. Puede producir unidad, restauración, directorio, FIA o confederación.

<a id="src-modular-endings-and-epilogues-matrix--6-orden-político"></a>
#### 6. Orden político

| Código | Orden | Rasgo rector |
|---|---|---|
| P1 | Transición respaldada por Azul | Gobierno local con supervisión y compromiso de retirada |
| P2 | Protectorado Azul | Gobierno dependiente, bases y control estratégico extranjero |
| P3 | Alianza restaurada con Rojo | Gobierno y Verde preservados; Asterión renegociado |
| P4 | Estado cliente Rojo | Gobierno formal sin autonomía y oposición reprimida |
| P5 | Gobierno de unidad | Autoridad constitucional, FIA cívica, Verde reformista y municipios |
| P6 | Restauración constitucional Verde | Soberanía militar devuelta a autoridad civil |
| P7 | Directorio militar nacional | Independencia y estabilidad a costa de libertades |
| P8 | República cívica de FIA | FIA se transforma en poder político y constituyente |
| P9 | Gobierno revolucionario militarizado | Las brigadas sustituyen las instituciones |
| P10 | Confederación municipal | Regiones conservan servicios sin centro fuerte |
| P11 | Estado fragmentado | Administraciones rivales y fronteras internas |

<a id="src-modular-endings-and-epilogues-matrix--7-condición-civil"></a>
#### 7. Condición civil

| Código | Condición | Lectura |
|---|---|---|
| C1 | Recuperación sostenible | Servicios, cohesión y autoridad aceptada; daños reparables |
| C2 | Recuperación frágil | Instituciones activas con refugiados, daños y legitimidad desigual |
| C3 | Paz represiva | Seguridad y servicios altos junto con miedo y legitimidad baja |
| C4 | Crisis humanitaria | Hospitales, suministros e infraestructura insuficientes |
| C5 | Nación radicalizada | Armas, agravios y redes clandestinas preparan otra guerra |
| C6 | Islas vaciadas | Éxodo, despoblación y bases sin sociedad funcional |

La condición civil describe qué nación recibe el vencedor, no quién gobierna.

<a id="src-modular-endings-and-epilogues-matrix--8-destino-de-helios"></a>
#### 8. Destino de Helios

| Código | Destino | Requisitos o coste |
|---|---|---|
| H1 | Nacional | Autoridad nativa, técnicos, acceso, red mínima y puertas traseras reducidas |
| H2 | Azul | Núcleo, claves, nodos y personal bajo custodia de la Coalición |
| H3 | Rojo | Integración técnica o política con el Pacto |
| H4 | Liberado | Evidencia, publicación, técnicos, descentralización y auditoría |
| H5 | Desconectado | Funciones locales conservadas sin centro integrado |
| H6 | Destruido | Núcleo y nodos caen; servicios y reconstrucción pagan el coste |
| H7 | Oscuro | El resultado visible oculta accesos, copias u operadores Argos |

H6 no elimina copias externas. H4 facilita auditoría y también copia o ataque. H1 puede volver a militarizarse.

<a id="src-modular-endings-and-epilogues-matrix--9-destino-de-argos"></a>
#### 9. Destino de Argos

| Código | Resultado |
|---|---|
| A1 | Expuesto y desmantelado |
| A2 | Expuesto, pero fragmentado |
| A3 | Debilitado y secreto |
| A4 | Superviviente |
| A5 | Replicado fuera de las islas |

A1 exige archivos autenticados, infiltrados identificados, Vardis confirmado, accesos eliminados y autoridad investigadora. A5 se reserva para una copia externa completada mediante escape o decisión técnica concreta.

<a id="src-modular-endings-and-epilogues-matrix--10-presencia-extranjera-y-verdad-pública"></a>
#### 10. Presencia extranjera y verdad pública

| Código | Presencia |
|---|---|
| F1 | Retirada completa |
| F2 | Bases limitadas por tratado |
| F3 | Protectorado u ocupación |
| F4 | Enclaves militares |
| F5 | Líneas permanentes de alto el fuego |

| Código | Verdad pública |
|---|---|
| T1 | Mentira oficial del vencedor |
| T2 | Verdad parcial |
| T3 | Verdad disputada |
| T4 | Revelación de UMBRAL, PHAROS, Vardis, Stratis y responsabilidades compartidas |

T4 puede impulsar reforma y juicios o destruir instituciones y radicalizar comunidades.

<a id="src-modular-endings-and-epilogues-matrix--11-familias-públicas"></a>
#### 11. Familias públicas

| N.º | Familia | Base y tono |
|---:|---|---|
| 1 | Liberación vigilada | Dominio Azul con Gobierno autónomo y retirada prometida; esperanza condicionada |
| 2 | Protectorado Azul | Bases, Gobierno dependiente y Helios extranjero; victoria sin soberanía |
| 3 | La victoria sin paz | Azul vence sin legitimidad ni consolidación; insurgencia futura |
| 4 | Alianza restaurada | Dominio Rojo aliancista, Gobierno y Verde preservados |
| 5 | Orden impuesto | Estado cliente, Verde subordinada y estabilidad fría |
| 6 | La alianza que devoró al Estado | La asistencia Roja se convierte en ocupación |
| 7 | Gobierno de unidad | Coalición nativa constitucional, cívica, municipal y reformista |
| 8 | República restaurada | Soberanía y autoridad civil recuperadas mediante Verde |
| 9 | Directorio de soberanía | Independencia bajo mando militar y libertades suspendidas |
| 10 | República de la resistencia | FIA cívica y comunidades abren transición democrática |
| 11 | La revolución armada | Las brigadas convierten liberación en monopolio militar |
| 12 | República de puertos y municipios | Confederación funcional sin centro fuerte |
| 13 | Islas divididas | Guerra congelada y fronteras internas permanentes |
| 14 | Islas desconectadas | Helios, infraestructura, autoridad y población colapsan |

<a id="src-modular-endings-and-epilogues-matrix--módulo-secreto-15-la-señal-continúa"></a>
##### Módulo secreto 15 — La señal continúa

Se superpone si Argos sobrevive, una copia escapa y la verdad es insuficiente. El plano final muestra un nuevo teatro pendiente. No niega el cierre principal: revela que la arquitectura sobrevivió.

<a id="src-modular-endings-and-epilogues-matrix--12-compatibilidad-entre-política-y-helios"></a>
#### 12. Compatibilidad entre política y Helios

| Orden | Nacional | Azul | Rojo | Liberado | Desconectado | Destruido | Oscuro |
|---|---|---|---|---|---|---|---|
| Transición Azul | Condicional | Sí | No | Sí | Sí | Sí | Sí |
| Protectorado Azul | No | Sí | No | Raro | Sí | Sí | Sí |
| Alianza Roja | Condicional | No | Sí | Condicional | Sí | Sí | Sí |
| Estado cliente Rojo | No | No | Sí | No | Sí | Sí | Sí |
| Gobierno de unidad | Sí | Comprometido | Comprometido | Sí | Sí | Sí | Sí |
| Restauración Verde | Sí | No | No | Sí | Sí | Sí | Sí |
| Directorio militar | Sí | No | No | Raro | Sí | Sí | Sí |
| República FIA | Sí | No | No | Sí | Sí | Sí | Sí |
| Revolución armada | Condicional | No | No | Raro | Sí | Sí | Sí |
| Confederación | Distribuido | No | No | Sí | Sí | Sí | Sí |
| Estado fragmentado | Raro | Enclave | Enclave | Raro | Sí | Sí | Sí |

«Comprometido» significa que la contradicción forma parte del epílogo. Un Gobierno de unidad con Helios Azul inicia su mandato sin controlar infraestructura esencial.

<a id="src-modular-endings-and-epilogues-matrix--13-resultados-favorables-y-estabilidad"></a>
#### 13. Resultados favorables y estabilidad

No existe final perfecto. Gobierno de unidad con H1 o H4 requiere autoridad constitucional, Markou o sustituto cívico, enlace Verde reformista, Kallas limitado, servicios, Argos expuesto, técnicos, baja dependencia extranjera, acuerdos municipales y archivos.

| Grado | Estabilidad |
|---|---|
| A | Orden sostenible; baja probabilidad de guerra inmediata |
| B | Equilibrio viable con capacidad de gestionar conflictos |
| C | Paz frágil dependiente de personas y recursos limitados |
| D | Posguerra armada e insurgencia probable |
| E | Colapso, éxodo y guerra regional |

La estabilidad no es calidad moral. Una paz represiva puede alcanzar A y una transición justa comenzar en C. La legitimidad se calcula por actor y región mediante constitucionalidad, apoyo municipal, servicios, promesas, conducta, participación, dependencia e historia local.

<a id="src-modular-endings-and-epilogues-matrix--14-resolución-de-personajes"></a>
#### 14. Resolución de personajes

El epílogo selecciona entre ocho y doce personajes:

1. **Definitorios:** Vardis, mando jugable, Varos, Markou, gobernante y una figura de Argos.
2. **Conflictos internos:** Hale, Vahid, Kallas, Koronis, Kouris, Pallis e infiltrados.
3. **Vínculo personal:** unidad protagonista, enlace de mando, técnicos, Neris, Serafim o Petrou.

Vardis puede ser juzgado, protegido, morir, escapar, borrar su identidad o cooperar sin absolución. Arendt puede descentralizar o cerrar puertas; Nassar testificar o salvar sus modelos; Mercer escapar, vender, destruir o rendir; Damaris dirigir una solución nativa o rechazar custodia extranjera.

Ward puede dirigir retirada, ocupación, investigación o encubrimiento. Hale puede quedar como héroe, ocupante, acusado o relevado. Navid puede negociar, testificar o ser sustituido. Vahid puede gobernar militarmente, vencer, ser juzgada o caer. Los demás destinos siguen [CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md](07_CHARACTERS_COMMAND_AND_RELATIONSHIPS.md#fuente-character-relationships-loyalties-and-betrayals), incluidas muertes y sustituciones.

<a id="src-modular-endings-and-epilogues-matrix--15-epílogos-regionales"></a>
#### 15. Epílogos regionales

Cada región recibe como máximo un módulo:

* Kavala: daño, FIA, municipio, puerto, verdad y ocupación;
* Pyrgos: Gobierno, archivos, Pallis, Kouris y daño institucional;
* aeropuerto: propietario, HELIOS-0, bases, expropiación y reconstrucción;
* noroeste: soberanismo, energía, guerrillas y autonomía;
* llanura oriental: Rojo, agricultura, Verde y rutas;
* Molos: playa, aeródromo, pesca, presencia Roja y aislamiento;
* sudeste: energía, convoyes, autonomía y daños;
* Stratis: Helios, PHAROS, población, militarización y destrucción.

Su significado procede de [ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md](02_STORY_BIBLE_AND_WORLD_HISTORY.md#fuente-altis-stratis-history-culture-and-economy).

<a id="src-modular-endings-and-epilogues-matrix--16-legado-de-la-unidad"></a>
#### 16. Legado de la unidad

| Perfil | Conducta |
|---|---|
| Vanguardia disciplinada | Obediencia, éxito táctico y confianza del mando |
| Protectores | Rescates, acuerdos, protección civil y desobediencia justificada |
| Martillo del mando | Grandes victorias, agresividad, bajas y afinidad con Hale o Vahid |
| Unidad incómoda | Investigación, autonomía y conflicto con superiores |
| Arquitectos de la verdad | Evidencia amplia, testigos protegidos y Argos expuesto |
| Unidad quebrada | Bajas, pérdida de personajes y victoria con coste humano |

AZUR-1 puede quedar condecorada, ocupante, disuelta, investigadora, abandonada o convertida en símbolo. RUBÍ-1 puede representar alianza, ocupación, protección de Verde, descubrimiento de Asterión, estabilidad o agravio insurgente.

<a id="src-modular-endings-and-epilogues-matrix--17-presentación"></a>
#### 17. Presentación

1. **Resolución inmediata, 3–6 minutos:** Helios, núcleo, Argos y salida de Stratis.
2. **Parte de guerra:** vencedor, mapa, sectores, bajas y fuerzas.
3. **Una semana:** Gobierno, alto el fuego, puertos, desplazados y prisioneros.
4. **Seis meses:** regiones, economía, ocupación, insurgencia, Helios y personajes.
5. **Dos años:** orden político, estabilidad y legado nacional.
6. **Poscréditos:** Argos, copia externa y comparación de campañas.

Duración objetivo: 8–14 minutos. Incluye cinco a siete módulos regionales o de facción, cinco a ocho personajes, un módulo de unidad y uno de Argos. Cada módulo tiene prioridad crítica, alta, media o baja; el constructor evita repetición y cierra primero los arcos centrales.

<a id="src-modular-endings-and-epilogues-matrix--18-comparación-de-campañas-y-continuidad"></a>
#### 18. Comparación de campañas y continuidad

Completar Azul y Rojo desbloquea UMBRAL, informes paralelos de Ward y Navid, decisiones reales, evaluación Argos y el papel confirmado de Vardis. No reemplaza los finales previos.

```text
IF-BLU-P1-H4-A2-C2-F2-T4
```

Significa campaña Azul, transición respaldada por Azul, Helios liberado, Argos expuesto y fragmentado, recuperación frágil, bases por tratado y revelación completa.

No se declara inmediatamente un final canónico universal. Cada partida conserva su continuidad. Canon promocional: «La guerra de Altis terminó después de la apertura de Stratis. El destino completo de Helios continúa disputado».

<a id="src-modular-endings-and-epilogues-matrix--19-arquitectura-técnica-prevista"></a>
#### 19. Arquitectura técnica prevista

La implementación modular, propiedad del estado, condiciones, efectos, transacciones, persistencia y pruebas se rigen por [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture).

La estructura autoritativa que alimenta estas funciones, sus snapshots y su transferencia entre escenarios se define en [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).

```text
IF_fnc_collectEndingState
IF_fnc_resolveMilitaryOutcome
IF_fnc_resolvePoliticalOrder
IF_fnc_resolveCivilCondition
IF_fnc_resolveHeliosOutcome
IF_fnc_resolveArgosOutcome
IF_fnc_validateEndingCompatibility
IF_fnc_selectEpilogueModules
IF_fnc_buildEndingReport
IF_fnc_saveEndingState
IF_fnc_playEndingSequence
```

```text
endingState = [
    ["campaignSide", "BLUE"],
    ["militaryOutcome", "BLUE_DOMINANT"],
    ["politicalOrder", "BLUE_TRANSITION"],
    ["civilCondition", "FRAGILE_RECOVERY"],
    ["heliosOutcome", "LIBERATED"],
    ["argosOutcome", "EXPOSED_FRAGMENTED"],
    ["foreignPresence", "TREATY_BASES"],
    ["publicTruth", "FULL_REVELATION"],
    ["stability", "B"],
    ["regions", []],
    ["characters", []],
    ["unitLegacy", "PROTECTORS"]
];
```

El resolvedor es determinista. Stratis entrega un final técnico básico y carga una misión de epílogo ligera que lee el estado, selecciona escenas y finaliza mediante `CfgDebriefing` y `BIS_fnc_endMission`.

Para un jugador se prefiere `missionProfileNamespace`, asociado a la misión o grupo, con guardado explícito y poco frecuente. `profileNamespace` queda para continuidad transversal deliberada. En cooperativo el servidor calcula y guarda; los clientes reciben la misma resolución y cierran mediante ejecución remota de `BIS_fnc_endMission`.

<a id="src-modular-endings-and-epilogues-matrix--20-validador"></a>
#### 20. Validador

Impide:

* Gobierno de unidad sin líderes, autoridad ni legitimidad;
* Helios nacional sin técnicos, acceso o red;
* retirada completa con bases permanentes;
* Argos desmantelado con Vardis desconocido, cero evidencia y accesos intactos.

El resultado imposible se degrada al más próximo coherente. H1 sin condiciones pasa a custodia incompleta y puede terminar en H7. Cada corrección genera un registro para depuración, nunca una cifra visible.

<a id="src-modular-endings-and-epilogues-matrix--21-pruebas"></a>
#### 21. Pruebas

Perfiles dorados mínimos:

1. Azul legalista;
2. Azul intervencionista;
3. Azul con Helios destruido;
4. Azul evacuada;
5. Rojo aliancista;
6. Rojo dominador;
7. Rojo con Gobierno colapsado;
8. Gobierno de unidad;
9. restauración Verde;
10. directorio militar;
11. FIA cívica;
12. FIA militarizada;
13. confederación municipal;
14. guerra congelada;
15. colapso humanitario;
16. Argos expuesto;
17. Argos oscuro;
18. Vardis capturado;
19. Vardis escapado;
20. ambas campañas.

También se prueban los pares vencedor–Helios, Gobierno–presencia, civil–estabilidad, Argos–verdad, personaje–sustituto y región–propietario.

<a id="src-modular-endings-and-epilogues-matrix--22-criterios-de-calidad"></a>
#### 22. Criterios de calidad

Todo final responde quién ganó, quién gobierna, quién controla la estrategia, qué ocurrió con Helios y Argos, qué precio pagó la población, qué pasó con aliados y al menos tres regiones, cómo terminó la unidad, si existe paz u ocupación y qué acciones previas hicieron viable la decisión.

> **No elegiste el final en Stratis. Llegaste a Stratis cargando todas las decisiones que ya lo habían hecho posible.**

<a id="src-modular-endings-and-epilogues-matrix--23-referencias"></a>
#### 23. Referencias

* [Failbetter Games — Quality-Based Narrative](https://www.failbettergames.com/news/storynexus-developer-diary-2-fewer-spreadsheets-less-swearing)
* [GDC Vault — Efficiently Branching Narrative](https://www.gdcvault.com/play/1023409/All-Choice-No-Consequence-Efficiently)
* [EA/BioWare — Mass Effect 3: Extended Cut](https://news.ea.com/press-releases/press-releases-details/2012/BioWare-Announces-Mass-Effect-3-Extended-Cut/default.aspx)
* [Bohemia Interactive — BIS_fnc_endMission](https://community.bistudio.com/wiki/BIS_fnc_endMission)
* [Bohemia Interactive — missionProfileNamespace](https://community.bistudio.com/wiki/missionProfileNamespace)
* [Bohemia Interactive — saveProfileNamespace](https://community.bistudio.com/wiki/saveProfileNamespace)
