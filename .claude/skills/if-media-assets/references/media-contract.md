# Contrato de procedencia visual

## Estados admitidos

- `proposal`: resultado generado, editado o diseñado que todavía no ha sido aprobado.
- `reference`: material externo conservado únicamente para consulta y con procedencia verificable.
- `approved_source`: fuente propia aprobada por una decisión humana explícita; el MCP no asigna este estado automáticamente.
- `built`: derivado técnico regenerable, como PNG o PAA; no implica validación en el motor.

## Campos mínimos del manifiesto

Cada registro debe incluir `schema_version`, `asset_id`, `path`, `sha256`, `media_type`, `created_at`, `origin.kind`, `origin.provider`, `origin.model`, `origin.license`, `origin.prompt` o `origin.description`, `status` y `approval_reference` cuando corresponda.

No registres datos desconocidos como si estuvieran confirmados. Usa `null` y comunica el pendiente.

## Promoción

Una aprobación debe identificar el archivo exacto por ruta y hash. La promoción conserva el manifiesto anterior y añade la referencia de decisión; no borra la condición de origen ni transforma una referencia de terceros en fuente propia.

## Separación de rutas

| Ruta | Uso | Versionable |
| --- | --- | --- |
| `production/media/drafts/` | Generación y edición no aprobada | No |
| `production/media/manifests/` | Procedencia y decisiones | Sí |
| `art/` | Fuente editable propia aprobada o propuesta declarada | Sí |
| `asset/reference/` | Referencia externa autorizada | Según `asset/PROCEDENCIA.md` |
| `art/export/` | PNG intermedio regenerable | No |
| `IslasFracturadas.Altis/ui/insignia/` | PAA final para el motor | Sí, solo tras conversión válida |
