## Lista maestra de documentos rectores

* [x] **1/14 — Arquitectura de campañas Azul y Roja**
* [x] **2/14 — Revelaciones, evidencias e investigación de Argos** — desarrollado a continuación
* [x] **3/14 — Misiones dinámicas y eventos emergentes**
* [x] **4/14 — Sistema civil, municipal, político y de estabilidad**
* [ ] **5/14 — FIA, insurgencia y guerra clandestina**
* [ ] **6/14 — Helios, inteligencia y niebla de guerra**
* [ ] **7/14 — Sistema táctico y virtualización de fuerzas**
* [ ] **8/14 — Progresión, autoridad y desbloqueos del jugador**
* [ ] **9/14 — Interfaz estratégica y experiencia del jugador**
* [ ] **10/14 — Arquitectura técnica maestra de SQF**
* [ ] **11/14 — Guía 3DEN y validación geográfica definitiva**
* [ ] **12/14 — Diálogos, radio, briefings y cinematografía**
* [ ] **13/14 — Pruebas, rendimiento y balance**
* [ ] **14/14 — Plan de implementación y producción**

# ISLAS FRACTURADAS

## Documento 2/14 — Matriz definitiva de revelaciones, evidencias e investigación de Argos

**Versión:** 1.0
**Clasificación:** documento rector narrativo, investigativo y sistémico
**Campañas:** Fuerza Azul y Fuerza Roja
**Terrenos:** Altis y Stratis
**Periodo:** prólogo, actos I–VIII y epílogo comparado
**Estado:** canon previo a implementación

> **Jerarquía documental:** este Documento 2/14 sustituye la matriz investigativa anterior. La secuencia de actos, puertas y contratos de misión procede de [BLUE_RED_CAMPAIGN_ARCHITECTURE.md](BLUE_RED_CAMPAIGN_ARCHITECTURE.md); sus estados persistentes se implementan según [PERSISTENT_CAMPAIGN_DATA_MODEL.md](PERSISTENT_CAMPAIGN_DATA_MODEL.md), y sus consecuencias finales alimentan [MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md](MODULAR_ENDINGS_AND_EPILOGUES_MATRIX.md).

---

# 1. Propósito

Este documento define cómo el jugador descubre la verdad relacionada con:

* Proyecto Helios;
* atentado contra Helios-0;
* supervivencia de Elias Vardis;
* Estación Nacional de Continuidad S-26;
* HELIOS-CORE;
* Protocolo PHAROS;
* Comité Argos;
* manipulación informativa de Azul y Rojo;
* fragmentación del mando Verde;
* infiltrados dentro de las facciones;
* Protocolo UMBRAL;
* Validación Integral de Teatro;
* responsabilidad auténtica de los actores políticos y militares.

También establece:

* qué evidencias existen;
* dónde pueden aparecer;
* quién puede interpretarlas;
* cómo se autentican;
* qué ocurre si se pierden;
* qué conclusiones desbloquean;
* cómo afectan a personajes y misiones;
* qué puede descubrirse en una sola campaña;
* qué requiere completar Azul y Rojo;
* qué condiciones permiten capturar a Vardis;
* cómo se evita que toda la investigación dependa de un único objeto perdible.

---

# 2. Decisión de diseño principal

La investigación no funcionará como una colección de documentos que el jugador encuentra para llenar un menú.

Funcionará como una cadena de conocimiento:

```text
Señal
→ pista
→ evidencia recuperada
→ autenticación
→ interpretación
→ comparación
→ conclusión
→ decisión
→ consecuencia
```

Una evidencia no proporciona automáticamente toda su verdad.

Puede ser:

* auténtica, pero incompleta;
* técnicamente correcta, pero mal interpretada;
* parcialmente modificada;
* real y colocada deliberadamente;
* falsa, pero construida con datos auténticos;
* correcta en su contenido, pero falsa en su contexto.

## Principio central

> Argos no construyó la guerra únicamente mediante documentos falsos. Construyó una situación donde documentos auténticos, distribuidos de forma selectiva, parecían demostrar conclusiones diferentes.

---

# 3. Lo que realmente ocurrió

La matriz investigativa debe conducir gradualmente hacia estos hechos.

## Verdad 1 — Helios nació en Altis

Helios-0 fue construido junto al Aeropuerto Internacional de Altis como sistema nacional de coordinación:

* civil;
* energética;
* portuaria;
* sanitaria;
* administrativa;
* militar.

---

## Verdad 2 — El atentado de Helios-0 no eliminó el proyecto

El ataque público ocurrido aproximadamente tres años antes de la invasión permitió:

* declarar muertos a Vardis y parte de su equipo;
* cerrar públicamente fases sensibles;
* trasladar operadores;
* mover archivos;
* crear una nueva estructura en Stratis.

---

## Verdad 3 — Vardis está vivo

Elias Vardis sobrevivió y dirige Argos desde Stratis.

Su muerte fue:

* preparada;
* documentada;
* aceptada institucionalmente;
* utilizada como protección.

---

## Verdad 4 — PHAROS convirtió personas vivas en muertos administrativos

PHAROS permitió:

* extraer técnicos;
* crear expedientes de fallecimiento o desaparición;
* mantener pagos indirectos a familias;
* trasladar operadores a Stratis;
* ocultar personal dentro de redes gubernamentales y contractuales.

---

## Verdad 5 — Azul recibió información verdadera presentada como certeza

La Coalición Azul poseía:

* indicios reales de preparación Roja;
* planes gubernamentales incompletos;
* actividad militar auténtica;
* contactos reales entre FIA y actores externos.

Argos presentó estos elementos como evidencia de una ocupación ya decidida.

---

## Verdad 6 — Rojo recibió una invitación auténtica, pero limitada

Kouris solicitó ayuda Roja.

La solicitud original no autorizaba necesariamente:

* ocupación abierta;
* sustitución del mando Verde;
* control completo de aeropuertos;
* integración de Helios;
* operaciones ilimitadas contra Azul.

La autoridad fue ampliada mediante anexos, interpretaciones y distribución selectiva.

---

## Verdad 7 — Las órdenes Verdes eran auténticas, pero incompatibles

No toda orden contradictoria fue falsa.

Argos y Rallis utilizaron:

* órdenes auténticas;
* canales diferentes;
* retrasos;
* prioridades alteradas;
* destinatarios parciales;
* códigos válidos.

El resultado fue que cada unidad Verde podía creer que obedecía a la autoridad legítima.

---

## Verdad 8 — Stratis nunca quedó realmente inactiva

