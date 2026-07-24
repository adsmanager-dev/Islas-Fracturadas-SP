## Lista maestra de documentos rectores

* [x] **1/14 — Arquitectura de campañas Azul y Roja**
* [x] **2/14 — Revelaciones, evidencias e investigación de Argos**
* [x] **3/14 — Misiones dinámicas y eventos emergentes**
* [x] **4/14 — Sistema civil, municipal, político y de estabilidad** — desarrollado a continuación
* [ ] **5/14 — FIA, insurgencia y guerra clandestina**
* [ ] **6/14 — Helios, inteligencia y niebla de guerra**
* [ ] **7/14 — Sistema táctico y virtualización de fuerzas**
* [ ] **8/14 — Progresión, autoridad y desbloqueos del jugador**
* [ ] **9/14 — Interfaz estratégica y experiencia del jugador**
* [ ] **10/14 — Arquitectura técnica maestra de SQF**
* [ ] **11/14 — Guía 3DEN y validación geográfica**
* [ ] **12/14 — Diálogos, radio, briefings y cinematografía**
* [ ] **13/14 — Pruebas, rendimiento y balance**
* [ ] **14/14 — Plan de implementación y producción**

# ISLAS FRACTURADAS

## Documento 4/14 — Sistema civil, municipal, político y de estabilidad

**Versión:** 1.0
**Clasificación:** documento rector de población, legitimidad, gobierno y consecuencias civiles
**Campañas:** Fuerza Azul y Fuerza Roja
**Territorios:** Altis y Stratis
**Motor:** Arma 3 2.18
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando
**Estado:** canon previo a implementación

> **Jerarquía documental:** este Documento 4/14 gobierna población estratégica, necesidades, servicios, administración, autoridad, legitimidad, estabilidad, desplazamiento, protestas, detenciones y memoria civil. El catálogo narrativo de comunidades y actores se conserva en [CIVILIANS_MUNICIPALITIES_AND_SOCIAL_SYSTEMS.md](CIVILIANS_MUNICIPALITIES_AND_SOCIAL_SYSTEMS.md); la conversión de demandas en contenido jugable se rige por [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md); y el estado autoritativo, por [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).

---

# 1. Propósito

Este documento define cómo la población de Altis y Stratis:

* reacciona a la invasión;
* interpreta a cada facción;
* obedece, coopera o resiste;
* mantiene o pierde servicios;
* conserva autoridades locales;
* organiza protestas, huelgas y evacuaciones;
* genera apoyo a FIA;
* colabora con Fuerza Verde;
* acepta o rechaza a Azul y Rojo;
* responde a requisiciones, arrestos y daños;
* participa en la reconstrucción;
* influye en la estabilidad;
* modifica la guerra territorial;
* condiciona los finales políticos.

También establece cómo una fuerza pasa de:

```text
capturar un sector
→ controlar sus accesos
→ asegurar infraestructura
→ reconocer o sustituir autoridades
→ restablecer servicios
→ obtener obediencia
→ construir legitimidad
→ gobernar realmente
```

## Principio central

> Controlar militarmente una localidad significa poder entrar, patrullar y defenderla.

> Gobernarla significa conseguir que sus trabajadores, médicos, autoridades, transportistas y habitantes continúen haciendo funcionar el lugar.

---

# 2. Decisión arquitectónica principal

El estado civil no se representará mediante una única barra de “apoyo”.

Cada sector tendrá dimensiones independientes:

```text
militaryControl
politicalAuthority
administrativeCapacity
civilianTrust
civilianSupport
civilianObedience
civilianDependency
fear
grievance
communityCohesion
radicalization
stability
serviceAvailability
economicActivity
displacement
```

## Ejemplo

Una ciudad puede presentar:

```text
Control militar Azul: 88
Obediencia civil a Azul: 74
Confianza civil en Azul: 31
Apoyo civil a Azul: 18
Dependencia civil de Azul: 69
Estabilidad: 52
```

Interpretación:

* Azul domina la ciudad;
* la población cumple órdenes;
* depende de suministros Azules;
* no confía ni apoya realmente a la fuerza ocupante;
* una crisis puede provocar protestas, sabotaje o apoyo a FIA.

---

# 3. Diferencia entre población física y población estratégica

La población estratégica representa miles de personas.

La población física será una selección limitada utilizada para:

* ambiente;
* conversaciones;
* evacuaciones;
* protestas;
* hospitales;
* mercados;
* eventos;
* misiones.

## Regla

No se materializarán decenas de miles de civiles.

Cada civil físico puede representar:

* un individuo concreto;
* una familia;
* un grupo social;
* una profesión;
* una parte de la comunidad.

## Persistencia

Los civiles narrativos y testigos importantes tendrán identidad propia.

Los civiles ambientales serán generados según el estado estratégico del sector.

---

# 4. Distribución poblacional estratégica

La población permanente estimada será:

```text
Altis: aproximadamente 63.500
Stratis: aproximadamente 3.500
Total insular permanente: aproximadamente 67.000
```

Además existirá una diáspora de:

```text
35.000–45.000 personas
```

La diáspora podrá influir mediante:

* financiación;
* presión internacional;
* regreso;
* voluntarios;
* medios;
* reconstrucción.

## Regla

Las cifras son canónicas para el proyecto, no una afirmación sobre el canon oficial de Arma 3.

---

# 5. Categorías de población

Cada sector dividirá su población en grupos relevantes.

## 5.1 Residentes permanentes

Personas vinculadas históricamente al sector.

## 5.2 Trabajadores desplazados temporalmente

Viven en otro lugar por razones laborales o de seguridad.

## 5.3 Desplazados internos

Abandonaron su sector, pero permanecen en las islas.

## 5.4 Refugiados o evacuados externos

Salieron de Altis o Stratis.

## 5.5 Retornados

Miembros de la diáspora o evacuados que regresan.

## 5.6 Personal institucional

* médicos;
* profesores;
* funcionarios;
* operadores;
* técnicos;
* policías.

## 5.7 Trabajadores esenciales

* conductores;
* agricultores;
* estibadores;
* electricistas;
* personal de agua;
* mecánicos;
* operadores aeroportuarios.

## 5.8 Personas movilizadas

