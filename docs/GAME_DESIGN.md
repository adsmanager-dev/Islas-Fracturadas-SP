# Islas Fracturadas — Diseño general

> Índice maestro de la documentación de diseño. El proyecto se encuentra en fase de canon y diseño conceptual.

## Documentos principales

| Documento | Contenido |
|---|---|
| [STORY_BIBLE.md](STORY_BIBLE.md) | Canon narrativo principal, premisa, facciones, actos y finales |
| [STRATEGIC_CAMPAIGN_SYSTEM.md](STRATEGIC_CAMPAIGN_SYSTEM.md) | Territorio, logística, recursos, IA, relaciones, simulación y desenlaces |
| [NARRATIVE_ACTS_AND_MISSION_SYSTEM.md](NARRATIVE_ACTS_AND_MISSION_SYSTEM.md) | Arquitectura híbrida Altis/Stratis, actos, misiones, persistencia y vertical slice |
| [HELIOS_ARGOS.md](HELIOS_ARGOS.md) | Naturaleza, validación, influencia y misterio de Helios/Argos |
| [HELIOS_ORIGIN_PHAROS_AND_ARGOS_DOSSIER.md](HELIOS_ORIGIN_PHAROS_AND_ARGOS_DOSSIER.md) | Dossier secreto de autor: Vardis, HELIOS-0, PHAROS, S-26, Meridian y dirección real de Argos |
| [LAST_72_HOURS_CHRONOLOGY.md](LAST_72_HOURS_CHRONOLOGY.md) | Cronología secreta de UMBRAL, Asterión, las dos invasiones y el Día Cero |
| [INVESTIGATION_REVELATION_MATRIX.md](INVESTIGATION_REVELATION_MATRIX.md) | Documento 2/14: líneas investigativas, evidencias, autenticación, cadena de custodia, conclusiones, acceso a Stratis y comparación dual |
| [CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md](CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md) | Red canónica de personajes, secretos, lealtades, rupturas, sustituciones y finales relacionales |
| [PLAYER_UNIT_AND_PROGRESSION.md](PLAYER_UNIT_AND_PROGRESSION.md) | Unidad protagonista, cooperativo, rangos, personajes y progresión |
| [INVADING_FORCES.md](INVADING_FORCES.md) | Fuerza Azul, Fuerza Roja, doctrinas, mandos y campañas |
| [NATIVE_ACTORS_AND_SECTORS.md](NATIVE_ACTORS_AND_SECTORS.md) | Panorama de actores nativos y variables mínimas de sectores |
| [GOVERNMENT_AND_GREEN_FORCES.md](GOVERNMENT_AND_GREEN_FORCES.md) | República, Protocolo Asterión, Gobierno y Fuerza Verde |
| [FIA_GUERRILLAS_AND_INSURGENCY.md](FIA_GUERRILLAS_AND_INSURGENCY.md) | FIA, guerrillas, radicalización y fuerzas clandestinas |
| [CIVILIANS_MUNICIPALITIES_AND_SOCIAL_SYSTEMS.md](CIVILIANS_MUNICIPALITIES_AND_SOCIAL_SYSTEMS.md) | Comunidades, municipios, desplazados, contrabando y reconstrucción |
| [ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md](ALTIS_GEOGRAPHY_AND_SECTOR_MAP.md) | Geografía operacional, 38 sectores, corredores, desembarcos, infraestructura y vertical slice |
| [ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md](ALTIS_STRATIS_HISTORY_CULTURE_AND_ECONOMY.md) | Continuidad alternativa, historia, cultura, economía, regiones e identidad civil de ambas islas |
| [MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md](MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md) | Matriz determinista de finales, Helios, Argos, nación, módulos y epílogos |
| [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md) | Contrato autoritativo de estado, persistencia, red, transferencia, validación y pruebas |
| [STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md](STRATEGIC_AI_AND_CHAIN_OF_COMMAND.md) | Percepción, planes, reservas, órdenes, cadenas de mando, errores y ejecución táctica |
| [MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md](MILITARY_SYSTEM_ORDER_OF_BATTLE_AND_FORCE_CATALOG.md) | Escalas, órdenes de batalla, activos, oleadas, guarniciones, bajas, suministros y materialización |
| [TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md](TERRITORIAL_SECTOR_FRONT_AND_CONSTRUCTION_SYSTEM.md) | Tipos y niveles de sector, profundidad del frente, módulos, construcción, memoria defensiva y captura |
| [TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md](TECHNICAL_3DEN_MODULE_AND_COMPOSITION_CATALOG.md) | Costes, objetos, variantes, anclajes, orientación, daño y validación de composiciones |
| [ECONOMIC_AND_LOGISTICS_SYSTEM.md](ECONOMIC_AND_LOGISTICS_SYSTEM.md) | Recursos localizados, producción, trabajo, rutas, convoyes, consumo, mantenimiento y reconstrucción |
| [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](BLUE_RED_CAMPAIGN_ARCHITECTURE.md) | Documento 1/14: estructura Azul/Roja, actos, puertas, misiones, Actos I y vertical slice narrativo |
| [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md) | Documento 3/14: necesidades causales, familias, plantillas, eventos, transformación, resolución externa, ritmo y anti-repetición |
| [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md) | Documento 4/14: población, municipios, servicios, autoridad, legitimidad, estabilidad, desplazamiento y política |