S-26 era la cobertura oficial.

HELIOS-CORE y PHAROS operaban desde el Complejo PHAROS.

Stratis recibía:

* energía;
* alimentos;
* medicina;
* electrónica;
* operadores;
* seguridad privada;
* archivos.

---

## Verdad 9 — Argos infiltró todos los centros principales

Infiltrados confirmados:

* Evelyn Shaw — Fuerza Azul;
* Rashid Volkov — Fuerza Roja;
* Damian Rallis — Gobierno y Fuerza Verde;
* Andreas Pelagos, “Némesis” — FIA.

Cada uno conocía solamente una parte del programa.

---

## Verdad 10 — UMBRAL convirtió la crisis en una validación integral

Argos no creó todas las causas del conflicto.

Aprovechó y organizó:

* rivalidades;
* miedos;
* planes existentes;
* decisiones auténticas;
* errores políticos.

UMBRAL buscaba comprobar si Helios podía:

* modelar decisiones;
* distribuir información selectiva;
* mantener varios actores activos;
* predecir escalada;
* observar respuestas humanas bajo presión.

---

## Verdad 11 — Los comandantes siguen siendo responsables

Descubrir Argos no absuelve a:

* Ward;
* Hale;
* Navid;
* Vahid;
* Kouris;
* Varos;
* Markou;
* Kallas.

Argos modificó el contexto de decisión.

No controló físicamente sus voluntades.

---

# 4. Principios obligatorios de investigación

1. Ninguna conclusión esencial dependerá de una sola evidencia.
2. Las evidencias importantes tendrán rutas alternativas.
3. Perder un documento no destruirá toda la campaña.
4. Las campañas Azul y Roja revelarán partes distintas.
5. Una campaña podrá descubrir gran parte de Argos.
6. La verdad completa requerirá comparar ambas.
7. El jugador podrá llegar a Stratis con conocimiento incompleto.
8. Investigar tendrá costes militares y políticos.
9. Entregar una evidencia modificará su disponibilidad.
10. Publicarla será diferente de entregarla a un comandante.
11. Una evidencia auténtica podrá producir una interpretación falsa.
12. Argos utilizará contradicciones, no falsificaciones perfectas ilimitadas.
13. Los personajes técnicos no interpretarán automáticamente cuestiones políticas.
14. Los políticos no podrán autenticar por sí solos datos técnicos.
15. Los testimonios humanos serán esenciales.
16. Los documentos no sustituirán a las personas afectadas.
17. Las familias PHAROS deben convertir la conspiración en una tragedia humana.
18. El menú investigativo mostrará lo conocido, no la verdad interna.
19. Cada revelación relevante deberá afectar una misión o decisión.
20. El descubrimiento final no ocurrirá mediante un monólogo único de Vardis.

---

# 5. Las cuatro dimensiones de la verdad

El progreso investigativo se dividirá en cuatro dimensiones.

## 5.1 Verdad técnica

Responde:

* cómo funcionó Helios;
* qué nodos estaban conectados;
* qué credenciales se utilizaron;
* qué registros fueron alterados;
* qué infraestructura continúa activa.

Variables conceptuales:

```text
evidenceTechnical
technicalConfidence
heliosArchitectureKnown
argosAccessKnown
```

---

## 5.2 Verdad política

Responde:

* quién autorizó qué;
* qué contenían los acuerdos;
* qué autoridades fueron sobrepasadas;
* cómo se justificaron las intervenciones;
* qué instituciones ocultaron información.

Variables:

```text
evidencePolitical
politicalConfidence
asterionScopeKnown
blueAuthorizationKnown
governmentResponsibilityKnown
```

---

## 5.3 Verdad humana

Responde:

* quién fue declarado muerto;
* qué ocurrió con los operadores;
* qué familias recibieron ayuda;
* quién fue obligado a permanecer en Stratis;
* quién intentó escapar.

Variables:

```text
evidenceHuman
humanConfidence
pharosVictimsKnown
operatorTestimonies
familyTestimonies
```

---

## 5.4 Verdad operacional

Responde:

* cómo se alteraron órdenes;
* qué información recibió cada ejército;
* cómo se protegió Stratis;
* cuándo intervino Argos;
* cómo funcionó UMBRAL.

Variables:

```text
evidenceOperational
operationalConfidence
manipulationPatternKnown
infiltratorsKnown
thresholdProtocolKnown
```

---

# 6. Niveles generales de revelación

## Nivel 0 — Versión oficial

El jugador conoce únicamente la explicación de su bando.

### Azul

Rojo prepara una ocupación.

### Rojo

Azul prepara un cambio de régimen.

---

## Nivel 1 — Inconsistencias

El jugador descubre:

* horarios incorrectos;
* posiciones omitidas;
* órdenes duplicadas;
* transmisiones anómalas;
* firmas de muertos.

Todavía pueden explicarse como:

* corrupción;
* errores;
* sabotaje enemigo;
* caos.

---

## Nivel 2 — Manipulación sistemática

Se demuestra que varias inconsistencias siguen un patrón.

El jugador sospecha:

* selección informativa;
* interferencia interna;
* supervivencia de una estructura Helios.

---

## Nivel 3 — Red clandestina

Se demuestra:

* PHAROS;
* S-26;
* operadores declarados muertos;
* infiltración;
* Stratis activa.

Argos puede ser conocido como nombre, estructura o hipótesis fuerte.

---

## Nivel 4 — Validación de la guerra

Se demuestra:

* UMBRAL;
* perfiles de decisión;
* manipulación paralela;
* Vardis vivo;
* HELIOS-CORE.

El jugador comprende que el conflicto fue utilizado como experimento estratégico.

---

## Nivel 5 — Verdad comparada

Requiere ambas campañas o un equivalente excepcional.

Se demuestra:

* qué recibió Ward;
* qué recibió Navid;
* qué sabía cada infiltrado;
* qué variables modelaba Argos;
* cuáles decisiones escaparon a sus predicciones;
* qué partes del conflicto no fueron creadas por Argos.

---

# 7. Estados de una evidencia

```text
UNKNOWN
RUMORED
LOCATED
RECOVERED
DAMAGED
AUTHENTICATED
INTERPRETED
CORRELATED
DELIVERED
CLASSIFIED
PUBLISHED
DESTROYED
LOST
```

## UNKNOWN

No existe para el jugador.

## RUMORED

Existe una referencia sin ubicación segura.

## LOCATED

Se conoce dónde buscarla.

## RECOVERED

El jugador o un aliado la posee.

## DAMAGED

