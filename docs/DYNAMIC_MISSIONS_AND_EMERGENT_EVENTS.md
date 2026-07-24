## Lista maestra de documentos rectores

* [x] **1/14 — Arquitectura de campañas Azul y Roja**
* [x] **2/14 — Revelaciones, evidencias e investigación de Argos**
* [x] **3/14 — Misiones dinámicas y eventos emergentes** — desarrollado a continuación
* [x] **4/14 — Sistema civil, municipal, político y de estabilidad**
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

## Documento 3/14 — Sistema definitivo de misiones dinámicas y eventos emergentes

**Versión:** 1.0
**Clasificación:** documento rector de diseño de misiones, simulación y narrativa emergente
**Campañas:** Fuerza Azul y Fuerza Roja
**Terrenos:** Altis y Stratis
**Motor:** Arma 3 2.18
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando
**Estado:** canon previo a implementación

> **Jerarquía documental:** este Documento 3/14 gobierna necesidades, eventos, plantillas, generación, transformación, resolución externa, ritmo y anti-repetición. Las misiones narrativas y sus puertas se rigen por [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](BLUE_RED_CAMPAIGN_ARCHITECTURE.md); las evidencias, por [INVESTIGATION_REVELATION_MATRIX.md](INVESTIGATION_REVELATION_MATRIX.md); las causas civiles, por [CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md); y el estado autoritativo, por [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md).
>
> **Espacios de identificadores:** `IF_*` identifica contenido narrativo o autoral estable; `TPL_*`, plantillas dinámicas; `NEED_*`, necesidades causales; y `DYN_*`, instancias generadas durante una campaña. Una instancia `DYN_*` nunca sustituye ni reutiliza el ID `IF_*` de una misión narrativa.

---

# 1. Propósito

Este documento define cómo el estado persistente de la campaña genera contenido jugable a partir de:

* necesidades de los comandantes;
* cambios territoriales;
* frentes;
* recursos;
* convoyes;
* guarniciones;
* población;
* infraestructura;
* relaciones;
* personajes;
* investigaciones;
* actividad de Helios;
* intervenciones de Argos;
* decisiones previas del jugador.

El sistema debe producir operaciones que parezcan consecuencias naturales de la guerra.

No debe producir una lista de tareas arbitrarias como:

* elimine una patrulla;
* capture una base sin contexto;
* transporte una caja;
* defienda durante diez minutos;
* repita exactamente la misma emboscada.

Cada misión dinámica deberá responder:

1. ¿Qué problema del mundo la originó?
2. ¿Quién desea resolverlo?
3. ¿Por qué necesita al jugador?
4. ¿Qué ocurre si se ignora?
5. ¿Qué cambia cuando termina?
6. ¿Por qué esta versión es diferente de la anterior?

---

# 2. Decisión de diseño principal

Las misiones dinámicas no serán seleccionadas únicamente mediante azar.

Se generarán mediante una cadena causal:

```text
Estado del mundo
→ necesidad
→ actor interesado
→ familia de misión
→ plantilla compatible
→ parámetros concretos
→ oferta
→ ejecución o resolución externa
→ consecuencias persistentes
```

## Ejemplo

Un convoy no aparece porque el generador decidió crear una misión de escolta.

Aparece porque:

* Neochori tiene combustible crítico;
* Katalaki posee existencias;
* la carretera está abierta;
* FIA ha atacado esa ruta anteriormente;
* Rourke no dispone de suficientes fuerzas;
* el jugador tiene autoridad y se encuentra cerca.

La misión puede ser:

* escoltar;
* despejar ruta;
* buscar convoy perdido;
* tender una contraemboscada;
* negociar paso;
* usar una ruta alternativa.

La necesidad logística es la misma.

La forma jugable depende del estado.

---

# 3. Diferencia entre misión y evento

## Misión

Requiere o permite una intervención organizada del jugador.

Posee:

* origen;
* objetivos;
* condiciones;
* resultado;
* consecuencias.

## Evento

Es un acontecimiento del mundo.

Puede ocurrir:

* con el jugador presente;
* fuera de pantalla;
* como resultado de otro sistema;
* sin convertirse en misión.

Ejemplos:

* protesta;
* ataque de artillería;
* huelga;
* deserción;
* apagón;
* caída de un sector;
* llegada de refugiados.

## Conversión

Un evento puede generar una misión.

Ejemplo:

```text
Apagón en hospital
→ necesidad de energía
→ misión de combustible, reparación o protección
```

---

# 4. Tipos generales de contenido dinámico

## 4.1 Operación solicitada

Un comandante o autoridad ofrece una misión.

Ejemplos:

* Rourke solicita reconocimiento;
* Vahid ordena romper un bloqueo;
* Markou pide proteger una evacuación.

---

## 4.2 Emergencia

La situación exige respuesta inmediata.

Ejemplos:

* sector atacado;
* convoy bajo fuego;
* helicóptero derribado;
* hospital sin energía.

---

## 4.3 Oportunidad

El jugador puede explotar una situación.

Ejemplos:

* oficial enemigo aislado;
* depósito mal protegido;
* señal Helios;
* vehículo abandonado.

---

## 4.4 Petición civil

Procede de:

* alcalde;
* médico;
* sindicato;
* comunidad;
* familia;
* trabajadores.

Puede contradecir una orden militar.

---

## 4.5 Investigación

Se genera por:

* pista;
* evidencia;
* testimonio;
* contradicción;
* señal;
* anomalía logística.

---

## 4.6 Operación clandestina

Procede de:

* FIA;
* Argos;
* inteligencia;
* infiltrado;
* contrabandista.

Puede ser:

* legítima;
* manipulada;
* trampa;
* parcialmente verdadera.

---

## 4.7 Consecuencia diferida

Aparece por una decisión anterior.

Ejemplos:

* un prisionero liberado ofrece información;
* un alcalde rechazado apoya a FIA;
* un vehículo no recuperado reaparece en manos enemigas;
* una evidencia entregada a Shaw desaparece.

---

# 5. Fuentes de necesidades

El generador observará categorías concretas.

## Militar

* sector amenazado;
* reserva insuficiente;
* fuerza aislada;
* guarnición débil;
* oportunidad ofensiva;
* comandante muerto;
* artillería enemiga.

## Logística

* recurso crítico;
* convoy detenido;
* ruta bloqueada;
* depósito amenazado;
* vehículo abandonado;
* puerto degradado.

## Civil

* desplazados;
* hospital;
* agua;
* alimentos;
* protesta;
* huelga;
* saqueo;
* detenciones.

## Política

* negociación;
* autoridad disputada;
* tratado;
* golpe;
* visita;
* propaganda;
* elección local.

## Inteligencia

* informe contradictorio;
* transmisión;
* infiltrado;
* prisionero;
* dron perdido;
* nodo Helios.

## Personal

* miembro herido;
* conflicto interno;
* deuda;
* familiar;
* promesa;
* sospecha.

## Argos

* evidencia expuesta;
* infiltrado en riesgo;
* nodo amenazado;
* equilibrio roto;
* evacuación PHAROS.

---

# 6. Niveles de prioridad

```text
CRITICAL
URGENT
HIGH
NORMAL
LOW
BACKGROUND
```

## CRITICAL

Amenaza inmediata de:

* derrota;
* muerte;
* colapso;
* pérdida irreversible.

Caduca rápidamente.

## URGENT

Ventana corta con consecuencias graves.

## HIGH

Importante para la estrategia actual.

## NORMAL

Operación útil sin emergencia.

## LOW

Oportunidad secundaria.

## BACKGROUND

Puede resolverse fuera de pantalla y normalmente no se ofrece directamente.

---

# 7. Ventana temporal

Cada misión tendrá:

```text
offerTime
earliestStart
softDeadline
hardDeadline
resolutionTime
```

## Soft deadline

Después de este punto:

* la situación empeora;
* cambian objetivos;
* desaparecen ventajas.

## Hard deadline

La misión:

* expira;
* se resuelve externamente;
* se transforma.

## Ejemplo

Un convoy bajo amenaza:

### Antes del soft deadline

Puede escoltarse desde el origen.

### Después

Ya se encuentra en ruta.

### Cerca del hard deadline

Está bajo ataque.

### Después

Se convierte en:

* recuperar supervivientes;
* recuperar carga;
* investigar la emboscada.

---

# 8. Transformación de misiones

Una misión no debe desaparecer siempre cuando expira.

Puede convertirse en otra.

## Cadena de ejemplo

```text
Escoltar convoy
→ convoy ignorado
→ convoy atacado
→ rescatar supervivientes
→ carga capturada
→ atacar depósito enemigo
```

## Otro ejemplo

```text
Proteger reunión
→ reunión atacada
→ líder herido
→ evacuar
→ investigar infiltración
→ represalia o negociación
```

## Ventaja

El mundo recuerda el problema original.

---

# 9. Familias principales de misión

1. Reconocimiento.
2. Ataque.
3. Defensa.
4. Convoy y logística.
5. Rescate y evacuación.
6. Recuperación.
7. Sabotaje.
8. Inteligencia e investigación.
9. Negociación y política.
10. Seguridad civil.
11. Contrainsurgencia.
12. Guerrilla e insurgencia.
13. Artillería y defensa aérea.
14. Operaciones aéreas y navales.
15. Helios y Argos.
16. Personajes y escuadra.

---

# 10. Familia RECONOCIMIENTO

## Propósito

Reducir incertidumbre antes de otra decisión.

## Variantes

### Observación de sector

* identificar guarnición;
* registrar vehículos;
* encontrar rutas.

### Reconocimiento de ruta

* minas;
* bloqueos;
* emboscadas;
* civiles.

### Reconocimiento técnico

* radar;
* señal;
* nodo;
* energía.

### Reconocimiento humano

* hablar con civiles;
* identificar mando;
* verificar lealtad.

### Reconocimiento profundo

* larga distancia;
* poca extracción;
* riesgo elevado.

---

# 11. Parámetros de reconocimiento

```text
targetSector
observationPoints
requiredInformation
allowedDetection
timeWindow
weather
enemyPatrolDensity
extractionRequired
```

## Resultados posibles

### Éxito discreto

* información de alta calidad;
* enemigo no alerta.

### Éxito detectado

* información obtenida;
* enemigo cambia defensas.

### Parcial

* fuerza o ruta estimada;
* detalles desconocidos.

### Fracaso

* información incorrecta;
* unidad perseguida;
* enemigo prepara trampa.

---

# 12. Anti-repetición de reconocimiento

No todas las misiones deben consistir en observar desde una colina.

Variaciones:

* infiltración urbana;
* dron;
* contacto civil;
* patrulla disfrazada;
* recuperación de fotografías;
* colocación de sensor;
* interrogatorio;
* seguir convoy;
* navegar por costa.

---

# 13. Familia ATAQUE

## Propósito

Cambiar:

* control;
* capacidad;
* recurso;
* iniciativa.

## Variantes

### Asalto de sector

Objetivo territorial completo.

### Ataque limitado

Destruir una capacidad específica.

### Incursión

Entrar, atacar y retirarse.

### Ruptura

Abrir una línea o carretera.

### Ataque de flanco

Apoyar una operación principal.

### Golpe de mando

Capturar o neutralizar liderazgo.

### Ataque de oportunidad

Explotar enemigo debilitado.

---

# 14. Parámetros de ataque

