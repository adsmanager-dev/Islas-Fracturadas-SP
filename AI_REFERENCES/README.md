# AI_REFERENCES — material de terceros para consulta técnica, no para copiar

> **Clasificación:** referencia de solo lectura. Nada de aquí es canon ni fuente de diseño de
> Islas Fracturadas. Ver `AGENTS.md` §Fuentes principales para la jerarquía real de canon.

## Qué es esto y qué no es

Estos son clones de misiones de Arma 3 de código abierto, usadas exclusivamente para **estudiar
cómo resuelven problemas técnicos concretos** (guarniciones, persistencia, captura territorial,
IA, spawning) — nunca para copiar su diseño, su narrativa ni su código directamente en
`IslasFracturadas.Altis/`. La regla es la misma que ya rige `asset/`: material de terceros con
procedencia registrada, no versionable como si fuera nuestro.

Uso correcto: "¿cómo resuelve Antistasi la reacción de IA a la pérdida de un sector?" → leer su
código → entender el patrón → implementar **nuestro propio diseño**, distinto, en SQF propio con
prefijo `IF_`.

Uso incorrecto: copiar o adaptar superficialmente su SQF, su `mission.sqm` o sus nombres de
función.

## Procedencia

| Carpeta | Repositorio | Licencia | Por qué esta y no otra variante |
| --- | --- | --- | --- |
| `A3-Antistasi/` | [official-antistasi-community/A3-Antistasi](https://github.com/official-antistasi-community/A3-Antistasi) | MIT (© 2019 Barbolani & The Official Antistasi Community) | Campaña persistente activa: guarniciones, captura territorial, IA — el sistema más cercano a lo que Islas Fracturadas necesita diseñar. Existen forks (`LordGolias/antistasi`, `A3-Antistasi-Plus`); se eligió el oficial por ser el mantenido de referencia. |
| `KP-Liberation/` | [KillahPotatoes/KP-Liberation](https://github.com/KillahPotatoes/KP-Liberation) | MIT (© 2015 GreuhZbug, Wyqer) | Continuación activa y mantenida de la misión Liberation original de GreuhZbug (el repo original, `GreuhZbug/greuh_liberation.Altis`, aparece abandonado). Arquitectura CTI distinta a Antistasi para los mismos problemas — sirve para comparar dos enfoques, no asumir que hay uno solo correcto. |

Ambos clonados con `git clone --depth 1` (solo el último commit, sin historial completo) el
2026-08-07.

## No versionado

Esta carpeta está excluida de Git (`.gitignore`). Si el equipo decide en el futuro que un
fragmento de patrón aprendido aquí debe pasar a ser diseño propio, eso se documenta como
`DESIGN_CHANGE` en el flujo normal de `AGENTS.md` — citando el patrón de origen, nunca copiando
el archivo.