* reservistas;
* milicias;
* FIA;
* voluntarios;
* reclutas.

---

# 6. Perfil civil del sector

Cada sector tendrá:

```text
populationTotal
populationPresent
populationDisplacedOut
populationDisplacedIn
workingPopulation
essentialWorkers
mobilizedPopulation
civilianCasualties
missingPersons
detainedPersons
returnedPopulation
```

## Ejemplo

```sqf
CIV_ALT_W_KAVALA = createHashMapFromArray [
    ["sectorId", "ALT_W_KAVALA_CITY"],
    ["populationTotal", 9200],
    ["populationPresent", 7100],
    ["populationDisplacedOut", 2600],
    ["populationDisplacedIn", 500],
    ["workingPopulation", 3100],
    ["essentialWorkers", 720],
    ["mobilizedPopulation", 240],
    ["civilianCasualties", 85],
    ["missingPersons", 110],
    ["detainedPersons", 64],
    ["returnedPopulation", 35]
];
```

---

# 7. Necesidades civiles

Las necesidades básicas utilizarán escala:

```text
0 = colapso total
100 = completamente cubierto
```

## Necesidades

```text
food
water
shelter
power
medicalCare
security
transport
employment
communications
education
sanitation
legalProtection
```

## Prioridad humana

Las primeras seis determinan supervivencia inmediata:

1. agua;
2. alimentos;
3. refugio;
4. medicina;
5. seguridad;
6. saneamiento.

Las restantes determinan recuperación y legitimidad.

---

# 8. Estado de servicios

Cada servicio tendrá:

```text
capacity
currentAvailability
staffing
infrastructureCondition
resourceSupply
security
accessibility
```

## Ejemplo: hospital

```text
Infraestructura: 75
Personal: 42
Medicina: 61
Energía: 38
Agua: 70
Seguridad: 55
Capacidad efectiva: 39
```

## Principio

Un edificio intacto no equivale a un servicio funcional.

---

# 9. Confianza

La confianza responde:

> ¿Cree la población que este actor cumplirá sus promesas y actuará de forma predecible?

Factores positivos:

* protección;
* compensación;
* transparencia;
* cumplimiento;
* disciplina;
* servicios;
* respeto municipal.

Factores negativos:

* promesas rotas;
* detenciones;
* desapariciones;
* saqueo;
* propaganda falsa;
* daños;
* órdenes contradictorias.

---

# 10. Apoyo

El apoyo responde:

> ¿Desea la población que este actor tenga éxito político o militar?

Puede existir confianza sin apoyo.

Ejemplo:

* la población cree que Rojo mantendrá el orden;
* no desea que Rojo permanezca.

Puede existir apoyo sin confianza.

Ejemplo:

* una comunidad apoya a FIA;
* no confía en que pueda gobernar eficazmente.

---

# 11. Obediencia

La obediencia responde:

> ¿Cumple la población las órdenes?

Puede surgir de:

* legitimidad;
* costumbre;
* confianza;
* miedo;
* dependencia;
* coerción.

## Ejemplo

```text
Obediencia: 85
Confianza: 20
Apoyo: 12
Miedo: 78
```

Representa control coercitivo estable solo a corto plazo.

---

# 12. Dependencia

La dependencia responde:

> ¿Cuánto necesita la población a este actor para sobrevivir o acceder a servicios?

Puede aumentar por:

* ayuda;
* control de alimentos;
* empleo;
* medicina;
* combustible;
* seguridad.

## Riesgo

Una fuerza puede crear dependencia deliberadamente.

Eso puede mejorar obediencia y reducir legitimidad futura.

---

# 13. Miedo

El miedo representa:

* temor a combate;
* temor a represalias;
* temor a detención;
* temor a FIA;
* temor a fuerzas extranjeras;
* temor al colapso.

## Efectos

Miedo moderado:

* aumenta cautela;
* reduce actividad visible.

Miedo alto:

* reduce denuncias;
* aumenta huida;
* reduce cooperación;
* puede aumentar obediencia.

Miedo extremo:

* genera pánico;
* desplazamiento;
* violencia;
* colapso institucional.

---

# 14. Agravio

El agravio registra memoria política y emocional acumulada.

Causas:

* muerte;
* desaparición;
* expropiación;
* detención;
* destrucción;
* humillación;
* desigualdad;
* ocupación.

## Diferencia frente al miedo

El miedo puede reducir la resistencia inmediata.

El agravio puede aumentarla a largo plazo.

---

# 15. Cohesión comunitaria

Representa la capacidad de una comunidad para actuar colectivamente.

Cohesión alta puede producir:

* ayuda mutua;
* resistencia organizada;
* huelga;
* evacuación eficiente;
* negociación fuerte.

Cohesión baja puede producir:

* saqueo;
* criminalidad;
* fragmentación;
* informantes;
* colapso.

## Principio

Una comunidad cohesionada no es automáticamente aliada.

Puede organizar cooperación o resistencia con igual eficacia.

---

# 16. Radicalización

La radicalización representa la disposición a aceptar:

* violencia política;
* insurgencia;
* represalias;
* autoridad extrema;
* ruptura institucional.

Factores:

```text
agravio
miedo
represión
desempleo
propaganda
bajas civiles
detenciones
falta de representación
actividad FIA
actividad Argos
```

## Regla

La pobreza por sí sola no genera automáticamente insurgencia.

Necesita:

* narrativa;
* organización;
* redes;
* oportunidad;
* liderazgo.

---

# 17. Estabilidad

La estabilidad mide la capacidad de un sector para funcionar sin crisis inmediata.

## Componentes

```text
security
services
administration
economicActivity
communityCohesion
politicalClarity
lowDisplacement
lowViolence
```

## Estados

```text
COLLAPSED
CHAOTIC
VOLATILE
FRAGILE
STABLE
CONSOLIDATED
```

---

# 18. Cálculo conceptual de estabilidad

```text
stability =
security
+ serviceAvailability
+ administrativeCapacity
+ economicActivity
+ communityCohesion
+ politicalClarity
- fear
- grievance
- radicalization
- displacementPressure
- activeViolence
```

Los pesos variarán por sector.

## Regla

La estabilidad no equivale a justicia.

Un régimen coercitivo puede ser estable.

