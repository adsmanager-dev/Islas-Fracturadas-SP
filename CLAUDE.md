@AGENTS.md

# Adaptador para Claude Code

## Contexto y procedimientos

- Mantén este archivo breve y trata `AGENTS.md` como reglas comunes.
- Carga procedimientos repetibles desde `.claude/skills/`.
- Antes de una tarea extensa, identifica la fuente de verdad y presenta un plan breve.
- No conviertas una skill en reglas permanentes ni una propuesta en canon.

## Herramientas

- Prioriza Codebase Memory para arquitectura y trazabilidad.
- Usa Serena cuando la navegación estructurada aporte valor.
- Usa búsqueda textual para SQF, macros, literales y configuración.
- Ejecuta Semgrep después de cambios funcionales.
- Aplica al iniciar y cerrar cambios de misión el flujo local de sincronización con 3DEN definido en `AGENTS.md`.
- No automatices trabajo que requiera interacción física con 3DEN.

## Skills del proyecto

- Inicia encargos amplios con `/if-task-intake`.
- Usa las skills narrativas para canon, actos, facciones, misiones y consecuencias.
- Usa las skills técnicas solo ante implementación o revisión explícita.
- Usa `/if-documentation-sync` después de cambios funcionales.
- Usa `/if-release-gate` al cerrar un hito.

## Delegación y verificación

- Para exploración amplia, puede usarse un subagente de lectura antes de editar.
- No delegues decisiones de canon sin revisión principal.
- Mantén subagentes de revisión en solo lectura salvo autorización expresa.
- No presentes revisión estática como sustituto de Arma 3, RPT o 3DEN.