Falta parte del contenido.

## AUTHENTICATED

Se verificó su origen o integridad.

## INTERPRETED

Un especialista explicó su contenido.

## CORRELATED

Se comparó con otras fuentes.

## DELIVERED

Fue entregada a un actor.

## CLASSIFIED

Un mando restringió su acceso.

## PUBLISHED

La sociedad conoce su existencia.

## DESTROYED

La evidencia física dejó de existir.

## LOST

Se desconoce su ubicación o quedó en manos enemigas.

---

# 8. Calidad y autenticidad

Cada evidencia tendrá dos valores separados.

## Autenticidad

```text
AUTHENTIC
PARTIALLY_AUTHENTIC
ALTERED
FORGED
UNKNOWN
```

## Integridad

```text
COMPLETE
PARTIAL
DAMAGED
FRAGMENTARY
```

## Ejemplo

Un anexo puede ser:

```text
Autenticidad: PARTIALLY_AUTHENTIC
Integridad: COMPLETE
```

Esto significa que el documento está completo, pero alguna sección fue añadida o modificada.

---

# 9. Confianza de interpretación

La conclusión derivada tendrá una confianza.

```text
UNSUPPORTED
POSSIBLE
PROBABLE
HIGH_CONFIDENCE
PROVEN
```

## Regla

El jugador no verá necesariamente números.

Verá frases como:

* “sin confirmar”;
* “existen indicios”;
* “altamente probable”;
* “confirmado por varias fuentes”.

---

# 10. Tipos de evidencia

## E1 — Técnica

* registros;
* firmas digitales;
* metadatos;
* tráfico;
* consumo energético;
* credenciales;
* servidores.

## E2 — Política

* acuerdos;
* decretos;
* órdenes;
* anexos;
* comunicaciones ministeriales;
* actas.

## E3 — Humana

* testimonio;
* familia;
* grabación;
* superviviente;
* identificación biométrica;
* objetos personales.

## E4 — Operacional

* mapas;
* manifiestos;
* planes;
* transmisiones;
* informes militares;
* órdenes de movimiento.

## E5 — Financiera

* pagos;
* contratos;
* fundaciones;
* nóminas;
* facturas;
* seguros.

## E6 — Física

* instalación;
* vehículo;
* cadáver;
* equipo;
* ruta;
* contenedor.

---

# 11. Cadena de custodia

Una evidencia podrá perder valor si:

* fue manipulada;
* pasó por manos enemigas;
* fue encontrada sin contexto;
* fue copiada sin original;
* fue recuperada mediante una operación ilegal;
* fue publicada antes de autenticarse.

## Datos de custodia

```text
recoveredBy
recoveredAt
recoveredLocation
holders
copiesCreated
authenticationHistory
tamperingRisk
publicExposure
```

## Consecuencia

Una evidencia puede ser suficiente para convencer a un personaje, pero no para:

* un tribunal;
* una investigación pública;
* un Gobierno;
* una potencia extranjera.

---

# 12. Intérpretes principales

## Miriam Kessler

Especialidades:

* arquitectura Helios;
* firmas técnicas;
* tráfico;
* modelado;
* credenciales.

Limitaciones:

* puede proteger la tecnología;
* puede clasificar;
* puede justificar custodia Azul.

---

## Kamran Sadeq

Especialidades:

* infraestructura técnica;
* integración de red;
* protocolos;
* órdenes digitales;
* acceso Rojo.

Limitaciones:

* presión del Pacto;
* relación con Volkov;
* interés en preservar Helios.

---

## Lidia Serafim

Especialidades:

* análisis comparado;
* patrones;
* cronología;
* relaciones entre archivos.

Ventaja:

* mayor independencia.

Riesgo:

* objetivo de Argos;
* poca protección militar.

---

## Sofia Laurent

Especialidades:

* legitimidad;
* instituciones;
* actores civiles;
* consecuencias políticas.

No puede autenticar por sí sola:

* claves;
* código;
* firmas técnicas.

---

## Nadir Khoury

Especialidades:

* tratados;
* anexos;
* Gobierno;
* Asterión;
* autoridad internacional.

Limitación:

* puede proteger la posición Roja.

---

## Niko Damaris

Especialidades:

* funcionamiento interno;
* Vardis;
* traslado;
* PHAROS;
* Stratis.

Es un testigo central, pero no omnisciente.

---

## Elias Petrou

Especialidades:

* guarnición de Stratis;
* rutas;
* actividad técnica;
* órdenes incompatibles;
* Meridian.

No conoce todo UMBRAL.

---

## Familias y operadores PHAROS

Especialidades:

* consecuencias humanas;
* pagos;
* mensajes;
* desapariciones;
* identidades.

---

# 13. Sustitución de intérpretes

Ninguna línea esencial dependerá de que sobreviva una sola persona.

## Si Kessler muere

Pueden interpretar parte de la verdad:

* Reed;
* Vellis;
* Sadeq;
* técnicos recuperados;
* Serafim.

## Si Sadeq muere

Pueden sustituirlo:

* Orlov;
* técnico Verde;
* Arendt;
* Serafim.

## Si Damaris muere

La información puede sobrevivir mediante:

* grabación;
* archivo LÁZARO;
* operador PHAROS;
* Petrou;
* notas personales.

## Coste

El sustituto puede:

* tardar más;
* producir menor confianza;
* no desbloquear todas las opciones.

---

# 14. Líneas investigativas principales

Las siete líneas no son siete historias separadas.

Se cruzan y convergen en Stratis.

---

# 15. LÍNEA LÁZARO

## Pregunta central

> ¿Por qué personas oficialmente muertas continúan firmando, cobrando o accediendo a sistemas?

## Revelaciones

1. Existen firmas posteriores a las muertes.
2. Algunas credenciales fueron utilizadas desde Stratis.
3. Las familias recibieron pagos indirectos.
4. Los muertos administrativos estaban vivos.
5. Vardis utilizó la misma estructura.

## Tipos de evidencia

* nóminas;
* firmas;
* accesos;
* mensajes familiares;
* seguros;
* registros de transporte.

## Resultado final

Demuestra que las muertes fueron utilizadas como infraestructura clandestina.

---

# 16. LÍNEA PHAROS

## Pregunta central

> ¿Qué ocurrió con los técnicos trasladados y quién controla su destino?

## Revelaciones

1. Existió un protocolo de continuidad de personal.
2. Los operadores perdieron identidad legal.
3. Algunos aceptaron voluntariamente.
4. Otros fueron presionados o retenidos.
5. Stratis contiene instalaciones para alojarlos y controlarlos.