```text
objectiveType
enemyStrengthEstimate
friendlyMainForce
playerRole
supportAvailable
civilianPresence
desiredDamageLimit
timeConstraint
withdrawalCondition
```

## Roles del jugador

* fuerza principal;
* avanzada;
* flanco;
* reconocimiento armado;
* neutralización técnica;
* reserva;
* extracción.

---

# 15. Resultados de ataque

## Captura completa

* propietario cambia;
* infraestructura evaluada;
* guarnición asignada.

## Objetivo destruido

* capacidad enemiga reducida;
* sector puede seguir enemigo.

## Retirada enemiga

* menos bajas;
* fuerza puede reaparecer.

## Éxito costoso

* control obtenido;
* baja capacidad de consolidación.

## Fracaso

* recursos consumidos;
* enemigo preparado;
* moral reducida.

---

# 16. Familia DEFENSA

## Variantes

### Defensa preparada

Tiempo para:

* orientar;
* fortificar;
* asignar reservas.

### Defensa de emergencia

Ataque ya comenzó.

### Retardo

No se pretende conservar el sector indefinidamente.

### Protección de instalación

Hospital, puente, nodo o depósito.

### Defensa móvil

Retiradas y contraataques.

### Defensa de evacuación

Proteger mientras salen civiles o recursos.

---

# 17. Condiciones de defensa

La defensa no se resolverá únicamente mediante “elimine a todos”.

Puede terminar cuando:

* transcurre una ventana;
* llega refuerzo;
* termina evacuación;
* enemigo pierde capacidad;
* ruta queda abierta;
* se ordena retirada.

## Decisiones

* sostener;
* contraatacar;
* retirarse;
* evacuar módulo;
* destruir instalación;
* solicitar apoyo.

---

# 18. Familia CONVOY Y LOGÍSTICA

## Variantes

### Escolta completa

Desde origen hasta destino.

### Seguridad de tramo

Proteger solo un segmento.

### Despeje de ruta

Eliminar amenaza antes del convoy.

### Reacción a emboscada

Llegar cuando el ataque ya comenzó.

### Convoy señuelo

Atraer al enemigo.

### Convoy civil

Refugiados o ayuda.

### Convoy clandestino

Carga FIA, Argos o inteligencia.

### Convoy pesado

Vehículos lentos y valiosos.

---

# 19. Contenido variable de convoy

* combustible;
* munición;
* medicina;
* alimentos;
* personal;
* prisioneros;
* técnicos;
* vehículos;
* evidencia;
* material Helios.

El contenido cambia:

* comportamiento;
* prioridad;
* reglas de fuego;
* consecuencias.

---

# 20. Familia RESCATE Y EVACUACIÓN

## Variantes

### CSAR

Rescate de piloto o tripulación.

### Unidad cercada

Abrir corredor.

### Personal civil

Evacuar población.

### Personaje

Rescatar figura relevante.

### Médico

Extraer heridos.

### Prisionero

Liberación o intercambio fallido.

### Operador PHAROS

Extraer técnico o testigo.

---

# 21. Decisiones de evacuación

El transporte puede ser insuficiente.

El jugador puede priorizar:

* heridos;
* civiles;
* técnicos;
* evidencia;
* soldados;
* vehículos.

## Consecuencia

Lo que queda atrás puede:

* morir;
* ser capturado;
* destruirse;
* aparecer más tarde.

---

# 22. Familia RECUPERACIÓN

## Objetivos

* vehículo;
* arma;
* dron;
* archivo;
* cadáver;
* caja;
* servidor;
* pieza de Helios.

## Variantes

### Recuperación limpia

Zona abandonada.

### Carrera

Enemigo también busca el objeto.

### Recuperación bajo fuego

El activo está en zona disputada.

### Recuperación técnica

Necesita ingeniero.

### Recuperación moral

Recuperar cuerpos o identificación.

---

# 23. Familia SABOTAJE

## Variantes

* puente;
* radar;
* combustible;
* artillería;
* pista;
* comunicaciones;
* generador;
* depósito;
* convoy;
* nodo Helios.

## Métodos

* explosivos;
* interferencia;
* contaminación;
* manipulación digital;
* robo;
* daño selectivo.

## Consecuencia civil

La destrucción puede afectar:

* agua;
* electricidad;
* hospitales;
* comercio.

---

# 24. Sabotaje reversible e irreversible

## Reversible

* cortar cables;
* robar componente;
* contaminar parcialmente;
* desactivar.

## Irreversible

* destruir puente;
* incendiar depósito;
* demoler nodo.

## Regla

Los comandantes pueden preferir una opción.

El jugador puede elegir otra y asumir consecuencias.

---

# 25. Familia INTELIGENCIA E INVESTIGACIÓN

## Variantes

* recuperar documento;
* seguir a un contacto;
* proteger testigo;
* interceptar transmisión;
* analizar instalación;
* registrar convoy;
* comparar archivos;
* capturar operador;
* verificar tumba;
* inspeccionar nómina.

## Diferencia

El objetivo no siempre es encontrar una prueba.

Puede ser demostrar que una prueba es falsa o incompleta.

---

# 26. Fases investigativas

1. Localizar.
2. Acceder.
3. Recuperar.
4. Preservar.
5. Extraer.
6. Entregar.
7. Interpretar.

El combate puede ocurrir en cualquier fase, pero no debe reemplazar la investigación.

---

# 27. Familia NEGOCIACIÓN Y POLÍTICA

## Variantes

* alto el fuego;
* paso por sector;
* entrega de guarnición;
* cooperación municipal;
* intercambio de prisioneros;
* protesta;
* tratado local;
* reunión Verde;
* disputa FIA;
* autoridad gubernamental.

## Mecánicas

* preparación;
* seguridad;
* evidencia;
* reputación;
* demandas;
* concesiones.

---

# 28. Negociaciones dinámicas

Una negociación debe tener:

```text
participants
minimumDemands
possibleConcessions
redLines
trust
externalPressure
securityRisk
timeLimit
```

## Ejemplo

Una unidad Verde puede aceptar:

* paso Rojo;
* conservar armas;
* mando local;
* no arrestar oficiales.

Vahid puede exigir:

* desarme;
* subordinación;
* control de carretera.

El jugador puede:

* mediar;
* presionar;
* preparar ataque;
* aceptar compromiso.

---

# 29. Familia SEGURIDAD CIVIL

## Variantes

* proteger hospital;
* distribuir alimentos;
* controlar saqueo;
* reparar agua;
* escoltar trabajadores;
* contener disturbios;
* registrar zona;
* proteger funeral;
* reabrir mercado.

## Riesgo

La respuesta militar puede resolver el evento inmediato y empeorar:

* legitimidad;
* radicalización;
* cooperación.

---

# 30. Disturbios y protestas

No serán hordas genéricas.

Tendrán causas:

* alimentos;
* detenciones;
* daños;
* ocupación;
* apagones;
* salarios;
* rumores.

## Respuestas

* negociar;
* proteger;
* dispersar;
* arrestar;
* ignorar;
* resolver causa.

---

# 31. Familia CONTRAINSURGENCIA

## Variantes

* patrulla;
* registro;
* red de informantes;
* operación selectiva;
* control de carretera;
* protección comunitaria;
* búsqueda de caché;
* captura de célula.

## Riesgo

Un éxito táctico puede aumentar la insurgencia si:

* existen abusos;
* daños;
* detenciones indiscriminadas;
* falsos positivos.

---

# 32. Familia GUERRILLA E INSURGENCIA

Utilizada cuando el jugador coopera con FIA o cuando una fuerza nativa ofrece operación irregular.

## Variantes

* emboscada;
* sabotaje;
* infiltración;
* propaganda;
* rescate;
* robo de armas;
* asesinato selectivo;
* liberación de prisioneros.

## Diferencia FIA

La misión debe priorizar:

* sorpresa;
* retirada;
* información local;
* bajo consumo;
* evitar combate prolongado.

---

# 33. Familia ARTILLERÍA Y DEFENSA AÉREA

## Variantes

* localizar batería;
* observar fuego;
* destruir radar;
* proteger batería;
* reabastecer artillería;
* desplazar sistema AA;
* recuperar misil;
* neutralizar observador.

## Consecuencia

Afecta otras misiones:

* apoyo disponible;
* riesgo aéreo;
* control de zona.

---

# 34. Familia AÉREA Y NAVAL

## Aérea

* transporte;
* inserción;
* apoyo cercano;
* evacuación;
* reconocimiento;
* intercepción.

## Naval

* desembarco;
* patrulla;
* escolta;
* infiltración;
* rescate;
* sabotaje costero.

## Regla

No aparecerán operaciones aéreas si:

* no hay aeronaves;
* la pista está inutilizable;
* no existe combustible;
* la defensa enemiga lo impide.

---

# 35. Familia HELIOS Y ARGOS

## Variantes Helios

* reparar nodo;
* desconectar nodo;
* recuperar claves;
* auditar registro;
* proteger técnico;
* comparar predicción;
* investigar tráfico.

## Variantes Argos

* contrainteligencia;
* infiltrado;
* extracción PHAROS;
* evidencia señuelo;
* convoy clandestino;
* falsa bandera;
* defensa de Stratis.

## Regla

Las misiones Argos no deben identificarse siempre como tales al comenzar.

---

# 36. Familia PERSONAJES Y ESCUADRA

## Variantes

* miembro herido;
* conflicto;
* deuda personal;
* búsqueda de familiar;
* investigación privada;
* decisión disciplinaria;
* rescate;
* entierro;
* sustitución.

## Propósito

Conectar los sistemas estratégicos con consecuencias humanas.

---

# 37. Estructura de una plantilla

Cada plantilla define un problema genérico.

```text
templateId
family
supportedSides
requiredActRange
requiredSectorTypes
requiredWorldStates
forbiddenWorldStates
requiredActors
objectivePatterns
optionalObjectivePatterns
failurePatterns
parameterRules
materializationRules
rewardRules
consequenceRules
dialogueTags
cooldownTags
```

---

# 38. Instancia de misión

La instancia concreta almacenará:

```text
missionId
templateId
originEventId
requesterId
campaignSide
act
priority
state
offeredAt
softDeadline
hardDeadline
sectorIds
actorIds
forceIds
convoyIds
evidenceIds
objectives
variants
generationSeed
resolution
consequencesApplied
```

---

# 39. Generación de candidatos

El generador realizará:

1. Recopilar necesidades.
2. Convertirlas en oportunidades de misión.
3. Buscar familias compatibles.
4. Filtrar plantillas.
5. Verificar recursos y actores.
6. Verificar distancia y carga actual.
7. Aplicar control de repetición.
8. Puntuar candidatos.
9. Seleccionar oferta.
10. Registrar origen causal.

---

# 40. Puntuación de candidatos

```text
score =
urgency
+ strategicImpact
+ narrativeRelevance
+ playerProximity
+ characterRelevance
+ varietyValue
+ actCompatibility
- repetitionPenalty
- travelBurden
- systemLoad
- conflictWithMainMission
```

## Regla

La prioridad del mundo no puede ser completamente reemplazada por la variedad.

Una cabeza de playa bajo ataque continuará siendo más importante que una misión secundaria novedosa.

---

# 41. Cantidad máxima de misiones activas

Para evitar saturación:

## Principales

```text
1 principal activa
```

## Operaciones estratégicas

```text
1–2 activas
```

## Emergencias

```text
0–2 activas
```

## Investigaciones

```text
hasta 2 disponibles
```

## Personajes y civiles

```text
1–3 disponibles
```