Un sistema legítimo puede ser temporalmente frágil.

---

# 19. Autoridad política

Cada sector tendrá:

```text
formalAuthority
recognizedAuthority
effectiveAuthority
militaryAuthority
municipalAuthority
clandestineAuthority
```

## Formal

Quien legalmente debería gobernar.

## Reconocida

Quien la población considera legítimo.

## Efectiva

Quien realmente administra.

## Militar

Quien controla por fuerza.

## Municipal

Alcalde, consejo o autoridad local.

## Clandestina

FIA, redes, contrabandistas o Argos.

---

# 20. Estados de gobierno sectorial

## G0 — Ausencia de autoridad

* caos;
* huida;
* saqueo;
* múltiples actores.

## G1 — Administración militar

La fuerza ocupante gestiona directamente:

* seguridad;
* accesos;
* distribución.

## G2 — Administración municipal supervisada

El municipio continúa bajo control militar.

## G3 — Autoridad local cooperadora

Existe legitimidad y capacidad.

## G4 — Gobierno regional funcional

Servicios, tribunales y administración operan.

## G5 — Integración política

El sector forma parte estable de un orden político reconocido.

---

# 21. Modos de administración

# 21.1 Ocupación militar directa

Ventajas:

* control rápido;
* órdenes claras;
* seguridad inicial.

Desventajas:

* poca legitimidad;
* alto consumo de tropas;
* resistencia;
* dependencia de oficiales extranjeros.

---

# 21.2 Gobierno municipal supervisado

Ventajas:

* continuidad;
* trabajadores;
* conocimiento local;
* menor coste militar.

Desventajas:

* riesgo de doble lealtad;
* corrupción;
* infiltración FIA;
* autoridad limitada.

---

# 21.3 Administración conjunta

Actores:

* fuerza militar;
* municipio;
* Verde;
* FIA cívica;
* Gobierno.

Ventajas:

* mayor legitimidad;
* reconciliación.

Desventajas:

* decisiones lentas;
* conflictos;
* reparto de poder.

---

# 21.4 Autoridad gubernamental restaurada

El Gobierno vuelve a administrar.

Depende de:

* legitimidad nacional;
* seguridad;
* funcionarios;
* reconocimiento.

---

# 21.5 Consejo de emergencia

Usado cuando:

* el Gobierno colapsa;
* las autoridades locales sobreviven;
* varias facciones acuerdan continuidad.

---

# 21.6 Administración FIA

Puede tomar forma de:

* consejo cívico;
* comité revolucionario;
* mando militar;
* coalición municipal.

La diferencia Markou–Kallas será decisiva.

---

# 21.7 Junta militar Verde

Puede surgir si:

* Verde controla sectores;
* el Gobierno colapsa;
* Varos, Sarris o Daskal toman autoridad.

---

# 22. Autoridades municipales

Cada municipio tendrá personajes o cargos persistentes.

## Datos

```text
municipalityId
sectorIds
mayorCharacterId
councilState
administrativeCapacity
publicTrust
factionRelations
essentialWorkerNetwork
politicalPosition
securityRequests
civilianDemands
```

## Funciones

* distribución;
* registros;
* servicios;
* trabajadores;
* mediación;
* evacuación;
* legitimidad;
* comunicación.

---

# 23. Alcaldes y consejos

Un alcalde no controlará automáticamente toda la comunidad.

Puede:

* conservar autoridad;
* perder legitimidad;
* colaborar;
* resistir;
* ser sustituido;
* morir;
* exiliarse.

## Consejo municipal

Puede contener:

* comerciantes;
* médicos;
* religiosos;
* sindicatos;
* familias;
* veteranos;
* FIA;
* funcionarios.

## Regla

Las decisiones municipales deben reflejar coaliciones, no una única barra personal.

---

# 24. Demandas civiles

Las comunidades pueden solicitar:

* agua;
* alimentos;
* electricidad;
* apertura de carretera;
* liberación de detenidos;
* retirada de armas;
* compensación;
* elecciones;
* protección;
* investigación;
* entierro;
* acceso a tierras;
* devolución de propiedades.

## Prioridad

Cada sector tendrá hasta:

```text
1–3 demandas activas
```

No se mostrarán todas las necesidades como misiones.

---

# 25. Satisfacción de demandas

Una demanda puede resolverse mediante:

* recursos;
* negociación;
* reparación;
* cambio de política;
* compensación;
* fuerza.

## Ejemplo

Demanda:

> Retirar el puesto de control del mercado.

Opciones:

* retirarlo;
* moverlo;
* limitar horario;
* mantenerlo;
* reforzarlo.

Cada opción modifica:

* seguridad;
* economía;
* confianza;
* riesgo insurgente.

---

# 26. Promesas

Las promesas serán eventos persistentes.

```text
PROMISE_MADE
PROMISE_FULFILLED
PROMISE_DELAYED
PROMISE_BROKEN
PROMISE_IMPOSSIBLE
```

## Ejemplos

* restablecer agua;
* liberar detenidos;
* compensar daños;
* no usar artillería;
* permitir elecciones.

## Importancia

La memoria civil debe recordar:

* quién prometió;
* cuándo;
* resultado;
* explicación.

---

# 27. Seguridad civil

La seguridad se divide en:

## Seguridad militar

Protección contra ataques externos.

## Seguridad pública

Protección contra:

* robos;
* violencia;
* saqueo;
* represalias;
* milicias.

## Seguridad política

Protección contra:

* detenciones arbitrarias;
* desapariciones;
* coerción;
* persecución.

## Regla

Una ciudad puede estar segura frente al enemigo y ser peligrosa para sus propios habitantes.

---

# 28. Policía y gendarmería

La policía local podrá:

* continuar;
* desarmarse;
* integrarse;
* dividirse;
* colaborar con FIA;
* servir al Gobierno;
* ser sustituida.

## Capacidades

* patrulla;
* investigación;
* custodia;
* control civil;
* tráfico;
* protección municipal.

## Limitaciones

No debe utilizarse como infantería militar genérica salvo colapso.

---

# 29. Justicia y detención

La campaña distinguirá:

```text
detention
arrest
internment
prisonerOfWar
disappearance
execution
release
exchange
```

