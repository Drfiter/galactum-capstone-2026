# Documento 03 — Sprint Backlog

Galactum · Equipo 3 (Mundo y Combate) · Proyecto de Título APT, Duoc UC 2026.

> **Origen:** este Sprint Backlog se reconstruyó el 10/11/2026 a partir del historial de commits del repositorio técnico (Drfiter/galactum, todas las ramas). Registra lo que se entregó en cada sprint de 2 semanas, con fecha y autor del commit. No reemplaza la planificación original del equipo; los períodos sin commits se indican como tales.

Sprints de 2 semanas desde el 31/08/2026. Autores tal como figuran en Git: *Drfiter* (dueño del repositorio), *lukinha* / *lucorellana1337* (Lucas Orellana), *Mateo Orellana*, *JuanCastroC.* (Juan Castro, desde la Fase 2) y *Claude* (asistente de IA usado por el equipo).

## Sprint 1 — 31/08 al 13/09 · Base técnica (M0–M2)

| Ítem | Entregado | Fecha | Autor (commit) |
|---|---|---|---|
| Repositorio y estructura inicial | Initial commit; carpetas de entrega | 30/08, 08/09 | Drfiter |
| M0 · Rebanada vertical cliente ↔ SSS (WebSocket JSON) | `feat(team3): implement M0 client-SSS vertical slice` | 03/09 | Drfiter |
| M1 · Núcleo del mundo en el SSS y área de interés (AOI) | `implement M1 SSS world core and AOI`, `complete M1 SSS AOI synchronization` | 04/09 | lukinha |
| M1 · Cliente Android e integración cliente ↔ SSS | `finalize M1 client-SSS integration` | 04/09 | Drfiter |
| M2 · Viaje autoritativo de la Astronave | `implement M2 authoritative ship travel` | 13/09 | lucorellana1337 |
| M2 · Flujo de viaje en el cliente | `implement M2 client travel flow` | 13/09 | Mateo Orellana |

## Sprint 2 — 14/09 al 27/09 · Estabilización de M2

| Ítem | Entregado | Fecha | Autor (commit) |
|---|---|---|---|
| Corrección de carga de TravelMath en el SSS | `fix(team3): load TravelMath explicitly in SSS` | 14/09 | Mateo Orellana |

## Sprint 3 — 28/09 al 11/10

Sin commits en el repositorio técnico.

## Sprint 4 — 12/10 al 25/10 · M3 (minería, combate, xenoformas, nave)

| Ítem | Entregado | Fecha | Autor (commit) |
|---|---|---|---|
| Diseño e implementación de asteroides y minería con cancelación por combate | `propose asteroid and mining design`, `implement asteroid mining with combat cancellation` | 14/10 | JuanCastroC. |
| Rebanada vertical de combate M3 | `implement M3 combat vertical slice` | 14/10 | Mateo Orellana |
| Representación reutilizable de la nave y selección | `add reusable ship representation and selection` | 14/10 | lucorellana1337 |
| Base autoritativa de Xenoformas para el combate | `agregar base autoritativa de Xenoforms y consulta para Combat` | 14/10 | lucorellana1337 |
| Documentación del estado de M2 y M3 | `document current M2 project state`, `update M3 ship integration status` | 14/10 | Mateo Orellana |
| APK del MVP (25/10) | Publicado en `releases/` el 03/11 | 25/10 | Mateo Orellana |

## Sprint 5 — 26/10 al 08/11 · MVP v0.12 y feedback docente

| Ítem | Entregado | Fecha | Autor (commit) |
|---|---|---|---|
| MVP v0.12 completo: lógica, catálogos, interfaz Android/PC, pruebas y lanzadores | 4 commits (`incorporar logica y catalogos del MVP completo v0.12`, …) | 03/11 | Mateo Orellana |
| Formato de números por idioma, HUD opaco, corrección de importación | 11 commits | 08/11 | Claude |

## Sprint 6 — 09/11 al 22/11 · Feedback del 26/10, funcionalidades y Docker (en curso)

| Ítem | Entregado | Fecha | Autor (commit) |
|---|---|---|---|
| 7 errores del feedback corregidos con pruebas de regresión (tarjeta de objetivo, coordenadas, textos internos, etiquetas de la nave, chat de alianza, audio, nombre de bot) | 32 commits e informe PDF | 09/11 | lukinha |
| Fase 1 · Tripulantes en flotas, Insignias, grados, rangos y doble empleo | commits y 16 comprobaciones | 10/11 | lukinha |
| Fase 2 · Comandante, Protocolos de Mando y captura | commits y 21 comprobaciones | 10/11 | lukinha |
| Fase 3 · Armería: 150 materiales, 90 equipos y drops | commits y 16 comprobaciones | 10/11 | lukinha |
| Fase 4 · Alianzas completas, Asedio y refuerzos | commits y 34 comprobaciones | 10/11 | lukinha |
| Fase 5 · Puente 25, N1-N5, árbol de 5 ramas, formaciones, 24 salas | commits, 24 comprobaciones y arnés de balance | 10/11 | lukinha |
| Fase 6 · Pase, Licencia, Singularidad y Festival | commits y 21 comprobaciones | 10/11 | lukinha |
| Fase 7 · Expediciones | commits y 27 comprobaciones | 10/11 | lukinha |
| Fase 8 · Colmenas, Plataformas Orbitales, títulos y Rescate | commits y 26 comprobaciones | 10/11 | lukinha |
| Fase 9 · Cuentas con JWT en el servidor dedicado | commits y 21 comprobaciones | 10/11 | lukinha |
| Docker versionado (servidor + web con nginx) y verificado | `feat(docker): servidor dedicado y versión web con Docker Compose` | 10/11 | lukinha |
| Informe de funcionalidades con evidencias (PDF) | `docs: informe con evidencias de las 9 fases` | 10/11 | lukinha |

Los commits de lukinha del 09 y 10/11 se hicieron con asistencia de Claude (línea `Co-Authored-By` en cada commit).

## Pendiente (backlog del sprint en curso)

- Exportar y probar un APK nuevo en un teléfono real.
- HTTPS para el servidor dedicado fuera del PC.
- Pagos reales (requiere cuenta de Play Console).
- Informe y presentación final de la Fase 3.