El sistema puede conservar necesidades en cola sin convertirlas todas en tareas visibles.

---

# 42. Fatiga de ofertas

Un personaje no llamará al jugador cada pocos minutos.

Cada emisor tendrá:

```text
lastOfferTime
offerCooldown
activeRequestCount
ignoredRequestCount
```

## Consecuencia

Si el jugador ignora repetidamente a un actor:

* puede dejar de solicitar ayuda;
* buscar otra unidad;
* reducir confianza;
* resolver problemas por otros medios.

---

# 43. Control de repetición

Cada misión registrará etiquetas.

Ejemplo:

```text
ESCORT
ROAD
DAY
FIA_AMBUSH
FUEL
NEOCHORI
```

## Penalizaciones

### Mismo tipo reciente

Penalización alta.

### Mismo sector

Penalización media.

### Mismo enemigo

Penalización media.

### Misma estructura de objetivos

Penalización alta.

### Contexto narrativo diferente

Reduce penalización.

---

# 44. Memoria de contenido

El sistema registrará:

* últimas familias jugadas;
* últimos sectores;
* últimos emisores;
* últimos objetivos;
* métodos usados;
* resultados.

## Ejemplo

Si las últimas dos operaciones fueron convoyes:

La siguiente necesidad logística puede convertirse en:

* despejar ruta;
* capturar depósito;
* reparar puente;
* realizar transporte aéreo.

---

# 45. Variación estructural

Una plantilla podrá modificar:

* fase inicial;
* orden de objetivos;
* aliado;
* enemigo;
* clima;
* hora;
* ruta;
* método;
* extracción;
* complicación.

## Ejemplo: recuperar dron

### Variante A

Dron intacto en territorio enemigo.

### Variante B

Civiles lo encontraron.

### Variante C

FIA lo vende.

### Variante D

Argos colocó datos señuelo.

### Variante E

El dron cayó cerca de una patrulla Roja.

---

# 46. Complicaciones

Una misión puede tener una complicación principal.

## Militares

* refuerzo;
* minas;
* artillería;
* comandante enemigo.

## Logísticas

* vehículo averiado;
* ruta cortada;
* carga incompatible.

## Civiles

* desplazados;
* trabajadores;
* hospital;
* protesta.

## Investigativas

* evidencia falsa;
* infiltrado;
* testigo asustado.

## Personales

* miembro herido;
* desobediencia;
* rivalidad.

## Regla

No se añadirán complicaciones únicamente para alargar.

Deben cambiar la decisión.

---

# 47. Complicaciones dinámicas durante ejecución

Pueden activarse por:

* tiempo;
* detección;
* bajas;
* destrucción;
* abandono de ruta;
* intervención del jugador.

## Ejemplo

Un reconocimiento discreto se convierte en persecución solamente si el jugador es detectado.

No ocurrirá siempre mediante un trigger fijo.

---

# 48. Objetivos opcionales

Deben modificar el mundo.

Ejemplos:

* proteger trabajadores;
* capturar oficial;
* recuperar evidencia;
* evitar destruir puente;
* evacuar heridos;
* conservar vehículo.

## Prohibición

No utilizar objetivos opcionales sin consecuencia real únicamente para otorgar una medalla.

---

# 49. Recompensas

No existirán recompensas abstractas desconectadas.

## Recompensas militares

* recursos;
* vehículo;
* apoyo;
* fuerza disponible;
* sector.

## Políticas

* confianza;
* legitimidad;
* cooperación.

## Investigativas

* evidencia;
* conclusión;
* acceso.

## Personales

* lealtad;
* supervivencia;
* diálogo;
* sucesión.

## Autoridad

* permiso;
* rango;
* capacidad de mando.

---

# 50. Costes

Una misión exitosa puede costar:

* munición;
* combustible;
* hombres;
* tiempo;
* legitimidad;
* relación.

## Principio

El éxito no debe devolver automáticamente más recursos de los consumidos.

Algunas operaciones son necesarias aunque sean costosas.

---

# 51. Resolución fuera de pantalla

Cuando el jugador no participa, el sistema selecciona:

* fuerza sustituta;
* capacidad;
* información;
* tiempo;
* riesgo.

## Resultado

```text
OFFSCREEN_SUCCESS
OFFSCREEN_PARTIAL
OFFSCREEN_FAILURE
OFFSCREEN_DISASTER
```

## Factores

* fuerza asignada;
* comandante;
* suministro;
* amenaza;
* dificultad;
* infiltración.

---

# 52. Participación indirecta del jugador

El jugador puede no ir personalmente y aun influir mediante:

* asignar unidad;
* enviar recursos;
* elegir ruta;
* autorizar apoyo;
* ordenar retirada.

## Resultado

Permite ejercer mando sin convertir todas las operaciones en misiones tácticas.

---

# 53. Ignorar una misión

Ignorar no significa siempre desobedecer.

Puede significar:

* priorizar otra crisis;
* no disponer de tiempo;
* rechazar una solicitud opcional.

## Consecuencias

Dependen de:

* autoridad del emisor;
* urgencia;
* relación;
* resultado externo.

---

# 54. Rechazar una orden directa

Puede producir:

* sanción;
* sustitución;
* pérdida de confianza;
* conflicto;
* misión asignada a otra unidad.

## Diferencia

Rechazar una petición civil no equivale a desobedecer a un comandante.

---

# 55. Cancelación

Una misión puede cancelarse por:

* objetivo destruido;
* actor muerto;
* sector cambiado;
* tratado;
* ruta imposible;
* acto avanzado.

## Resultado

Debe registrar:

* causa;
* consecuencias;
* recursos comprometidos.

---

# 56. Misiones encadenadas

Una cadena tendrá máximo habitual de:

```text
2–4 misiones
```

## Ejemplo logístico