## Legitimidad

Depende de:

* causa;
* registro;
* trato;
* duración;
* acceso legal;
* destino.

## Riesgo

Detener a combatientes reales puede mejorar seguridad.

Las detenciones indiscriminadas pueden:

* aumentar radicalización;
* producir falsos testimonios;
* fortalecer FIA.

---

# 30. Registro de detenidos

Cada sector tendrá:

```text
detainedCivilians
detainedCombatants
unregisteredDetainees
missingAfterDetention
releasedDetainees
```

## Regla

Una persona detenida no puede desaparecer administrativamente sin generar:

* familia;
* rumor;
* agravio;
* posible evidencia PHAROS o Argos.

---

# 31. Reglas de uso de fuerza

Las políticas de ocupación pueden definirse como perfiles.

## Restrictiva

* verificación;
* reglas estrictas;
* menor daño;
* mayor riesgo militar.

## Estándar

* equilibrio.

## Agresiva

* registros;
* detenciones;
* fuego rápido;
* mayor seguridad inmediata;
* mayor agravio.

## Coercitiva

* toque de queda;
* castigos;
* control total;
* alto consumo político.

---

# 32. Toque de queda

Puede:

* reducir movimiento nocturno;
* dificultar FIA;
* disminuir economía;
* aumentar miedo;
* generar enfrentamientos.

## Variables

```text
curfewStart
curfewEnd
exceptions
enforcementLevel
duration
```

## Regla

Un toque de queda temporal tras un ataque no produce el mismo efecto que uno permanente.

---

# 33. Puestos de control

Los puestos de control afectan:

* seguridad;
* transporte;
* comercio;
* confianza;
* inteligencia;
* insurgencia.

## Factores

* número;
* ubicación;
* disciplina;
* tiempo de espera;
* registros;
* sobornos;
* trato.

## Principio

Más puestos no garantizan mayor control.

Pueden saturar rutas y multiplicar fricciones.

---

# 34. Requisiciones civiles

La requisición se integra con la política.

## Tipos

* vivienda;
* vehículo;
* combustible;
* comida;
* edificio;
* trabajo.

## Registro

```text
requisitionId
resourceType
amount
owner
compensation
authority
duration
returned
damage
```

## Consecuencias

Dependen de:

* necesidad;
* compensación;
* trato;
* duración;
* desigualdad.

---

# 35. Propiedad y restitución

Durante la guerra pueden cambiar:

* viviendas;
* tierras;
* empresas;
* vehículos;
* edificios.

## Problemas

* ocupación;
* abandono;
* documentos perdidos;
* propietarios muertos;
* ventas coercitivas;
* retornados.

## Misiones y epílogos

Los conflictos de propiedad pueden determinar:

* estabilidad;
* regreso;
* apoyo político;
* corrupción.

---

# 36. Desplazamiento

Los desplazados se moverán estratégicamente entre sectores.

## Causas

* combate;
* hambre;
* miedo;
* evacuación;
* represión;
* destrucción;
* reclutamiento forzado.

## Destinos

* ciudad;
* sector seguro;
* campamento;
* puerto;
* exterior;
* familia.

---

# 37. Presión de desplazados

Cada sector receptor tendrá:

```text
housingPressure
foodPressure
medicalPressure
employmentPressure
securityPressure
socialTension
```

## Efectos positivos posibles

* trabajadores;
* redes;
* testigos;
* cooperación.

## Efectos negativos

* escasez;
* tensión;
* enfermedades;
* radicalización.

---

# 38. Campamentos de desplazados

No se crearán automáticamente como grandes campos permanentes.

Pueden existir:

* refugios escolares;
* iglesias;
* almacenes;
* campamentos temporales;
* viviendas familiares.

## Riesgos

* enfermedad;
* infiltración;
* explotación;
* reclutamiento;
* ataques;
* dependencia.

---

# 39. Evacuación

Una evacuación requiere:

* transporte;
* destino;
* seguridad;
* registro;
* alimentos;
* tiempo.

## Tipos

* preventiva;
* voluntaria;
* obligatoria;
* militar;
* clandestina.

## Consecuencia política

Una evacuación obligatoria puede salvar vidas y aun destruir confianza.

---

# 40. Retorno

El regreso depende de:

* seguridad;
* vivienda;
* servicios;
* propiedad;
* empleo;
* confianza.

## Regla

Capturar una ciudad no hace que toda la población regrese.

---

# 41. Bajas civiles

Las bajas se registrarán por:

```text
cause
responsibleActor
perceivedResponsibleActor
location
time
witnesses
publicKnowledge
investigationState
```

## Diferencia

El responsable real y el percibido pueden ser distintos.

Argos, FIA o propaganda pueden explotar esa diferencia.

---

# 42. Investigación de incidentes

Las bajas civiles importantes pueden generar:

* investigación;
* protesta;
* represalia;
* sanción;
* encubrimiento;
* evidencia;
* ruptura de alianza.

## Resultado

No todo incidente se resuelve inmediatamente.

Puede influir varios actos después.

---

# 43. Daño civil e infraestructura

El daño se divide en:

```text
housingDamage
serviceDamage
economicDamage
culturalDamage
environmentalDamage
```

## Cultural

Incluye:

* monumentos;
* archivos;
* iglesias;
* cementerios;
* lugares históricos.

## Importancia

Puede generar agravios superiores a su valor militar.

---

# 44. Protestas

Una protesta surge de:

* demanda;
* organización;
* agravio;
* oportunidad;
* liderazgo.

## Tamaños

```text
SMALL
LOCAL
MASS
REGIONAL
```

## Estados

```text
PEACEFUL
TENSE
CONFRONTATIONAL
RIOT
SUPPRESSED
NEGOTIATED
DISPERSED
```

---

# 45. Respuestas a protestas

## Negociar

* lento;
* puede conceder legitimidad;
* puede producir compromiso.

## Ignorar

* puede desinflarse;
* puede crecer.

## Dispersar

* restaura movilidad;
* aumenta agravio.

## Arrestar líderes

* desorganiza;
* puede radicalizar.

## Resolver causa

* coste de recursos;
* mejora duradera.

## Infiltrar

* inteligencia;
* riesgo político.

---

