# Sistema militar, orden de batalla y catálogo de fuerzas

> **Estado:** diseño confirmado y diseño en desarrollo
> **Fuente de verdad para:** orden de batalla y catálogo militar
> **Relacionados:** [12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md); [14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-07-24

## Propósito

Centralizar orden de batalla y catálogo militar sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [MILITARY SYSTEM ORDER OF BATTLE AND FORCE CATALOG](#fuente-military-system-order-of-battle-and-force-catalog)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 13_MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

## Contenido consolidado

<a id="fuente-military-system-order-of-battle-and-force-catalog"></a>
## Fuente integrada: `MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md`

> **Procedencia:** contenido migrado de `MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-military-system-order-of-battle-and-force-catalog--sistema-militar-orden-de-batalla-y-catálogo-de-fuerzas"></a>
### Sistema militar, orden de batalla y catálogo de fuerzas

> **Jerarquía:** este documento conserva escalas, órdenes de batalla, perfiles y catálogo de activos. La proyección física, reserva transaccional, resolución virtual y reintegración se rigen por [TACTICAL_AND_FORCE_VIRTUALIZATION_SYSTEM.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-tactical-and-force-virtualization-system); las hipótesis de balance, métricas y puertas de aprobación, por [MASTER_TESTING_PERFORMANCE_AND_BALANCE_SYSTEM.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system).

> **Estado:** canon militar y contrato de diseño previo a implementación.
> **Motor objetivo:** Arma 3 2.18.
> **Autoridad de estado:** [PERSISTENT_CAMPAIGN_DATA_MODEL.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-persistent-campaign-data-model).
> **Decisión estratégica:** [STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md](14_AI_COMMAND_OPERATIONS_AND_DIFFICULTY.md#fuente-strategic-ai-and-chain-of-command).
> **Capacidad territorial:** [TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md](11_SECTORS_BASES_FORTIFICATIONS_AND_MODULES.md#fuente-territorial-sector-front-and-construction-system).
> **Sostenimiento:** [ECONOMIC_AND_LOGISTICS_SYSTEM.md](12_ECONOMY_LOGISTICS_RESOURCES_AND_SUPPLY.md#fuente-economic-and-logistics-system).

<a id="src-military-system-order-of-battle-and-force-catalog--1-propósito"></a>
#### 1. Propósito

Este documento determina cuántos combatientes y activos existen, cómo llegan, se organizan, consumen recursos, sufren bajas, se recuperan y se traducen entre la guerra estratégica y el combate físico.

La campaña no genera soldados, vehículos ni apoyos ilimitados. Cada fuerza materializada representa una entidad estratégica auditable.

<a id="src-military-system-order-of-battle-and-force-catalog--2-perfiles-de-contenido"></a>
#### 2. Perfiles de contenido

<a id="src-military-system-order-of-battle-and-force-catalog--perfil-básico"></a>
##### Perfil básico

Usa el juego base y activos oficiales sin dependencia premium obligatoria. Ningún DLC puede ser requisito silencioso para iniciar, terminar o comprender la campaña.

<a id="src-military-system-order-of-battle-and-force-catalog--perfil-oficial-ampliado"></a>
##### Perfil oficial ampliado

Puede sustituir activos por equivalentes oficiales de DLC —como Huron, Taru, Black Wasp, Shikra, Gryphon, Rhino MGS, Nyx o Angara— solo tras comprobar su licencia y disponibilidad.

Un paquete opcional:

- no cambia el canon, la fuerza estratégica ni los desenlaces;
- no bloquea misiones ni altera el formato de guardado;
- no concede una ventaja sistémica;
- resuelve roles lógicos a clases diferentes.

<a id="src-military-system-order-of-battle-and-force-catalog--mods-futuros"></a>
##### Mods futuros

Un paquete `IF_AssetPack_ModName` puede cambiar armas, uniformes, vehículos, aeronaves y nombres, pero no fuerza estratégica, recursos, relaciones, persistencia ni finales.

<a id="src-military-system-order-of-battle-and-force-catalog--3-identidad-política-y-lado-técnico"></a>
#### 3. Identidad política y lado técnico

| Actor | Identidad persistente | Proyección habitual |
|---|---|---|
| Azul | `FAC_BLUE` | `WEST`, NATO |
| Rojo | `FAC_RED` | `EAST`, CSAT |
| Verde | `FAC_GREEN` | `INDEPENDENT`, AAF |
| Civiles | actores locales | `CIVILIAN` |
| FIA | `FAC_FIA_*` | `B_G`, `O_G` o `I_G` según misión |
| Meridian | `FAC_MERIDIAN` | lado compatible con la misión |
| Argos | actor informativo | sin lado territorial permanente |

El lado del motor resuelve combate y relaciones locales; no redefine identidad, lealtad o control político.

<a id="src-military-system-order-of-battle-and-force-catalog--4-burbuja-táctica"></a>
#### 4. Burbuja táctica

Una misión física utiliza normalmente el bando del jugador, el enemigo principal, un actor nativo y los civiles pertinentes.

Los demás actores permanecen virtuales, aparecen con retraso, abandonan la zona, se proyectan temporalmente o actúan en otra misión. No se intentará representar simultáneamente todas las lealtades políticas con los cuatro lados del motor.

<a id="src-military-system-order-of-battle-and-force-catalog--5-escalas-de-fuerza"></a>
#### 5. Escalas de fuerza

| Fuerza | Reserva estratégica | Día Cero o primera oleada | Máximo sostenible previsto |
|---|---:|---:|---:|
| Azul | 720 | 144 | 650–720 |
| Rojo | 810 | 168 | 750–810 |
| Verde | 3.200 activos + 1.200 reservistas | 1.950 preparados | 400–500 reservistas movilizables la primera semana |
| FIA | 1.100–1.400 en red; 360 cuadros armados | 220–280 activos | ~420 combatientes sostenibles |
| Meridian | 128 armados + 86 protegidos | 214 totales | sin reserva nacional |

FIA puede atraer hasta unos 650 locales, pero apoyo social no equivale automáticamente a fuerza entrenada.

<a id="src-military-system-order-of-battle-and-force-catalog--6-presupuesto-físico"></a>
#### 6. Presupuesto físico

Una misión habitual contiene 25–45 aliados, 30–55 enemigos, uno a tres grupos de terceros, cuatro a diez vehículos y civiles limitados por escena.

Una batalla grande contiene 110–150 IA totales, 12–20 vehículos, hasta tres aeronaves activas y artillería estrictamente controlada.

El objetivo inicial de simulación es 70–110 infantes, 8–16 vehículos terrestres, 0–3 aeronaves y 8–25 civiles. Solo las pruebas pueden autorizar 150–180 IA.

<a id="src-military-system-order-of-battle-and-force-catalog--7-formaciones-abstractas"></a>
#### 7. Formaciones abstractas

| Formación | Fuerza representada |
|---|---:|
| Escuadra | 6–10 |
| Pelotón | 24–40 |
| Compañía reducida | 70–120 |
| Grupo mecanizado | 1–4 blindados con infantería |
| Sección de carros | 2 carros |
| Pelotón de carros | 3–4 carros |
| Batería | 1–3 piezas |
| Vuelo | 1–2 aeronaves disponibles |

Las plantillas físicas parten de roles oficiales de NATO, CSAT, AAF y FIA, pero su composición de campaña puede variar sin romper su función estratégica.

<a id="src-military-system-order-of-battle-and-force-catalog--8-armas-y-compatibilidad"></a>
#### 8. Armas y compatibilidad

| Fuerza | Familia principal |
|---|---|
| Azul | MX |
| Rojo | Katiba, Rahim, RPG-42 |
| Verde | Mk20, Mk200 |
| FIA | TRG y equipo capturado mixto |

La munición no se considera universal. Armas capturadas pueden aumentar potencia y a la vez fragmentar abastecimiento.

<a id="src-military-system-order-of-battle-and-force-catalog--9-orden-de-batalla-azul"></a>
#### 9. Orden de batalla Azul

| Componente | Personal |
|---|---:|
| Cuartel general y comunicaciones | 36 |
| Tres compañías de infantería | 324 |
| Reconocimiento, ingenieros y EOD | 42 |
| Blindados y mecanizados | 84 |
| Artillería y defensa aérea | 48 |
| Aviación | 66 |
| Logística, mantenimiento y sanidad | 120 |
| **Total** | **720** |

Cada compañía ronda 108 efectivos; un pelotón, 32. AZUR-1 conserva ocho integrantes nombrados y se materializa mediante clases oficiales adaptadas a sus funciones.

<a id="src-military-system-order-of-battle-and-force-catalog--activos-azul"></a>
##### Activos Azul

| Categoría | Inventario estratégico |
|---|---|
| Movilidad | 16 Hunter, 18 HEMTT |
| Mecanizados | 6 Marshall, 6 Panther |
| Recuperación/AA | 2 Bobcat, 2 Cheetah |
| Carros y artillería | 6 Slammer, 2 Scorcher, 1 Sandstorm |
| Helicópteros | 2 MH-9, 2 AH-9, 3 UH-80, 2 AH-99 |
| Ala fija y UAV | 2 A-164, 2 MQ-4A, 8 Darter |
| Terrestres no tripulados | 4 UGV |
| Costa | 2 lanchas armadas, 10 de asalto, 2 SDV y rescate |

La flota mayor permanece abstracta.

<a id="src-military-system-order-of-battle-and-force-catalog--primera-oleada-azul"></a>
##### Primera oleada Azul

144 efectivos, cuatro Hunter, dos Marshall, sanidad, ingeniería, lanchas y drones. Antes de asegurar aeropuerto o puerto pueden desplegarse aproximadamente 360 efectivos; el resto exige corredor y autorización.

<a id="src-military-system-order-of-battle-and-force-catalog--10-orden-de-batalla-rojo"></a>
#### 10. Orden de batalla Rojo

| Componente | Personal |
|---|---:|
| Cuartel general y enlace político | 42 |
| Tres compañías mecanizadas | 348 |
| Reconocimiento y fuerzas especiales | 48 |
| Blindados | 110 |
| Artillería y defensa aérea | 58 |
| Aviación | 72 |
| Logística, mantenimiento y apoyo | 132 |
| **Total** | **810** |

RUBÍ-1 conserva ocho integrantes nombrados.

<a id="src-military-system-order-of-battle-and-force-catalog--activos-rojo"></a>
##### Activos Rojo

| Categoría | Inventario estratégico |
|---|---|
| Movilidad | 18 Ifrit, 20 Tempest |
| Mecanizados | 8 Marid, 8 Kamysh |
| AA, carros y artillería | 3 Tigris, 8 Varsuk, 3 Sochor |
| Helicópteros | 2 Orca armadas, 1 sin armar, 3 Kajman |
| Ala fija y UAV | 2 Neophron, 2 UAV de ala fija, 8 drones pequeños |
| Terrestres no tripulados | 4 UGV |
| Costa | 2 lanchas armadas, 10 de asalto, 2 SDV y auxiliares |

Taru pertenece únicamente a un perfil opcional compatible. La flota mayor es abstracta.

<a id="src-military-system-order-of-battle-and-force-catalog--primera-oleada-rojo"></a>
##### Primera oleada Rojo

168 efectivos, cuatro Ifrit, dos Marid, dos Kamysh, defensa aérea ligera y lanchas. Antes de asegurar el corredor de Sofia pueden alcanzar aproximadamente 420 efectivos.

<a id="src-military-system-order-of-battle-and-force-catalog--11-orden-de-batalla-verde"></a>
#### 11. Orden de batalla Verde

| Componente | Activos | Preparados en Día Cero |
|---|---:|---:|
| Mando y apoyo | 320 | 160 |
| Región oeste | 530 | 380 |
| Región central | 620 | 460 |
| Región este | 560 | 410 |
| Región sur | 430 | 280 |
| Stratis | 260 | 150 |
| Aviación, costa y técnicos | 480 | 110 |
| **Total** | **3.200** | **1.950** |

Verde defiende toda la nación y comienza con mayor masa, bases y conocimiento del terreno, pero su mando está dividido. Su reserva de 1.200 necesita movilización; solo 400–500 pueden incorporarse durante la primera semana sin consecuencias graves sobre producción, servicios y radicalización.

<a id="src-military-system-order-of-battle-and-force-catalog--activos-verde"></a>
##### Activos Verde

| Categoría | Inventario estratégico |
|---|---|
| Movilidad y logística | 30 Strider, 44 Zamak |
| Mecanizados | 12 Gorgon, 14 Mora |
| Carros | 10 Kuma |
| Helicópteros | 4 Hellcat armadas, 4 sin armar, 4 Mohawk |
| Ala fija y UAV | 6 Buzzard, 4 Ababil, 12 Darter |
| Terrestres no tripulados | 6 UGV |
| Costa | 4 lanchas armadas, 12 de asalto, 4 SDV |

Verde dispone de morteros y defensas estáticas AT/AA, pero no comienza con un equivalente orgánico a las baterías Scorcher o Sochor. Puede capturarlo, con las restricciones de adaptación correspondientes.

<a id="src-military-system-order-of-battle-and-force-catalog--12-fia"></a>
#### 12. FIA

Este catálogo define activos y escalas militares. La creación, reclutamiento, exposición, apoyo civil, autonomía y transición política de células se rigen por [FIA_INSURGENCY_AND_CLANDESTINE_WAR_SYSTEM.md](06_FIA_REBELS_GUERRILLAS_AND_CIVILIANS.md#fuente-fia-insurgency-and-clandestine-war-system).

| Componente | Personal |
|---|---:|
| Brigadas de Liberación | 170 |
| Células locales | 90 |
| Apoyo comunitario | 80 |
| Frente Negro y radicales | 40–60, parcialmente solapados |

Escalas: célula de 3–6, equipo de 4–8, patrulla de 6–10, sección de 12–20 y brigada local estratégica de 40–70.

El total autoritativo inicial sigue siendo 360 cuadros armados. Frente Negro es una afiliación transversal: parte de sus miembros ya está incluida en brigadas, células o apoyo y no vuelve a sumarse.

<a id="src-military-system-order-of-battle-and-force-catalog--activos-fia"></a>
##### Activos FIA

- 20 Offroad sin armar, 8 HMG y 5 AT;
- 14 furgonetas, 3 cisternas y 3 vehículos de reparación;
- 8 embarcaciones;
- 6 morteros Mk6 y 12 estáticas M2;
- armas para unos 360 cuadros;
- 2 drones capturados.

FIA no inicia con carros, IFV, aviación, artillería autopropulsada, defensa aérea pesada ni logística industrial. Cada activo pesado capturado exige tripulación, combustible, munición, reparación, escondite y rutas; concentrarlo vuelve a FIA más visible y convencional.

<a id="src-military-system-order-of-battle-and-force-catalog--13-radicales"></a>
#### 13. Radicales

El Frente Negro y otras redes radicales reúnen unos 40–60 miembros en células clandestinas. Su poder procede de explosivos, asesinatos, sabotaje y banderas falsas, no de un orden de batalla territorial.

<a id="src-military-system-order-of-battle-and-force-catalog--14-meridian"></a>
#### 14. Meridian

| Componente armado | Personal |
|---|---:|
| Mando y comunicaciones | 12 |
| Tres pelotones de seguridad | 72 |
| Reacción | 16 |
| Aire, costa y movilidad | 16 |
| Operaciones especiales | 12 |
| **Armados** | **128** |

Meridian protege además a 86 técnicos, sanitarios y especialistas. Posee cuatro MRAP, cuatro Offroad, dos vehículos logísticos, dos helicópteros ligeros o de transporte, dos lanchas armadas, cuatro de asalto, dos UGV, drones y armas estáticas.

Puede usar clases base de reconocimiento de NATO o CSAT con identidad propia. No dispone de división blindada, fuerza aérea de combate ni flota real. Protege Stratis mediante secreto, información y posiciones.

<a id="src-military-system-order-of-battle-and-force-catalog--15-gendarmería-y-seguridad-civil"></a>
#### 15. Gendarmería y seguridad civil

Existen aproximadamente 380 policías y gendarmes nacionales y 220 agentes municipales, portuarios y aeroportuarios. Cumplen controles, investigación, cárceles, tráfico, evacuación, puertos y orden público.

Pueden permanecer neutrales, servir al Gobierno o a Verde, cooperar con municipios, ser absorbidos, desertar o entregar armas a FIA. No cuentan automáticamente como militares.

<a id="src-military-system-order-of-battle-and-force-catalog--16-oleadas-expedicionarias"></a>
#### 16. Oleadas expedicionarias

| Oleada | Contenido | Condición |
|---|---|---|
| 0 — Reconocimiento | protagonistas, observadores, especiales, drones y contactos | inserción inicial |
| 1 — Cabeza de playa | 120–180, ligeros, ingenieros, sanidad y seguridad | acceso costero |
| 2 — Consolidación | infantería adicional, blindados medios, suministros y AA | costa, nodo, ruta y comunicaciones |
| 3 — Fuerza pesada | carros, artillería, mantenimiento y reservas | puerto/aeródromo, corredor y amenaza aceptable |
| 4 — Reserva estratégica | escalada adicional | autorización, legitimidad, recursos y rutas |

Capturar un aeropuerto no crea soldados; permite transportar reservas existentes con mayor rapidez.

<a id="src-military-system-order-of-battle-and-force-catalog--17-condiciones-de-refuerzo"></a>
#### 17. Condiciones de refuerzo

Todo refuerzo necesita simultáneamente reserva disponible, transporte, punto de recepción seguro, protección de la ruta y autorización política. Si una condición falla, la fuerza queda retrasada, desviada, reducida o cancelada.

<a id="src-military-system-order-of-battle-and-force-catalog--18-bajas-y-reemplazos"></a>
#### 18. Bajas y reemplazos

```text
FIT WOUNDED_LIGHT WOUNDED_SERIOUS MISSING CAPTURED
KILLED RETURNED_TO_DUTY
```

Un herido grave exige evacuación, hospital, tiempo y capacidad médica. Un capturado puede activar interrogatorio, intercambio, rescate o propaganda. Un muerto se descuenta permanentemente.

El respawn táctico del jugador, si el modo lo permite, no borra bajas estratégicas.

<a id="src-military-system-order-of-battle-and-force-catalog--personajes-nombrados"></a>
##### Personajes nombrados

No reaparecen. Su puesto puede cubrirlo un reemplazo genérico, pero se pierden experiencia, confianza histórica, relaciones, secretos y arco personal. La unidad conserva memoria.

<a id="src-military-system-order-of-battle-and-force-catalog--19-vehículos-persistentes"></a>
#### 19. Vehículos persistentes

```text
OPERATIONAL DAMAGED IMMOBILIZED ABANDONED RECOVERABLE
CAPTURED DESTROYED SALVAGED
```

Un inmovilizado requiere ingenieros, recuperación, seguridad y piezas. Un abandonado puede cambiar de propietario. Un destruido produce restos, piezas, evidencia y pérdida permanente.

Desaparecer del motor no equivale a ser reemplazado. Primero debe resolverse su estado estratégico.

Las fuentes de reposición son reserva exterior, reparación, recuperación, captura, canibalización y producción local limitada. Un ligero puede regresar en horas o días; un APC/IFV tarda varios días; un carro requiere transporte pesado; una aeronave puede no tener reemplazo. Perder seis carros altera la campaña.

<a id="src-military-system-order-of-battle-and-force-catalog--20-guarniciones"></a>
#### 20. Guarniciones

| Nivel | Fuerza estratégica | Capacidad |
|---|---:|---|
| G0 — Presencia | 2–6 | observación |
| G1 — Puesto local | 8–16 | patrulla, carretera, automática ligera |
| G2 — Básica | 20–35 | escuadras, HMG/GMG, AT y vehículo |
| G3 — Reforzada | 40–70 | mortero, AA, vehículos y reserva |
| G4 — Fortaleza regional | 80–140 | blindados, apoyo, mando y logística |

Un G4 representa capacidad estratégica, no 140 soldados físicos simultáneos.

| Sector | Nivel habitual |
|---|---|
| Aldea | G1–G2 |
| Cruce | G1–G3 |
| Ciudad o puerto | G2–G4 |
| Aeródromo o base militar | G3–G4 |
| Nodo Helios | G2–G4 |
| Energía, montaña o radar | G1–G3 |

Toda guarnición se divide en núcleo permanente, patrulla, reserva local y refuerzo regional no presente.

<a id="src-military-system-order-of-battle-and-force-catalog--21-frente-y-fortificación"></a>
#### 21. Frente y fortificación

Al moverse el frente se recalculan dirección principal, carreteras enemigas, alturas, flancos y sectores vecinos. Pueden reorientarse AT/HMG, reservas y puestos avanzados.

Las estructuras pesadas no se teletransportan: exigen tiempo, recursos e ingenieros.

| Tier | Preparación |
|---|---|
| 0 | posiciones naturales y patrulla |
| 1 | sacos, iluminación, barrera, tienda y radio |
| 2 | parapetos, estáticas, refugio y depósito |
| 3 | capas, sanidad, reparación, AT y AA |
| 4 | mando regional, sensores, logística y reserva |

El jugador prioriza `DEFENSE`, `LOGISTICS`, `ANTI_TANK`, `ANTI_AIR`, `MEDICAL`, `INTELLIGENCE` o `CIVIL_SUPPORT`; no coloca manualmente toda la fortificación.

<a id="src-military-system-order-of-battle-and-force-catalog--22-fuerza-de-reacción-rápida"></a>
#### 22. Fuerza de reacción rápida

| Fuerza | Composición típica |
|---|---|
| Azul | Hunter, Marshall e infantería |
| Rojo | Ifrit, Marid/Kamysh e infantería |
| Verde | Strider, Gorgon/Mora e infantería |
| FIA | Offroad, quad o movilidad ligera |

Una QRF refuerza, recupera sectores, responde a sabotaje, persigue guerrilla o rescata convoyes. Comprometida en un sector, queda indisponible para otros.

<a id="src-military-system-order-of-battle-and-force-catalog--23-morteros-artillería-y-contrabatería"></a>
#### 23. Morteros, artillería y contrabatería

Los morteros necesitan equipo, observador, munición y posición. La artillería autopropulsada se limita a dos Scorcher y un Sandstorm Azul, y tres Sochor Rojo.

Toda solicitud comprueba batería, alcance, munición, comunicaciones, riesgo civil y autorización. Disparar puede revelar posición, ruta, radar y comunicaciones, provocando ataque aéreo, sabotaje, incursión, contrabatería o desplazamiento.

Las baterías pueden existir estratégicamente sin estar siempre materializadas.

<a id="src-military-system-order-of-battle-and-force-catalog--24-defensa-aérea"></a>
#### 24. Defensa aérea

La capa corta usa lanzadores personales, Titan estático y vehículos AA; la media, Cheetah, Tigris y baterías regionales; la estratégica, radar y defensa de aeropuertos o Stratis.

La superioridad aérea es temporal. Destruir, aislar, engañar o agotar defensas abre ventanas; ninguna capa concede inmunidad absoluta.

<a id="src-military-system-order-of-battle-and-force-catalog--25-operaciones-aéreas"></a>
#### 25. Operaciones aéreas

```text
status fuel damage pilotAvailability munitionState
baseSector sortieCooldown maintenance
```

```text
READY ARMING AIRBORNE RETURNING MAINTENANCE
DAMAGED GROUNDED DESTROYED
```

Cada salida requiere base utilizable, combustible, munición, piloto, meteorología, inteligencia y espacio aéreo aceptable.

Los pilotos son recursos especializados. Rescatar al piloto de una aeronave perdida conserva capacidad humana y puede generar una misión CSAR; perder ambos es una degradación mayor.

<a id="src-military-system-order-of-battle-and-force-catalog--26-guerra-naval"></a>
#### 26. Guerra naval

La flota principal permanece abstracta porque el núcleo oficial representa lanchas, SDV y sistemas costeros, no una flota navegable equivalente a la escala política.

Se simulan estratégicamente bloqueo, escolta, intercepción, bombardeo, pérdidas de transporte y presión internacional. Se materializan desembarcos, patrullas, infiltraciones, rescates, sabotajes y combate de lanchas.

<a id="src-military-system-order-of-battle-and-force-catalog--27-abastecimiento"></a>
#### 27. Abastecimiento

```text
food water fuel lightAmmo heavyAmmo missiles
parts medicine construction
```

Infantería consume principalmente comida, agua, munición y medicina. Mecanizados añaden combustible, piezas y munición pesada. Aviación tiene consumo alto y especializado. Toda guarnición consume aun sin combatir.

```text
FULL ADEQUATE LOW CRITICAL EMPTY
```

`LOW` reduce preparación, apoyo y patrullas. `CRITICAL` degrada defensa, impide ofensivas y daña moral. `EMPTY` conduce a retirada, rendición, abandono o captura de recursos.

<a id="src-military-system-order-of-battle-and-force-catalog--28-material-capturado"></a>
#### 28. Material capturado

| Clase | Tratamiento |
|---|---|
| Compatible | uso casi inmediato: alimentos, combustible, camiones y armas comunes |
| Adaptable | técnicos y tiempo: MRAP, drones y radios |
| Incompatible | uso muy limitado: misiles, piezas, cifrado y aeronaves |
| Inteligencia | puede valer más por sus datos que como arma |

Capturar un depósito no repone automáticamente todas las categorías.

<a id="src-military-system-order-of-battle-and-force-catalog--29-rendición-y-prisioneros"></a>
#### 29. Rendición y prisioneros

Una unidad puede rendirse, dispersarse, desertar, cambiar de mando, integrarse o entregar equipo según moral, aislamiento, bajas, legitimidad, trato recibido, comandante y política. Rendirse no convierte inmediatamente a una unidad Verde en aliada.

```text
CAPTURED REGISTERED INTERROGATED TRANSFERRED EXCHANGED
RELEASED ESCAPED EXECUTED MISSING
```

Los prisioneros afectan inteligencia, legitimidad, relaciones, rescates, propaganda y finales. Ejecuciones y desapariciones siempre producen consecuencias.

<a id="src-military-system-order-of-battle-and-force-catalog--30-moral-y-experiencia"></a>
#### 30. Moral y experiencia

```text
ELITE CONFIDENT STEADY SHAKEN BROKEN ROUTED
```

La moral depende de bajas, suministro, mando, victorias, descanso, civiles, aislamiento, confianza y experiencia. Modifica precisión, agresividad, obediencia, retirada, rendición y cohesión.

```text
RECRUIT TRAINED VETERAN ELITE
```

La experiencia mejora por supervivencia, operaciones, mando, descanso y entrenamiento. Una formación puede conservar su nombre y perder experiencia si reemplaza a la mayoría.

<a id="src-military-system-order-of-battle-and-force-catalog--31-materialización-y-reintegración"></a>
#### 31. Materialización y reintegración

Una fuerza se materializa cuando entra en la burbuja del jugador, participa en una misión, necesita ser observada o su destrucción debe resolverse en combate.

Puede hacerlo parcialmente: un pelotón estratégico de 32 aparece como 16 soldados, un vehículo y reserva virtual. Al terminar se reintegran supervivientes, bajas, munición, moral, experiencia y vehículos.

Dynamic Simulation optimiza grupos ya físicos; no reemplaza este sistema de representación estratégica.

<a id="src-military-system-order-of-battle-and-force-catalog--32-vertical-slice"></a>
#### 32. Vertical slice

<a id="src-military-system-order-of-battle-and-force-catalog--teatro"></a>
##### Teatro

Katalaki–Neochori–Stavros–FOB Whiskey–AAC.

<a id="src-military-system-order-of-battle-and-force-catalog--azul"></a>
##### Azul

144 efectivos estratégicos. La escena inicial dispone de AZUR-1, dos escuadras de asalto, una de apoyo, ingenieros, sanidad, logística, cuatro Hunter, dos Marshall, lanchas y un dron. Un segundo pelotón y vehículos sin descargar permanecen virtuales.

<a id="src-military-system-order-of-battle-and-force-catalog--verde"></a>
##### Verde

220–280 efectivos estratégicos:

- Katalaki: observadores y puesto;
- Neochori: G2, reservistas y vehículo;
- Stavros: G3 y refuerzo regional;
- FOB Whiskey: mando, armas pesadas, comunicaciones y 35–55 efectivos;
- AAC: seguridad, medio aéreo limitado y reserva.

Activos previstos: 4–6 Strider, dos Mora/Gorgon, un Kuma tardío, Zamak y morteros.

<a id="src-military-system-order-of-battle-and-force-catalog--secuencia-de-prueba"></a>
##### Secuencia de prueba

1. desembarco;
2. contraataque Verde;
3. convoy Azul;
4. ataque o infiltración de FOB Whiskey;
5. respuesta desde Stavros;
6. AAC y primer medio aéreo.

Valida refuerzo, guarnición, captura, recuperación, bajas, apoyo aéreo, artillería limitada y fuerzas virtuales.

<a id="src-military-system-order-of-battle-and-force-catalog--33-contrato-mínimo-de-datos"></a>
#### 33. Contrato mínimo de datos

```text
formationId factionId formationType manpower effectiveStrength
readiness morale experience supply currentSector assignedPlan
vehicleIds specialCapabilities casualties status
```

```text
vehicleId assetId className factionOwner originalOwner condition
fuel ammoState crewState sectorId assignedFormation
captured recoverable destroyed
```

<a id="src-military-system-order-of-battle-and-force-catalog--34-catálogo-lógico-de-activos"></a>
#### 34. Catálogo lógico de activos

Los sistemas solicitan un rol estable, no una clase dispersa:

```text
ASSET_BLUE_MRAP_HMG -> B_MRAP_01_hmg_F
ASSET_RED_HEAVY_TRANSPORT -> O_Truck_03_covered_F
```

El segundo rol podría resolverse a una variante Taru solo bajo un perfil opcional compatible.

```text
assetId role faction baseClass optionalClass requiredContent
crew cargo strategicCost supplyProfile replacementTime
capabilities verificationVersion
```

Toda clase debe verificarse en el `configFile` de la versión objetivo antes de publicarse. El catálogo lógico permite sustituciones, camuflaje, pruebas y mods sin migrar el estado.

<a id="src-military-system-order-of-battle-and-force-catalog--35-pruebas-obligatorias"></a>
#### 35. Pruebas obligatorias

| Área | Casos mínimos |
|---|---|
| Infantería | escuadra, pelotón, refuerzo, retirada y rendición |
| Vehículos | destrucción, abandono, captura, recuperación y reparación |
| Guarnición | creación, orientación, propietario y virtualización |
| Refuerzo | oleada válida, ruta bloqueada, convoy perdido y aeropuerto inutilizable |
| Aviación | salida, munición, pista, piloto y defensa aérea |
| Artillería | solicitud, munición, civiles y contrabatería |
| FIA | célula, concentración, dispersión y captura |
| Stratis | Verde/Meridian, civiles, operadores y asalto limitado |

También deben medirse FPS, grupos activos, tiempos del scheduler, transición visible, duplicación de activos y conservación de identidad tras guardar/cargar.

<a id="src-military-system-order-of-battle-and-force-catalog--36-balance-asimétrico"></a>
#### 36. Balance asimétrico

| Fuerza | Ventajas | Costes |
|---|---|---|
| Azul | inteligencia, movilidad, precisión, aire y anfibio | poca masa, costa/aeropuerto, política, reemplazo difícil |
| Rojo | mecanización, carros, profundidad, artillería | logística pesada, corredor, acuerdo y rebelión Verde |
| Verde | masa, terreno, bases, reservas y legitimidad | división, mando, infraestructura y apoyo pesado limitado |
| FIA | clandestinidad, población, movilidad e inteligencia humana | armamento, suministro, fragmentación y represalias |
| Meridian | secreto, tecnología, posiciones e información | aislamiento, poca fuerza, sin reserva y dependencia de Stratis |

<a id="src-military-system-order-of-battle-and-force-catalog--37-prohibiciones-de-diseño"></a>
#### 37. Prohibiciones de diseño

No se permite:

1. crear refuerzos sin reserva ni ruta;
2. reponer gratuitamente vehículos destruidos;
3. mantener toda Verde físicamente activa;
4. convertir FIA rápidamente en ejército blindado;
5. conceder aviación o artillería ilimitada;
6. ignorar tripulaciones, pilotos, mantenimiento o munición;
7. fortificar todos los sectores igual;
8. obligar a toda facción a luchar hasta morir;
9. generar patrullas infinitas;
10. usar DLC restringido como requisito oculto;
11. materializar todas las fuerzas virtuales;
12. tratar la flota abstracta como vehículo ordinario;
13. reaparecer personajes nombrados.

<a id="src-military-system-order-of-battle-and-force-catalog--38-principios-vinculantes"></a>
#### 38. Principios vinculantes

1. La escala estratégica supera la física.
2. Cada baja reduce una reserva real.
3. Personajes y vehículos importantes conservan identidad.
4. Suministro, rutas, bases y mantenimiento limitan el combate.
5. Verde comienza fuerte pero dividido; Azul y Rojo, limitados.
6. FIA crece por población, política y capturas, pagando visibilidad.
7. Meridian protege; no conquista Altis.
8. Guarniciones y orientación defensiva son automáticas.
9. La QRF no puede estar en dos lugares.
10. Reservistas, prisioneros, pilotos y técnicos poseen consecuencias.
11. Los paquetes opcionales no alteran canon ni guardado.
12. Toda fuerza materializada puede auditarse desde el estado persistente.

<a id="src-military-system-order-of-battle-and-force-catalog--39-fuentes-técnicas-oficiales"></a>
#### 39. Fuentes técnicas oficiales

- [DLC Restrictions — Bohemia Interactive Community](https://community.bohemia.net/wiki/Arma_3%3A_DLC_Restrictions)
- [CfgGroups — Bohemia Interactive Community](https://community.bohemia.net/wiki/Arma_3%3A_CfgGroups)
- [Dynamic Simulation — Bohemia Interactive Community](https://community.bohemia.net/wiki/Arma_3_Dynamic_Simulation)

Estas fuentes validan restricciones de contenido, plantillas oficiales y comportamiento del motor. Las cifras, identidades y reglas de campaña de este documento son decisiones canónicas propias de *Islas Fracturadas*.

<a id="src-military-system-order-of-battle-and-force-catalog--40-definición-final"></a>
#### 40. Definición final

Cada vehículo destruido llegó de algún lugar; cada refuerzo cruzó una ruta; cada guarnición consume; cada baja deja un puesto que alguien debe ocupar.

La escala estratégica hace que la guerra parezca nacional. La escala táctica hace que cada combate siga siendo personal.
