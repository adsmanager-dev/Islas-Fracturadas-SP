# Matriz modular de finales y epílogos

> **Estado:** canon rector de autor, narrativa, sistemas y producción.  
> **Campañas:** Azul y Roja.  
> **Terrenos:** Altis y Stratis.  
> **Continuidad:** prevalece el canon revisado: Helios nació en Altis; Vardis fingió su muerte y trasladó clandestinamente el núcleo a Stratis.  
> **Propósito:** representar toda la campaña sin producir miles de finales independientes.
> **Entrada de campaña:** actos, PNR-7/PNR-8 y comparación Azul/Roja se rigen por [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](BLUE_RED_CAMPAIGN_ARCHITECTURE.md).
> **Entrada investigativa:** autenticidad, publicación, S0–S4, exposición de Argos y captura de Vardis se rigen por [INVESTIGATION_REVELATION_MATRIX.md](INVESTIGATION_REVELATION_MATRIX.md).
> **Entrada civil:** condición civil, orden político, legitimidad gubernamental, reconciliación nativa y ocupación extranjera se rigen por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md).

## 1. Modelo Delta Modular

El desenlace se resuelve mediante:

> **Familia principal derivada del mundo + decisión viable sobre Helios + resolución de Argos + epílogos modulares.**

No habrá puntuación moral, elección final capaz de borrar la campaña, árbol completo por combinación ni cinemáticas idénticas con otro color.

El resultado tiene cuatro niveles:

1. familia militar y política;
2. resolución de Helios y Argos;
3. condición de la nación;
4. epílogos de regiones, facciones, personajes y unidad protagonista.

Habrá **14 familias públicas** y un **decimoquinto módulo secreto superpuesto**, «La señal continúa». Este último contamina cualquier familia compatible, pero nunca reemplaza quién ganó o quién gobierna.

## 2. Ecuación conceptual

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

## 3. Principios inviolables

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

## 4. Variables rectoras

El estado final conserva agregados útiles, no una variable por cada decisión.

### Militar

```text
blueMilitaryPower redMilitaryPower greenMilitaryPower fiaArmedPower
blueTerritory redTerritory greenTerritory contestedTerritory
blueLogistics redLogistics greenCohesion
```

### Política

```text
governmentLegitimacy governmentCohesion constitutionalAuthority
unityCoalitionSupport municipalAutonomy
bluePoliticalDependency redPoliticalDependency
fiaPoliticalInfluence greenPoliticalInfluence
```

### Civil

```text
civilianSecurity essentialServices infrastructureIntegrity
civilianDisplacement civilianCasualties economicActivity
communityCohesion radicalization
```

### Helios

```text
heliosPhysicalControl heliosDigitalAccess heliosNetworkIntegrity
heliosCivilFunctions heliosMilitaryFunctions argosBackdoorAccess
technicalStaffSurvival
```

### Investigación

```text
evidenceTechnical evidencePolitical evidenceHuman evidenceOperational
argosExposure vardisConfirmed truthPublished dualCampaignComparison
```

### Presencia extranjera

```text
blueOccupationIntent redOccupationIntent
blueBasePresence redBasePresence
blueWithdrawalPressure redWithdrawalPressure internationalPressure
```

### Personajes

```text
alive loyaltyState trustPlayer politicalPosition evidenceKnown finalAlignment
```

No existirán `goodEndingPoints`, `evilPoints`, `heroScore`, `correctFaction` ni `perfectEndingUnlocked`. La sociedad tampoco se resume en `civilianReputation`: confianza, miedo, legitimidad, dependencia, seguridad y radicalización permanecen separadas.

## 5. Resultado militar

| Código | Resultado | Condición resumida |
|---|---|---|
| M1 | Dominio Azul | Rojo pierde capacidad ofensiva; Azul conserva logística y fuerza de teatro |
| M2 | Dominio Rojo | Azul no puede sostenerse; Rojo conserva corredores, reservas y administración aliada |
| M3 | Ascenso nativo | Los invasores se retiran o quedan incapaces; una coalición nativa conserva fuerza y autoridad |
| M4 | Guerra congelada | Ningún actor domina; persisten territorios conectados y líneas logísticas rivales |
| M5 | Colapso mutuo | Fuerzas, infraestructura y Estado pierden capacidad para imponer paz |

El ascenso nativo no equivale automáticamente a democracia. Puede producir unidad, restauración, directorio, FIA o confederación.