## Evidencias

* listas de extracción;
* testimonios;
* expedientes médicos;
* registros familiares;
* habitaciones;
* traslados;
* órdenes de custodia.

## Resultado final

PHAROS no fue solamente una evacuación.

Fue un sistema de desaparición administrativa.

---

# 17. LÍNEA ESPEJO AZUL

## Pregunta central

> ¿Cómo fue convencida Azul de que una ocupación Roja era inminente?

## Revelaciones

1. Existían movimientos Rojos reales.
2. Existían planes de contingencia Azules.
3. Se omitieron probabilidades y alternativas.
4. Se presentaron hipótesis como decisiones confirmadas.
5. Shaw priorizó versiones específicas.

## Evidencias

* informes múltiples;
* versiones borrador;
* mapas;
* correos;
* mensajes de Shaw;
* registros Helios;
* órdenes de preparación Roja.

## Resultado

La amenaza no era inventada.

Su inevitabilidad sí fue construida.

---

# 18. LÍNEA ASTERIÓN

## Pregunta central

> ¿Qué autorizó realmente el Gobierno de Altis a Rojo?

## Revelaciones

1. Kouris solicitó asistencia.
2. La solicitud era limitada.
3. Pallis no firmó el alcance completo.
4. Annex C-4 amplió la interpretación.
5. La distribución hizo parecer total una autoridad parcial.

## Evidencias

* texto original;
* anexos;
* sellos;
* registro de firmas;
* comunicaciones ministeriales;
* instrucciones de Khoury;
* archivos de Kouris.

## Resultado

La presencia Roja tenía fundamento legal inicial.

La campaña abierta superó ese fundamento.

---

# 19. LÍNEA ESCUDO ROTO

## Pregunta central

> ¿Por qué Fuerza Verde recibió órdenes incompatibles y se fragmentó?

## Revelaciones

1. Las órdenes principales eran auténticas.
2. Los códigos provenían de autoridades distintas.
3. Las horas fueron alteradas o retrasadas.
4. Rallis controló parte de la distribución.
5. Argos necesitaba una tercera fuerza autónoma.

## Evidencias

* códigos;
* retransmisiones;
* libros de órdenes;
* testimonios;
* terminales;
* registro de Rallis;
* declaración bloqueada de Pallis.

## Resultado

Verde no fue víctima de una simple orden falsa.

Fue empujada a obedecer varias autoridades verdaderas al mismo tiempo.

---

# 20. LÍNEA FARO NEGRO

## Pregunta central

> ¿Cómo se mantuvo oculta Stratis y qué recibía realmente?

## Revelaciones

1. S-26 nunca quedó inactiva.
2. Existía consumo energético anormal.
3. Cargamentos llegaban sin destinatario público.
4. Meridian controlaba accesos.
5. HELIOS-CORE estaba operativo.

## Evidencias

* señal de Petrou;
* manifiestos;
* rutas marítimas;
* consumo;
* inventarios;
* fotografías;
* navegación;
* testimonios stratiotas.

## Resultado

Stratis no era un archivo de emergencia.

Era el centro activo de la operación.

---

# 21. LÍNEA UMBRAL

## Pregunta central

> ¿Por qué Argos permitió que la crisis se convirtiera en una guerra integral?

## Revelaciones

1. Azul y Rojo eran variables de validación.
2. Verde debía permanecer autónoma.
3. FIA y civiles eran variables sociales.
4. Helios modelaba decisiones.
5. Argos medía divergencia entre predicción y conducta.
6. Stratis era la fase final de observación.

## Evidencias

* perfiles de Ward;
* perfiles de Navid;
* registros de decisiones;
* intervención Argos;
* informes de Vardis;
* clasificación de AZUR-1 y RUBÍ-1;
* archivo comparado.

## Resultado

La guerra no fue completamente creada por Argos.

Fue deliberadamente prolongada, equilibrada y observada.

---

# 22. Matriz de revelaciones por acto

| Acto    | Azul                                      | Rojo                                | Línea principal          |
| ------- | ----------------------------------------- | ----------------------------------- | ------------------------ |
| Prólogo | Señal S-26 y datos demasiado concluyentes | Códigos Verdes incompatibles        | Faro Negro / Escudo Roto |
| I       | Posiciones omitidas del informe           | Dos órdenes auténticas              | Espejo / Asterión        |
| II      | Tres versiones de un mismo informe        | Firmas de muertos y anexos técnicos | Espejo / Lázaro          |
| III     | Contingencia presentada como operación    | Invitación limitada ampliada        | Espejo / Asterión        |
| IV      | Pagos, familias y técnicos desaparecidos  | Fundación y nóminas PHAROS          | Lázaro / PHAROS          |
| V       | Distribución Verde manipulada             | Rallis y cadena paralela            | Escudo Roto              |
| VI      | Manifiestos hacia Stratis                 | Convoyes de los muertos             | Faro Negro / PHAROS      |
| VII     | Perfil de Ward y Shaw                     | Perfil de Navid/Vahid y Volkov      | UMBRAL                   |
| VIII    | HELIOS-CORE y Vardis                      | HELIOS-CORE y Vardis                | Todas                    |
| Dual    | Comparación Azul–Rojo                     | Comparación Roja–Azul               | UMBRAL completo          |

---

# 23. Evidencias del prólogo y Acto I

## E-B-FN-001 — Fragmento previo de S-26

Campaña:

* Azul.

Origen:

* comunicación interceptada antes del desembarco.

Contenido:

* “S-26”;
* “continuidad”;
* enlace no autorizado.

Valor:

* bajo inicialmente;
* alto al compararse con Petrou.

---

## E-R-ER-001 — Doble autenticación Verde

Campaña:

* Roja.

Origen:

* preparativos de Escudo de la Aurora.

Contenido:

* dos códigos válidos;
* instrucciones incompatibles.

Valor:

* primera prueba de Escudo Roto.

---

## E-B-ES-001 — Omisión costera

Campaña:

* Azul.

Origen:

* equipo Verde en Katalaki.

Contenido:

* posición Azul conocida antes de lo esperado;
* unidades Verdes omitidas del informe de Shaw;
* marca temporal anómala.

Conclusión inicial:

* fallo de inteligencia.

Conclusión posterior:

* selección deliberada de información.

---

## E-R-AS-001 — Órdenes Asterión de Molos

Campaña:

* Roja.

Contenido:

* cooperación autorizada;
* contención de fuerzas extranjeras;
* ambas órdenes auténticas.

