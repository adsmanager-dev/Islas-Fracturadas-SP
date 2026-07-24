# Documento 1/14 — Arquitectura de las campañas Azul y Roja

> **Estado:** canon narrativo, estratégico y de producción previo a implementación.  
> **Campañas:** Fuerza Azul y Fuerza Roja.  
> **Inicio:** 24 de junio de 2042, Hora H 05:40.  
> **Terrenos:** Altis y Stratis.  
> **Modalidad inicial:** un jugador; futuro cooperativo de un solo bando.  
> **Persistencia:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).  
> **Fundamento narrativo:** [NARRATIVE_ACTS_AND_MISSION_SYSTEM.md](NARRATIVE_ACTS_AND_MISSION_SYSTEM.md).

## 1. Autoridad

Este documento fija la columna vertebral jugable, las puertas entre actos, los puntos de no retorno, el contrato de misión y el Acto I detallado de ambas campañas.

Los documentos narrativos anteriores conservan premisa, revelaciones, personajes y sistemas; si existe conflicto sobre orden, condición de avance o misión del Acto I, esta arquitectura prevalece.

## 2. Estructura híbrida

> Actos narrativos definidos + guerra territorial persistente + operaciones dinámicas + investigaciones opcionales + decisiones irreversibles.

Cada acto contiene situación estratégica, objetivos narrativos, misiones principales, operaciones emergentes, investigaciones, conflictos, condiciones de cierre y estado transferido.

No es una secuencia rígida de escenarios independientes ni un mundo abierto sin dirección.

## 3. Forma completa

Cada campaña posee:

- prólogo;
- Actos I–VII en Altis;
- Acto VIII, operación final en Stratis;
- Acto IX, epílogo modular no abierto.

Las ocho fases jugables principales incluyen Stratis. El Acto IX es resolución reactiva.

## 4. Identidad de campaña

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

## 5. Duración y mezcla

Objetivo por campaña: 28–40 horas. Ambas: 60–85 horas con comparación, secretos y finales.

| Contenido | Proporción |
|---|---:|
| Misiones principales | 40 % |
| Guerra y operaciones | 25 % |
| Investigación | 15 % |
| Política, civiles y relaciones | 10 % |
| Logística, preparación y mando | 10 % |

## 6. Familias de misión

| Tipo | Función |
|---|---|
| Principal `M` | avanza acto, conflicto o revelación |
| Investigación `I` | evidencia, testigo, señal o archivo |
| Personaje `C` | confianza, lealtad, secreto y supervivencia |
| Política/civil `P` | población, negociación, administración o prisioneros |
| Operación `O` | necesidad estratégica del mundo |
| Emergencia `E` | crisis urgente y caducable |
| Oportunidad | iniciativa descubierta fuera del mando |

Esta taxonomía describe la función dentro de los actos. Las 16 familias ejecutables, sus variantes y reglas de generación se rigen por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md).

## 7. Éxito y fracaso

| Resultado | Efecto |
|---|---|
| Éxito | intención y restricciones cumplidas |
| Parcial | intención lograda con pérdidas o coste |
| Fracaso operacional | cambia frente, recursos, información o plan |
| Desastre | altera de forma mayor fuerza, ciudad, alianza o mando |
| Derrota de campaña | no queda vía razonable de continuar |

> Perder una misión cambia la guerra; no obliga siempre a repetirla.

Derrota exige destrucción/evacuación irreversible, pérdida total de base logística, unidad sin sucesión o colapso final.

## 8. Núcleo fijo y variante

Toda misión principal conserva personaje, propósito, revelación y consecuencia narrativa.

Puede variar sector, ruta, guarnición, clima, aliados, infraestructura, inserción y resultado territorial.

ESPEJO siempre revela versiones incompatibles; el archivo puede aparecer en estación, convoy, técnico o nodo según el mundo.

## 9. Puertas entre actos

| Puerta | Regla |
|---|---|
| Dura | condición obligatoria |
| Alternativa | varias soluciones equivalentes |
| Acumulación | progreso suficiente entre opciones |
| Temporal | el mundo avanza aunque el jugador espere |
| No retorno | cierra contenido y transfiere consecuencias |

La transición puede exigir narrativa, territorio, logística, decisión y tiempo.

## 10. Puntos de no retorno

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

## 11. Arquitectura de actos

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

## 12. Campaña Azul por actos

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

## 13. Campaña Roja por actos

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

## 14. Eventos sincronizados

