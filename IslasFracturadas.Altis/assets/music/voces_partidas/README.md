# ISLAS FRACTURADAS

## VOCES PARTIDAS

### *La Isla Hablará*

> **Tipo:** canción narrativa principal de campaña
> **Autor diegético:** Elias Vardis
> **Campañas relacionadas:** Fuerza Azul + Fuerza Roja + Verdad Comparada
> **Duración del máster seleccionado:** `06:57`
> **Versión generada:** MusicArt V2.5
> **Voz:** masculina
> **Estilo base:** rock alternativo antibélico cinematográfico, orquesta oscura y paisaje sonoro militar
> **Estado narrativo:** `DISEÑO_CONFIRMADO`
> **Estado del asset:** runtime y función `PROBADO` en SP; reproducción automática desactivada durante el desarrollo
> **Fuente maestra disponible:** `MP3` (único formato que permite descargar MusicArt en este caso); el pipeline parte de este archivo y no queda bloqueado esperando WAV
> **Fuente temática de autoridad:** [`docs/17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md`](../../../../docs/17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md)
> **Canon relacionado:** [`docs/02`](../../../../docs/02_STORY_BIBLE_AND_WORLD_HISTORY.md), [`docs/03`](../../../../docs/03_HELIOS_PHAROS_AND_ARGOS_DOSSIER.md), [`docs/08`](../../../../docs/08_BLUE_AND_RED_CAMPAIGN_ARCHITECTURE.md) y [`docs/09`](../../../../docs/09_CHRONOLOGY_INTELLIGENCE_AND_REVELATION.md)

---

## 1. Propósito

### 1.1. Regla técnica de fuente

El MP3 seleccionado es la fuente maestra disponible para producción. Debe conservarse byte a byte:
no se normaliza, recorta ni reemplaza en sitio. Los análisis y candidatos OGG parten de este MP3,
registran su SHA-256 y se generan primero fuera de `runtime/`. Solo un candidato validado puede
promoverse mediante copia exacta a `runtime/`. Si en el futuro aparece una fuente sin pérdida
verificable, se incorporará como fuente adicional; su ausencia actual no bloquea el pipeline ni
invalida el máster seleccionado.

**Voces Partidas** es la pieza musical que resume la tesis humana y moral de *Islas Fracturadas*.

No pertenece a Azul.

No pertenece a Rojo.

No pertenece a Verde.

No es una marcha militar, una canción de victoria ni una condena simplista de todos los participantes.

Su función es recordar que la guerra se construye mediante decisiones tomadas por personas con información incompleta, intereses legítimos, miedo, ambición, obediencia, dudas y responsabilidad propia.

La canción debe expresar que:

* tener motivos no elimina las consecuencias;
* recibir información manipulada no elimina la responsabilidad de decidir;
* obedecer una orden no vuelve invisible a quien la ejecuta;
* seleccionar qué información llega también puede modificar una guerra;
* registrar el sufrimiento no significa permanecer moralmente fuera de él;
* ninguna bandera posee por sí sola la memoria de lo ocurrido;
* la victoria militar no puede borrar lo que queda en las personas, las instituciones y el territorio;
* Altis y Stratis sobreviven a quienes intentaron decidir su futuro.

La frase central es:

> **Y cuando callen todas las voces,
> la isla hablará en nuestro lugar.**

---

## 2. Función dentro de Islas Fracturadas

La canción funciona en tres niveles.

### 2.1. Primera escucha — La guerra

El jugador puede interpretarla como una canción antibélica sobre Azul, Rojo, Verde, FIA, civiles y todos los actores atrapados en el conflicto.

Las referencias a órdenes, silencios, información, banderas y responsabilidad deben parecer universales.

### 2.2. Segunda escucha — La responsabilidad

Después de avanzar en la investigación de Helios, PHAROS y Argos, determinadas líneas adquieren otro significado.

El jugador comprende que la canción no sólo habla de soldados que obedecieron órdenes.

También habla de quienes:

* seleccionaron información;
* modificaron prioridades;
* ocultaron evidencias;
* calcularon consecuencias;
* justificaron pérdidas;
* construyeron las condiciones en las que otros terminaron tomando decisiones.

### 2.3. Escucha definitiva — Elias Vardis

Después de completar las campañas Azul y Roja y alcanzar la **Verdad Comparada**, se confirma que la canción pertenece a **Elias Vardis**.

En ese momento deja de ser únicamente una reflexión sobre la guerra.

Se convierte también en una confesión indirecta.

Vardis nunca declara:

> «Yo provoqué la guerra.»

La letra conserva algo mucho más importante.

Reconoce su responsabilidad sin apropiarse de las decisiones que tomaron otras personas.

Por eso adquieren un nuevo significado líneas como:

> Yo escondí un sol bajo una piedra.

> No encendí todos los incendios,
> pero supe hacia dónde soplar.

> No pronuncié cada mandato,
> pero elegí qué verdad debía llegar.

> Pensé que contar a los caídos
> bastaba para no hacerlos caer.

> Todos dejamos la firma.

---

## 3. Regla de conocimiento y spoilers

La identidad de Elias Vardis como autor **no debe exponerse prematuramente al jugador**.

Mientras `dualCampaignCompleted != true`, cualquier aparición descubrible de la canción debe utilizar crédito oculto, incompleto o no autenticado.

Presentación permitida antes de la Verdad Comparada:

**VOCES PARTIDAS**
*La Isla Hablará*
`Autor no identificado`

o:

**VOCES PARTIDAS**
`Archivo recuperado — procedencia sin autenticar`

Después de `dualCampaignCompleted == true`:

**ISLAS FRACTURADAS**
**VOCES PARTIDAS**
*La Isla Hablará*
**Elias Vardis**

La música puede contener pistas antes de esta revelación.

Los metadatos del juego no pueden confirmar lo que la campaña todavía no ha demostrado.

---

## 4. Función de las dos campañas

### Campaña Azul

La canción debe resonar con:

* la intervención presentada inicialmente como protección;
* la contradicción entre intervención temporal y permanencia;
* decisiones sobre civiles, territorio y legitimidad;
* obediencia y conflictos de mando;
* información de Helios utilizada antes de comprender su origen;
* consecuencias producidas incluso cuando las intenciones iniciales eran defendibles.

### Campaña Roja

Debe resonar con:

* la entrada basada en una solicitud auténtica pero limitada;
* la percepción de actuar frente a una invasión ya iniciada;
* la relación con Gobierno y Fuerza Verde;
* la tensión entre alianza, protección y subordinación;
* información parcial convertida en certeza operacional;
* responsabilidad por las decisiones tomadas bajo presión.

### Verdad Comparada

Al terminar ambas campañas, la canción une las dos perspectivas sin declarar que eran idénticas.

Azul y Rojo:

* tuvieron motivos diferentes;
* recibieron información diferente;
* aplicaron doctrinas diferentes;
* cometieron decisiones diferentes;
* produjeron consecuencias diferentes.

La canción no afirma que todos fueran igualmente culpables.

Afirma que:

> **cada actor dejó una firma distinta sobre la misma guerra.**

---

## 5. Arco sonoro

La arquitectura sonora sigue este recorrido:

**MAR → LLEGADA → OCUPACIÓN → GUERRA → RUINAS → RESPONSABILIDAD → MEMORIA → MAR**

### Mar

La isla existe antes que los ejércitos.

Oleaje, viento, piano grave y radio casi imperceptible.

### Llegada

Aparecen helicópteros lejanos, comunicaciones y movimiento militar.

Todavía existe distancia.

### Ocupación

Convoyes, motores, pasos, infraestructura y comunicaciones indican que las fuerzas ya no están llegando: están permaneciendo.

### Guerra

Único tramo deliberadamente saturado.

Artillería, rotores, radio, percusión y combate crecen hasta alcanzar máxima intensidad.

Después:

**corte absoluto.**

Un único casquillo cae sobre hormigón.

### Ruinas

La guerra desaparece del primer plano.

Quedan piano, cello, viento, edificios vacíos y memoria.

### Responsabilidad

Durante **La firma**, los efectos prácticamente desaparecen.

La letra ocupa todo el espacio.

### Memoria

La orquesta regresa, pero deja de sonar militar.

El clímax ya no representa poder.

Representa personas.

### Mar

La canción termina donde comenzó.

Los ejércitos desaparecen.

Las islas permanecen.

---

## 6. Regla principal de silencio

El momento:

> Y cuando callen todas las voces...

debe provocar una retirada casi completa de la instrumentación.

Después:

> **la isla hablará en nuestro lugar.**

No utilizar:

* explosiones;
* disparos;
* radio;
* percusión militar;
* impacto cinematográfico;
* coro dominante.

La voz debe quedar prácticamente expuesta.

Después entran únicamente mar y viento.

El silencio no es ausencia de producción.

**Es parte de la composición.**

---

# 7. LETRA DEFINITIVA

## [Intro — Mar negro]