1. Reconocer ruta.
2. Escoltar convoy.
3. Recuperar carga.
4. Atacar depósito captor.

## Regla

No toda cadena debe completarse.

Puede ramificarse según resultados.

---

# 57. Arcos emergentes

Varias misiones pueden formar una historia no escrita previamente.

## Ejemplo

1. El jugador salva a una médica.
2. La médica administra un hospital.
3. El hospital protege a soldados enemigos.
4. Un comandante exige arrestarla.
5. La población protesta.
6. FIA la ayuda a escapar.

Cada paso surge del estado y de relaciones persistentes.

---

# 58. Eventos emergentes civiles

## Categorías

* escasez;
* desplazamiento;
* epidemia;
* funeral;
* protesta;
* saqueo;
* huelga;
* colaboración;
* denuncia;
* mercado negro.

## Conversión a misión

Solo cuando:

* existe decisión;
* el jugador puede influir;
* el impacto es relevante.

---

# 59. Eventos emergentes militares

* contraataque;
* retirada;
* motín;
* rendición;
* deserción;
* fuego amigo;
* pérdida de comunicaciones;
* comandante muerto;
* munición agotada.

---

# 60. Eventos emergentes logísticos

* avería;
* contaminación;
* puente destruido;
* depósito incendiado;
* puerto bloqueado;
* pista dañada;
* huelga de trabajadores.

---

# 61. Eventos emergentes políticos

* decreto;
* acusación;
* golpe;
* destitución;
* negociación;
* filtración;
* cambio de alianza;
* declaración municipal.

---

# 62. Eventos de Argos

Argos evaluará:

* exposición;
* equilibrio;
* amenaza a Stratis;
* infiltrados;
* divergencia del jugador.

## Posibles eventos

* archivo trasladado;
* testigo desaparecido;
* orden retrasada;
* convoy redirigido;
* falsa bandera;
* infiltrado activa protocolo;
* Meridian refuerza acceso.

---

# 63. Presupuesto de intervención Argos

Los eventos Argos consumen:

```text
interventionCapacity
```

## Coste bajo

* retraso;
* clasificación;
* rumor.

## Coste medio

* robo;
* sabotaje;
* extracción.

## Coste alto

* asesinato;
* falsa bandera grande;
* despliegue Meridian.

## Consecuencia

Argos no puede intervenir en todos los problemas.

---

# 64. Eventos programados y eventos sistémicos

## Programados

Necesarios para el canon.

Ejemplos:

* señal de Petrou;
* fragmentación Verde;
* apertura de Stratis.

## Sistémicos

Nacen del estado.

Ejemplos:

* convoy destruido;
* hospital sin energía;
* protesta.

## Híbridos

El evento canónico ocurre, pero su forma depende del estado.

Ejemplo:

La fragmentación Verde siempre ocurre.

La región, el detonante y los supervivientes pueden variar.

---

# 65. Ritmo narrativo

El generador respetará fases de ritmo.

## Intensidad alta

* combate;
* emergencia;
* persecución.

## Intensidad media

* preparación;
* patrulla;
* logística.

## Intensidad baja

* investigación;
* diálogo;
* administración;
* recuperación.

## Regla

No ofrecer tres grandes ataques consecutivos salvo colapso real.

---

# 66. Periodos de recuperación

Después de una misión principal grande:

* reducir emergencias no críticas;
* permitir reabastecimiento;
* activar conversaciones;
* ofrecer investigación;
* mostrar consecuencias.

## Excepción

Una derrota puede impedir descanso.

---

# 67. Distancia y desplazamiento

El generador penalizará misiones que exijan atravesar Altis repetidamente sin razón.

## Soluciones

* asignar otra unidad;
* resolución externa;
* transporte;
* agrupar operaciones regionales;
* ofrecer misiones cerca del frente del jugador.

---

# 68. Regiones operativas

El jugador normalmente tendrá una región primaria activa.

## Contenido visible

* frente principal;
* 1–2 problemas secundarios;
* información nacional resumida.

## Ventaja

Mantiene coherencia y rendimiento.

---

# 69. Materialización

Una misión dinámica no colocará toda la guerra físicamente.

## Antes de comenzar

Se materializan:

* fuerzas implicadas;
* objetivos;
* composiciones;
* civiles relevantes;
* vehículos.

## Durante

Se pueden añadir:

* refuerzos;
* QRF;
* eventos.

## Después

Se reintegran:

* bajas;
* recursos;
* daños;
* vehículos;
* control.

---

# 70. Persistencia durante misión

Debe guardarse:

* estado de objetivos;
* fuerzas;
* vehículos importantes;
* evidencia;
* consecuencias parciales.

## No es necesario guardar

* cada proyectil;
* cada posición exacta de enemigo genérico;
* cada waypoint temporal.

---

# 71. Misión interrumpida por guardado

Al cargar:

* reconstruir fase;
* restaurar activos;
* evitar duplicar recompensas;
* conservar bajas registradas;
* restaurar objetivos.

---

# 72. Semillas de generación

Cada misión tendrá:

```text
generationSeed
```

Permite:

* reproducir problemas;
* depurar;
* reconstruir variante.

## No implica

Que toda IA táctica actúe exactamente igual.

---

# 73. Misiones en cooperativo futuro

El servidor:

* genera;
* valida;
* asigna;
* persiste;
* resuelve.

Los jugadores pueden votar:

* aceptación;
* prioridad;
* método;
* asignación.

## Regla

Una misión no se duplicará para cada cliente.

---

# 74. Plantilla de ejemplo — Convoy crítico

```text
Template:
TPL_LOGISTICS_CRITICAL_CONVOY

Origen:
Déficit crítico en un sector

Variantes:
- escolta
- despeje
- contraemboscada
- ruta alternativa

Requisitos:
- origen con recurso
- destino conectado
- vehículos disponibles
- amenaza superior a mínimo

Resultados:
- carga completa
- carga parcial
- pérdida
- captura
```