| Hora | Evento |
|---|---|
| 05:40 | Azul inicia Katalaki |
| 05:52 | Rojo entra en Molos |
| H+01:00 aprox. | Verde activa órdenes incompatibles |
| H+02:00 | apagones y bloqueos Helios |
| H+05:00 | Argos marca UMBRAL completado |
| primera noche | Petrou transmite 90 segundos |

Las consecuencias varían; la secuencia central no.

## 15. Doble campaña

Cada campaña guarda su propia cronología. Completar ambas crea `IF_DUAL_CAMPAIGN_STATE`.

```text
sharedEvidence differences decisions survivors endings comparableFiles
```

Desbloquea análisis, escena secreta, archivos UMBRAL, contexto AZUR/RUBÍ y encuentro completo con Vardis.

No fusiona partidas, declara una falsa ni borra finales.

## 16. Volumen orientativo

Por campaña:

- prólogo de 2–3 segmentos;
- Actos I–VII con 2–3 principales, una investigación, 2–6 operaciones y 0–2 misiones de personaje;
- Acto VIII con 3–5 fases;
- Acto IX con un epílogo modular.

Total aproximado: 25–32 principales/semiprincipales, 35–70 operaciones, 8–14 investigaciones y 10–18 eventos de personaje o civiles.

## 17. Estado de misión

```text
LOCKED AVAILABLE OFFERED ACCEPTED ACTIVE SUCCEEDED PARTIAL
FAILED EXPIRED ABORTED RESOLVED_OFFSCREEN
```

`FAILED` implica intento fallido; `EXPIRED`, ausencia antes del límite; `RESOLVED_OFFSCREEN`, ejecución de otra fuerza con resultado propio.

## 18. Contrato narrativo de misión

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

## 19. Identificadores estables

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

## 20. Acto I Azul: situación y cierre

Hora 05:40. Azul comienza sin territorio, con 144 efectivos estratégicos, AZUR-1, lanchas, dos Marshall, Hunter, recursos limitados y aire ligero; sin artillería, puerto ni hospital regional.

Objetivos: sobrevivir, asegurar Katalaki, conectar Neochori, gestionar población, activar logística, resistir Verde, interpretar Helios y decidir consolidación/avance.

| Ruta | Condición |
|---|---|
| A — completa | Katalaki, Neochori, hub, contraataque y fuerza viable |
| B — reducida | Katalaki, Neochori disputada/neutral y logística temporal |
| C — reubicación | Katalaki dañada, base alternativa y supervivencia |
| D — crisis | presencia mínima; Acto II abre recuperación |
| Derrota | acceso marítimo perdido y fuerza sin alternativa |

## 21. IF_B_P00 — Orden Horizonte Seguro

Prólogo/tutorial con Ward, Hale, Rourke, Kessler, Shaw y AZUR-1.

Enseña movimiento, interacción, equipo, radio, mapa y escuadra. Shaw presenta riesgo Rojo y aeropuerto. Reed detecta:

```text
...S-26...
...continuidad...
...enlace no autorizado...
```

El jugador informa formalmente, comparte con Reed o ignora. No cambia el desembarco; modifica confianza y conocimiento.

## 22. IF_B_A01_M01 — Costa ciega

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

## 23. IF_B_A01_M02 — La arena no es territorio

Introduce sectores, módulos, prioridades, logística, guarnición y frente.

Ward exige consolidar; Hale pide reconocimiento inmediato. El jugador consolida, reconoce, solicita fuerza separada o avanza.

- consolidar mejora defensa y Ward;
- reconocer mejora información con riesgo;
- avanzar habilita sorpresa, expone playa y favorece a Hale.

## 24. IF_B_A01_M03 — Neochori no está vacía

Objetivo: acceso funcional a Neochori, no necesariamente conquista por asalto.

Métodos: asalto, negociación, infiltración, cerco o cooperación civil.

Opcionales: clínica, saqueo, depósito, armas FIA y prisioneros.

| Estado | Efecto |
|---|---|
| Cooperadora | administración, logística y legitimidad |
| Ocupada | control con inestabilidad y sabotaje |
| Dañada | desplazamiento y capacidad médica reducida |
| No capturada | ruta o hub alternativo |

## 25. IF_B_A01_M04 — El primer convoy

Conecta Katalaki con Neochori o el hub alternativo. Transporta combustible, medicina, munición y construcción.

El jugador escolta, despeja, desvía, engaña o divide. Éxito activa centro; parcial entrega parte; fracaso reduce defensa y abre recuperación. Ignorada, otra unidad la resuelve según ruta, escolta y amenaza.