# 46. Huelgas

Sectores con trabajadores esenciales pueden detener:

* puertos;
* energía;
* transporte;
* hospitales;
* aeropuertos.

## Causas

* salarios;
* requisición;
* seguridad;
* ocupación;
* detenciones;
* muerte de trabajadores.

## Respuestas

* negociar;
* sustituir;
* militarizar;
* arrestar;
* conceder.

---

# 47. Mercados y comercio

Los mercados representan:

* alimentos;
* transporte;
* información;
* empleo;
* normalidad.

## Estado

```text
CLOSED
RESTRICTED
BLACK_MARKET_DOMINANT
LIMITED
OPEN
THRIVING
```

## Impacto

Un mercado abierto mejora:

* actividad;
* confianza;
* información civil.

También facilita:

* contrabando;
* infiltración;
* espionaje.

---

# 48. Información civil

Los civiles proporcionan inteligencia según:

* confianza;
* miedo;
* apoyo;
* contacto;
* compensación.

## Tipos

* movimientos;
* escondites;
* rumores;
* rutas;
* personas;
* sabotaje;
* abusos.

## Riesgo

La información puede ser:

* auténtica;
* exagerada;
* vengativa;
* comprada;
* manipulada.

---

# 49. Denuncias

Una denuncia puede originarse por:

* lealtad;
* miedo;
* rivalidad;
* recompensa;
* agravio.

## Regla

El sistema no debe asumir que todo informante es fiable.

---

# 50. Colaboración

La colaboración puede ser:

```text
VOLUNTARY
PRAGMATIC
ECONOMIC
COERCED
SECRET
PUBLIC
```

## Ejemplo

Un alcalde puede colaborar públicamente con Azul para mantener servicios y ayudar secretamente a FIA.

---

# 51. Resistencia civil

No toda resistencia es armada.

Puede incluir:

* huelga;
* ocultamiento;
* información falsa;
* boicot;
* protesta;
* ayuda a fugitivos;
* sabotaje menor;
* rechazo administrativo.

---

# 52. Legitimidad

La legitimidad es una evaluación social y política.

Fuentes:

* legalidad;
* historia;
* servicios;
* representación;
* comportamiento;
* soberanía;
* resultados.

## Dimensiones

```text
legalLegitimacy
proceduralLegitimacy
performanceLegitimacy
nationalLegitimacy
localLegitimacy
internationalLegitimacy
```

---

# 53. Legalidad frente a legitimidad

Rojo puede tener una base legal parcial mediante Asterión y baja legitimidad local.

Azul puede carecer de invitación formal y obtener legitimidad local al proteger comunidades.

FIA puede tener apoyo local y poca legalidad estatal.

Verde puede poseer legitimidad nacional y baja confianza en una región.

---

# 54. Reconocimiento político

Los sectores pueden reconocer:

* Gobierno de Kouris;
* Pallis;
* mando militar Verde;
* administración Azul;
* administración Roja;
* FIA;
* consejo municipal;
* coalición.

## Regla

El reconocimiento no cambia instantáneamente por control militar.

---

# 55. Estado nacional del Gobierno

```text
governmentLegitimacy
constitutionalAuthority
administrativeCapacity
securityControl
regionalRecognition
foreignDependency
publicConfidence
```

## Estados posibles

```text
FUNCTIONAL
EMERGENCY
CONTESTED
FRAGMENTED
DISPLACED
COLLAPSED
TRANSITIONAL
```

---

# 56. Kouris

Puede ser visto como:

* dirigente que pidió ayuda;
* protector del Estado;
* responsable de dependencia Roja;
* traidor;
* víctima de Argos.

Su destino depende de:

* Asterión;
* pruebas;
* Gobierno;
* resultado militar.

---

# 57. Pallis

Representa:

* continuidad constitucional;
* autoridad limitada;
* posible transición.

Puede:

* restaurarse;
* ser ignorada;
* exiliarse;
* morir;
* encabezar gobierno provisional.

---

# 58. Gobierno militar

Puede surgir mediante:

* Varos;
* Sarris;
* Daskal;
* combinación.

## Ventajas

* mando;
* continuidad;
* seguridad.

## Riesgos

* autoritarismo;
* división;
* rechazo civil;
* dependencia militar.

---

# 59. Coalición municipal

Puede formarse cuando:

* Gobierno colapsa;
* varias ciudades conservan autoridad;
* Markou, Koronis o alcaldes cooperan.

## Función

* transición;
* servicios;
* negociación;
* legitimidad desde abajo.

---

# 60. Elecciones y representación

No se implementarán elecciones completas durante los primeros actos.

Podrán existir:

* consultas;
* consejos provisionales;
* nombramientos;
* elecciones locales tardías;
* proceso constitucional en epílogo.

## Requisitos

* seguridad;
* registros;
* participación;
* libertad;
* reconocimiento.

---

# 61. Propaganda y medios

Los medios influyen en:

* percepción;
* miedo;
* legitimidad;
* atribución de incidentes;
* publicación de evidencia.

## Canales

* Radio Nacional;
* Voz de Kavala;
* Diario de Pyrgos;
* Red del Este;
* radios comunitarias;
* transmisiones militares;
* panfletos;
* redes locales.

---

# 62. Control de medios

Una facción puede:

* censurar;
* proteger;
* utilizar;
* bloquear;
* desacreditar.

## Coste

La censura puede mantener orden inmediato y aumentar desconfianza.

---

# 63. Rumores

Cada sector puede acumular rumores.

```text
rumorId
subject
origin
credibility
spread
emotionalImpact
knownBy
```

## Ejemplos

* tropas extranjeras roban niños;
* hospital tiene medicina;
* FIA prepara ataque;
* Vardis está vivo;
* agua está contaminada.

## Regla

Los rumores no se convierten automáticamente en hechos, pero sí en conducta.

---

# 64. Memoria civil

Cada región almacenará eventos relevantes.

```text
eventId
responsibleActor
perceivedResponsibility
severity
duration
decay
symbolicImportance
```

## Memorias permanentes

* masacre;
* desaparición;
* destrucción cultural;
* salvamento;
* liberación;
* gran promesa.

## Memorias degradables

* retraso;
* escasez menor;
* restricción temporal.