## Serie rectora 1/14–14/14

- [x] **1/14 — Arquitectura de campañas Azul y Roja**
- [x] **2/14 — Revelaciones, evidencias e investigación de Argos**
- [x] **3/14 — Misiones dinámicas y eventos emergentes**
- [x] **4/14 — Sistema civil, municipal, político y de estabilidad**
- [ ] **5/14 — FIA, insurgencia y guerra clandestina**
- [ ] **6/14 — Helios, inteligencia y niebla de guerra**
- [ ] **7/14 — Sistema táctico y virtualización de fuerzas**
- [ ] **8/14 — Progresión, autoridad y desbloqueos del jugador**
- [ ] **9/14 — Interfaz estratégica y experiencia del jugador**
- [ ] **10/14 — Arquitectura técnica maestra de SQF**
- [ ] **11/14 — Guía 3DEN y validación geográfica definitiva**
- [ ] **12/14 — Diálogos, radio, briefings y cinematografía**
- [ ] **13/14 — Pruebas, rendimiento y balance**
- [ ] **14/14 — Plan de implementación y producción**

## Pilares del diseño

1. Solo Azul o Rojo es jugable en cada campaña.
2. La guerra continúa mediante IA aunque el jugador esté en otra operación.
3. Control militar, administrativo, logístico, informativo, político y clandestino son dimensiones distintas.
4. Helios recomienda e influye; no controla directamente a las personas.
5. La logística, información, legitimidad y población tienen el mismo peso estratégico que el territorio.
6. Las unidades, personajes, vehículos, relaciones y comunidades conservan memoria.
7. La campaña individual se diseña para una futura adaptación cooperativa de un solo bando.
8. La victoria militar no garantiza una victoria política, civil o estratégica.
9. La geografía real de Altis determina sectores y corredores; no se utiliza una cuadrícula uniforme.
10. Los personajes poseen lealtades múltiples; toda ruptura debe tener antecedentes, señales y memoria.
11. El Día Cero es el 24 de junio de 2042 y la continuidad diverge del Armaverse después del alto el fuego de 2030.
12. La economía y la identidad regional determinan cómo funciona un sector, no solo quién lo ocupa.
13. El desenlace combina estado acumulado y decisión final viable; Stratis no borra la campaña.
14. Una única estructura autoritativa conserva consecuencias mediante IDs estables, eventos, snapshots y migraciones.
15. Los comandantes deciden con información limitada; la IA nativa ejecuta tácticamente planes estratégicos propios.
16. No existen soldados, vehículos, apoyos ni reemplazos estratégicos infinitos.
17. Tipo, estructura, fortificación, profundidad y estabilidad territorial son dimensiones independientes.
18. Toda construcción física procede de una composición validada y conserva identidad lógica al desmaterializarse.
19. Ningún recurso es abstractamente global: posee ubicación, propietario, controlador, capacidad de uso y ruta.
20. Las campañas comparten hechos canónicos, pero sus actos, conflictos, logística y experiencia no son intercambiables.

## Próximo documento previsto

Documento 5/14 — Sistema definitivo de FIA, insurgencia y guerra clandestina.