Conclusión:

* la autoridad política estaba fragmentada antes del desembarco.

---

## E-S-FN-002A — Petrou: S-26 activa

Receptor inicial:

* Azul.

Estado:

* fragmentario.

---

## E-S-FN-002B — Petrou: mando comprometido

Receptor inicial:

* Rojo.

Estado:

* fragmentario.

## Comparación

Juntas demuestran que Petrou intentaba advertir simultáneamente:

* actividad técnica;
* infiltración del mando.

---

# 24. Evidencias del Acto II

## Azul — Tres espejos

### E-B-ES-002A

Informe preliminar.

Describe movimientos Rojos como preparación posible.

### E-B-ES-002B

Informe operacional.

Elimina lenguaje probabilístico.

### E-B-ES-002C

Informe entregado a Ward.

Presenta la ocupación como inminente.

## Conclusión

La información no fue falsificada completamente.

Fue endurecida en cada versión.

---

## Rojo — Los muertos firman

### E-R-LZ-002A

Firma digital de técnico declarado muerto.

### E-R-LZ-002B

Acceso desde un relé vinculado a Stratis.

### E-R-LZ-002C

Orden de mantenimiento posterior al atentado.

## Conclusión

Al menos un operador sobrevivió.

---

# 25. Evidencias del Acto III

## E-B-ES-003 — Plan de contingencia Azul

Demuestra que Azul poseía planes reales para:

* aeropuerto;
* nodos;
* Gobierno.

Argos presentó la existencia del plan a Rojo como prueba de ejecución inevitable.

---

## E-R-AS-003 — Solicitud original de Kouris

Contenido:

* protección;
* asesoría;
* defensa de instalaciones;
* apoyo limitado.

No contiene autoridad inequívoca para:

* ocupación general;
* subordinación total de Verde.

---

## E-R-AS-004 — Annex C-4

Estado:

* parcialmente auténtico.

Problema:

* firmas y sellos provienen de documentos válidos;
* la cláusula de extensión fue añadida o ratificada irregularmente.

---

# 26. Evidencias del Acto IV

## E-S-LZ-004 — Nómina de los ausentes

Contiene:

* personas declaradas muertas;
* pagos posteriores;
* fundaciones intermediarias;
* referencias a continuidad.

---

## E-S-PH-004 — Expedientes familiares

Incluyen:

* seguros;
* ayudas;
* mensajes;
* instrucciones de silencio;
* visitas anónimas.

---

## E-S-PH-005 — Testimonio de operador

Variantes:

* voluntario;
* retenido;
* fugado;
* herido;
* familiar.

## Función

Humanizar PHAROS y evitar que sea únicamente una conspiración documental.

---

# 27. Evidencias del Acto V

## E-S-ER-005 — Libro de órdenes de Varos

Contiene:

* órdenes nacionales;
* versiones regionales;
* tiempos;
* prioridades.

---

## E-S-ER-006 — Registro de Rallis

Puede demostrar:

* retrasos;
* reenvíos;
* exclusiones;
* canales privados;
* accesos Argos.

---

## E-S-ER-007 — Declaración bloqueada de Pallis

Pallis intentó:

* limitar intervención;
* convocar autoridad constitucional;
* ordenar coordinación Verde.

La transmisión fue bloqueada o fragmentada.

---

# 28. Evidencias del Acto VI

## E-B-FN-006 — Manifiestos de continuidad

Azul descubre envíos hacia Stratis:

* medicina;
* alimentos;
* servidores;
* combustible;
* componentes.

---

## E-R-PH-006 — Convoy de los muertos

Rojo intercepta carga asignada a:

* técnicos fallecidos;
* departamentos cerrados;
* S-26.

---

## E-S-FN-007 — Consumo energético

Demuestra que Stratis mantenía una carga incompatible con una estación archivística inactiva.

---

## E-S-FN-008 — Rutas de Meridian

Incluye:

* embarcaciones;
* vuelos;
* códigos;
* personal;
* puntos de descarga.

---

# 29. Evidencias del Acto VII

## E-B-UM-007 — Perfil Ward

Contiene:

* respuestas previstas;
* límites legales;
* probabilidad de intervención;
* relación con Hale;
* reacción a pérdidas.

---

## E-R-UM-007A — Perfil Navid

Contiene:

* preferencia por alianza;
* límites políticos;
* tendencia a consolidar.

---

## E-R-UM-007B — Perfil Vahid

Contiene:

* probabilidad de escalada;
* respuesta a bloqueo;
* uso de fuerza mecanizada.

---

## E-S-UM-008 — Registro de intervención

Registra acciones Argos:

* informe retrasado;
* prioridad modificada;
* señal protegida;
* infiltrado activado.

No demuestra control total.

Demuestra intervención selectiva.

---

## E-S-UM-009 — Variables de divergencia

AZUR-1 y RUBÍ-1 aparecen clasificadas como:

```text
HIGH DIVERGENCE VARIABLES
```

Esto indica que sus decisiones se alejaron de predicciones en puntos relevantes.

---

# 30. Evidencias de Stratis

## E-S-VA-008 — Biometría de Vardis

Puede incluir:

* acceso;
* huella;
* registro médico;
* identificación visual.

---

## E-S-PH-009 — Archivo maestro PHAROS

Contiene:

* identidades;
* familias;
* traslados;
* voluntarios;
* retenidos;
* fallecidos reales.

---

## E-S-AR-010 — Registro de Argos

Contiene:

* nombres;
* funciones;
* operaciones;
* infiltrados;
* patrocinadores parciales.

---

## E-S-UM-010 — Informe UMBRAL

Contiene:

* objetivos;
* condiciones;
* fase integral;
* resultados;
* evaluación de los actores.

---

## E-S-HC-011 — Claves de HELIOS-CORE

Permiten:

* auditar;
* controlar;
* desconectar;
* liberar;
* copiar;
* destruir.

No constituyen por sí solas la verdad política.

---

# 31. Conclusiones y requisitos

# Conclusión C1 — S-26 está activa

Requiere dos elementos entre:

* señal de Petrou;
* consumo energético;
* manifiestos;
* rutas de Meridian;
* testimonio stratiota.

---

# C2 — Algunos muertos siguen vivos

Requiere:

* firma posterior;
* acceso posterior;
* pago;
* testimonio;
* biometría.

Una evidencia técnica fuerte puede permitir sospecha.

Dos tipos diferentes permiten confirmación.

---

# C3 — PHAROS existe

Requiere:

* evidencia administrativa;
* evidencia humana;
* ruta o instalación.

