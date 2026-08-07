---
goal: Preparar un entorno seguro y reproducible para generar, editar, registrar y convertir assets visuales de Islas Fracturadas desde Codex y Claude
version: 1.0
date_created: 2026-08-07
last_updated: 2026-08-07
owner: Islas Fracturadas
status: 'On Hold'
tags: [infrastructure, media, assets, mcp, ai, arma3]
---

# Introduction

![Status: On Hold](https://img.shields.io/badge/status-On%20Hold-orange)

Este plan instala la cadena SVG disponible, crea un servidor MCP local común para Codex y Claude, añade trazabilidad de procedencia y mantiene separados los borradores generados, las fuentes aprobadas y las texturas finales de Arma 3.

Resultado al 2026-08-07: el MCP está conectado en Codex y Claude, la cadena SVG→PNG funciona con Inkscape 1.4.4 y Sharp como fallback, y las pruebas offline pasan. ChatGPT Plus y la API tienen facturación separada: el MCP queda deliberadamente sin generación remota, Codex usa su generador nativo y Claude conserva el procesamiento local. El cierre PAA queda en espera únicamente de Arma 3 Tools/ImageToPAA.

## 1. Requirements & Constraints

- **REQ-001**: Exponer a Codex y Claude las mismas operaciones de estado, generación, edición, registro de procedencia, rasterizado SVG y compilación controlada de identidad.
- **REQ-002**: Mantener `art/identity/*.svg` como fuente editable, `production/media/drafts/` como área de borradores y `IslasFracturadas.Altis/ui/insignia/*.paa` como salida final.
- **REQ-003**: Registrar para cada imagen generada o incorporada proveedor, modelo, fecha, prompt o resumen de origen, licencia/condiciones, hash SHA-256 y estado de aprobación.
- **SEC-001**: Leer credenciales exclusivamente desde variables de entorno y no escribirlas en archivos, manifiestos, logs ni salida MCP.
- **SEC-002**: Restringir lecturas y escrituras a rutas permitidas dentro del repositorio, rechazar rutas absolutas, recorridos `..` y escapes mediante enlaces simbólicos.
- **SEC-003**: Fallar de forma cerrada cuando falte una clave, un ejecutable, una aprobación explícita o una validación de entrada.
- **CON-001**: No editar `mission.sqm`, no incluir `CfgUnitInsignia.hpp` y no declarar assets como implementados hasta producir `.paa` válidos.
- **CON-002**: `ImageToPAA.exe` solo puede obtenerse mediante Arma 3 Tools en Steam y requiere intervención de cuenta si Steam/Tools no están instalados.
- **CON-003**: La generación remota del MCP está desactivada mediante `IF_MEDIA_REMOTE_MODE=disabled`; habilitarla en el futuro requerirá una cuenta API facturada aparte y nunca permitirá secretos en el repositorio.
- **GUD-001**: Conservar las etiquetas `PROPUESTA`, `DISEÑO_CONFIRMADO`, `IMPLEMENTADO` y `PROBADO` conforme a las fuentes rectoras.
- **PAT-001**: Usar MCP por `stdio`, salida de protocolo solo por stdout y diagnóstico sin secretos por stderr.

## 2. Implementation Steps

### Implementation Phase 1

- GOAL-001: Auditar y documentar el estado inicial sin alterar cambios existentes del usuario.

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-001 | Leer `AGENTS.md`, `docs/00_INDEX_AND_DOCUMENTATION_MAP.md`, estado Git y estado de sincronización 3DEN. | ✅ | 2026-08-07 |
| TASK-002 | Inventariar Codex, Claude, VS Code, Node, Python, GPU, variables de proveedor y ejecutables gráficos. | ✅ | 2026-08-07 |
| TASK-003 | Confirmar fuentes oficiales para Inkscape, ImageToPAA, OpenAI Images y MCP. | ✅ | 2026-08-07 |

### Implementation Phase 2

- GOAL-002: Instalar y validar las dependencias locales de conversión visual.

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-004 | Instalar y validar Inkscape 1.4.4 desde `D:\Programas\Inkscape`; conservar Sharp 0.35.3 como fallback local reproducible. | ✅ | 2026-08-07 |
| TASK-005 | Ejecutar un rasterizado temporal de los seis SVG de `art/identity/` y validar dimensiones y transparencia. | ✅ | 2026-08-07 |
| TASK-006 | Detectar ImageToPAA desde Steam/Arma 3 Tools y registrar el procedimiento manual si la cuenta o el paquete faltan. | ✅ | 2026-08-07 |

### Implementation Phase 3

- GOAL-003: Implementar el servidor MCP local gobernado y su almacenamiento de borradores.

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-007 | Crear `tools/if-media-mcp/` con Node.js, TypeScript, MCP 2, Zod y OpenAI SDK fijados en `package-lock.json`. | ✅ | 2026-08-07 |
| TASK-008 | Implementar validación de rutas, límites de tamaño/llamadas, manifiestos JSON y auditoría sin contenido sensible. | ✅ | 2026-08-07 |
| TASK-009 | Implementar herramientas MCP de estado, generación, edición, registro, rasterizado SVG y compilación aprobada de identidad. | ✅ | 2026-08-07 |
| TASK-010 | Añadir pruebas unitarias y de protocolo MCP sin consumir una API real. | ✅ | 2026-08-07 |

### Implementation Phase 4

- GOAL-004: Integrar el flujo con los dos agentes y conservar una única fuente de instrucciones.

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-011 | Crear y validar `agent-skills-src/if-media-assets/` con el flujo de propuesta, aprobación, procedencia y conversión. | ✅ | 2026-08-07 |
| TASK-012 | Corregir la sincronización de skills para recuperar manifiestos obsoletos sin aceptar modificaciones manuales divergentes. | ✅ | 2026-08-07 |
| TASK-013 | Sincronizar la skill hacia `.agents/skills/` y `.claude/skills/` y verificar hashes. | ✅ | 2026-08-07 |
| TASK-014 | Registrar `if-media` en `.codex/config.toml` y `.mcp.json` sin credenciales embebidas. | ✅ | 2026-08-07 |

### Implementation Phase 5

- GOAL-005: Validar la entrega y registrar con precisión los bloqueos externos.

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-015 | Ejecutar build, pruebas, smoke test MCP, `git diff --check` y Semgrep. | ✅ | 2026-08-07 |
| TASK-016 | Ejecutar `tools/Build-Assets.ps1 -WhatIf` y el rasterizado real con Inkscape; completado hasta PNG, pendiente generar PAA y aplicar el flujo Push de misión cuando exista ImageToPAA. | ✅ | 2026-08-07 |
| TASK-017 | Actualizar este plan con resultados, riesgos residuales y tareas externas pendientes. | ✅ | 2026-08-07 |

## 3. Alternatives

- **ALT-001**: Ejecutar ComfyUI localmente; descartado como base inicial porque la Intel UHD 620 disponible produciría tiempos de generación improductivos y añadiría un entorno Python pesado.
- **ALT-002**: Instalar MCP visuales de terceros sin revisión; descartado porque ampliarían permisos, proveedores y superficie de ejecución sin controles de ruta o procedencia específicos del proyecto.
- **ALT-003**: Escribir imágenes generadas directamente dentro de la misión; descartado porque mezclaría borradores con arte aprobado y podría crear rutas inválidas o estado exagerado.

## 4. Dependencies

- **DEP-001**: Inkscape 1.4.4 como rasterizador principal; Sharp 0.35.3 como fallback local reproducible.
- **DEP-002**: ImageToPAA de Arma 3 Tools para convertir PNG de potencia de dos a PAA.
- **DEP-003**: Node.js 24 y paquetes `@modelcontextprotocol/server`, `@modelcontextprotocol/client`, `openai`, `zod` y TypeScript.
- **DEP-004**: Generador nativo de Codex para creación visual sin API; una futura activación remota del MCP requeriría `OPENAI_API_KEY` y facturación API separada.

## 5. Files

- **FILE-001**: `plan/infrastructure-media-assets-1.md`, plan ejecutable y registro de estado.
- **FILE-002**: `tools/if-media-mcp/`, implementación, pruebas y dependencias del servidor MCP.
- **FILE-003**: `agent-skills-src/if-media-assets/`, instrucciones canónicas para agentes.
- **FILE-004**: `.agents/skills/if-media-assets/` y `.claude/skills/if-media-assets/`, copias sincronizadas.
- **FILE-005**: `.codex/config.toml` y `.mcp.json`, registro local por proyecto del servidor MCP.
- **FILE-006**: `.gitignore`, exclusión de borradores, auditoría y secretos locales.
- **FILE-007**: `tools/Sync-AgentSkills.ps1` y `tools/Test-Sync-AgentSkills.ps1`, sincronización segura y regresión.

## 6. Testing

- **TEST-001**: Las rutas válidas permanecen bajo las raíces permitidas y las absolutas, recorridos y escapes son rechazados.
- **TEST-002**: Los manifiestos contienen hash, proveedor, modelo, estado y origen sin exponer credenciales.
- **TEST-003**: El servidor MCP inicia, enumera herramientas y devuelve estado incluso sin `OPENAI_API_KEY`.
- **TEST-004**: La generación y edición remotas fallan cerradas en modo `disabled`, sin llamadas ni consumo real.
- **TEST-005**: Inkscape produce PNG legibles desde los seis SVG sin modificar sus fuentes.
- **TEST-006**: La sincronización de skills rechaza divergencias reales y recupera manifiestos obsoletos cuando destino y fuente coinciden.
- **TEST-007**: `Build-Assets.ps1 -WhatIf` informa de forma accionable cualquier dependencia externa que falte.

## 7. Risks & Assumptions

- **RISK-001**: La instalación de Arma 3 Tools puede quedar pendiente de Steam, autenticación y aceptación de licencia del usuario.
- **RISK-002**: Una llamada real de imagen puede tener coste y políticas de retención del proveedor; por ello no se ejecutará sin clave y solicitud explícita.
- **RISK-003**: Los SVG actuales son propuestas y su conversión técnica no implica aprobación visual ni canónica.
- **ASSUMPTION-001**: El `package-lock.json` conservará las versiones y hashes de la cadena Node/Sharp instalada desde npm.
- **ASSUMPTION-002**: Codex y Claude se ejecutarán desde la raíz del repositorio; Codex aporta la generación nativa y Claude utiliza las operaciones locales compartidas.

## 8. Related Specifications / Further Reading

[Índice y mapa documental](../docs/00_INDEX_AND_DOCUMENTATION_MAP.md)
[Identidad visual y estado de propuestas](../art/IDENTIDAD_VISUAL.md)
[Arquitectura técnica](../docs/18_TECHNICAL_ARCHITECTURE_3DEN_SQF_AND_MULTIPLAYER.md)
[OpenAI Image generation](https://platform.openai.com/docs/guides/image-generation)
[Model Context Protocol TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk)
[ImageToPAA oficial](https://community.bohemia.net/wiki/ImageToPAA)