## 26. IF_B_A01_M05 — Primera línea

Verde contraataca desde Stavros, Whiskey, Lakka o combinación según reconocimiento, Argos y Neochori.

Objetivo: conservar una conexión logística. El jugador prioriza orientación, reserva, vehículo, evacuación y medicina, sin colocar objetos.

Resultados: victoria mueve frente; defensa costosa daña logística; retirada conserva fuerza; ruptura abre emergencia.

## 27. IF_B_A01_M06 — La primera noche

Petrou transmite `S-26 ACTIVA` con coordenadas incompletas y autenticación Verde.

El jugador protege/rastrea y entrega `E-S-FN-002A` a Rourke, Kessler, Ward, Shaw o AZUR-1. Su contraparte Roja `E-S-FN-002B` permite reconstruir la advertencia completa.

- Shaw puede clasificarlo;
- Kessler abre análisis;
- Ward se alarma;
- ocultarlo da ventaja privada y riesgo disciplinario.

## 28. Operaciones Azul

| ID | Operación |
|---|---|
| `IF_B_A01_O01` | Pescadores entre dos fuegos |
| `IF_B_A01_O02` | El puesto que no respondió |
| `IF_B_A01_O03` | Heridos en la carretera |
| `IF_B_A01_O04` | Carga perdida |
| `IF_B_A01_O05` | Ruta de Poliakko |
| `IF_B_A01_O06` | Dron caído |
| `IF_B_A01_O07` | Prisioneros de la primera hora |

## 29. Estado de salida Azul

```text
blueBeachheadState katalakiControl neochoriControl
firstConvoyResult greenCounterattackResult blueCasualtiesAct1
civilianDamageAct1 wardTrust haleTrust rourkeTrust
shawSuspicion s26FragmentKnown coastEvidenceState
blueLogisticsLevel
```

## 30. Acto I Rojo: situación y cierre

Hora 05:52. Rojo llega con 168 efectivos, RUBÍ-1, Ifrit, Marid, Kamysh, lanchas y AA ligera; sin artillería pesada. Tiene autorización formal confusa y un corredor estrecho.

Objetivos: Molos, aeródromo, Asterión, Verde, puerto, Sofia, corredor y Petrou.

| Ruta | Condición |
|---|---|
| A — alianza | Molos, aeródromo, Verde cooperante y paso |
| B — militar | Molos/aeródromo y preparación contra Sofia |
| C — enclave | corredor bloqueado y logística marítima |
| D — legal sin control | documentos válidos, rechazo local |
| Derrota | Molos/aeródromo perdidos y fuerza sin evacuación |

## 31. IF_R_P00 — Escudo de la Aurora

Prólogo con Navid, Vahid, Khadem, Sadeq, Khoury, Volkov y RUBÍ-1.

Khoury presenta solicitud y Asterión; Vahid, Molos y Sofia. Farouk detecta dos códigos Verdes válidos incompatibles.

Informar a Khadem, Sadeq, Volkov o guardar copia modifica confianza, interpretación y control de evidencia.

## 32. IF_R_A01_M01 — Asterión

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

## 33. IF_R_A01_M02 — Molos espera

Convierte el desembarco en enclave. Asegura muelle, depósito, comunicaciones y orden.

Khoury conserva administración; Vahid militariza puerto/combustible; Navid busca equilibrio.

El jugador administra, militariza, requisa, compensa o cambia descarga. Afecta trabajadores, logística, civiles, FIA y Gobierno.

## 34. IF_R_A01_M03 — Dos códigos

RUBÍ-1 contacta puesto, oficial, estación o convoy para determinar la cadena Verde en Sofia.

La unidad puede ser gubernamental, soberanista, confundida o infiltrada. El jugador negocia, espera, desarma, rodea, arresta o intercambia códigos.

El resultado fija la primera relación Rojo–Verde.

## 35. IF_R_A01_M04 — El corredor de Molos

Conecta puerto, aeródromo y vanguardia con combustible, munición, comunicaciones y medicina.

Opciones: pesado, convoyes pequeños, costa, aire limitado o espera.

Determina expansión, libertad de Vahid, dependencia marítima y disponibilidad blindada.

## 36. IF_R_A01_M05 — La puerta de Sofia

Sofia puede cooperar, ser neutral, estar dividida, fortificada, soberanista o manipulada.

Métodos: tratado, integración, ultimátum, flanqueo, asalto o infiltración.