## 6. Orden político

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

## 7. Condición civil

| Código | Condición | Lectura |
|---|---|---|
| C1 | Recuperación sostenible | Servicios, cohesión y autoridad aceptada; daños reparables |
| C2 | Recuperación frágil | Instituciones activas con refugiados, daños y legitimidad desigual |
| C3 | Paz represiva | Seguridad y servicios altos junto con miedo y legitimidad baja |
| C4 | Crisis humanitaria | Hospitales, suministros e infraestructura insuficientes |
| C5 | Nación radicalizada | Armas, agravios y redes clandestinas preparan otra guerra |
| C6 | Islas vaciadas | Éxodo, despoblación y bases sin sociedad funcional |

La condición civil describe qué nación recibe el vencedor, no quién gobierna.

## 8. Destino de Helios

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

## 9. Destino de Argos

| Código | Resultado |
|---|---|
| A1 | Expuesto y desmantelado |
| A2 | Expuesto, pero fragmentado |
| A3 | Debilitado y secreto |
| A4 | Superviviente |
| A5 | Replicado fuera de las islas |

A1 exige archivos autenticados, infiltrados identificados, Vardis confirmado, accesos eliminados y autoridad investigadora. A5 se reserva para una copia externa completada mediante escape o decisión técnica concreta.

## 10. Presencia extranjera y verdad pública

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

## 11. Familias públicas

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

### Módulo secreto 15 — La señal continúa

Se superpone si Argos sobrevive, una copia escapa y la verdad es insuficiente. El plano final muestra un nuevo teatro pendiente. No niega el cierre principal: revela que la arquitectura sobrevivió.

## 12. Compatibilidad entre política y Helios

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

## 13. Resultados favorables y estabilidad

No existe final perfecto. Gobierno de unidad con H1 o H4 requiere autoridad constitucional, Markou o sustituto cívico, enlace Verde reformista, Kallas limitado, servicios, Argos expuesto, técnicos, baja dependencia extranjera, acuerdos municipales y archivos.

| Grado | Estabilidad |
|---|---|
| A | Orden sostenible; baja probabilidad de guerra inmediata |
| B | Equilibrio viable con capacidad de gestionar conflictos |
| C | Paz frágil dependiente de personas y recursos limitados |
| D | Posguerra armada e insurgencia probable |
| E | Colapso, éxodo y guerra regional |

La estabilidad no es calidad moral. Una paz represiva puede alcanzar A y una transición justa comenzar en C. La legitimidad se calcula por actor y región mediante constitucionalidad, apoyo municipal, servicios, promesas, conducta, participación, dependencia e historia local.

## 14. Resolución de personajes

El epílogo selecciona entre ocho y doce personajes:

1. **Definitorios:** Vardis, mando jugable, Varos, Markou, gobernante y una figura de Argos.
2. **Conflictos internos:** Hale, Vahid, Kallas, Koronis, Kouris, Pallis e infiltrados.
3. **Vínculo personal:** unidad protagonista, enlace de mando, técnicos, Neris, Serafim o Petrou.

Vardis puede ser juzgado, protegido, morir, escapar, borrar su identidad o cooperar sin absolución. Arendt puede descentralizar o cerrar puertas; Nassar testificar o salvar sus modelos; Mercer escapar, vender, destruir o rendir; Damaris dirigir una solución nativa o rechazar custodia extranjera.

Ward puede dirigir retirada, ocupación, investigación o encubrimiento. Hale puede quedar como héroe, ocupante, acusado o relevado. Navid puede negociar, testificar o ser sustituido. Vahid puede gobernar militarmente, vencer, ser juzgada o caer. Los demás destinos siguen [CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md](CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md), incluidas muertes y sustituciones.

## 15. Epílogos regionales

Cada región recibe como máximo un módulo:

* Kavala: daño, FIA, municipio, puerto, verdad y ocupación;
* Pyrgos: Gobierno, archivos, Pallis, Kouris y daño institucional;
* aeropuerto: propietario, HELIOS-0, bases, expropiación y reconstrucción;
* noroeste: soberanismo, energía, guerrillas y autonomía;
* llanura oriental: Rojo, agricultura, Verde y rutas;
* Molos: playa, aeródromo, pesca, presencia Roja y aislamiento;
* sudeste: energía, convoyes, autonomía y daños;
* Stratis: Helios, PHAROS, población, militarización y destrucción.

Su significado procede de [ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md](ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md).

