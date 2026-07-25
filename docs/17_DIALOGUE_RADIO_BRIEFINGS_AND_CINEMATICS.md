# Diálogo, radio, briefings y cinemáticas

> **Estado del contenedor:** diseño confirmado y diseño en desarrollo
> **Fuente de verdad para:** diálogo, radio, briefings, audio y cinemáticas
> **Relacionados:** [16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md); [18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md); [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md)
> **Última consolidación:** 2026-07-25

## Propósito

Centralizar diálogo, radio, briefings, audio y cinemáticas sin perder requisitos, decisiones, variantes ni trazabilidad de las fuentes anteriores.

## Alcance

Este documento reúne las fuentes enumeradas en su tabla de contenido. Las áreas cuya fuente de verdad pertenece a otro documento se conservan solo como contexto y remiten al índice documental.

## Tabla de contenido

- [Matriz directora de escenas y recordatorios](#matriz-directora-de-escenas-y-recordatorios)
- [DIALOGUE RADIO BRIEFING AUDIO AND CINEMATICS SYSTEM](#fuente-dialogue-radio-briefing-audio-and-cinematics-system)

## Principios

Rigen las [convenciones de canon](00_INDEX_AND_DOCUMENTATION_MAP.md#convenciones-de-canon). En el ámbito de 17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS, ninguna mención contextual desplaza la fuente principal ni convierte diseño previsto en implementación.

## Reglas obligatorias

Son obligatorias las reglas detalladas en las fuentes integradas de 17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS, junto con la conservación de etiquetas, granularidad de requisitos y separación entre conocimiento de autor, personajes, facciones y jugador.

## Dependencias

El mapa de dependencias y fuentes de verdad está en [00_INDEX_AND_DOCUMENTATION_MAP.md](00_INDEX_AND_DOCUMENTATION_MAP.md#mapa-de-fuentes-de-verdad). Las referencias internas migradas incluyen un ancla de procedencia para mantener la trazabilidad hasta la sección de la fuente original.

## Conflictos o decisiones pendientes

Fuentes auditadas: `DIALOGUE_RADIO_BRIEFING_AUDIO_AND_CINEMATICS_SYSTEM.md`. No se identificó una pareja explícita de cánones mutuamente excluyentes. Las alternativas, hipótesis, cifras por calibrar y decisiones pendientes conservadas en esas fuentes requieren confirmación humana; su fecha no resuelve su autoridad.

## Criterios de validación

- Las fuentes declaradas para 17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS mantienen reglas, estados, secretos y pendientes.
- Sus enlaces migrados resuelven al archivo consolidado y al ancla de procedencia.
- El documento solo reclama autoridad sobre el alcance declarado en sus metadatos.

<a id="matriz-directora-de-escenas-y-recordatorios"></a>
## Matriz directora de escenas y recordatorios

> **Clasificación de sección:** `DISEÑO_CONFIRMADO`
> **Variantes de líneas y localización exacta:** `POR_CALIBRAR`

Las escenas no existen para repetir biografías ni explicar variables. Deben preparar una decisión, mostrar una reacción, advertir una transición o recordar una consecuencia. Radio, briefing, trayecto, combate, debriefing, visita y conversación privada son canales equivalentes si conservan función, acceso al conocimiento e interrupción segura.

### Contrato de escena ejecutable

```text
sceneId
dramaticFunction
requiredParticipants
functionalSubstitutes
knowledgeGate
triggerAndFallbackWindow
relationshipOrClockState
mandatoryFacts
variableLines
interruptionRule
worldOrMissionConsequence
callbackId
```

Una escena obligatoria puede variar o trasladarse, pero no desaparecer. Si falta un participante, el sustituto debe conservar la función y cambiar la voz, posición política y consecuencia.

### Obligaciones por acto

| Acto | Preparación | Reacción | Transición visible | Recordatorio diferido |
| --- | --- | --- | --- | --- |
| I | unidad y mando expresan prioridades antes de la primera elección civil/militar | al menos cuatro perspectivas reaccionan al coste | comunidad, Verde o FIA cambia conducta | el convoy o la primera noche recuerda la elección |
| II | una fuente explica qué sabe y qué no | técnico, mando y unidad discrepan sobre autenticación | confianza o acceso cambia | una predicción usada/descartada reaparece en III o VI |
| III | se presentan dos frentes que no pueden sostenerse plenamente | logística, mando y autoridad local nombran el sacrificio | ruta, servicio o guarnición muestra la prioridad | el área abandonada exige ayuda o se alía después |
| IV | municipio formula demanda concreta | ocupante, FIA, civiles y unidad interpretan seguridad de modo distinto | protesta, huelga, servicio o desplazamiento cambia | una promesa o abuso vuelve en V–VII |
| V | cada mando Verde expone autoridad y límite | aliados reaccionan a reconocimiento, subordinación o desarme | insignias, radio y fuerzas conjuntas evidencian fractura | el fragmento elegido aparece en VII–VIII |
| VI | testigo/técnico delimita riesgo de la evidencia | mandos, nativos y unidad discuten custodia | acceso, protección o silencio cambia | una copia, testigo o hipótesis vuelve en VII–VIII |
| VII | se anuncian órdenes incompatibles y consecuencias | la unidad y bloques toman posición | relevo, mediación, golpe o compromiso cambia mando | la fuerza disponible en Stratis refleja la resolución |
| VIII | cada aliado formula qué quiere preservar | personajes centrales responden a la decisión final | mundo, mando y Helios ejecutan el resultado | epílogos citan decisiones concretas sin omnisciencia |

### Llamadas de consecuencia

Toda decisión estructural recibe, como mínimo:

1. reacción inmediata de una persona presente;
2. señal de mundo o facción dentro de la siguiente ventana estratégica;
3. recordatorio posterior por un actor que conoció el hecho;
4. debriefing que distingue certeza, interpretación e incógnita;
5. epílogo o resolución personal si contribuyó al estado final.

El recordatorio no repite la opción elegida: muestra su efecto. Puede ser un número de serie, una ausencia en formación, una ruta distinta, un hospital abierto, una consigna hostil, un oficial que ahora coopera o una promesa reclamada.

### Matriz mínima del vertical slice de Neochori

| Actor | Si se protegen civiles | Si se persigue a Verde | Conocimiento permitido |
| --- | --- | --- | --- |
| Ward | reconoce disciplina y advierte el riesgo operacional | acepta la ventaja si hubo proporcionalidad; exige parte de daños | órdenes Azul y efecto inmediato, no cálculo oculto |
| Hale | cuestiona perder la unidad Verde | aprueba iniciativa y exige explotar la brecha | situación militar y su doctrina |
| Laurent | convierte la protección en cooperación verificable | pide investigación, reparación o explicación pública | contactos civiles y conducta Azul |
| Torres | vincula la decisión con confianza en Cole y cuidado de la unidad | apoya solo si no se abandonó a heridos o aliados | lo vivido por AZUR-1 |
| Comunidad | ofrece guía, refugio o información según trato | coopera por miedo, se cierra o acude a FIA | daños, promesas y rumores locales |
| Verde/FIA | Verde reordena el contraataque; FIA evalúa cooperación | Verde pierde fuerza; FIA evalúa a Azul como patrocinador o amenaza | observación local, nunca intención omnisciente |

La conversación posterior, la ruta de `IF_B_A01_M04` y el debriefing deben leer el mismo registro causal. Líneas contradictorias solo son válidas si proceden de conocimiento parcial o propaganda identificable, no de estados desincronizados.

## Contenido consolidado

<a id="fuente-dialogue-radio-briefing-audio-and-cinematics-system"></a>
## Fuente integrada: `DIALOGUE_RADIO_BRIEFING_AUDIO_AND_CINEMATICS_SYSTEM.md`

> **Procedencia:** contenido migrado de `DIALOGUE_RADIO_BRIEFING_AUDIO_AND_CINEMATICS_SYSTEM.md`. Sus etiquetas de canon, clasificación, propuesta y pendiente conservan el significado original.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--islas-fracturadas"></a>
### ISLAS FRACTURADAS

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--documento-1214-sistema-definitivo-de-diálogos-radio-briefings-audio-y-cinematografía"></a>
#### Documento 12/14 — Sistema definitivo de diálogos, radio, briefings, audio y cinematografía

**Versión:** 1.0
**Clasificación:** documento rector narrativo, audiovisual y de presentación dramática
**Campañas:** Fuerza Azul y Fuerza Roja
**Territorios:** Altis y Stratis
**Motor:** Arma 3 2.18
**Idioma base:** español
**Modalidad inicial:** campaña individual
**Preparación futura:** cooperativo de un solo bando
**Estado:** canon previo a escritura final de guiones y grabación

> **Jerarquía documental:** este Documento 12/14 gobierna voces, canales, prioridades, interrupción, briefings, debriefings, diálogos, radio, documentos, subtítulos, audio, música, escenas y cinematografía reactiva. [STORY_BIBLE.md](02_STORY_BIBLE_AND_WORLD_HISTORY.md#fuente-story-bible) conserva los hechos narrativos; [CHARACTER_RELATIONSHIPS_LOYALTIES_AND_BETRAYALS.md](07_CHARACTERS_COMMAND_AND_RELATIONSHIPS.md#fuente-character-relationships-loyalties-and-betrayals), secretos, lealtades y rupturas; [DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md](16_MISSIONS_EVENTS_AND_DYNAMIC_CONTENT.md#fuente-dynamic-missions-and-emergent-events), las causas y estados de misión; [STRATEGIC_UI_AND_PLAYER_EXPERIENCE_SYSTEM.md](15_PLAYER_UNIT_PROGRESSION_AND_DECISIONS.md#fuente-strategic-ui-and-player-experience-system), la presentación funcional y accesibilidad; [SQF_MASTER_TECHNICAL_ARCHITECTURE.md](18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md#fuente-sqf-master-technical-architecture), condiciones, efectos, persistencia, localización y contratos de implementación; y [MASTER_TESTING_PERFORMANCE_AND_BALANCE_SYSTEM.md](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system), las pruebas narrativas, de interrupción, accesibilidad y regresión.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--1-propósito"></a>
### 1. Propósito

Este documento define cómo Islas Fracturadas contará su historia mediante:

* diálogos;
* comunicaciones tácticas;
* radio estratégica;
* briefings;
* debriefings;
* conversaciones ambientales;
* informes;
* subtítulos;
* diarios;
* documentos;
* audio;
* música;
* escenas;
* cámaras;
* transiciones;
* silencios;
* interrupciones;
* consecuencias narrativas.

También establece:

* la voz de cada facción;
* la voz de cada personaje principal;
* qué información puede decirse;
* cuándo puede decirse;
* cómo evitar exposición artificial;
* cómo reaccionan los diálogos al estado persistente;
* cómo interrumpir conversaciones durante emergencias;
* cómo preservar información importante;
* cómo escribir campañas Azul y Roja diferentes;
* cómo usar cinemáticas sin quitar control innecesariamente;
* cómo representar Helios y Argos sin convertirlos en narradores omniscientes;
* cómo integrar decisiones y relaciones;
* cómo preparar localización y doblaje;
* cómo probar cada línea.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--principio-central"></a>
#### Principio central

> La historia no debe detener la guerra para explicarse.

> Debe surgir de órdenes, dudas, silencios, consecuencias, discusiones, informes incompletos y personas obligadas a hablar mientras la guerra continúa.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--2-objetivos-narrativos"></a>
### 2. Objetivos narrativos

El sistema debe conseguir que el jugador:

1. Comprenda la intención de cada misión.
2. Distinga información confirmada de interpretación.
3. Reconozca a los personajes por su forma de hablar.
4. Perciba conflictos internos antes de que sean declarados.
5. Entienda que Azul y Rojo observan realidades parciales.
6. Recuerde las consecuencias humanas.
7. Descubra Argos gradualmente.
8. Reciba información crítica incluso si una conversación se interrumpe.
9. Sienta que los personajes recuerdan decisiones.
10. Perciba que Altis continúa existiendo fuera de la misión actual.
11. Llegue a Stratis con preguntas acumuladas.
12. Comprenda el final sin depender de un monólogo explicativo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--3-principios-obligatorios-de-escritura"></a>
### 3. Principios obligatorios de escritura

1. Cada línea debe cumplir una función.
2. Los personajes no explicarán lo que todos ya saben.
3. La exposición debe tener destinatario y motivo.
4. Los rangos y relaciones modificarán el lenguaje.
5. La información incierta se expresará como incierta.
6. Los personajes pueden equivocarse.
7. Un infiltrado no hablará siempre de forma sospechosa.
8. Un comandante no revelará información clasificada sin motivo.
9. Los civiles no hablarán como analistas militares.
10. Los analistas no hablarán como narradores omniscientes.
11. El jugador no debe recibir simultáneamente cinco conversaciones.
12. Las emergencias tácticas tienen prioridad.
13. Las líneas críticas deben conservarse en registro.
14. El silencio puede ser narrativo.
15. La música no debe manipular todas las emociones.
16. Las cinemáticas deben ser breves y justificadas.
17. El jugador debe conservar control siempre que sea posible.
18. Azul y Rojo deben tener vocabulario, ritmo y conflictos distintos.
19. Helios no tendrá una voz consciente autónoma.
20. Argos no explicará toda la conspiración.
21. Los personajes deben recordar promesas, bajas y traiciones.
22. El mismo evento debe sonar diferente según quien lo relate.
23. La repetición dinámica debe utilizar variantes.
24. Los briefings deben priorizar intención sobre listas.
25. Los debriefings deben mostrar consecuencias, no puntuaciones vacías.
26. Los documentos escritos deben tener autor, fecha y propósito.
27. Toda línea crítica debe tener subtítulo.
28. La localización debe considerarse desde la primera versión.
29. Las escenas no deben depender de que un NPC mantenga una animación perfecta durante minutos.
30. La narrativa debe seguir siendo comprensible con música desactivada.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--4-capas-narrativas"></a>
### 4. Capas narrativas

La campaña utilizará seis capas.

```text id="o6as7c"
NARRATIVA PRINCIPAL
NARRATIVA OPERACIONAL
NARRATIVA DE PERSONAJES
NARRATIVA EMERGENTE
NARRATIVA AMBIENTAL
NARRATIVA DOCUMENTAL
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--5-narrativa-principal"></a>
### 5. Narrativa principal

Contiene:

* actos;
* puntos de no retorno;
* revelaciones;
* Stratis;
* Helios;
* Argos;
* decisiones finales.

Se presenta mediante:

* briefings principales;
* conversaciones;
* escenas;
* evidencias;
* informes;
* operaciones.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--6-narrativa-operacional"></a>
### 6. Narrativa operacional

Explica:

* frente;
* fuerzas;
* logística;
* objetivos;
* riesgos;
* consecuencias.

Se transmite por:

* mando;
* oficiales;
* radio;
* mapa;
* informes posteriores.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--7-narrativa-de-personajes"></a>
### 7. Narrativa de personajes

Desarrolla:

* relaciones;
* dudas;
* ambiciones;
* heridas;
* pérdidas;
* conflictos;
* lealtades.

Debe surgir en momentos apropiados:

* viaje;
* base;
* recuperación;
* guardia;
* espera;
* después de una misión.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--8-narrativa-emergente"></a>
### 8. Narrativa emergente

Nace de sistemas.

Ejemplos:

* convoy perdido;
* alcalde traicionado;
* miembro herido;
* promesa incumplida;
* sector abandonado;
* evidencia entregada al infiltrado.

Las líneas se generan mediante plantillas y condiciones.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--9-narrativa-ambiental"></a>
### 9. Narrativa ambiental

Se transmite mediante:

* actividad;
* sonido;
* carteles;
* radio local;
* conversaciones breves;
* edificios;
* daños;
* funerales;
* mercados;
* hospitales.

No debe requerir interacción obligatoria.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--10-narrativa-documental"></a>
### 10. Narrativa documental

Incluye:

* órdenes;
* informes;
* expedientes;
* mensajes;
* transcripciones;
* grabaciones;
* nóminas;
* archivos Helios;
* comunicaciones Argos.

Debe mantener:

* autor;
* destinatario;
* fecha;
* clasificación;
* contexto;
* integridad.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--11-canales-de-comunicación"></a>
### 11. Canales de comunicación

```text id="ce5do8"
PRESENCIAL
RADIO_TÁCTICA
RADIO_MANDO
RADIO_ESTRATÉGICA
CANAL_CIVIL
CANAL_CLANDESTINO
HELIOS_DATOS
DOCUMENTO
GRABACIÓN
SUBTÍTULO_AMBIENTAL
```

Cada canal tendrá:

* alcance;
* formalidad;
* seguridad;
* prioridad;
* posibilidad de interrupción;
* nivel de registro.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--12-comunicación-presencial"></a>
### 12. Comunicación presencial

Ventajas:

* lenguaje corporal;
* privacidad relativa;
* decisiones;
* emoción.

Limitaciones:

* requiere ubicación;
* puede interrumpirse;
* puede exponer a personajes.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--uso"></a>
#### Uso

* conversaciones importantes;
* conflictos;
* negociaciones;
* escenas personales;
* entrega de evidencias.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--13-radio-táctica"></a>
### 13. Radio táctica

Uso:

* contactos;
* órdenes;
* cambios inmediatos;
* bajas;
* apoyo;
* retirada.

Características:

* frases cortas;
* identificadores;
* poca exposición;
* prioridad alta.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla"></a>
#### Regla

No utilizar la radio táctica para explicar historia durante combate.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--14-radio-de-mando"></a>
### 14. Radio de mando

Uso:

* coordinación;
* intención;
* cambios operacionales;
* autorización;
* resultado.

Características:

* formal;
* más contextual;
* puede incluir conflicto controlado.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--15-radio-estratégica"></a>
### 15. Radio estratégica

Uso:

* cambios regionales;
* política;
* operaciones;
* inteligencia.

Puede aparecer:

* en centro de mando;
* briefing;
* traslado;
* pausa operacional.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--16-canal-civil"></a>
### 16. Canal civil

Incluye:

* radio local;
* autoridades;
* hospitales;
* trabajadores;
* medios.

Debe sonar diferente a redes militares:

* menos estructura;
* ruido;
* interrupciones;
* nombres locales;
* urgencias humanas.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--17-canal-clandestino"></a>
### 17. Canal clandestino

Utilizado por:

* FIA;
* informantes;
* Argos;
* contrabandistas;
* Petrou.

Características:

* mensajes incompletos;
* autenticación dudosa;
* ventanas cortas;
* códigos;
* silencios.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--18-helios-como-canal-de-datos"></a>
### 18. Helios como canal de datos

Helios no hablará como una persona consciente.

Presentará:

* alertas;
* modelos;
* estimaciones;
* recomendaciones;
* registros;
* mensajes automáticos.

Ejemplo correcto:

```text id="h2o350"
HELIOS — ALERTA LOGÍSTICA

Probabilidad de interrupción de suministro:
72 %

Factores principales:
• Bloqueo de ruta.
• Consumo superior a previsión.
• Reserva de transporte reducida.
```

Ejemplo incorrecto:

```text id="f4e083"
“Comandante, creo que deberíamos retirarnos.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--19-prioridad-de-comunicaciones"></a>
### 19. Prioridad de comunicaciones

```text id="4lfasc"
P0 — Emergencia táctica
P1 — Orden inmediata
P2 — Información operacional urgente
P3 — Narrativa principal
P4 — Conversación de personaje
P5 — Ambiente
```

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-1"></a>
#### Regla

Un mensaje de prioridad superior puede:

* interrumpir;
* pausar;
* posponer;
* resumir.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--20-interrupción-de-conversaciones"></a>
### 20. Interrupción de conversaciones

Cuando una conversación sea interrumpida:

1. Registrar punto alcanzado.
2. Atender emergencia.
3. Reanudar si sigue siendo relevante.
4. Resumir si no puede reanudarse.
5. Guardar información crítica.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--estados"></a>
#### Estados

```text id="6hw9aq"
NOT_STARTED
PLAYING
INTERRUPTED
RESUMABLE
RESUMED
SUMMARIZED
COMPLETED
CANCELLED
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--21-reanudación-natural"></a>
### 21. Reanudación natural

Ejemplo:

```text id="23z6so"
WARD:
Como decía antes de la alarma, ese informe no coincide con la cronología de Shaw.
```

No repetir toda la conversación desde el inicio.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--22-información-crítica-interrumpida"></a>
### 22. Información crítica interrumpida

Si una línea crítica no llegó a pronunciarse:

* puede enviarse como mensaje;
* añadirse al registro;
* reanudarse;
* transmitirse por otro personaje.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-2"></a>
#### Regla

Una explosión aleatoria no debe hacer que el jugador pierda permanentemente una revelación esencial.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--23-cola-narrativa"></a>
### 23. Cola narrativa

El sistema tendrá una cola para comunicaciones no urgentes.

```text id="3ycoen"
speaker
channel
priority
earliestTime
latestTime
conditions
interruptible
repeatPolicy
```

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--función"></a>
#### Función

Evitar:

* solapamientos;
* spam;
* pérdida de líneas;
* escenas simultáneas.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--24-ventanas-narrativas"></a>
### 24. Ventanas narrativas

Momentos apropiados:

* antes de misión;
* durante viaje;
* después de combate;
* en base;
* guardia nocturna;
* espera logística;
* recuperación;
* transición de acto.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--momentos-inapropiados"></a>
#### Momentos inapropiados

* fuego intenso;
* conducción peligrosa;
* aterrizaje;
* órdenes simultáneas;
* interacción crítica.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--25-ritmo-de-conversación"></a>
### 25. Ritmo de conversación

La narrativa alternará:

```text id="8d6h55"
INFORMACIÓN
ACCIÓN
SILENCIO
REACCIÓN
DECISIÓN
CONSECUENCIA
```

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-3"></a>
#### Regla

No encadenar largos bloques de exposición antes de cada misión.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--26-briefings"></a>
### 26. Briefings

Cada briefing debe responder:

1. ¿Qué ocurre?
2. ¿Qué quiere conseguir el mando?
3. ¿Qué se sabe?
4. ¿Qué se desconoce?
5. ¿Qué recursos existen?
6. ¿Qué restricciones se aplican?
7. ¿Qué puede decidir el jugador?
8. ¿Qué ocurre si fracasa o se demora?

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--27-estructura-del-briefing"></a>
### 27. Estructura del briefing

```text id="88l5sk"
SITUACIÓN
INTENCIÓN
MISIÓN
ENEMIGO
FUERZAS AMIGAS
CIVILES
TERRENO
LOGÍSTICA
INTELIGENCIA
RESTRICCIONES
AUTORIDAD
CONTINGENCIAS
```

No todos los apartados necesitan igual extensión.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--28-intención"></a>
### 28. Intención

Debe escribirse antes que la lista de objetivos.

Ejemplo:

```text id="2gphxl"
INTENCIÓN

Mantener una ruta logística segura entre Katalaki y Neochori para permitir que la cabeza de playa sobreviva la primera noche.
```

Esto permite que el jugador improvise sin perder el propósito.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--29-misión"></a>
### 29. Misión

Debe ser concreta.

```text id="ozwtp4"
Escolte el convoy hasta Neochori o garantice que al menos el 60 % de la carga llegue mediante una ruta alternativa.
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--30-inteligencia-del-briefing"></a>
### 30. Inteligencia del briefing

Distinguir:

```text id="a5j0o7"
CONFIRMADO
ESTIMADO
DESCONOCIDO
CONTRADICTORIO
```

Ejemplo:

```text id="7hcrmb"
Confirmado:
Una escuadra Verde controla el cruce principal.

Estimado:
Posible equipo antitanque en las alturas.

Desconocido:
Reservas desde Stavros.

Contradictorio:
Un informante afirma que FIA también prepara una emboscada.
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--31-autoridad-en-briefing"></a>
### 31. Autoridad en briefing

Debe indicar qué puede decidir el jugador.

Ejemplo:

```text id="0vt9lh"
AUTORIDAD

Puede:
• Elegir ruta.
• Solicitar morteros.
• Abortar y regresar.

No puede:
• Requisar transporte civil sin autorización.
• Destruir el puente salvo emergencia.
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--32-briefing-hablado-y-escrito"></a>
### 32. Briefing hablado y escrito

El briefing hablado:

* resume;
* establece tono;
* muestra conflictos.

El escrito:

* conserva detalles;
* mapas;
* restricciones;
* información.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-4"></a>
#### Regla

No obligar al jugador a recordar cifras escuchadas una vez.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--33-rebriefing"></a>
### 33. Rebriefing

Si cambia la situación antes de iniciar:

* actualizar briefing;
* resaltar cambios;
* conservar versión anterior en historial.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--34-briefing-de-misión-dinámica"></a>
### 34. Briefing de misión dinámica

Debe ser más corto que el de misión principal.

Estructura:

```text id="dajqtl"
Problema
Emisor
Intención
Tiempo
Riesgo
Consecuencia
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--35-debriefing"></a>
### 35. Debriefing

El debriefing debe mostrar:

* intención;
* resultado;
* pérdidas;
* consecuencias;
* decisiones;
* cambios;
* información nueva.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--no-debe-centrarse-en"></a>
#### No debe centrarse en

* puntuación;
* disparos;
* enemigos eliminados;
* tiempo aislado del contexto.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--36-resultados-de-debriefing"></a>
### 36. Resultados de debriefing

```text id="zx43wz"
ÉXITO
ÉXITO PARCIAL
FRACASO CONTROLADO
FRACASO
DESASTRE
OPERACIÓN CANCELADA
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--37-debriefing-hablado"></a>
### 37. Debriefing hablado

Puede incluir:

* reacción de mando;
* conflicto;
* reconocimiento;
* crítica;
* revelación.

Debe variar según:

* resultado;
* relaciones;
* bajas;
* decisiones.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--38-informe-posterior-escrito"></a>
### 38. Informe posterior escrito

Estructura:

```text id="un6fzj"
INTENCIÓN
RESULTADO
PÉRDIDAS
RECURSOS
TERRITORIO
CIVILES
INTELIGENCIA
RELACIONES
SIGUIENTES EFECTOS
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--39-decisiones-de-diálogo"></a>
### 39. Decisiones de diálogo

Las opciones deben expresar postura.

Ejemplo:

```text id="3miiqv"
[Respaldar a Ward]
“La cabeza de playa todavía no puede sostener otra ofensiva.”

[Respaldar a Hale]
“Si dejamos que se organicen, pagaremos el doble mañana.”

[Proponer alternativa]
“Consolidemos Neochori y enviemos reconocimiento a Stavros.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--40-evitar-opciones-falsas"></a>
### 40. Evitar opciones falsas

No ofrecer tres frases que produzcan exactamente el mismo resultado.

Las diferencias pueden afectar:

* relación;
* autoridad;
* plan;
* información;
* tiempo;
* tono.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--41-opciones-bloqueadas"></a>
### 41. Opciones bloqueadas

Una opción puede aparecer bloqueada con causa.

```text id="yv6j60"
[Presentar evidencia] — No posee prueba autenticada.
[Invocar autoridad] — Autoridad política insuficiente.
[Contactar a Markou] — Relación rota.
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--42-silencio-como-opción"></a>
### 42. Silencio como opción

El jugador puede:

* no responder;
* observar;
* posponer;
* negarse a comprometerse.

El silencio debe tener interpretación contextual.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--43-respuestas-temporizadas"></a>
### 43. Respuestas temporizadas

Solo se utilizarán cuando:

* la presión sea dramáticamente real;
* la situación no pueda esperar;
* el tiempo forme parte de la decisión.

No usar temporizador en conversaciones políticas complejas sin motivo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--44-memoria-de-conversación"></a>
### 44. Memoria de conversación

Los personajes recordarán:

* promesas;
* mentiras;
* apoyo;
* humillación;
* evidencia;
* silencios;
* decisiones.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--ejemplo"></a>
#### Ejemplo

```text id="r64rre"
WARD:
La última vez pediste tiempo y lo utilizaste bien. Tienes una hora.
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--45-variantes-de-relación"></a>
### 45. Variantes de relación

Una misma información puede expresarse de forma distinta.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--ward-con-confianza-alta"></a>
#### Ward con confianza alta

```text id="4al9or"
Necesito tu juicio, no una respuesta automática.
```

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--ward-con-confianza-baja"></a>
#### Ward con confianza baja

```text id="ckk3ir"
La orden está clara. Esta vez no improvises fuera de sus límites.
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--46-voz-de-la-campaña-azul"></a>
### 46. Voz de la campaña Azul

Características:

* lenguaje profesional;
* énfasis en autorización;
* riesgo;
* coalición;
* inteligencia;
* responsabilidad pública.

Conflicto interno:

```text id="kvikgv"
consolidación
frente a
explotación rápida
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--47-vocabulario-azul"></a>
### 47. Vocabulario Azul

Términos frecuentes:

* intención;
* autorización;
* evaluación;
* riesgo;
* protección;
* consolidación;
* reglas de enfrentamiento;
* Coalición;
* fuente;
* confirmación.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--evitar-exceso-de"></a>
#### Evitar exceso de

* tecnicismos sin utilidad;
* heroísmo grandilocuente;
* lenguaje idéntico entre todos los oficiales.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--48-elena-ward"></a>
### 48. Elena Ward

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz"></a>
#### Voz

* precisa;
* contenida;
* analítica;
* consciente de consecuencias.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--habla"></a>
#### Habla

* formula preguntas;
* distingue hechos y evaluaciones;
* evita amenazas teatrales;
* reconoce incertidumbre.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-representativas"></a>
#### Frases representativas

```text id="zalv4q"
“Dime qué sabes. Después dime qué estás suponiendo.”

“Capturar el sector no significa que podamos conservarlo.”

“No necesito que Helios decida. Necesito saber qué datos utilizó.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--49-marcus-hale"></a>
### 49. Marcus Hale

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-1"></a>
#### Voz

* directa;
* ofensiva;
* impaciente;
* militarmente lógica.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--habla-1"></a>
#### Habla

* utiliza verbos de acción;
* mide oportunidades;
* considera el tiempo un recurso;
* no es un caricaturesco amante de la violencia.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases"></a>
#### Frases

```text id="et6jkp"
“Cada hora que usamos para confirmar, ellos la usan para fortificar.”

“No te pedí que destruyeras la ciudad. Te pedí que no dejaras escapar la reserva.”

“Una línea que no presiona termina retrocediendo.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--50-thomas-rourke"></a>
### 50. Thomas Rourke

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-2"></a>
#### Voz

* práctica;
* logística;
* terrenal;
* poco ceremonial.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--habla-2"></a>
#### Habla

* explica limitaciones;
* utiliza tiempo, carga, rutas;
* desconfía de planes sin transporte.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-1"></a>
#### Frases

```text id="fpcyw7"
“El combustible no discute con la estrategia. Se acaba.”

“Puedo enviar el convoy o la escolta. No tengo ambos.”

“Si quieres esa compañía en Lakka, dime quién cubrirá Neochori.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--51-miriam-kessler"></a>
### 51. Miriam Kessler

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-3"></a>
#### Voz

* técnica;
* meticulosa;
* reservada;
* incisiva.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--habla-3"></a>
#### Habla

* distingue autenticidad e interpretación;
* corrige simplificaciones;
* evita conclusiones sin cadena de custodia.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-2"></a>
#### Frases

```text id="c88j3j"
“La firma es válida. Eso no demuestra que la orden lo sea.”

“Este informe tiene tres fuentes y un solo origen.”

“No apagues el nodo todavía. Primero necesito saber qué está intentando ocultar.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--52-sofia-laurent"></a>
### 52. Sofia Laurent

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-4"></a>
#### Voz

* política;
* empática;
* firme;
* negociadora.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--habla-4"></a>
#### Habla

* introduce consecuencias civiles;
* evita reducir personas a variables;
* utiliza nombres y compromisos.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-3"></a>
#### Frases

```text id="5emxq3"
“El alcalde no controla a toda la ciudad, pero sin él nadie abrirá el depósito.”

“Puede imponer el toque de queda. Después tendrá que gobernar a quienes sobrevivan.”

“La legitimidad no llega en el mismo convoy que las municiones.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--53-naomi-reyes"></a>
### 53. Naomi Reyes

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-5"></a>
#### Voz

* operativa;
* clara;
* orientada a personal y terreno.

Puede actuar como enlace entre:

* mando;
* unidad;
* consecuencias inmediatas.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--54-evelyn-shaw"></a>
### 54. Evelyn Shaw

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-pública"></a>
#### Voz pública

* competente;
* tranquila;
* útil;
* razonablemente cauta.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--señales-sutiles"></a>
#### Señales sutiles

* prioriza determinadas versiones;
* responde demasiado rápido;
* reduce contradicciones;
* clasifica.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-5"></a>
#### Regla

No debe sonar malvada antes de ser descubierta.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-públicas"></a>
#### Frases públicas

```text id="m7mebi"
“La fuente no es perfecta, pero coincide con el patrón.”

“Podemos discutir la metodología después de asegurar la costa.”

“No todo dato contradictorio merece el mismo peso.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--55-azur-1"></a>
### 55. AZUR-1

La escuadra debe tener conversación natural sin convertirse en comedia constante.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--funciones"></a>
#### Funciones

* comentar terreno;
* reaccionar;
* discutir;
* recordar;
* informar;
* humanizar.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-6"></a>
#### Regla

No hablar continuamente.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--56-adrian-cole"></a>
### 56. Adrian Cole

Puede representar:

* liderazgo;
* disciplina;
* identidad profesional.

Si el jugador ocupa otro personaje, Cole puede adaptarse como segundo al mando.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--57-maya-torres"></a>
### 57. Maya Torres

Voz:

* observadora;
* directa;
* sensible a población y comportamiento.

Puede detectar:

* tensión civil;
* inconsistencias humanas;
* cambios de ambiente.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--58-elias-okafor"></a>
### 58. Elias Okafor

Voz:

* médica;
* serena;
* concreta.

Evita convertir toda herida en exposición.

Frase:

```text id="biqjz6"
“Puede caminar. Eso no significa que deba seguir combatiendo.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--59-jonah-reed"></a>
### 59. Jonah Reed

Voz:

* técnica;
* curiosa;
* inquieta ante anomalías.

Puede introducir dudas sobre:

* señales;
* canales;
* Helios;
* Shaw.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--60-lucas-varga"></a>
### 60. Lucas Varga

Voz:

* ingenieril;
* práctica;
* orientada a terreno y destrucción.

Frase:

```text id="jc3v1n"
“Puedo volar el puente. Lo difícil será explicar por qué nadie puede cruzarlo mañana.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--61-daniel-ruiz"></a>
### 61. Daniel Ruiz

Voz:

* experimentada;
* enfocada en combate;
* consciente del coste humano.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--62-noah-kim"></a>
### 62. Noah Kim

Voz:

* reconocimiento;
* drones;
* detalles;
* análisis visual.

Evitar que se convierta en expositor constante de tecnología.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--63-gabriel-bennett"></a>
### 63. Gabriel Bennett

Puede aportar:

* humor contenido;
* tensión;
* observación humana.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-7"></a>
#### Regla

El humor debe surgir de personas bajo presión, no convertir la guerra en parodia.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--64-voz-de-la-campaña-roja"></a>
### 64. Voz de la campaña Roja

Características:

* lenguaje de estructura;
* corredor;
* pacto;
* continuidad;
* disciplina;
* autoridad;
* soberanía.

Conflicto interno:

```text id="qh70xq"
alianza y estabilidad
frente a
control y subordinación
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--65-vocabulario-rojo"></a>
### 65. Vocabulario Rojo

Términos frecuentes:

* mandato;
* corredor;
* Pacto;
* coordinación;
* continuidad;
* disciplina;
* orden;
* seguridad;
* cooperación;
* consolidación.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--66-darius-navid"></a>
### 66. Darius Navid

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-6"></a>
#### Voz

* política;
* estratégica;
* calmada;
* institucional.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--habla-5"></a>
#### Habla

* busca acuerdos;
* reconoce límites;
* protege legitimidad.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-4"></a>
#### Frases

```text id="lvj52f"
“Una invitación limitada no es permiso para reemplazar un Estado.”

“Podemos ganar el corredor y perder la razón por la que entramos.”

“Necesito que Verde coopere mañana, no que obedezca solo esta noche.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--67-soraya-vahid"></a>
### 67. Soraya Vahid

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-7"></a>
#### Voz

* fuerte;
* precisa;
* operacional;
* controladora.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--habla-6"></a>
#### Habla

* prioriza seguridad;
* considera ambigüedad un riesgo;
* no es irracional.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-5"></a>
#### Frases

```text id="zj4mq7"
“Una autoridad dividida no es autoridad. Es una pausa antes del siguiente ataque.”

“Si el corredor permanece abierto, podremos negociar. Si se cierra, solo quedará romperlo.”

“No confunda moderación con falta de voluntad.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--68-samir-khadem"></a>
### 68. Samir Khadem

Voz:

* Estado Mayor;
* coordinación;
* disciplina;
* análisis.

Puede actuar como figura de continuidad entre Navid y Vahid.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--69-kamran-sadeq"></a>
### 69. Kamran Sadeq

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-8"></a>
#### Voz

* técnica;
* paciente;
* orientada a protocolos.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-6"></a>
#### Frases

```text id="evoswr"
“Los dos códigos son válidos. El problema es que no deberían existir juntos.”

“Controlar el terminal no significa controlar la red.”

“Alguien conservó permisos que el sistema considera muertos.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--70-nadir-khoury"></a>
### 70. Nadir Khoury

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-9"></a>
#### Voz

* jurídica;
* diplomática;
* cuidadosa.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-7"></a>
#### Frases

```text id="6uy0kp"
“Asterión autoriza asistencia. La palabra ocupación no aparece en el texto original.”

“Una firma válida puede ratificar una cláusula inválida.”

“Si publicamos esto sin contexto, destruiremos al Gobierno antes de demostrar quién lo manipuló.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--71-laleh-arman"></a>
### 71. Laleh Arman

Puede representar:

* inteligencia humana;
* enlace político;
* observación social.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--72-rashid-volkov"></a>
### 72. Rashid Volkov

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-pública-1"></a>
#### Voz pública

* segura;
* disciplinada;
* protectora de secretos.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--señales-sutiles-1"></a>
#### Señales sutiles

* reduce dudas;
* desplaza responsabilidad;
* utiliza clasificación como respuesta.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-públicas-1"></a>
#### Frases públicas

```text id="tqo1vc"
“El mando no necesita cada hipótesis. Necesita una evaluación utilizable.”

“Esa fuente está comprometida. Déjela en mis manos.”

“La cadena de custodia es precisamente la razón por la que no debe conservar una copia.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--73-rubí-1"></a>
### 73. RUBÍ-1

La escuadra Roja debe sonar:

* profesional;
* cohesionada;
* culturalmente distinta de Azul;
* no caricaturesca.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--74-samira-qadir"></a>
### 74. Samira Qadir

Voz:

* mando;
* disciplina;
* responsabilidad.

Puede funcionar como segundo al mando o figura central según protagonista.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--75-arman-darzi"></a>
### 75. Arman Darzi

Voz:

* táctica;
* franca;
* orientada a unidad.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--76-idris-nasser"></a>
### 76. Idris Nasser

Voz:

* médica;
* pragmática;
* sensible al desgaste.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--77-nabil-farouk"></a>
### 77. Nabil Farouk

Voz:

* señales;
* sospecha;
* paciencia analítica.

Puede descubrir:

* duplicaciones;
* códigos;
* actividad PHAROS.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--78-viktor-sokolov"></a>
### 78. Viktor Sokolov

Voz:

* vehículos;
* mantenimiento;
* experiencia;
* escepticismo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--79-rashan-kerim"></a>
### 79. Rashan Kerim

Voz:

* fuerza;
* seguridad;
* agresividad controlada.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--80-levan-orlov"></a>
### 80. Levan Orlov

Voz:

* técnica;
* sistemas;
* acceso;
* equipos.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--81-yusef-baran"></a>
### 81. Yusef Baran

Voz:

* observación;
* contexto humano;
* identidad de unidad.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--82-voz-verde"></a>
### 82. Voz Verde

Fuerza Verde no debe sonar como facción genérica enemiga.

Vocabulario:

* República;
* soberanía;
* cadena nacional;
* orden legítima;
* continuidad;
* defensa;
* traición;
* ocupación.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--diferencias-internas"></a>
#### Diferencias internas

* gubernamental;
* soberanista;
* reformista;
* radical;
* profesional.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--83-andreas-kouris"></a>
### 83. Andreas Kouris

Voz:

* política;
* defensiva;
* cargada de responsabilidad.

Puede alternar entre:

* justificación;
* arrepentimiento;
* supervivencia.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--84-helena-vrettos"></a>
### 84. Helena Vrettos

Puede representar:

* institucionalidad;
* comunicación;
* administración;
* transición.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--85-theodor-laskaris"></a>
### 85. Theodor Laskaris

Puede representar:

* mando tradicional;
* soberanía;
* resistencia a extranjeros.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--86-irene-stavrou"></a>
### 86. Irene Stavrou

Puede aportar:

* análisis;
* administración;
* legalidad;
* continuidad civil.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--87-iason-demetriou"></a>
### 87. Iason Demetriou

Puede representar:

* fuerza militar;
* pragmatismo;
* situación regional.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--88-eleni-pallis"></a>
### 88. Eleni Pallis

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-10"></a>
#### Voz

* constitucional;
* contenida;
* firme.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-8"></a>
#### Frases

```text id="ig1uid"
“Una emergencia no elimina la ley. Solo revela quién estaba dispuesto a ignorarla.”

“Mi firma no autoriza lo que ese anexo afirma.”

“Si restauran el Gobierno sin restaurar sus límites, solo habrán cambiado el uniforme del ocupante.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--89-leon-varos"></a>
### 89. Leon Varos

Voz:

* militar;
* nacional;
* práctica.

Puede tener conflictos entre:

* obediencia;
* supervivencia;
* soberanía.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--90-nikos-sarris"></a>
### 90. Nikos Sarris

Puede representar:

* defensa dura;
* autoridad militar;
* resistencia.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--91-marios-daskal"></a>
### 91. Marios Daskal

Puede representar:

* continuidad;
* organización regional;
* pragmatismo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--92-thalia-koronis"></a>
### 92. Thalia Koronis

Puede representar:

* reforma;
* municipio;
* transición;
* legitimidad.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--93-elias-petrou"></a>
### 93. Elias Petrou

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-11"></a>
#### Voz

* cansada;
* precisa;
* urgente;
* dividida entre deber y conciencia.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-9"></a>
#### Frases

```text id="gl19np"
“S-26 no está vacía. Nunca lo estuvo.”

“No sé quién controla el sistema. Sé quién desaparece cuando pregunta.”

“Si llegan a Stratis como ejército de ocupación, Meridian habrá ganado antes de que encuentren la entrada.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--94-damian-rallis"></a>
### 94. Damian Rallis

Voz pública:

* burocrática;
* militar;
* útil;
* racionalizadora.

Debe ocultar infiltración sin parecer una caricatura.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--95-alexia-neris"></a>
### 95. Alexia Neris

Puede representar:

* Stratis civil;
* testimonio;
* memoria;
* resistencia interna.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--96-voz-fia"></a>
### 96. Voz FIA

FIA debe sonar heterogénea.

Vocabulario:

* comunidad;
* ocupación;
* desaparecidos;
* consejo;
* brigada;
* liberación;
* soberanía;
* justicia;
* colaboración.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--97-eleni-markou"></a>
### 97. Eleni Markou

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-12"></a>
#### Voz

* política;
* firme;
* empática;
* estratégica.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-10"></a>
#### Frases

```text id="3umlx7"
“Una resistencia que no sabe qué hará con el poder termina obedeciendo al hombre que conserva las armas.”

“No les pedimos que gobiernen Altis. Les pedimos que no la destruyan mientras dicen salvarla.”

“Kallas puede ganar una carretera. Yo necesito que la ciudad todavía quiera abrirla mañana.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--98-petros-kallas"></a>
### 98. Petros Kallas

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-13"></a>
#### Voz

* militar;
* intensa;
* coherente;
* desconfiada.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-11"></a>
#### Frases

```text id="nl6ksd"
“Los consejos no detienen blindados.”

“Cada arma que entregamos hoy será una orden que no podremos rechazar mañana.”

“No necesito que confíen en mí. Necesito que el enemigo no sobreviva para castigar a quienes sí lo hicieron.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--99-sofia-anagnostou"></a>
### 99. Sofia Anagnostou

Voz:

* médica;
* documentadora;
* moralmente firme.

Frase:

```text id="yqof1j"
“Un desaparecido no es una baja sin confirmar. Es una familia obligada a esperar sin saber a quién odiar.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--100-nikos-arvanis"></a>
### 100. Nikos Arvanis

Voz:

* profesional;
* clandestina;
* orientada a operaciones.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--101-mara-vellis"></a>
### 101. Mara Vellis

Voz:

* técnica;
* rápida;
* crítica.

Puede conectar FIA con:

* señales;
* documentos;
* Helios.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--102-tomas-leandros"></a>
### 102. Tomas Leandros

Voz:

* municipal;
* organizativa;
* comunitaria.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--103-dalia-petrakis"></a>
### 103. Dalia Petrakis

Voz:

* logística clandestina;
* costa;
* contrabando;
* conocimiento local.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--104-némesis"></a>
### 104. Némesis

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-pública-2"></a>
#### Voz pública

* radical;
* convincente;
* orientada a agravios.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-privada"></a>
#### Voz privada

* calculadora;
* selectiva;
* instrumental.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-8"></a>
#### Regla

No debe declarar filosofía Argos antes de tiempo.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-públicas-2"></a>
#### Frases públicas

```text id="yqr1lf"
“Cada tregua les da tiempo para escribir la versión en la que nosotros empezamos la guerra.”

“Los moderados siempre piden paciencia a quienes ya enterraron a alguien.”

“No hay negociación posible con una fuerza que todavía cree tener derecho a quedarse.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--105-voz-civil"></a>
### 105. Voz civil

Los civiles deben diferenciarse por:

* región;
* profesión;
* edad;
* experiencia;
* posición.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--evitar"></a>
#### Evitar

* todos hablan como víctimas;
* todos conocen política nacional;
* todos ofrecen misiones;
* todos apoyan a la misma facción.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--106-helena-drakos"></a>
### 106. Helena Drakos

Puede representar:

* autoridad local;
* administración;
* presión municipal.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--107-giorgos-manetas"></a>
### 107. Giorgos Manetas

Puede representar:

* trabajo;
* puerto;
* sindicato;
* economía.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--108-althea-marinou"></a>
### 108. Althea Marinou

Puede representar:

* medicina;
* civiles;
* servicios.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--109-elias-vornis"></a>
### 109. Elias Vornis

Puede representar:

* conocimiento local;
* transporte;
* política comunitaria.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--110-father-mikos-andreou"></a>
### 110. Father Mikos Andreou

Puede aportar:

* memoria;
* funerales;
* mediación;
* comunidad.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-9"></a>
#### Regla

No convertirlo en portavoz moral infalible.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--111-lidia-serafim"></a>
### 111. Lidia Serafim

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-14"></a>
#### Voz

* investigativa;
* clara;
* independiente.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-12"></a>
#### Frases

```text id="r5b361"
“No estoy buscando el documento que confirme la teoría. Estoy buscando el que la contradiga.”

“Las fechas no prueban una conspiración. Prueban que alguien esperaba que nadie las comparara.”

“Si dos ejércitos tienen versiones distintas del mismo hecho, empiece por preguntar quién redactó ambas.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--112-elias-vardis"></a>
### 112. Elias Vardis

> **Control de acceso narrativo:** la voz directa, presencia física y diálogo interactivo de Vardis solo pueden utilizarse después de `dualCampaignCompleted == true` y del desbloqueo de S4. En una campaña aislada solo se permiten documentos, firmas, referencias indirectas, voz no autenticada o inferencias que no establezcan `vardisConfirmed`.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-15"></a>
#### Voz

* intelectual;
* contenida;
* convencida;
* no teatral.

Debe:

* reconocer límites;
* defender decisiones;
* evitar confesión completa;
* plantear responsabilidad compartida.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--frases-13"></a>
#### Frases

```text id="rrw8bf"
“Helios no creó sus órdenes. Registró qué necesitaban creer para firmarlas.”

“Usted llama manipulación a seleccionar información. Sus mandos lo llaman inteligencia.”

“No modelamos héroes. Modelamos instituciones. Los héroes fueron el error.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--113-selene-arendt"></a>
### 113. Selene Arendt

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-16"></a>
#### Voz

* técnica;
* culpable;
* defensiva;
* capaz de autocrítica.

```text id="9cne9i"
“Construimos un sistema para mantener servicios durante una crisis. Vardis decidió que la crisis también podía mantener vivo al sistema.”

“Destruirlo es fácil. Separar lo útil de lo que Argos convirtió en arma es otra cosa.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--114-farid-nassar"></a>
### 114. Farid Nassar

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-17"></a>
#### Voz

* metodológica;
* distante;
* obsesionada con validez.

```text id="z747ae"
“Los resultados dejaron de ser válidos cuando empezaron a intervenir para conservar el modelo.”

“Una predicción que necesita corregir la realidad no es una predicción.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--115-niko-damaris"></a>
### 115. Niko Damaris

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-18"></a>
#### Voz

* jurídica;
* filosófica;
* cargada de responsabilidad.

```text id="dmh458"
“El problema nunca fue que Helios supiera demasiado. Fue que nadie pudo determinar quién tenía derecho a preguntarle.”

“PHAROS comenzó como protección. Terminó convirtiendo la supervivencia en una forma de prisión.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--116-adrian-mercer"></a>
### 116. Adrian Mercer

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--voz-19"></a>
#### Voz

* fría;
* operacional;
* controlada.

```text id="oaoes7"
“Los archivos no sobreviven por ser verdaderos. Sobreviven porque alguien conserva la sala.”

“Vardis quería observar la historia. Yo me aseguré de que nadie interrumpiera el experimento.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--117-argos-como-presencia-narrativa"></a>
### 117. Argos como presencia narrativa

Argos debe sentirse mediante:

* patrones;
* mensajes;
* omisiones;
* coincidencias;
* operaciones;
* infiltrados.

No mediante una voz omnipresente.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-10"></a>
#### Regla

El nombre Argos puede aparecer antes de comprenderse.

Su significado debe evolucionar.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--118-helios-como-presencia-narrativa"></a>
### 118. Helios como presencia narrativa

Helios debe sentirse útil antes de resultar amenazante.

Etapas:

```text id="fof72k"
Herramienta
→ sistema degradado
→ fuente contradictoria
→ infraestructura comprometida
→ instrumento Argos
→ decisión política final
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--119-narrativa-de-evidencias"></a>
### 119. Narrativa de evidencias

Cada evidencia debe tener al menos:

* descubrimiento;
* reacción;
* análisis;
* consecuencia.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--prohibición"></a>
#### Prohibición

Encontrar un documento y hacer que toda su importancia aparezca instantáneamente en una pantalla.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--120-documentos"></a>
### 120. Documentos

Tipos:

* memorando;
* orden;
* informe;
* registro;
* correo;
* mensaje;
* expediente;
* transcripción;
* manifiesto;
* nómina;
* log técnico.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--estructura"></a>
#### Estructura

```text id="jgwuw0"
Autor
Destinatario
Fecha
Clasificación
Asunto
Contenido
Anexos
Estado de integridad
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--121-lenguaje-documental"></a>
### 121. Lenguaje documental

Debe variar.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--militar"></a>
#### Militar

* intención;
* orden;
* fuerza;
* hora;
* autoridad.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--administrativo"></a>
#### Administrativo

* referencia;
* autorización;
* procedimiento;
* firma.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--helios"></a>
#### Helios

* evento;
* modelo;
* confianza;
* fuente;
* proceso.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--argos"></a>
#### Argos

* variable;
* fase;
* intervención;
* exposición;
* resultado.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--122-grabaciones"></a>
### 122. Grabaciones

Pueden incluir:

* voz;
* radio;
* entrevista;
* cámara;
* llamada.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--ventaja"></a>
#### Ventaja

Aporta emoción y autenticidad.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--riesgo"></a>
#### Riesgo

No debe sustituir toda investigación por escuchar archivos largos.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--123-diarios-y-notas-personales"></a>
### 123. Diarios y notas personales

Se utilizarán con moderación.

Deben:

* revelar humanidad;
* aportar contexto;
* no explicar sistemas que el autor no comprendería.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--124-radio-ambiental"></a>
### 124. Radio ambiental

Tipos:

* noticias;
* propaganda;
* música;
* emergencias;
* anuncios;
* llamadas.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--función-1"></a>
#### Función

Mostrar cómo cambia la percepción pública.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--125-emisoras"></a>
### 125. Emisoras

Propuestas:

```text id="stblup"
Radio Nacional de Altis
Voz de Kavala
Red del Este
Canal de Emergencia S-26
Transmisiones FIA
Emisora militar Azul
Emisora militar Roja
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--126-noticias-dinámicas"></a>
### 126. Noticias dinámicas

Las noticias pueden reaccionar a:

* capturas;
* bajas;
* protestas;
* evidencias;
* Gobierno;
* Helios.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-11"></a>
#### Regla

Los medios pueden equivocarse o servir propaganda.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--127-propaganda"></a>
### 127. Propaganda

Debe reflejar objetivos.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--azul"></a>
#### Azul

* protección;
* estabilidad;
* amenaza Roja;
* ayuda.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--rojo"></a>
#### Rojo

* invitación;
* continuidad;
* amenaza Azul;
* soberanía asistida.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--verde"></a>
#### Verde

* defensa nacional;
* ocupación extranjera.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--fia"></a>
#### FIA

* resistencia;
* desaparecidos;
* justicia.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--128-contradicción-mediática"></a>
### 128. Contradicción mediática

El mismo evento puede tener titulares distintos.

Ejemplo:

```text id="j04sdp"
Radio Azul:
“Coalición asegura corredor humanitario.”

Radio Roja:
“Fuerzas extranjeras consolidan ocupación occidental.”

Voz de Kavala:
“Carretera reabierta bajo presencia militar.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--129-subtítulos"></a>
### 129. Subtítulos

Todo contenido relevante tendrá subtítulos.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--formato"></a>
#### Formato

```text id="5u091y"
[CANAL — PERSONA, FUNCIÓN]
Texto
```

Ejemplo:

```text id="04qgh2"
[RADIO DE MANDO — ELENA WARD]
Mantengan Katalaki. No persigan más allá de la carretera.
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--130-identificación-de-hablante"></a>
### 130. Identificación de hablante

Cuando el jugador no conozca a la persona:

```text id="5kq1x4"
[VOZ DESCONOCIDA]
```

Después de identificarla:

```text id="w7844f"
[ELIAS PETROU — COMODORO, FUERZA VERDE]
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--131-subtítulos-de-radio-dañada"></a>
### 131. Subtítulos de radio dañada

Se pueden representar fragmentos.

```text id="whldqr"
[TRANSMISIÓN INCOMPLETA]
...S-26... activa... mando comprometido...
```

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-12"></a>
#### Regla

No abusar de texto ilegible.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--132-accesibilidad-de-subtítulos"></a>
### 132. Accesibilidad de subtítulos

Opciones:

* tamaño;
* fondo;
* duración;
* nombre;
* color por canal;
* descripción de sonido crítico.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--133-audio-crítico"></a>
### 133. Audio crítico

Sonidos relevantes deben tener apoyo visual o textual.

Ejemplos:

* alarma;
* artillería;
* transmisión;
* motor;
* sirena;
* llamada de rendición.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--134-diseño-de-radio"></a>
### 134. Diseño de radio

La radio puede usar:

* filtro;
* ruido;
* compresión;
* cortes.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-13"></a>
#### Regla

La inteligibilidad tiene prioridad sobre el realismo extremo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--135-diferenciación-de-canales"></a>
### 135. Diferenciación de canales

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--táctico"></a>
#### Táctico

* seco;
* cercano;
* claro.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--estratégico"></a>
#### Estratégico

* más limpio;
* formal.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--civil"></a>
#### Civil

* menos controlado;
* ambiente.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--clandestino"></a>
#### Clandestino

* inestable;
* breve;
* auténticamente imperfecto.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--helios-1"></a>
#### Helios

* tonos;
* alertas;
* voz sintética limitada opcional para mensajes automáticos neutros.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--136-voz-sintética-helios"></a>
### 136. Voz sintética Helios

Puede utilizarse para:

* código;
* alarma;
* lectura de estado.

No debe:

* expresar emociones;
* opinar;
* dialogar libremente.

Ejemplo:

```text id="ftmvg8"
“Advertencia. Integridad de datos: cuarenta y tres por ciento.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--137-sonido-de-facciones"></a>
### 137. Sonido de facciones

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--azul-1"></a>
#### Azul

* comunicaciones limpias;
* equipos modernos;
* notificaciones modulares.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--rojo-1"></a>
#### Rojo

* tonos más graves;
* estructura de mando;
* comunicaciones robustas.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--verde-1"></a>
#### Verde

* mezcla de equipos;
* interferencias;
* canales fragmentados.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--fia-1"></a>
#### FIA

* radios civiles;
* teléfonos;
* señales;
* ruido ambiental.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--138-música"></a>
### 138. Música

La música tendrá cuatro funciones.

```text id="pzp13r"
IDENTIDAD
TENSIÓN
TRANSICIÓN
MEMORIA
```

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--no-se-usará"></a>
#### No se usará

Como acompañamiento constante.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--139-leitmotivs"></a>
### 139. Leitmotivs

Pueden existir motivos para:

* Azul;
* Rojo;
* Verde;
* FIA;
* Helios;
* Argos;
* Stratis;
* población.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-14"></a>
#### Regla

Deben mezclarse cuando historias convergen.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--140-música-azul"></a>
### 140. Música Azul

Características:

* tensión contenida;
* precisión;
* amplitud;
* duda moral.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--141-música-roja"></a>
### 141. Música Roja

Características:

* peso;
* ritmo;
* disciplina;
* impulso;
* conflicto institucional.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--142-música-verde"></a>
### 142. Música Verde

Características:

* identidad nacional;
* pérdida;
* fragmentación;
* resistencia.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--143-música-fia"></a>
### 143. Música FIA

Características:

* memoria;
* comunidad;
* clandestinidad;
* tensión irregular.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--144-música-helios"></a>
### 144. Música Helios

Características:

* patrones;
* repetición;
* capas;
* pulsos;
* frialdad institucional.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--145-música-argos"></a>
### 145. Música Argos

No necesita un tema maligno evidente.

Debe surgir como variación deformada de Helios:

* notas omitidas;
* ritmos desplazados;
* capas ocultas.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--146-música-de-stratis"></a>
### 146. Música de Stratis

Debe combinar:

* aislamiento;
* vigilancia;
* continuidad;
* final técnico y humano.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--147-activación-musical"></a>
### 147. Activación musical

Por:

* estado;
* escena;
* revelación;
* intensidad;
* lugar.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--evitar-1"></a>
#### Evitar

* reinicios bruscos;
* música heroica tras daño civil;
* señalar traiciones demasiado pronto.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--148-silencio"></a>
### 148. Silencio

El silencio será importante después de:

* baja;
* desastre;
* revelación;
* decisión irreversible;
* llegada a Stratis.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--149-cinematografía"></a>
### 149. Cinematografía

Las escenas se dividirán en:

```text id="jrp3h6"
CINEMÁTICA COMPLETA
ESCENA INTERACTIVA
ESCENA AMBIENTAL
TRANSICIÓN
MOMENTO TÁCTICO
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--150-cinemática-completa"></a>
### 150. Cinemática completa

Uso limitado para:

* prólogo;
* apertura de campaña;
* transición mayor;
* llegada a Stratis;
* epílogo.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--duración-recomendada"></a>
#### Duración recomendada

Breve y enfocada.

No utilizar para cada misión.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--151-escena-interactiva"></a>
### 151. Escena interactiva

El jugador conserva:

* cámara;
* movimiento limitado o completo;
* capacidad de observar;
* posible respuesta.

Adecuada para:

* reuniones;
* bases;
* conversaciones;
* consecuencias.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--152-escena-ambiental"></a>
### 152. Escena ambiental

Ocurre sin bloquear al jugador.

Ejemplos:

* funeral;
* convoy;
* protesta;
* aterrizaje;
* trabajadores regresando.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--153-momento-táctico"></a>
### 153. Momento táctico

Pequeña secuencia dentro de combate:

* helicóptero cae;
* columna aparece;
* edificio explota;
* rendición.

No necesita quitar control.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--154-regla-de-control-del-jugador"></a>
### 154. Regla de control del jugador

Solo retirar control cuando:

* la composición visual sea esencial;
* la acción no pueda expresarse interactivamente;
* la pérdida de control sea breve;
* no exista riesgo inmediato de daño injusto.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--155-entrada-a-escena"></a>
### 155. Entrada a escena

Debe comprobar:

* combate;
* posición;
* personajes;
* estado;
* tiempo;
* cámaras;
* seguridad.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-15"></a>
#### Regla

No iniciar conversación importante mientras el NPC está bajo fuego o huyendo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--156-fallback-de-escena"></a>
### 156. Fallback de escena

Si una escena compleja falla:

* usar posiciones alternativas;
* reproducir diálogo sin cámara;
* pasar a briefing;
* registrar información.

La historia no debe bloquearse por una animación.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--157-cámaras"></a>
### 157. Cámaras

Cada cámara debe tener:

* propósito;
* sujeto;
* duración;
* transición;
* salida.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--evitar-2"></a>
#### Evitar

* giros innecesarios;
* exceso de profundidad de campo;
* cámaras que atraviesan objetos;
* mostrar spawns.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--158-encuadres"></a>
### 158. Encuadres

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--mando"></a>
#### Mando

* composición estable;
* distancia;
* jerarquía.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--personaje"></a>
#### Personaje

* proximidad;
* reacción;
* silencio.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--guerra"></a>
#### Guerra

* escala;
* movimiento;
* consecuencia.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--helios-2"></a>
#### Helios

* estructura;
* terminales;
* operadores;
* no solo pantallas.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--159-cámara-y-continuidad"></a>
### 159. Cámara y continuidad

Debe respetar:

* equipo;
* heridas;
* posición;
* hora;
* daños;
* supervivientes.

No mostrar en escena un vehículo destruido como intacto.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--160-escenas-variables"></a>
### 160. Escenas variables

Una escena puede tener variantes por:

* bando;
* relación;
* baja;
* autoridad;
* evidencia;
* resultado.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--ejemplo-1"></a>
#### Ejemplo

Reunión con Ward:

* confianza alta;
* confianza baja;
* Hale presente;
* Kessler presente;
* Shaw expuesta.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--161-prólogo-compartido"></a>
### 161. Prólogo compartido

El prólogo puede mostrar:

* atentado Helios-0;
* cobertura mediática;
* imágenes incompletas;
* continuidad oculta.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-16"></a>
#### Regla

No revelar que Vardis sobrevivió.

Debe establecer:

* ausencia;
* memoria;
* infraestructura;
* duda.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--162-apertura-azul"></a>
### 162. Apertura Azul

Debe transmitir:

* desembarco;
* incertidumbre;
* disciplina;
* urgencia;
* información incompleta.

La primera línea de mando debe orientar intención, no recitar contexto político.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--163-apertura-roja"></a>
### 163. Apertura Roja

Debe transmitir:

* mandato;
* coordinación;
* confianza institucional;
* primeras contradicciones.

La diferencia con Azul debe sentirse desde el lenguaje.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--164-primera-noche"></a>
### 164. Primera noche

Momento central para:

* cansancio;
* relaciones;
* señal de Petrou;
* primeros silencios;
* comprensión de que el conflicto es más grande.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--azul-2"></a>
#### Azul

Fragmento:

```text id="n8cjq4"
“S-26 activa.”
```

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--rojo-2"></a>
#### Rojo

Fragmento:

```text id="9xqc9s"
“Mando comprometido.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--165-revelaciones-de-acto-iiiv"></a>
### 165. Revelaciones de Acto II–IV

Deben distribuirse mediante:

* informes;
* testigos;
* conversaciones;
* documentos.

No mediante una exposición única.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--166-conflictos-de-mando"></a>
### 166. Conflictos de mando

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--azul-3"></a>
#### Azul

Ward y Hale deben:

* coincidir a veces;
* respetarse;
* discutir por prioridades reales.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--rojo-3"></a>
#### Rojo

Navid y Vahid deben:

* compartir objetivos;
* diferir en métodos;
* evitar parecer bien contra mal.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--167-revelación-de-infiltrados"></a>
### 167. Revelación de infiltrados

Debe tener tres fases.

```text id="8k0rbl"
SOSPECHA
CONFRONTACIÓN
CONFIRMACIÓN
```

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--sospecha"></a>
#### Sospecha

* comportamiento;
* evidencia;
* inconsistencias.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--confrontación"></a>
#### Confrontación

Puede producir:

* negación;
* justificación;
* escape;
* ataque.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--confirmación"></a>
#### Confirmación

No debe depender solo de que el infiltrado confiese.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--168-shaw"></a>
### 168. Shaw

Puede defenderse diciendo:

* protegía operación;
* evitaba pánico;
* la información seguía siendo válida.

Esto obliga a discutir:

* selección;
* intención;
* responsabilidad.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--169-volkov"></a>
### 169. Volkov

Puede defenderse mediante:

* seguridad;
* autoridad;
* necesidad de preservar Asterión;
* amenaza Azul.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--170-rallis"></a>
### 170. Rallis

Puede justificar:

* evitar colapso;
* preservar orden;
* seleccionar cadena “más viable”.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--171-némesis"></a>
### 171. Némesis

Puede intentar convertir su exposición en prueba de que Markou es débil o que Kallas fue manipulado.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--172-llegada-a-stratis"></a>
### 172. Llegada a Stratis

Debe sentirse como:

* lugar conocido por fragmentos;
* espacio más pequeño;
* mayor densidad;
* vigilancia;
* silencios;
* infraestructura viva.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--no-debe-sentirse"></a>
#### No debe sentirse

Como una nueva misión desconectada.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--173-primer-contacto-con-petrou"></a>
### 173. Primer contacto con Petrou

Debe variar según:

* campaña;
* investigación;
* relación con Verde;
* estado de Stratis.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--174-encuentro-con-operadores-pharos"></a>
### 174. Encuentro con operadores PHAROS

Debe evitar que todos hablen como víctimas idénticas.

Tipos:

* voluntario;
* retenido;
* convencido;
* arrepentido;
* oportunista;
* aterrado;
* leal a Vardis.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--175-confrontación-con-vardis"></a>
### 175. Confrontación con Vardis

> **Precondición obligatoria:** `dualCampaignCompleted == true`, S4 — Verdad Comparada y sala de dirección desbloqueada. Ninguna variante de campaña aislada presenta físicamente a Vardis.

No será un único monólogo.

Estructura:

1. Reconocimiento del jugador.
2. Disputa sobre hechos.
3. Uso de evidencia.
4. Responsabilidad de mandos.
5. Estado actual de Helios.
6. Decisión inmediata.
7. Consecuencia.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--176-opciones-ante-vardis"></a>
### 176. Opciones ante Vardis

Estas opciones pertenecen exclusivamente a la confrontación dual desbloqueada; no se ofrecen por alcanzar S3 en una sola campaña.

Pueden depender de:

* autoridad;
* evidencia;
* relación;
* acceso;
* fuerza;
* Mercer;
* Arendt;
* Damaris.

Opciones posibles:

* arrestar;
* negociar;
* auditar;
* copiar;
* destruir;
* transferir;
* permitir escape;
* usar como testigo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--177-mercer-en-la-escena-final"></a>
### 177. Mercer en la escena final

Mercer puede:

* destruir archivos;
* extraer a Vardis;
* traicionarlo;
* negociar;
* resistir.

Su conducta dependerá de:

* fuerza Meridian;
* rutas;
* exposición;
* supervivientes;
* evidencia.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--178-epílogos"></a>
### 178. Epílogos

Los epílogos se presentarán mediante combinación de:

* escenas;
* radio;
* documentos;
* testimonios;
* imágenes del mundo;
* narración limitada si es necesaria.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-17"></a>
#### Regla

No usar una voz omnisciente para explicar todo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--179-epílogo-comparado"></a>
### 179. Epílogo comparado

Después de ambas campañas puede mostrar:

* documentos enfrentados;
* fragmentos Azul y Rojo;
* decisiones reflejadas;
* variables UMBRAL.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--objetivo"></a>
#### Objetivo

Completar comprensión sin invalidar la experiencia de cada campaña.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--180-muertes-de-personajes"></a>
### 180. Muertes de personajes

Una muerte importante necesita:

* reacción inmediata;
* efecto operativo;
* memoria;
* posible funeral;
* cambio de líneas posteriores.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--no-siempre"></a>
#### No siempre

Una escena larga.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--181-heridas"></a>
### 181. Heridas

Los personajes heridos deben:

* sonar afectados;
* tener disponibilidad;
* modificar diálogos;
* evitar continuidad inconsistente.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--182-sustituciones-de-voz-narrativa"></a>
### 182. Sustituciones de voz narrativa

Si muere el personaje que entrega información:

* otro personaje;
* documento;
* grabación;
* informe.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-18"></a>
#### Regla

La sustitución puede reducir profundidad, pero no romper la campaña.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--183-conversaciones-de-viaje"></a>
### 183. Conversaciones de viaje

Útiles para:

* escuadra;
* contexto;
* reacción;
* memoria.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--reglas"></a>
#### Reglas

* breves;
* interrumpibles;
* variantes;
* no durante maniobras complejas.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--184-conversaciones-de-base"></a>
### 184. Conversaciones de base

Pueden ser más largas.

Categorías:

* personal;
* técnico;
* político;
* consecuencia;
* preparación.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--185-conversaciones-opcionales"></a>
### 185. Conversaciones opcionales

Deben aportar:

* relación;
* contexto;
* opción;
* humanidad.

No esconder información imprescindible sin alternativa.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--186-conversaciones-repetibles"></a>
### 186. Conversaciones repetibles

Usarán variantes por:

* acto;
* moral;
* sector;
* relación;
* bajas.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--prohibición-1"></a>
#### Prohibición

Repetir exactamente la misma frase ambiental cada pocos minutos.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--187-frases-tácticas-dinámicas"></a>
### 187. Frases tácticas dinámicas

Categorías:

```text id="l6w76a"
CONTACT
SUPPRESSION
WOUNDED
RELOAD
RETREAT
VEHICLE
CIVILIANS
OBJECTIVE
SUPPORT
```

Deben ser:

* cortas;
* claras;
* funcionales.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--188-barks-y-personalidad"></a>
### 188. Barks y personalidad

Las frases tácticas pueden conservar identidad, pero no deben impedir comprensión.

Ejemplo:

Reed:

```text id="jrcso6"
“Señal nueva, este canal no estaba activo.”
```

Varga:

```text id="puvx7e"
“Ese vehículo no se mueve sin reparación.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--189-evitar-spam-táctico"></a>
### 189. Evitar spam táctico

El sistema utilizará:

* cooldown;
* prioridad;
* probabilidad;
* relevancia;
* máximo por categoría.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--190-reacciones-a-bajas"></a>
### 190. Reacciones a bajas

Las reacciones dependerán de:

* relación;
* combate;
* urgencia.

Durante combate:

```text id="9xun4f"
“Okafor cayó. Cubran la evacuación.”
```

Después:

* conversación;
* duelo;
* consecuencia.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--191-rendición"></a>
### 191. Rendición

Las líneas deben ser claras para evitar fuego accidental.

Ejemplos:

```text id="ydno20"
“¡Alto el fuego! ¡Armas al suelo!”

“Nos rendimos. Hay heridos.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--192-reglas-de-fuego"></a>
### 192. Reglas de fuego

Las líneas deben reflejar:

* confirmación;
* civiles;
* autoridad.

Ejemplo:

```text id="39x75p"
“Objetivo no confirmado. Mantengan fuego.”
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--193-negociaciones"></a>
### 193. Negociaciones

Estructura:

1. Presentación.
2. Posiciones.
3. Demanda.
4. Concesión.
5. Riesgo externo.
6. Decisión.
7. Garantía.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-19"></a>
#### Regla

No reducir negociación a una barra de persuasión.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--194-intermediarios"></a>
### 194. Intermediarios

Pueden participar:

* alcalde;
* Markou;
* Laurent;
* Khoury;
* sacerdote;
* médico;
* oficial Verde.

Su credibilidad debe importar.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--195-garantías"></a>
### 195. Garantías

Las promesas de diálogo deben convertirse en estado.

Ejemplo:

```text id="ksjw0v"
“Si abren la ruta, el consejo conservará la administración.”
```

Genera promesa persistente.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--196-mentiras-del-jugador"></a>
### 196. Mentiras del jugador

El jugador puede:

* omitir;
* prometer sin autoridad;
* presentar información incompleta.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--consecuencia"></a>
#### Consecuencia

Los personajes pueden descubrirlo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--197-información-clasificada"></a>
### 197. Información clasificada

Un personaje puede negarse a compartir.

Ejemplo:

```text id="0jjopa"
“No tiene autorización para ese compartimento.”
```

Debe existir:

* razón;
* ruta de acceso;
* posibilidad de conflicto.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--198-localización"></a>
### 198. Localización

La escritura base será en español neutro, con diferencias culturales sin caricatura.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--reglas-1"></a>
#### Reglas

* evitar modismos excesivamente regionales;
* conservar rangos;
* mantener términos técnicos consistentes;
* permitir traducción al inglés;
* evitar juegos de palabras esenciales.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--199-longitud-de-líneas"></a>
### 199. Longitud de líneas

Para subtítulos:

* preferir líneas cortas;
* dividir frases largas;
* dejar tiempo de lectura.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--radio-táctica"></a>
#### Radio táctica

Muy corta.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--conversación"></a>
#### Conversación

Puede ser más larga.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--200-nombres-y-pronunciación"></a>
### 200. Nombres y pronunciación

Se creará una guía:

```text id="d5yb1r"
Nombre
Pronunciación
Rango
Facción
Tratamiento
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--201-dirección-de-voz"></a>
### 201. Dirección de voz

Cada personaje tendrá ficha de actuación.

```text id="owj62l"
ritmo
tono
energía
formalidad
acento permitido
emociones evitadas
referencias
```

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--ejemplo-ward"></a>
#### Ejemplo Ward

```text id="iqt0kt"
Ritmo: controlado.
Tono: profesional.
Energía: contenida.
Evitar: dramatismo excesivo.
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--202-grabación-modular"></a>
### 202. Grabación modular

Las líneas se dividirán por:

* misión;
* personaje;
* canal;
* variante.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--convención"></a>
#### Convención

```text id="z29f19"
IF_VO_BLUE_WARD_A01_M01_BRIEF_001
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--203-convención-de-archivo-de-audio"></a>
### 203. Convención de archivo de audio

```text id="hzi0xs"
{campaign}_{character}_{act}_{mission}_{context}_{line}
```

Ejemplo:

```text id="j3dp7k"
blue_ward_a01_m03_brief_001.ogg
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--204-metadatos-de-línea"></a>
### 204. Metadatos de línea

```text id="4dcqf6"
lineId
speakerId
textKey
audioPath
channel
priority
conditions
interruptible
resumePolicy
duration
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--205-modelo-de-línea"></a>
### 205. Modelo de línea

```sqf id="lvd6gd"
IF_dialogueLine = createHashMapFromArray [
    ["id", "DLG_BLUE_WARD_A01_014"],
    ["speakerId", "CHAR_BLUE_WARD"],
    ["textKey", "STR_IF_DLG_BLUE_WARD_A01_014"],
    ["audioPath", "audio\blue\ward\a01\014.ogg"],
    ["channel", "RADIO_COMMAND"],
    ["priority", 2],
    ["interruptible", true],
    ["resumePolicy", "RESUME_FROM_NEXT_LINE"],
    ["conditions", []],
    ["effects", []]
];
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--206-modelo-de-conversación"></a>
### 206. Modelo de conversación

```sqf id="qn4q0a"
IF_dialogueConversation = createHashMapFromArray [
    ["id", "CONV_BLUE_FIRST_NIGHT_WARD"],
    ["participants", [
        "CHAR_BLUE_WARD",
        "CHAR_BLUE_REED"
    ]],
    ["channel", "PRESENT"],
    ["lineIds", []],
    ["entryConditions", []],
    ["branchIds", []],
    ["interruptPolicy", "PAUSE_AND_RESUME"],
    ["completionEffects", []],
    ["state", "NOT_STARTED"]
];
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--207-modelo-de-briefing"></a>
### 207. Modelo de briefing

```sqf id="kyr1t0"
IF_briefing = createHashMapFromArray [
    ["id", "BRF_BLUE_A01_M04"],
    ["missionId", "B-I04"],
    ["titleKey", "STR_IF_BRF_BI04_TITLE"],
    ["situationKey", "STR_IF_BRF_BI04_SITUATION"],
    ["intentKey", "STR_IF_BRF_BI04_INTENT"],
    ["objectiveIds", []],
    ["intelReportIds", []],
    ["restrictionIds", []],
    ["speakerId", "CHAR_BLUE_ROURKE"],
    ["conversationId", "CONV_BLUE_BI04_BRIEF"]
];
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--208-gestor-narrativo"></a>
### 208. Gestor narrativo

Funciones:

```text id="5jv4lh"
IF_fnc_dialogueQueue
IF_fnc_dialoguePlay
IF_fnc_dialogueInterrupt
IF_fnc_dialogueResume
IF_fnc_dialogueCancel
IF_fnc_dialogueEvaluateConditions
IF_fnc_dialogueSelectVariant
IF_fnc_briefingBuild
IF_fnc_debriefingBuild
IF_fnc_subtitleShow
IF_fnc_radioPlay
IF_fnc_cinematicStart
IF_fnc_cinematicAbort
IF_fnc_narrativeRegisterMemory
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--209-condiciones-narrativas"></a>
### 209. Condiciones narrativas

Pueden incluir:

```text id="ppmtfa"
RELATION
CHARACTER_STATE
MISSION_RESULT
EVIDENCE_STATE
ACT
SECTOR_CONTROL
AUTHORITY
PROMISE
TIME
LOCATION
```

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--210-efectos-narrativos"></a>
### 210. Efectos narrativos

Pueden:

* cambiar relación;
* registrar promesa;
* compartir conocimiento;
* desbloquear misión;
* crear decisión;
* actualizar perfil.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-20"></a>
#### Regla

El diálogo no modificará directamente estructuras ajenas; usará el sistema de efectos.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--211-registro-de-conocimiento"></a>
### 211. Registro de conocimiento

Cuando una línea comunica un hecho:

```text id="c69leq"
KNOWLEDGE_SHARED
```

Debe indicar:

* hablante;
* receptor;
* hecho;
* confianza;
* fuente.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--212-evitar-metaconocimiento"></a>
### 212. Evitar metaconocimiento

La conversación solo puede usar hechos conocidos por sus participantes.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--ejemplo-2"></a>
#### Ejemplo

Kallas no puede hablar de UMBRAL si nunca recibió esa información.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--213-conversaciones-en-cooperativo-futuro"></a>
### 213. Conversaciones en cooperativo futuro

La escena debe considerar:

* varios jugadores;
* quién responde;
* quién escucha;
* voto;
* líder.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-21"></a>
#### Regla

Las líneas críticas se registran para todos.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--214-elección-de-respuesta-cooperativa"></a>
### 214. Elección de respuesta cooperativa

Opciones:

* líder elige;
* votación;
* rol autorizado;
* consenso en decisiones irreversibles.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--215-repetición-al-reconectar"></a>
### 215. Repetición al reconectar

Un jugador que entra tarde puede recibir:

* resumen;
* registro;
* briefing.

No es necesario repetir toda la cinemática para todos.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--216-narrativa-y-guardado"></a>
### 216. Narrativa y guardado

Se guardará:

* conversación iniciada;
* línea alcanzada;
* ramas;
* decisiones;
* líneas críticas entregadas;
* escenas vistas.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--217-carga-durante-diálogo"></a>
### 217. Carga durante diálogo

Al cargar:

* reiniciar desde punto seguro;
* reanudar;
* o marcar completada si la información fue registrada.

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--regla-22"></a>
#### Regla

No duplicar efectos de diálogo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--218-cinemáticas-vistas"></a>
### 218. Cinemáticas vistas

El jugador podrá:

* omitir escenas repetidas;
* volver a consultar transcripción;
* conservar decisiones.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--219-vertical-slice-narrativo"></a>
### 219. Vertical slice narrativo

El Acto I Azul debe incluir:

1. Introducción de Ward y Hale.
2. Briefing de desembarco.
3. Conversaciones de AZUR-1.
4. Reacción civil de Neochori.
5. Briefing logístico de Rourke.
6. Primera contradicción de Shaw.
7. Análisis de Reed.
8. Debriefing de convoy.
9. Conflicto Ward–Hale.
10. Transmisión nocturna de Petrou.
11. Una conversación personal opcional.
12. Un documento recuperable.
13. Un anuncio civil dinámico.
14. Un punto de no retorno menor.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--220-vertical-slice-rojo-posterior"></a>
### 220. Vertical slice Rojo posterior

Debe demostrar diferencias mediante:

* briefing de Navid;
* presión de Vahid;
* Asterión;
* códigos dobles;
* Sadeq;
* Volkov;
* diálogo con Verde;
* transmisión “mando comprometido”.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--221-prueba-1-interrupción"></a>
### 221. Prueba 1 — Interrupción

Iniciar conversación y activar combate.

Validar:

* pausa;
* emergencia;
* reanudación;
* conocimiento preservado.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--222-prueba-2-personaje-muerto"></a>
### 222. Prueba 2 — Personaje muerto

Eliminar al emisor previsto.

Validar:

* sustitución;
* briefing;
* continuidad.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--223-prueba-3-relación-alta-y-baja"></a>
### 223. Prueba 3 — Relación alta y baja

Reproducir misma conversación con dos estados.

Validar:

* tono;
* información;
* opciones.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--224-prueba-4-evidencia-ausente"></a>
### 224. Prueba 4 — Evidencia ausente

Intentar línea de confrontación sin prueba.

Validar:

* opción bloqueada;
* rama alternativa.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--225-prueba-5-radio-saturada"></a>
### 225. Prueba 5 — Radio saturada

Activar varios mensajes.

Validar:

* prioridad;
* cola;
* ausencia de solapamiento.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--226-prueba-6-subtítulos"></a>
### 226. Prueba 6 — Subtítulos

Validar:

* nombre;
* canal;
* duración;
* tamaño;
* contraste.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--227-prueba-7-escena-bajo-condiciones-inválidas"></a>
### 227. Prueba 7 — Escena bajo condiciones inválidas

Personaje en combate o ausente.

Validar:

* fallback;
* no bloqueo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--228-prueba-8-guardado-durante-conversación"></a>
### 228. Prueba 8 — Guardado durante conversación

Validar:

* estado;
* no duplicar efectos;
* reanudación.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--229-prueba-9-información-secreta"></a>
### 229. Prueba 9 — Información secreta

Comprobar que ningún personaje mencione hechos no conocidos.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--230-prueba-10-repetición"></a>
### 230. Prueba 10 — Repetición

Jugar varias misiones dinámicas.

Validar:

* variantes;
* cooldown;
* ausencia de spam.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--231-criterios-de-calidad"></a>
### 231. Criterios de calidad

Una escena o conversación será válida cuando:

1. Tiene propósito.
2. Respeta conocimiento.
3. Respeta relación.
4. Respeta estado de personajes.
5. Puede interrumpirse o tiene protección.
6. Su información crítica queda registrada.
7. No duplica el briefing escrito.
8. No explica lo evidente.
9. Mantiene voz propia.
10. Tiene duración adecuada.
11. Funciona con subtítulos.
12. Tiene fallback.
13. Sus efectos son idempotentes.
14. No bloquea la campaña.
15. Aporta decisión, emoción, contexto o consecuencia.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--232-errores-que-deben-evitarse"></a>
### 232. Errores que deben evitarse

1. Monólogos largos antes de cada misión.
2. Radio explicando toda la conspiración.
3. Personajes con la misma voz.
4. Infiltrados obviamente sospechosos desde el principio.
5. Hale y Vahid como villanos simples.
6. Ward y Navid como figuras moralmente perfectas.
7. FIA hablando como una sola persona.
8. Civiles con conocimiento imposible.
9. Helios hablando como conciencia.
10. Argos narrando sus planes.
11. Música constante.
12. Cinemáticas para cada evento.
13. Quitar control durante combate.
14. Información crítica perdible por interrupción.
15. Subtítulos sin identificación.
16. Audio radiofónico incomprensible.
17. Repetición de frases.
18. Humor constante.
19. Muertes sin reacción.
20. Decisiones de diálogo sin consecuencia.
21. Documentos sin autor o fecha.
22. Exposición sin destinatario.
23. Escenas que ignoran heridas o bajas.
24. Opciones falsas.
25. Narración omnisciente en epílogo.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--233-principios-obligatorios-finales"></a>
### 233. Principios obligatorios finales

1. La historia continúa durante la guerra.
2. Los briefings explican intención.
3. Los debriefings explican consecuencias.
4. Los personajes poseen voces distintas.
5. Azul y Rojo utilizan lenguajes diferentes.
6. Verde está fragmentada también narrativamente.
7. FIA tiene diversidad interna.
8. Helios comunica datos, no emociones.
9. Argos se revela por patrones.
10. Los infiltrados mantienen cobertura creíble.
11. La información incierta se expresa como tal.
12. La radio táctica es breve.
13. La narrativa principal tiene prioridad sin saturar.
14. Las conversaciones pueden interrumpirse.
15. La información crítica se conserva.
16. Los personajes recuerdan.
17. Las promesas se registran.
18. Las muertes cambian líneas futuras.
19. Los sustitutos existen.
20. Los documentos tienen procedencia.
21. Las noticias reflejan perspectivas.
22. La música utiliza silencio.
23. Las cinemáticas son limitadas.
24. El jugador conserva control.
25. Las escenas tienen fallback.
26. Los subtítulos son obligatorios.
27. La localización se diseña desde el inicio.
28. El audio se organiza por IDs.
29. Los efectos narrativos son idempotentes.
30. El final se comprende mediante acumulación, no confesión.

---

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--234-definición-final"></a>
### 234. Definición final

Islas Fracturadas no contará su historia mediante un narrador que explique quién tiene razón.

La contará mediante:

* una orden que llega tarde;
* un comandante que omite una duda;
* un alcalde que recuerda una promesa;
* un médico que registra un nombre;
* una escuadra que pierde a uno de sus miembros;
* un documento firmado por alguien oficialmente muerto;
* una radio que transmite solo la mitad de una advertencia;
* dos campañas que reciben partes diferentes de la misma verdad.

Ward y Hale no discutirán porque uno sea bueno y el otro malo.

Discutirán porque ambos comprenden riesgos diferentes.

Navid y Vahid no representarán paz y guerra.

Representarán dos formas incompatibles de mantener control sobre una situación que ambos consideran peligrosa.

Markou y Kallas no discutirán sobre si Altis debe ser libre.

Discutirán sobre si una libertad sin fuerza puede sobrevivir y si una fuerza sin límites merece llamarse liberación.

Vardis no podrá borrar la responsabilidad de los demás explicando Argos.

El jugador tendrá que recordar:

* qué información recibió;
* qué decidió creer;
* a quién obedeció;
* a quién protegió;
* qué verdad decidió publicar.

> **La historia no estará separada de los sistemas. Cada sistema generará situaciones que las personas necesitarán explicar, discutir, ocultar o recordar.**

> **Las mejores líneas no serán las que describan la guerra. Serán las que revelen qué cree cada persona que todavía puede salvarse dentro de ella.**

> **Cuando el jugador llegue a Stratis, no necesitará que alguien le explique por qué está allí. Cada orden contradictoria, cada pérdida, cada evidencia y cada silencio de Altis deberá haber construido ya la respuesta.**

<a id="src-dialogue-radio-briefing-audio-and-cinematics-system--estado-actualizado"></a>
#### Estado actualizado

El [Documento 13/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-testing-performance-and-balance-system) organiza pruebas unitarias, integración, E2E, escenarios manuales en 3DEN, rendimiento, estabilidad de guardados, equilibrio militar, logística, civiles, dificultad y criterios de aprobación.

El [Documento 14/14](19_IMPLEMENTATION_TESTING_ROADMAP_AND_STATUS.md#fuente-master-implementation-and-production-plan) fija el orden, alcance, entregables y puertas de producción narrativa y audiovisual. La colección rectora queda completa.