*[Oleaje suave. Viento costero. Radio militar muy distante. Piano grave.]*

Antes de alzar una bandera,
escucha su peso al caer.

Hay órdenes dichas en nombre de todos
que nadie se atreve a escoger.

---

## [Verse 1 — La llegada]

Dos bordes del cielo ardieron juntos,
el mar devolvió el mismo rumor.

Cada llegada ofrecía refugio,
cada promesa escondía intención.

Uno guardaba sus viejos puertos.
Otro juraba no retroceder.

La isla aprendió a guardar silencio
mientras decidían por ella otra vez.

---

## [Pre-Chorus]

Todos llegaron con sus motivos.
Casi ninguno quiso escuchar.

Cuando el interés toma la palabra,
la duda aprende a callar.

---

## [Chorus]

Voces partidas vuelven del mar.
Nadie las quiere escuchar.

Cambian de lengua, de rostro y lugar,
pero la herida vuelve a hablar.

Toda bandera promete justicia.
Todo silencio ayuda a mandar.

Y cuando callen todas las voces,
la isla hablará en nuestro lugar.

---

## [Instrumental — La presencia]

*[Motores distantes. Convoy. Radio táctica breve.]*

---

## [Verse 2 — La ocupación]

Quien prometió traer equilibrio
dejó sus piedras para perdurar.

Quien juró devolver la palabra
acabó enseñando a no preguntar.

Vi manos contrarias cerrar una herida
que una de las nuestras dejó al pasar.

Vi a un hombre bajar lentamente el arma
cuando le ordenaban disparar.

Yo también llegué con mis motivos.

Yo también elegí qué debía callar.

Desde la sombra de mi bandera
fue demasiado fácil señalar.

---

## [Pre-Chorus II]

Todos teníamos una razón.

Todos sabíamos justificar.

Pero una orden no pierde su peso
porque otro la quiera firmar.

---

## [Chorus II]

Voces partidas vuelven del mar.
Nadie las quiere escuchar.

Cambian de lengua, de rostro y lugar,
pero la herida vuelve a hablar.

Toda bandera promete justicia.
Todo silencio ayuda a mandar.

Y cuando callen todas las voces,
la isla hablará en nuestro lugar.

---

## [Interlude — La guerra]

*[Radio. Artillería distante. Rotores. Combate. Intensidad creciente.]*

*[Corte total.]*

*[Silencio.]*

*[Un casquillo cae sobre hormigón.]*

---

## [Verse 3 — Después]

Vi rostros conocidos negar el sustento
mientras el hambre aprendía a esperar.

Vi al que hablaba de puertas abiertas
guardar la última llave y cerrar.

Yo escondí un sol bajo una piedra
para obligar a la noche a ceder.

Cubrí con ceniza parte de su lumbre
y llamé prudencia a no dejarla ver.

No encendí todos los incendios,
pero supe hacia dónde soplar.

No pronuncié cada mandato,
pero elegí qué verdad debía llegar.

Pensé que contar a los caídos
bastaba para no hacerlos caer.

*[Silencio.]*

Pero quien inclina la balanza
también decide sobre quién ha de pesar.

---

## [Bridge — La firma]

El miedo habló con muchas voces.

La herida guardó una sola memoria.

Importa quién escribió la orden.

Importa quién decidió ejecutar.

Importa quién convirtió la duda
en certeza antes de avanzar.

Importa quién eligió qué voces
podían llegar y cuáles callar.

*[Pausa.]*

En cada puerto.

En cada casa.

En cada nombre que nadie pronuncia.

Todos dejamos la firma.

*[Silencio completo.]*

---

## [Final Chorus I — La memoria]

Voces partidas vuelven del mar.

Ya no preguntan quién tuvo razón.

Traen en sus nombres la memoria
del precio de cada decisión.

Toda bandera habló de justicia.

Todo silencio ayudó a mandar.

Y cuando callen todas las voces...

*[Todo se detiene.]*

la isla hablará en nuestro lugar.

*[Mar y viento.]*

---

## [Final Chorus II — Los nombres]

Voces partidas vuelven del mar.

Traen los nombres que hicimos callar.

No hay uniforme que esconda la memoria.

No hay victoria que pueda borrar

lo que dejamos bajo las ruinas,

lo que elegimos no preguntar.

Cuando no quede nadie para contarlo,

la isla nos recordará.

---

## [Outro — La luz bajo la piedra]

Las islas guardarán el eco
de aquello que hicimos callar.

No preguntarán qué nombre llevamos,
sino qué dejamos al pasar.