---

# 65. Variación regional

# Kavala occidental

Características:

* política;
* sindicatos;
* FIA;
* comercio;
* memoria de guerra civil.

Reacciona especialmente a:

* ocupación;
* represión;
* medios;
* trabajo portuario.

---

# Noroeste

Características:

* comunidades pequeñas;
* soberanismo;
* terreno;
* memoria militar.

Reacciona a:

* requisas;
* presencia extranjera;
* destrucción rural.

---

# Corredor agrícola occidental

Características:

* alimentos;
* transporte;
* cooperativas.

Reacciona a:

* combustible;
* cosecha;
* movilización;
* daños.

---

# Aeropuerto y centro

Características:

* técnicos;
* trabajadores;
* administración;
* Helios.

Reacciona a:

* control de infraestructura;
* empleo;
* seguridad;
* acceso.

---

# Athira y norte central

Características:

* identidad regional;
* comercio;
* instituciones.

Reacciona a:

* estabilidad;
* representación;
* rutas.

---

# Oriente y Molos

Características:

* militares;
* tradición gubernamental;
* presencia Roja;
* corredores.

Reacciona a:

* alianza;
* subordinación;
* control portuario.

---

# Pyrgos y sur

Características:

* Gobierno;
* funcionarios;
* puertos;
* legitimidad estatal.

Reacciona a:

* crisis institucional;
* golpes;
* protección ministerial.

---

# Stratis

Características:

* autonomía;
* silencio;
* vigilancia;
* militarización.

Reacciona a:

* control externo;
* Meridian;
* evacuación;
* revelación PHAROS.

---

# 66. Perfil de administración Azul

## Fortalezas

* disciplina;
* ayuda;
* capacidad técnica;
* administración modular;
* relaciones civiles.

## Debilidades

* falta de legalidad inicial;
* identidad extranjera;
* presión de Hale;
* dependencia logística.

## Tendencias

Ward y Laurent favorecen:

* municipios;
* servicios;
* negociación.

Hale favorece:

* control;
* seguridad;
* avance.

---

# 67. Perfil de administración Roja

## Fortalezas

* invitación parcial;
* cooperación gubernamental;
* recursos;
* orden.

## Debilidades

* riesgo de subordinación;
* mecanización pesada;
* requisiciones;
* Vahid.

## Tendencias

Navid y Khoury favorecen:

* continuidad institucional;
* autoridades locales.

Vahid favorece:

* control militar;
* seguridad de corredor.

---

# 68. Perfil Verde

Verde puede representar:

* defensa nacional;
* autoridad local;
* represión;
* continuidad.

## Variantes

### Gubernamental

Protege instituciones.

### Soberanista

Prioriza independencia.

### Reformista

Prioriza transición y municipios.

---

# 69. Perfil FIA

FIA puede obtener legitimidad mediante:

* protección;
* representación;
* servicios clandestinos;
* oposición a ocupación.

Puede perderla mediante:

* coerción;
* ejecuciones;
* saqueo;
* militarización;
* Kallas;
* Frente Negro.

---

# 70. Argos y la población

Argos no gobierna territorios.

Puede manipular:

* rumores;
* protestas;
* atentados;
* desapariciones;
* suministros;
* evidencia.

## Objetivo

Medir y provocar reacciones.

## Límite

No controla completamente:

* comunidades;
* cultura;
* líderes;
* consecuencias.

---

# 71. Ciclo civil estratégico

## Cada pocos minutos estratégicos

* seguridad;
* demandas críticas;
* desplazamiento inmediato;
* servicios esenciales.

## Cada hora

* mercados;
* hospitales;
* trabajo;
* protestas;
* obediencia.

## Cada día

* legitimidad;
* radicalización;
* retorno;
* economía;
* memoria;
* política.

---

# 72. Pipeline civil

1. Evaluar seguridad.
2. Evaluar servicios.
3. Evaluar necesidades.
4. Evaluar autoridad.
5. Actualizar confianza y miedo.
6. Actualizar obediencia y apoyo.
7. Actualizar estabilidad.
8. Detectar demandas.
9. Detectar eventos.
10. Generar misión si existe intervención significativa.
11. Aplicar memoria.
12. Propagar efectos regionales.

---

# 73. Modelo de estado civil

```sqf
IF_civilSectorState = createHashMapFromArray [
    ["sectorId", "ALT_W_KAVALA_CITY"],

    ["populationTotal", 9200],
    ["populationPresent", 7100],
    ["populationDisplacedOut", 2600],
    ["populationDisplacedIn", 500],

    ["civilianTrust", createHashMap],
    ["civilianSupport", createHashMap],
    ["civilianObedience", createHashMap],
    ["civilianDependency", createHashMap],

    ["fear", 62],
    ["grievance", 74],
    ["communityCohesion", 78],
    ["radicalization", 55],
    ["stability", 41],

    ["serviceState", createHashMap],
    ["activeDemandIds", []],
    ["activeProtestId", ""],
    ["municipalityId", "MUN_KAVALA"],
    ["governmentMode", "MUNICIPAL_SUPERVISED"],
    ["civilMemory", []]
];
```

---

# 74. Modelo municipal

```sqf
IF_municipality = createHashMapFromArray [
    ["id", "MUN_KAVALA"],
    ["displayName", "Municipio de Kavala"],
    ["sectorIds", ["ALT_W_KAVALA_CITY", "ALT_W_KAVALA_PORT"]],
    ["mayorCharacterId", "CHAR_CIV_DRAKOS"],
    ["councilState", "ACTIVE"],
    ["administrativeCapacity", 72],
    ["publicTrust", 64],
    ["recognizedAuthority", "LOCAL_COUNCIL"],
    ["supervisingFactionId", "FAC_BLUE"],
    ["essentialWorkerNetworks", []],
    ["activeDemandIds", []],
    ["politicalAlignment", "REFORMIST_LOCALIST"]
];
```

---

# 75. Modelo de demanda