---

# C4 — Azul recibió información manipulada

Requiere:

* dos versiones de informe;
* metadatos;
* registro de Shaw;
* comparación con hechos Rojos.

---

# C5 — Asterión fue ampliado irregularmente

Requiere:

* solicitud original;
* Annex C-4;
* registro de firma;
* testimonio político;
* orden Verde.

---

# C6 — Verde fue fragmentada deliberadamente

Requiere:

* órdenes auténticas;
* diferencias temporales;
* registro de Rallis;
* declaración bloqueada;
* comunicación Argos.

---

# C7 — Argos infiltró las facciones

Requiere:

* prueba individual por infiltrado;
* patrón compartido;
* registro Argos o UMBRAL.

---

# C8 — Vardis está vivo

Puede confirmarse mediante:

* biometría;
* encuentro;
* voz autenticada;
* registro médico;
* archivo maestro.

Una grabación aislada no es suficiente.

---

# C9 — La guerra fue utilizada como validación

Requiere:

* perfiles;
* registro de intervención;
* UMBRAL;
* comparación de decisiones;
* archivo central.

---

# C10 — Argos no controló todas las decisiones

Requiere:

* predicciones fallidas;
* divergencias;
* decisiones no previstas;
* comparación dual.

Esta conclusión es esencial para evitar que toda responsabilidad humana desaparezca.

---

# 32. Redundancia narrativa

Cada conclusión esencial tendrá:

* una ruta Azul;
* una ruta Roja;
* una ruta compartida o de Stratis.

## Ejemplo: Vardis vivo

### Ruta Azul

* firma;
* análisis de Kessler;
* biometría en Stratis.

### Ruta Roja

* acceso;
* Sadeq;
* archivo médico.

### Ruta alternativa

* testimonio Damaris;
* encuentro directo.

---

# 33. Evidencias perdibles y no perdibles

## No perdibles completamente

La campaña conservará alguna vía para descubrir:

* Stratis activa;
* PHAROS;
* Vardis;
* Argos;
* UMBRAL.

## Perdibles

Pueden perderse:

* nombres concretos;
* patrocinadores;
* testimonios;
* detalles de infiltrados;
* pruebas válidas para publicación;
* rutas de acceso;
* opciones de captura.

## Resultado

El jugador puede comprender la conspiración y aun no poder demostrarla públicamente.

---

# 34. Investigación activa frente a descubrimiento automático

## Investigación activa

Requiere que el jugador:

* acepte misión;
* proteja testigo;
* recupere objeto;
* compare;
* elija intérprete.

## Descubrimiento automático

Ocurre cuando:

* cae un nodo;
* cambia un acto;
* un personaje revela información;
* el enemigo publica datos;
* una fuerza aliada resuelve una operación.

## Regla

Las conclusiones principales no deben depender exclusivamente de explorar rincones sin indicación.

---

# 35. Entrega de evidencias en la campaña Azul

## Ward

Efectos:

* investigación oficial;
* mayor prudencia;
* posible clasificación;
* confrontación con Hale.

## Hale

Efectos:

* puede usar la evidencia para justificar ofensiva;
* prioriza amenaza militar;
* puede restar importancia a implicaciones políticas.

## Kessler

Efectos:

* autenticación técnica;
* preservación de Helios;
* acceso a misiones de nodos.

## Shaw

Efectos:

* retraso;
* alteración;
* exposición del jugador;
* posible contraoperación Argos.

## Laurent

Efectos:

* conexión con civiles;
* protección de testigos;
* publicación o negociación.

## Markou

Efectos:

* legitimidad FIA;
* filtración pública;
* oposición a ocupación.

---

# 36. Entrega de evidencias en la campaña Roja

## Navid

Efectos:

* revisión de misión;
* negociación;
* conflicto con Vahid.

## Vahid

Efectos:

* puede considerar Argos una razón para acelerar control;
* busca capturar Helios antes que Azul.

## Sadeq

Efectos:

* autenticación;
* acceso técnico;
* preservación de nodos.

## Volkov

Efectos:

* clasificación;
* desinformación;
* operación contra el jugador.

## Khoury

Efectos:

* revisión de Asterión;
* crisis gubernamental;
* protección de documentos.

## Pallis, Varos o Koronis

Efectos:

* soberanía;
* ruptura con Rojo;
* coalición nativa.

---

# 37. Publicación

Publicar evidencia será una acción diferente de conocerla.

## Requisitos

* copia;
* canal;
* autenticidad;
* protección;
* destinatarios;
* tiempo.

## Resultados posibles

### Publicación verificada

* legitimidad;
* investigación;
* ruptura política;
* Argos expuesto.

### Filtración incompleta

* rumores;
* propaganda;
* confusión;
* destrucción de reputaciones.

### Publicación prematura

* Argos desacredita;
* testigos quedan expuestos;
* mandos destruyen archivos.

### Censura

* verdad conocida por pocos;
* estabilidad inmediata;
* Argos puede sobrevivir.

---

# 38. Contrainteligencia de Argos

Argos puede reaccionar cuando aumenta:

```text
argosExposure
```

## Exposición baja

* observación;
* retrasos;
* clasificación.

## Exposición media

* robo;
* sabotaje;
* presión;
* cambio de rutas;
* desacreditación.

## Exposición alta

* extracción;
* asesinato selectivo;
* destrucción de archivos;
* evacuación;
* activación de Meridian.

## Regla

Cada respuesta cuesta capacidad y produce nuevas pistas.

---

# 39. Técnicas de desinformación Argos

## Selección verdadera

Entregar solo hechos compatibles con una conclusión.

## Contexto falso

Utilizar documento auténtico dentro de una cronología engañosa.

## Duplicación

Crear varias versiones con pequeñas diferencias.

## Saturación

Enviar demasiada información para ocultar la importante.

## Retraso

Entregar una orden auténtica cuando ya es perjudicial.

## Atribución

Hacer que una acción propia parezca una decisión rival.

## Evidencia señuelo

Colocar un archivo falso acompañado de elementos auténticos.

---

# 40. Evidencias señuelo

No todas las pruebas encontradas serán correctas.

## Tipos

### Falsificación simple

Fácil de detectar.

### Falsificación sofisticada

Necesita especialista.

### Documento auténtico mal utilizado

El más peligroso.

### Testimonio erróneo

La persona cree decir la verdad.

### Testimonio comprado

Conoce la falsedad.

## Principio

El jugador no debe ser castigado arbitrariamente.

Deben existir señales:

* fechas;
* firmas;
* inconsistencias;
* motivaciones;
* falta de cadena de custodia.

---

# 41. Tablero de investigación

La interfaz futura deberá mostrar:

* líneas;
* evidencias;
* conclusiones;
* contradicciones;
* personajes;
* eventos;
* preguntas pendientes.

## No mostrará

* verdad completa oculta;
* autenticidad real antes de analizar;
* identidad de infiltrados no descubiertos;
* requisitos numéricos exactos.

## Ejemplo

```text
LÍNEA: FARO NEGRO

Confirmado:
✓ S-26 consume energía
✓ Cargamentos llegan a Stratis

Probable:
• Existe personal técnico permanente

Sin demostrar:
? HELIOS-CORE continúa activo
? Vardis está presente
```

---

# 42. Acceso a Stratis según investigación

## S0 — Asalto ciego

Conocimiento:

* Stratis como centro hostil;
* poca información interna.

Consecuencias:

* entrada frontal;
* más bajas;
* archivos destruidos;
* pocas opciones finales.

---

## S1 — Acceso parcial

Conocimiento:

* S-26 activa;
* Meridian;
* alguna ruta.

Consecuencias:

* entrada alternativa;
* objetivos técnicos;
* posibilidad de preservar evidencia.

---

## S2 — Operación informada

Conocimiento:

* PHAROS;
* Damaris o Petrou;
* estructura parcial.

Consecuencias:

* aliados internos;
* rescate de operadores;
* reducción de combate Verde.

---

## S3 — Operación integral

Conocimiento:

* Argos;
* Vardis;
* infiltrados;
* accesos;
* protocolos.

Consecuencias:

* captura posible;
* auditoría;
* separación de HELIOS-CORE;
* confrontación completa.

---

## S4 — Verdad comparada

Requiere:

* ambas campañas;
* evidencia dual;
* archivo UMBRAL.

Consecuencias:

* diálogo completo;
* identificación de manipulación paralela;
* final secreto;
* máxima comprensión, no victoria automática.

---

# 43. Condiciones para capturar a Vardis

No bastará con llegar físicamente a su sala.

Se requiere una combinación de:

* operación integral;
* rutas de escape identificadas;
* Mercer neutralizado o separado;
* archivos preservados;
* conocimiento de identidades;
* acceso a HELIOS-CORE;
* tiempo suficiente;
* fuerza superviviente.

## Sin estas condiciones

Vardis puede:

* escapar;
* ser asesinado por Mercer;
* desaparecer con identidad nueva;
* destruir archivos;
* entregarse a otra potencia;
* morir durante el asalto.

---

# 44. Destino de infiltrados

## Evelyn Shaw

Pruebas posibles:

* versiones de informes;
* accesos;
* comunicación Argos;
* órdenes de clasificación.

## Rashid Volkov

Pruebas:

* manipulación de anexos;
* comunicación;
* rutas de Stratis;
* presión sobre Sadeq.

## Damian Rallis

Pruebas:

* retrasos;
* canales;
* órdenes Verdes;
* protección de nodos.

## Andreas Pelagos, Némesis

Pruebas:

* falsas banderas;
* pagos;
* explosivos;
* comunicación Argos;
* objetivos contra negociaciones.

## Regla

Descubrir a uno no revela automáticamente a todos.

---

# 45. Comparación dual

Al completar ambas campañas se comparan pares de evidencia.

## Pares centrales

```text
ESPEJO AZUL ↔ ASTERIÓN
Shaw ↔ Volkov
Orden Azul ↔ Informe Rojo
Orden Roja ↔ Informe Azul
S-26 activa ↔ Mando comprometido
Perfil Ward ↔ Perfil Navid/Vahid
AZUR-1 ↔ RUBÍ-1
```

## Resultado

Se demuestra que Argos:

* no necesitaba que un bando fuera completamente inocente;
* necesitaba que cada uno viera al otro como amenaza irreversible;
* utilizó decisiones auténticas para validar el modelo.

---

# 46. Archivo UMBRAL comparado

El archivo final puede mostrar:

```text
BLUE COMMITMENT: ACHIEVED
RED COMMITMENT: ACHIEVED
GREEN AUTONOMY: MAINTAINED
CIVIL/FIA REACTION: ACTIVE
STRATIS CONCEALMENT: MAINTAINED
INTEGRAL VALIDATION: INITIATED
```

Después:

```text
AZUR-1: HIGH DIVERGENCE
RUBÍ-1: HIGH DIVERGENCE
```

## Significado

Argos predijo categorías generales.

No predijo completamente las razones, relaciones y sacrificios concretos.

---

# 47. Consecuencias de investigar demasiado tarde

La investigación seguirá disponible, pero el tiempo importa.

## Posibles pérdidas

* testigo asesinado;
* archivo evacuado;
* infiltrado ascendido;
* Stratis fortificada;
* Mercer preparado;
* verdad publicada por el enemigo;
* familia desplazada.

## Regla

No todas las investigaciones caducan.

Algunas cambian de forma.

Ejemplo:

Un testigo vivo puede convertirse en:

* grabación;
* cadáver;
* expediente;
* familiar.

---

# 48. Costes de investigación

Investigar puede consumir:

* tiempo;
* unidades;
* combustible;
* relación con mando;
* oportunidad ofensiva;
* protección civil;
* secreto.

## Ejemplo

Perseguir un convoy PHAROS puede permitir que:

* un sector quede sin refuerzo;
* una ofensiva continúe;
* un aliado pierda confianza.

## Principio

La verdad debe tener un coste estratégico real.

---

# 49. Resolución fuera de pantalla

Una investigación ignorada puede ser intentada por:

* otra unidad;
* FIA;
* inteligencia;
* Verde;
* personaje.

## Resultado

Depende de:

* capacidad;
* amenaza;
* infiltración;
* recursos;
* tiempo.

## Consecuencias

El jugador puede recibir:

* evidencia parcial;
* informe de fracaso;
* testigo perdido;
* rumor;
* evidencia clasificada.

---

# 50. Modelo de datos