---

# 75. Ejemplo Azul — Combustible para Lakka

## Estado

* Lakka P1;
* combustible crítico;
* Katalaki posee reserva;
* Neochori estable;
* ataques FIA en ruta secundaria.

## Opciones generadas

1. Convoy pesado por carretera principal.
2. Dos convoyes ligeros.
3. Capturar depósito Verde.
4. Transporte aéreo limitado.
5. Racionar y cancelar ofensiva.

## Misión ofrecida

Rourke propone despejar la ruta principal.

Laurent advierte que atraviesa una zona de desplazados.

La misión combina:

* logística;
* civil;
* riesgo de emboscada.

---

# 76. Ejemplo Rojo — Apertura de Sofia

## Estado

* convoyes acumulados en Molos;
* Sofia neutral;
* Vahid exige paso;
* unidad Verde local dividida.

## Misión

Negociar o preparar ruptura.

## Variantes

* reunión;
* infiltración;
* ultimátum;
* asalto.

## Consecuencias

La misma necesidad logística puede resolverse de formas políticas o militares.

---

# 77. Ejemplo Verde — Retirada de aeropuerto

## Estado

* Airport West amenazado;
* combustible y técnicos presentes;
* Varos ordena conservar personal;
* Sarris ordena defender.

## Oferta al jugador

Según campaña:

### Azul

Interceptar evacuación.

### Rojo

Proteger o capturar técnicos.

### Aliado Verde

Abrir corredor.

---

# 78. Ejemplo FIA — El almacén de armas

## Estado

* guarnición Verde abandona pueblo;
* depósito parcialmente intacto;
* Kallas quiere capturarlo;
* Markou teme militarización.

## Opciones

* entregar armas a FIA;
* destruir;
* registrar con municipio;
* ocultar;
* permitir que Verde las recupere.

---

# 79. Plantillas mínimas del vertical slice

La primera biblioteca dinámica tendrá:

1. Reconocimiento de ruta.
2. Reconocimiento de sector.
3. Defensa de puesto.
4. Contraataque.
5. Escolta de convoy.
6. Reacción a emboscada.
7. Recuperación de vehículo.
8. Evacuación de heridos.
9. Protección civil.
10. Captura de prisionero.
11. Investigación de transmisión.
12. Sabotaje de comunicaciones.

---

# 80. Variantes mínimas por plantilla

Cada plantilla del vertical slice deberá tener:

* 2 localizaciones;
* 2 composiciones enemigas;
* 2 complicaciones;
* 2 resultados parciales;
* 1 transformación por expiración.

No significa combinar todo aleatoriamente.

Significa disponer de suficiente variación validada.

---

# 81. Estado del generador

```sqf
IF_missionDirector = createHashMapFromArray [
    ["activeMainMissionId", ""],
    ["activeOperationIds", []],
    ["activeEmergencyIds", []],
    ["availableInvestigationIds", []],
    ["queuedNeeds", []],
    ["recentMissionTags", []],
    ["emitterCooldowns", createHashMap],
    ["regionActivity", createHashMap],
    ["globalPacingState", "MEDIUM"]
];
```

---

# 82. Modelo de necesidad

```sqf
IF_need = createHashMapFromArray [
    ["id", "NEED_BLUE_LAKKA_FUEL"],
    ["type", "LOGISTICS_DEFICIT"],
    ["originSystem", "ECONOMY"],
    ["requesterId", "CHAR_BLUE_ROURKE"],
    ["sectorId", "ALT_CW_LAKKA"],
    ["priority", "URGENT"],
    ["createdAt", 1040],
    ["softDeadline", 1160],
    ["hardDeadline", 1280],
    ["requiredResource", "FUEL"],
    ["requiredAmount", 24],
    ["ignoredOutcome", "OFFENSIVE_DELAYED"],
    ["resolved", false]
];
```

---

# 83. Modelo de misión dinámica

```sqf
IF_dynamicMission = createHashMapFromArray [
    ["id", "DYN_BLUE_A03_014"],
    ["templateId", "TPL_LOGISTICS_CONVOY_ESCORT"],
    ["originNeedId", "NEED_BLUE_LAKKA_FUEL"],
    ["campaignSide", "BLUE"],
    ["actId", "ACT_III"],

    ["requesterId", "CHAR_BLUE_ROURKE"],
    ["priority", "URGENT"],
    ["state", "OFFERED"],

    ["sectorIds", [
        "ALT_CW_NEOCHORI",
        "ALT_CW_STAVROS_WHISKEY",
        "ALT_CW_LAKKA"
    ]],

    ["objectiveStates", createHashMap],
    ["optionalObjectiveStates", createHashMap],
    ["variantTags", [
        "ROAD",
        "FUEL",
        "FIA_THREAT"
    ]],

    ["softDeadline", 1160],
    ["hardDeadline", 1280],
    ["generationSeed", 482114],
    ["consequencesApplied", false]
];
```

---

# 84. Funciones conceptuales

```text
IF_fnc_needCreate
IF_fnc_needUpdate
IF_fnc_needResolve
IF_fnc_missionDirectorTick
IF_fnc_missionGenerateCandidates
IF_fnc_missionFilterTemplates
IF_fnc_missionScoreCandidate
IF_fnc_missionInstantiate
IF_fnc_missionOffer
IF_fnc_missionTransform
IF_fnc_missionExpire
IF_fnc_missionResolve
IF_fnc_missionResolveOffscreen
IF_fnc_missionApplyConsequences
IF_fnc_eventCreateEmergent
IF_fnc_eventEvaluateMissionConversion
IF_fnc_pacingEvaluate
IF_fnc_repetitionCalculatePenalty
```