```sqf
IF_civilDemand = createHashMapFromArray [
    ["id", "DEM_KAVALA_PORT_WORKERS"],
    ["sectorId", "ALT_W_KAVALA_PORT"],
    ["issuerId", "MUN_KAVALA"],
    ["type", "WORKER_RELEASE"],
    ["priority", "HIGH"],
    ["createdAt", 1560],
    ["softDeadline", 1740],
    ["hardDeadline", 2100],
    ["requestedAction", "RELEASE_DETAINED_DOCKWORKERS"],
    ["possibleCompromises", []],
    ["ignoredOutcome", "PORT_STRIKE"],
    ["resolved", false]
];
```

---

# 76. Eventos civiles dinámicos

## Escasez

Genera:

* mercado negro;
* protesta;
* requisición;
* ayuda.

## Detención

Genera:

* familia;
* petición;
* huelga;
* radicalización.

## Ataque

Genera:

* evacuación;
* hospital;
* funeral;
* represalia.

## Reconstrucción

Genera:

* empleo;
* retorno;
* cooperación;
* disputa de contratos.

---

# 77. Misiones civiles principales

## Agua para tres banderas

Restablecer suministro mientras tres actores reclaman autoridad.

## El puerto no trabaja

Resolver huelga o militarizar operaciones.

## La casa de dos llaves

Conflicto de propiedad entre retornado y familia ocupante.

## Los nombres de la noche

Proteger vigilia por desaparecidos.

## La última cosecha

Permitir recolección en zona disputada.

## Funeral sin cuerpo

Investigar desaparecido vinculado a PHAROS.

## Mercado cerrado

Resolver seguridad, precios o coerción.

---

# 78. Decisiones administrativas del jugador

Según autoridad, el jugador podrá:

* recomendar política;
* autorizar ayuda;
* asignar seguridad;
* trasladar puesto;
* liberar detenidos;
* priorizar reparación;
* negociar;
* imponer toque de queda;
* proteger funcionarios.

## Límite

El jugador no será alcalde ni gobernador absoluto.

Sus decisiones pueden ser:

* aceptadas;
* modificadas;
* rechazadas;
* mal ejecutadas.

---

# 79. Conflictos entre seguridad y legitimidad

## Ejemplo 1

Cerrar un mercado reduce infiltración y empeora alimentos.

## Ejemplo 2

Liberar detenidos mejora confianza y puede liberar combatientes.

## Ejemplo 3

Fortificar una escuela mejora defensa y destruye educación.

## Ejemplo 4

Requisar camiones abastece el frente y paraliza cosecha.

## Principio

No existe una política que maximice todas las variables.

---

# 80. Resolución fuera de pantalla

Los problemas civiles pueden ser resueltos por:

* municipio;
* mando;
* FIA;
* Gobierno;
* otra unidad.

## Resultado

Depende de:

* capacidad;
* confianza;
* recursos;
* política;
* infiltración.

## Ejemplo

Una huelga ignorada puede terminar en:

* acuerdo;
* represión;
* sabotaje;
* colapso portuario.

---

# 81. Gobierno y finales

El sistema civil alimentará directamente los ejes finales:

```text
civilCondition
politicalOrder
governmentLegitimacy
nativeReconciliation
foreignOccupation
fiaPoliticalFuture
greenFuture
publicTruth
```

## Regla

No podrá existir un final estable si:

* servicios colapsan;
* desplazamiento es extremo;
* autoridades desaparecieron;
* toda obediencia depende del miedo.

---

# 82. Finales civiles posibles

## Estabilidad legítima

* servicios;
* representación;
* seguridad;
* verdad suficiente.

## Estabilidad coercitiva

* control;
* miedo;
* servicios parciales.

## Libertad fragmentada

* ocupantes se retiran;
* autoridades locales débiles.

## Colapso humanitario

* desplazamiento;
* escasez;
* violencia.

## Reconstrucción tutelada

* apoyo extranjero;
* dependencia.

## Pacto municipal

* consejos y Gobierno transitorio.

---

# 83. Vertical slice civil

Sectores:

* Katalaki;
* Neochori;
* Poliakko–Therisa;
* Stavros–Whiskey.

## Sistemas mínimos

* población;
* alcalde o autoridad;
* confianza;
* obediencia;
* necesidades;
* hospital;
* desplazamiento;
* demanda;
* protesta o huelga;
* evento de bajas.

## Personajes

* autoridad local;
* médico;
* trabajador;
* civil desplazado;
* contacto FIA.

---

# 84. Escenario de prueba 1 — Neochori ocupada

Estado:

* Azul controla;
* Verde se retiró;
* clínica dañada;
* mercado cerrado;
* trabajadores temerosos.

Decisiones:

* seguridad;
* ayuda;
* requisición;
* administración.

Validar:

* diferencia entre control y estabilidad;
* demanda;
* confianza;
* logística.

---

# 85. Escenario de prueba 2 — Puerto en huelga

Estado:

* puerto intacto;
* trabajadores detenidos;
* suministros esperando.

Opciones:

* negociar;
* liberar;
* sustituir;
* militarizar.

Validar:

* throughput;
* legitimidad;
* sabotaje;
* relación municipal.

---

# 86. Escenario de prueba 3 — Desplazados

Estado:

* ataque en Stavros;
* familias llegan a Neochori.

Validar:

* presión;
* alimentos;
* refugio;
* misión;
* retorno posterior.

---

# 87. Escenario de prueba 4 — Protesta

Causa:

* muerte civil;
* información contradictoria.

Validar:

* rumor;
* medios;
* respuesta;
* escalada;
* memoria.

---

# 88. Escenario de prueba 5 — Administración dual

Estado:

* Verde mantiene municipio;
* Rojo controla militarmente.

Validar:

* órdenes;
* cooperación;
* autoridad;
* conflicto político.

---

# 89. Funciones conceptuales

```text
IF_fnc_civilTick
IF_fnc_civilEvaluateNeeds
IF_fnc_civilUpdateTrust
IF_fnc_civilUpdateSupport
IF_fnc_civilUpdateObedience
IF_fnc_civilUpdateStability
IF_fnc_civilCreateDemand
IF_fnc_civilResolveDemand
IF_fnc_civilCreateProtest
IF_fnc_civilResolveProtest
IF_fnc_civilDisplacePopulation
IF_fnc_civilReturnPopulation
IF_fnc_municipalityEvaluate
IF_fnc_governanceAssignMode
IF_fnc_governanceEvaluateLegitimacy
IF_fnc_detentionRegister
IF_fnc_incidentRegisterCivilianHarm
IF_fnc_rumorCreate
IF_fnc_rumorPropagate
```