Tal vez la luz bajo la piedra
nunca nos quiso señalar.

Sólo mostró nuestras sombras
cuando aprendimos a mirar.

*[Señal de radio distante.]*

*[Signal lost.]*

*[Oleaje.]*

*[Viento.]*

*[Silencio.]*

---

# 8. Asset musical

## Máster seleccionado

**Nombre lógico:**

`IF_Voces_Partidas_La_Isla_Hablara`

**Duración:**

`06:57`

**Archivo fuente:**

[`source/IF_Voces_Partidas_La_Isla_Hablara_MASTER.mp3`](source/IF_Voces_Partidas_La_Isla_Hablara_MASTER.mp3)

El MP3 se conserva como **máster/original de producción**.

No debe sobrescribirse con versiones comprimidas, normalizadas o preparadas específicamente para el motor.

---

## 9. Estructura recomendada

```text
IslasFracturadas.Altis/
└── assets/
    └── music/
        └── voces_partidas/
            ├── README.md
            ├── source/
            │   └── IF_Voces_Partidas_La_Isla_Hablara_MASTER.mp3
            ├── runtime/
            │   └── IF_Voces_Partidas_La_Isla_Hablara.ogg
            └── stems/
```

`source/` conserva el máster.

`runtime/` contiene únicamente derivados preparados para Arma 3.

`stems/` queda reservado para futuras versiones instrumentales, ambientales o separaciones de voz si se producen.

El máster de `source/` y el derivado `.ogg` de `runtime/` están implementados. Los *stems* permanecen
pendientes. La configuración `CfgMusic` y la función local de reproducción están probadas en Arma 3
para el caso SP de apertura. La llamada automática desde `postInit` se retiró después de validar el
caso, para que la canción no interfiera con los arranques repetidos de desarrollo. La evidencia se conserva en
[`docs/validation/MUSIC_INTRO_VOCES_PARTIDAS_2026-08-12.md`](../../../../docs/validation/MUSIC_INTRO_VOCES_PARTIDAS_2026-08-12.md).

### 9.1. Trazabilidad del runtime implementado

| Artefacto | Ruta | SHA-256 | Tamaño |
| --- | --- | --- | ---: |
| fuente maestra MP3 | `source/IF_Voces_Partidas_La_Isla_Hablara_MASTER.mp3` | `2c3f58caf25f07ba6a0093f705a8481729bc972b503f5d5741fd306bbbb42918` | 9.212.976 bytes |
| candidato validado | `production/media/drafts/audio-test/if_voces_partidas_la_isla_hablara_candidate_20260812.ogg` | `d5ec78553aa915bde7c632a9dc03d2630190a9a0db67630046e5207a29752a08` | 8.278.528 bytes |
| runtime promovido | `runtime/IF_Voces_Partidas_La_Isla_Hablara.ogg` | `d5ec78553aa915bde7c632a9dc03d2630190a9a0db67630046e5207a29752a08` | 8.278.528 bytes |

El runtime conserva exactamente el hash del candidato: Vorbis estéreo, `48 kHz`, duración
`417.000979 s`, perfil `music_high` (`libvorbis:q=6`), sin normalización ni recorte y con metadatos
no necesarios eliminados. La comprobación técnica acredita contenedor, códec, duración y
decodificación. La ejecución del 2026-08-12 acreditó además la carga de `CfgMusic`, la solicitud de
`playMusic`, una única traza de inicio, reproducción observable conforme al objetivo y ausencia de
errores RPT atribuibles a la integración.

### 9.2. Contrato de reproducción disponible

`IF_fnc_musicPlayIntro` queda registrada para una activación explícita futura únicamente en máquinas
con interfaz (`hasInterface`). Espera a que exista la interfaz de misión, no usa `remoteExec`, no crea
un bucle, no modifica el volumen elegido por el usuario y no altera estado de campaña. El servidor
dedicado no reproduce la pista. `postInit` no llama a esta función durante el desarrollo. El nombre
visible previo a la Verdad Comparada omite la autoría diegética para no revelar prematuramente a
Vardis.

---

# 10. Versiones futuras previstas

Del máster completo podrán derivarse, si la producción lo requiere:

| Variante | Función |
| --- | --- |
| `FULL` | canción completa de 06:57 |
| `INSTRUMENTAL` | versión sin voz para créditos, menú o escenas |
| `MOTIF_SEA` | mar, piano y cello |
| `MOTIF_ARRIVAL` | llegada militar contenida |
| `MOTIF_WAR` | tensión y escalada |
| `MOTIF_RUINS` | posguerra, piano y cello |
| `MOTIF_SIGNATURE` | motivo de «Todos dejamos la firma» |
| `MOTIF_ISLAND` | motivo de «la isla hablará» |
| `EPILOGUE` | edición para epílogo comparado |