| Resultado | Efecto |
|---|---|
| Cooperación | logística y legitimidad; limita a Vahid |
| Subordinación | control rápido y resentimiento |
| Destrucción | paso abierto, infraestructura perdida y guerra soberanista |
| Bloqueo | enclave oriental |

## 37. IF_R_A01_M06 — La primera noche

Petrou transmite `MANDO COMPROMETIDO` y `...VARD...`.

El jugador protege/rastrea y entrega a Khadem, Sadeq, Volkov, Navid o RUBÍ-1.

Volkov puede clasificar/modificar; Sadeq investiga; Navid revisa alianza; ocultar preserva copia privada.

## 38. Operaciones Rojas

| ID | Operación |
|---|---|
| `IF_R_A01_O01` | Pescadores de Molos |
| `IF_R_A01_O02` | El enlace perdido |
| `IF_R_A01_O03` | Munición sin destinatario |
| `IF_R_A01_O04` | Heridos Verdes |
| `IF_R_A01_O05` | Radar oriental |
| `IF_R_A01_O06` | Ruta del cabo |
| `IF_R_A01_O07` | El primer desertor |

## 39. Estado de salida Rojo

```text
redBeachheadState molosControl molosAirfieldState sofiaRelation
firstRedConvoyResult greenCooperationLevel redCasualtiesAct1
civilianDamageAct1 navidTrust vahidTrust khademTrust
volkovSuspicion s26FragmentKnown asterionEvidenceState
redLogisticsLevel
```

## 40. Comparación del Acto I

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

## 41. Estado de personajes

Azul registra Ward/Hale, Rourke/jugador, Reed/Shaw, Okafor/heridos, Ruiz/agresión y Torres/unidad.

Rojo registra Navid/Vahid, Khadem/jugador, Sadeq/Volkov, Farouk/secretos, Nasser/población y Kerim/hostilidad.

Cada conflicto ofrece prioridades incompatibles; el jugador no satisface a todos.

## 42. Cierre hacia Acto II

Azul necesita base logística, supervivientes, frente y ruta a Stavros, Lakka o AAC. Neochori no es obligatoria.

Rojo necesita Molos o aeródromo, logística marítima/terrestre, relación Verde y plan a Sofia o alternativa.

La señal de Petrou siempre existe como recuperada, perdida, clasificada o conocida indirectamente.

## 43. Niveles de conocimiento para Stratis

| Nivel | Operación |
|---|---|
| S0 | asalto ciego |
| S1 | objetivo técnico |
| S2 | PHAROS y Meridian conocidos |
| S3 | Argos, Vardis y accesos comprendidos |
| S4 | verdad comparada de ambas campañas |

Modifican rutas, aliados, objetivos, diálogos, decisiones y captura de Vardis. Investigar no es obligatorio para terminar.

## 44. Vertical slice narrativo

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

## 45. Puerta de producción

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

## 46. Estructura de archivos

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

## 47. Funciones conceptuales

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

## 48. Invariantes narrativas

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

## 49. Prohibiciones

No se permite duplicar campañas con uniformes distintos, exigir victoria ideal, reiniciar historia tras fracaso, revelar Argos temprano, convertir Helios en conciencia, cambiar globalmente a Verde, olvidar logística/civiles, concentrar decisiones al final, separar operaciones de narrativa, permitir espera infinita, crear misiones sin impacto, matar roles sin sucesión, reducir Stratis a una base, exigir toda investigación, conceder final por una sola elección, contradecir horarios o producir todos los actos antes del slice.

## 50. Principios vinculantes

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

## 51. Definición final

Azul comienza creyendo que impide una ocupación; Rojo, que impide un cambio de régimen. Ambos encuentran pruebas auténticas presentadas para que solo una decisión pareciera razonable.

Cada acto abre una parte de la guerra. Cada misión decide qué queda disponible cuando se cierra. Stratis es la operación que toda la campaña anterior hizo posible.

## 52. Continuación de la serie

El [Documento 2/14](INVESTIGATION_REVELATION_MATRIX.md) fija la matriz definitiva de revelaciones, evidencias e investigación de Argos.

El [Documento 3/14](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md) fija las necesidades causales, plantillas, transformaciones, resolución externa y ritmo del contenido dinámico.

El [Documento 4/14](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md) fija población, administración, autoridad, legitimidad, estabilidad y política.

El siguiente contrato rector es el **Documento 5/14 — Sistema definitivo de FIA, insurgencia y guerra clandestina**. Los Actos II–VII no se producen en detalle antes de validar el Acto I Azul.