```sqf
IF_evidence = createHashMapFromArray [
    ["id", "E-B-ES-002A"],
    ["lineId", "ESPEJO_AZUL"],
    ["campaignSide", "BLUE"],
    ["actId", "ACT_II"],
    ["evidenceType", "TECHNICAL_DOCUMENT"],

    ["state", "RECOVERED"],
    ["authenticity", "AUTHENTIC"],
    ["integrity", "COMPLETE"],
    ["interpretationConfidence", "POSSIBLE"],

    ["locationId", ""],
    ["holderFactionId", "FAC_BLUE"],
    ["holderCharacterId", "CHAR_BLUE_REED"],
    ["recoveredById", "CHAR_BLUE_PLAYER"],
    ["chainOfCustody", []],

    ["requiredInterpreterTags", ["HELIOS_TECHNICAL"]],
    ["relatedEvidenceIds", []],
    ["conclusionIds", []],

    ["copies", 1],
    ["classified", false],
    ["published", false],
    ["destroyed", false],
    ["argosAwareness", 20]
];
```

---

# 51. Modelo de conclusión

```sqf
IF_conclusion = createHashMapFromArray [
    ["id", "CONCLUSION_PHAROS_EXISTS"],
    ["displayName", "PHAROS existió"],
    ["state", "SUSPECTED"],

    ["technicalConfidence", 40],
    ["politicalConfidence", 20],
    ["humanConfidence", 70],
    ["operationalConfidence", 35],

    ["supportingEvidenceIds", []],
    ["contradictingEvidenceIds", []],
    ["knownByFaction", createHashMap],
    ["knownByCharacters", []],

    ["public", false],
    ["unlockedMissionIds", []],
    ["unlockedDialogueIds", []],
    ["unlockedEndingOptions", []]
];
```

---

# 52. Funciones conceptuales

```text
IF_fnc_evidenceDiscover
IF_fnc_evidenceRecover
IF_fnc_evidenceDamage
IF_fnc_evidenceTransfer
IF_fnc_evidenceAuthenticate
IF_fnc_evidenceInterpret
IF_fnc_evidenceCorrelate
IF_fnc_evidencePublish
IF_fnc_evidenceClassify
IF_fnc_evidenceDestroy
IF_fnc_investigationEvaluateConclusion
IF_fnc_investigationUnlockMission
IF_fnc_investigationUpdateBoard
IF_fnc_investigationResolveOffscreen
IF_fnc_argosReactToExposure
IF_fnc_dualCampaignCompareEvidence
```

---

# 53. Pruebas obligatorias

## Prueba 1 — Pérdida de evidencia

Destruir una prueba principal.

Verificar:

* ruta alternativa;
* conclusión todavía alcanzable;
* menor confianza o acceso.

## Prueba 2 — Intérprete muerto

Eliminar a Kessler o Sadeq.

Verificar sustitución.

## Prueba 3 — Entrega al infiltrado

Entregar evidencia a Shaw o Volkov.

Verificar:

* clasificación;
* reacción Argos;
* copia posible.

## Prueba 4 — Publicación prematura

Publicar evidencia no autenticada.

Verificar:

* controversia;
* contrainteligencia;
* credibilidad.

## Prueba 5 — Cadena de custodia

Comparar original y copia.

## Prueba 6 — Campaña con poca investigación

Llegar a Stratis en S0 o S1.

## Prueba 7 — Campaña integral

Llegar en S3.

## Prueba 8 — Comparación dual

Completar ambas campañas y reconstruir UMBRAL.

---

# 54. Errores que deben evitarse

1. Resolver la conspiración con un único archivo.
2. Hacer que todos los documentos sean falsos.
3. Hacer que todos los documentos sean auténticos y claros.
4. Revelar a Vardis demasiado pronto.
5. Convertir a Argos en controlador absoluto.
6. Exculpar a los comandantes.
7. Depender de un personaje inmortal.
8. Ocultar evidencias sin ninguna pista.
9. Castigar al jugador con falsedades imposibles de detectar.
10. Convertir la investigación en coleccionables.
11. Bloquear Stratis por perder una misión opcional.
12. Permitir publicación sin consecuencias.
13. Dar acceso total a Helios por encontrar una contraseña.
14. Confundir acceso técnico con legitimidad política.
15. Hacer que completar ambas campañas produzca un final perfecto.
16. Ignorar a familias y operadores.
17. Permitir que Argos elimine toda evidencia mágicamente.
18. Hacer que una grabación aislada pruebe toda la conspiración.
19. Mostrar al jugador información que su personaje no conoce.
20. Crear conclusiones sin impacto jugable.

---

# 55. Criterios de calidad

La investigación será válida cuando:

1. Cada acto aporte una pregunta nueva.
2. Las primeras pistas admitan explicaciones normales.
3. El patrón aparezca gradualmente.
4. Azul y Rojo descubran verdades distintas.
5. Las pruebas humanas sean tan importantes como las técnicas.
6. Entregar una evidencia cambie relaciones.
7. Perder una prueba cambie el camino, no destruya la campaña.
8. Stratis resulte comprensible antes de llegar.
9. Vardis no explique todo mediante un discurso.
10. El jugador pueda distinguir hecho, interpretación y propaganda.
11. Argos parezca competente, pero limitado.
12. La verdad completa mantenga responsabilidad humana.
13. El nivel de investigación modifique la operación final.
14. La comparación dual revele información realmente nueva.
15. La publicación influya en los finales.

---

# 56. Definición final

La investigación de Islas Fracturadas no consistirá en demostrar que todo fue mentira.

Consistirá en descubrir algo más peligroso:

* los planes Azules existían;
* la solicitud Roja existía;
* las divisiones Verdes existían;
* FIA estaba armada;
* el Gobierno estaba debilitado;
* las potencias temían perder Altis.

Argos no necesitó inventar esos hechos.

Necesitó conseguir que:

* Azul no viera los límites de la invitación Roja;
* Rojo no viera la naturaleza condicional de los planes Azules;
* Verde no recibiera una autoridad única;
* FIA creyera que la represión era inmediata;
* los civiles vieran desaparecer sus canales de protección.

> **La guerra no comenzó con una gran mentira. Comenzó porque ninguna verdad llegó completa a tiempo.**

> **Cada prueba recuperada no revela únicamente qué hizo Argos. Revela qué estaba dispuesto a creer cada actor antes de que Argos interviniera.**

> **En Altis combatían por el territorio. En Stratis alguien decidía qué parte del territorio podía ver cada ejército.**

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

El [Documento 3/14](DYNAMIC_MISSIONS_AND_EMERGENT_EVENTS.md) conecta necesidades de comandantes, sectores, logística, civiles, personajes e investigación con plantillas reutilizables.

El [Documento 4/14](CIVIL_MUNICIPAL_POLITICAL_STABILITY_SYSTEM.md) fija el sistema civil, municipal, político y de estabilidad.

El siguiente documento será el **5/14 — Sistema definitivo de FIA, insurgencia y guerra clandestina**.