Ninguna variante debe sustituir automáticamente el máster.

---

# 11. Uso recomendado en campaña

La canción completa **no debe sonar repetidamente durante operaciones normales**.

Sus usos principales son:

1. créditos o epílogo;
2. Verdad Comparada;
3. archivo musical recuperado;
4. galería o reproductor desbloqueable;
5. material promocional narrativo;
6. leitmotivs instrumentales derivados durante la campaña.

Durante combate activo deben preferirse fragmentos instrumentales breves o música reactiva.

La canción completa necesita espacio para ser escuchada.

---

# 12. Presentación definitiva en Verdad Comparada

Después de completar las dos campañas:

---

**ISLAS FRACTURADAS**

### VOCES PARTIDAS

*La Isla Hablará*

**Elias Vardis**

---

La aparición del nombre debe cambiar retrospectivamente la interpretación de la letra.

No necesita una explicación adicional.

El jugador ya debe poseer suficiente información para comprenderla.

---

# 13. Objetivo emocional final

La canción no busca que el jugador termine pensando:

> «Azul tenía razón.»

ni:

> «Rojo tenía razón.»

ni:

> «Todos eran iguales.»

Debe terminar pensando:

> **Entiendo por qué actuaron.
> Entiendo que podían haber actuado de otra manera.
> Entiendo que cada decisión dejó algo detrás.**

El último sentimiento no es victoria.

Tampoco desesperanza absoluta.

Es memoria.

Los ejércitos pasan.

Las órdenes terminan.

Las transmisiones se apagan.

**Las islas permanecen.**

---

# 14. Criterios de aceptación

La integración se considerará correcta cuando:

* la versión completa conserva aproximadamente `06:57`;
* la voz masculina mantiene carácter contenido y no heroico;
* los efectos ambientales no ocultan la letra;
* el tramo de batalla es la única saturación sonora deliberada;
* el corte posterior a la batalla es perceptible;
* «Pensé que contar a los caídos...» conserva claridad;
* «Todos dejamos la firma» recibe espacio posterior;
* «la isla hablará en nuestro lugar» queda prácticamente desnuda;
* el final vuelve al mar y al viento;
* el archivo no revela prematuramente a Vardis;
* la reproducción no bloquea una operación jugable;
* existe versión de runtime separada del máster;
* la canción sigue siendo comprensible aunque el jugador conozca sólo una campaña;
* después de la Verdad Comparada adquiere una segunda lectura coherente;
* la implementación respeta [`docs/17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md`](../../../../docs/17_DIALOGUE_RADIO_BRIEFINGS_AND_CINEMATICS.md).

---

## 15. Nota de producción

**Voces Partidas** no debe convertirse en una explicación de la conspiración.

Su función es hacer algo diferente:

**permitir que el jugador sienta el significado de lo que ya descubrió.**

La documentación explica los hechos.

Las campañas permiten vivir las decisiones.

Las evidencias permiten reconstruir la verdad.

**La canción conserva la memoria.**

Este diseño conserva las reglas audiovisuales de `docs/17`: el silencio puede ser narrativo, la
música no debe manipular constantemente las emociones y la historia debe seguir siendo comprensible
con la música desactivada. El `.ogg` y su función permanecen disponibles, pero no se reproducen
automáticamente en la misión actual de desarrollo. No son acompañamiento constante ni música
reactiva de operaciones. El MP3 de `06:57` permanece como máster sin sobrescribir.

La integración conserva evidencia `PROBADO` para la reproducción de apertura en SP. El RPT completo de
la ejecución registra la función y la clase musical como `PASS`, `introMusicRequested=true` y una
única traza `Música de apertura iniciada`; el responsable del proyecto confirmó que la reproducción
fue correcta y cumplió el objetivo planeado. Después de esa prueba se desactivó únicamente el
disparador automático de `postInit`; el asset, la clase y la función no se retiraron. Esta prueba no
acredita activadores musicales futuros, multijugador/JIP ni variantes todavía no implementadas.

La autoría diegética de Vardis es información de autor hasta la Verdad Comparada. Toda presentación al jugador debe respetar `DEC-003`–`DEC-005`: antes de completar ambas campañas solo se permiten crédito oculto, procedencia no autenticada o inferencia; el crédito completo exige `dualCampaignCompleted == true`.