## 16. Legado de la unidad

| Perfil | Conducta |
|---|---|
| Vanguardia disciplinada | Obediencia, éxito táctico y confianza del mando |
| Protectores | Rescates, acuerdos, protección civil y desobediencia justificada |
| Martillo del mando | Grandes victorias, agresividad, bajas y afinidad con Hale o Vahid |
| Unidad incómoda | Investigación, autonomía y conflicto con superiores |
| Arquitectos de la verdad | Evidencia amplia, testigos protegidos y Argos expuesto |
| Unidad quebrada | Bajas, pérdida de personajes y victoria con coste humano |

AZUR-1 puede quedar condecorada, ocupante, disuelta, investigadora, abandonada o convertida en símbolo. RUBÍ-1 puede representar alianza, ocupación, protección de Verde, descubrimiento de Asterión, estabilidad o agravio insurgente.

## 17. Presentación

1. **Resolución inmediata, 3–6 minutos:** Helios, núcleo, Argos y salida de Stratis.
2. **Parte de guerra:** vencedor, mapa, sectores, bajas y fuerzas.
3. **Una semana:** Gobierno, alto el fuego, puertos, desplazados y prisioneros.
4. **Seis meses:** regiones, economía, ocupación, insurgencia, Helios y personajes.
5. **Dos años:** orden político, estabilidad y legado nacional.
6. **Poscréditos:** Argos, copia externa y comparación de campañas.

Duración objetivo: 8–14 minutos. Incluye cinco a siete módulos regionales o de facción, cinco a ocho personajes, un módulo de unidad y uno de Argos. Cada módulo tiene prioridad crítica, alta, media o baja; el constructor evita repetición y cierra primero los arcos centrales.

## 18. Comparación de campañas y continuidad

Completar Azul y Rojo desbloquea UMBRAL, informes paralelos de Ward y Navid, decisiones reales, evaluación Argos y el papel confirmado de Vardis. No reemplaza los finales previos.

```text
IF-BLU-P1-H4-A2-C2-F2-T4
```

Significa campaña Azul, transición respaldada por Azul, Helios liberado, Argos expuesto y fragmentado, recuperación frágil, bases por tratado y revelación completa.

No se declara inmediatamente un final canónico universal. Cada partida conserva su continuidad. Canon promocional: «La guerra de Altis terminó después de la apertura de Stratis. El destino completo de Helios continúa disputado».

## 19. Arquitectura técnica prevista

La estructura autoritativa que alimenta estas funciones, sus snapshots y su transferencia entre escenarios se define en [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).

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

## 20. Validador

Impide:

* Gobierno de unidad sin líderes, autoridad ni legitimidad;
* Helios nacional sin técnicos, acceso o red;
* retirada completa con bases permanentes;
* Argos desmantelado con Vardis desconocido, cero evidencia y accesos intactos.

El resultado imposible se degrada al más próximo coherente. H1 sin condiciones pasa a custodia incompleta y puede terminar en H7. Cada corrección genera un registro para depuración, nunca una cifra visible.

## 21. Pruebas

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

## 22. Criterios de calidad

Todo final responde quién ganó, quién gobierna, quién controla la estrategia, qué ocurrió con Helios y Argos, qué precio pagó la población, qué pasó con aliados y al menos tres regiones, cómo terminó la unidad, si existe paz u ocupación y qué acciones previas hicieron viable la decisión.

> **No elegiste el final en Stratis. Llegaste a Stratis cargando todas las decisiones que ya lo habían hecho posible.**

## 23. Referencias

* [Failbetter Games — Quality-Based Narrative](https://www.failbettergames.com/news/storynexus-developer-diary-2-fewer-spreadsheets-less-swearing)
* [GDC Vault — Efficiently Branching Narrative](https://www.gdcvault.com/play/1023409/All-Choice-No-Consequence-Efficiently)
* [EA/BioWare — Mass Effect 3: Extended Cut](https://news.ea.com/press-releases/press-releases-details/2012/BioWare-Announces-Mass-Effect-3-Extended-Cut/default.aspx)
* [Bohemia Interactive — BIS_fnc_endMission](https://community.bistudio.com/wiki/BIS_fnc_endMission)
* [Bohemia Interactive — missionProfileNamespace](https://community.bistudio.com/wiki/missionProfileNamespace)
* [Bohemia Interactive — saveProfileNamespace](https://community.bistudio.com/wiki/saveProfileNamespace)