---

# 90. Invariantes civiles

1. Control militar no equivale a gobierno.
2. Obediencia no equivale a apoyo.
3. Dependencia no equivale a confianza.
4. Miedo no produce estabilidad duradera por sí solo.
5. Un servicio no funciona sin personal.
6. Una autoridad muerta no continúa gobernando.
7. Los desplazados deben existir en algún lugar.
8. Las bajas civiles deben tener causa.
9. Las detenciones deben tener estado.
10. Una demanda ignorada produce resultado.
11. Una protesta necesita causa.
12. Una huelga necesita trabajadores organizados.
13. Un municipio no administra sin capacidad.
14. La población no regresa instantáneamente.
15. Las requisiciones reducen recursos civiles.
16. La reconstrucción requiere trabajadores y materiales.
17. Las promesas quedan registradas.
18. La legitimidad no cambia solo por capturar un sector.
19. Los rumores no son hechos confirmados.
20. Argos no controla completamente las comunidades.

---

# 91. Errores que deben evitarse

1. Usar una sola barra de apoyo.
2. Hacer que todos los civiles reaccionen igual.
3. Convertir cada necesidad en misión.
4. Usar protestas sin causa.
5. Hacer que ocupar una ciudad restaure servicios.
6. Ignorar trabajadores esenciales.
7. Tratar alcaldes como dueños absolutos del sector.
8. Hacer que la represión funcione sin coste.
9. Hacer que la negociación siempre funcione.
10. Generar refugiados que desaparecen.
11. Olvidar propiedad y retornados.
12. Hacer que ayuda produzca apoyo automático.
13. Confundir FIA con toda la población.
14. Hacer que todo informante sea fiable.
15. Utilizar civiles solo como obstáculos.
16. Crear bajas sin memoria.
17. Permitir hospitales sin energía ni médicos.
18. Mantener mercados abiertos durante combate intenso.
19. Permitir elecciones sin condiciones.
20. Dar al jugador autoridad civil ilimitada.

---

# 92. Principios obligatorios

1. Cada sector tiene población estratégica.
2. La población posee necesidades.
3. Los servicios requieren personal y recursos.
4. Control, autoridad y legitimidad son diferentes.
5. Confianza, apoyo, obediencia y dependencia son diferentes.
6. El miedo puede producir obediencia temporal.
7. El agravio produce consecuencias duraderas.
8. La cohesión puede sostener cooperación o resistencia.
9. La radicalización necesita organización y narrativa.
10. Los municipios son actores reales.
11. Los trabajadores esenciales condicionan infraestructura.
12. Los desplazados se trasladan a sectores concretos.
13. Las bajas civiles quedan registradas.
14. Las promesas producen memoria.
15. Las requisiciones tienen propietario y compensación.
16. Las detenciones tienen estado y consecuencias.
17. Las protestas pueden escalar o resolverse.
18. Las huelgas afectan producción y logística.
19. Los rumores modifican conducta.
20. Los medios modifican percepción.
21. Azul y Rojo administran de forma diferente.
22. Verde conserva legitimidad nacional potencial.
23. FIA puede ganar o perder legitimidad.
24. Argos manipula condiciones, no voluntades.
25. La reconstrucción compite con la guerra.
26. La estabilidad no siempre es justa.
27. La legitimidad no siempre es estable.
28. El jugador influye, pero no gobierna solo.
29. Los resultados civiles alimentan los finales.
30. El sistema debe explicar por qué una comunidad coopera o resiste.

---

# 93. Definición final

La población de Islas Fracturadas no existirá únicamente para observar pasar convoyes o convertirse en víctimas de una batalla.

Será la estructura que determine si un territorio capturado puede seguir funcionando.

Un puerto no operará porque una bandera Azul o Roja aparezca sobre el muelle.

Operará si:

* los trabajadores regresan;
* las grúas tienen energía;
* los camiones tienen combustible;
* el municipio acepta coordinar;
* las familias creen que colaborar no las condenará después.

Una ciudad podrá obedecer por miedo y resistir en silencio.

Una aldea podrá desconfiar de una fuerza extranjera y aun ayudarla porque protege la cosecha.

Una comunidad podrá apoyar a FIA y rechazar a Kallas.

Un funcionario podrá servir a Kouris, reconocer a Pallis y seguir órdenes Verdes para evitar el colapso.

> **El territorio cambia de dueño en horas. La autoridad se construye durante semanas. La legitimidad puede necesitar generaciones.**

> **Una fuerza ocupa cuando puede entrar. Gobierna cuando la vida cotidiana depende de sus decisiones y la población decide —por confianza, necesidad o miedo— seguirlas.**

> **La pregunta civil no será solamente quién controla la ciudad. Será quién puede mantenerla viva y qué precio exige por hacerlo.**

## Estado actualizado

* [x] **1/14 — Arquitectura de campañas Azul y Roja**
* [x] **2/14 — Revelaciones, evidencias e investigación de Argos**
* [x] **3/14 — Misiones dinámicas y eventos emergentes**
* [x] **4/14 — Sistema civil, municipal, político y de estabilidad**
* [ ] **5/14 — FIA, insurgencia y guerra clandestina** — siguiente
* [ ] **6/14 — Helios, inteligencia y niebla de guerra**
* [ ] **7/14 — Sistema táctico y virtualización de fuerzas**
* [ ] **8/14 — Progresión, autoridad y desbloqueos**
* [ ] **9/14 — Interfaz estratégica**
* [ ] **10/14 — Arquitectura técnica SQF**
* [ ] **11/14 — Guía 3DEN y validación geográfica**
* [ ] **12/14 — Diálogos, radio y cinematografía**
* [ ] **13/14 — Pruebas, rendimiento y balance**
* [ ] **14/14 — Plan de implementación y producción**

El siguiente documento será el **5/14 — Sistema definitivo de FIA, insurgencia y guerra clandestina**, diferenciando células, apoyo civil, Markou, Kallas, Némesis, redes logísticas, sabotaje, contrainsurgencia y evolución política de FIA.