---

# 85. Validaciones antes de ofrecer

La misión no se ofrece si:

* el actor está muerto;
* el sector ya cambió;
* el objetivo no existe;
* no hay ruta;
* otra misión usa el mismo activo;
* el jugador no posee autoridad;
* la plantilla no está validada;
* el acto la prohíbe;
* no puede generar consecuencias coherentes.

---

# 86. Validación durante ejecución

El sistema debe detectar:

* objetivo destruido por otra fuerza;
* sector capturado externamente;
* actor muerto;
* tratado firmado;
* convoy desviado;
* jugador abandona zona.

## Respuesta

* adaptar;
* completar parcialmente;
* cancelar;
* transformar.

---

# 87. Validación posterior

Antes de aplicar consecuencias:

* verificar objetivos;
* contar supervivientes;
* registrar carga;
* resolver propiedad;
* actualizar relaciones;
* comprobar que no se aplicó antes.

---

# 88. Pruebas obligatorias

## Prueba 1 — Causalidad

Verificar que cada misión tenga una necesidad real.

## Prueba 2 — Repetición

Generar veinte misiones y revisar patrones.

## Prueba 3 — Expiración

Ignorar misión y comprobar transformación.

## Prueba 4 — Resolución externa

Asignar otra unidad.

## Prueba 5 — Cambio de sector

Capturar objetivo antes de aceptar.

## Prueba 6 — Actor muerto

Eliminar emisor.

## Prueba 7 — Guardado

Guardar durante misión dinámica.

## Prueba 8 — Materialización

Comprobar que no duplica fuerzas.

## Prueba 9 — Recompensas

Evitar duplicación.

## Prueba 10 — Pacing

Verificar alternancia de intensidad.

---

# 89. Criterios de calidad

Una misión dinámica será aceptable si:

1. Tiene origen claro.
2. Cambia el estado.
3. Puede fallar parcialmente.
4. Puede ser ignorada.
5. Posee consecuencias.
6. Utiliza recursos existentes.
7. No repite exactamente una misión reciente.
8. Es compatible con el acto.
9. Respeta la geografía.
10. Respeta las relaciones.
11. Puede resolverse fuera de pantalla.
12. No depende de enemigos infinitos.
13. No necesita una recompensa artificial.
14. Puede explicar por qué el jugador fue seleccionado.
15. Su variante está validada.

---

# 90. Errores que deben evitarse

1. Misiones aleatorias sin causa.
2. Enemigos creados sin reserva estratégica.
3. Convoyes sin recurso real.
4. Sectores capturados sin consecuencias.
5. Ofertas ilimitadas.
6. Emergencias permanentes.
7. Misma emboscada repetida.
8. Misiones que caducan sin efecto.
9. Civiles usados solo como decoración.
10. Investigación reducida a recoger objetos.
11. Actores muertos ofreciendo misiones.
12. Misiones incompatibles con tratados.
13. Recompensas duplicadas.
14. Guardados que reinician objetivos.
15. Cambiar objetivos arbitrariamente.
16. Complicaciones sin causa.
17. Tiempos artificiales injustificados.
18. Viajes largos sin contenido.
19. Resolver todo mediante combate.
20. Argos interviniendo en cada misión.

---

# 91. Principios obligatorios

1. Cada misión nace de una necesidad.
2. Cada necesidad pertenece a un sistema.
3. Cada misión tiene un emisor o causa.
4. Cada misión cambia el estado.
5. Ignorarla produce consecuencias.
6. Expirar puede transformarla.
7. Las misiones pueden resolverse externamente.
8. El jugador no realiza todo personalmente.
9. El mundo continúa.
10. La variedad procede de contexto y estructura.
11. El azar no sustituye causalidad.
12. Los recursos utilizados existen.
13. Las fuerzas utilizadas existen.
14. Los actores utilizados están vivos.
15. La geografía limita.
16. La política limita.
17. La logística limita.
18. Las relaciones modifican ofertas.
19. Las investigaciones modifican variantes.
20. Argos tiene capacidad limitada.
21. Los objetivos opcionales importan.
22. El fracaso parcial es válido.
23. Las misiones principales tienen prioridad.
24. El ritmo debe alternar.
25. La interfaz no debe saturar.
26. Las misiones dinámicas no sustituyen actos.
27. Los actos no ignoran la guerra dinámica.
28. Las cadenas emergentes deben conservar memoria.
29. El servidor será autoridad futura.
30. El generador debe registrar por qué creó cada misión.

---

# 92. Definición final

Las misiones dinámicas de Islas Fracturadas no existirán para mantener ocupado al jugador entre capítulos.

Existirán porque:

* una carretera fue cortada;
* un comandante perdió una reserva;
* una ciudad se quedó sin agua;
* una guarnición recibió una orden contradictoria;
* un técnico intentó escapar;
* un convoy transportaba suministros para alguien oficialmente muerto;
* una decisión anterior dejó un problema sin resolver.

El sistema no preguntará primero:

> ¿Qué tipo de misión toca ahora?

Preguntará:

> ¿Qué necesita el mundo, quién puede pedirlo y qué precio tendrá no resolverlo?

> **Una misión dinámica no es contenido aleatorio. Es una consecuencia que todavía permite intervención.**

> **Cuando el jugador no acuda, el problema no desaparecerá. Otra persona lo resolverá, fracasará o convertirá ese problema en uno nuevo.**

> **La variedad no surgirá de cambiar enemigos y coordenadas. Surgirá de cambiar causas, restricciones, personas, riesgos y consecuencias.**

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

El [Documento 4/14](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md) define cómo una fuerza pasa de ocupar un sector a gobernarlo y cómo reaccionan las comunidades.

El siguiente documento será el **5/14 — Sistema definitivo de FIA, insurgencia y guerra clandestina**.
