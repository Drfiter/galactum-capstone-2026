# Galactum — CAPSTONE 2026

## Nombre del proyecto
**Galactum — Sistema de Mundo y Combate en Tiempo Real (Equipo 3)**

## Descripción
Galactum es un proyecto de videojuego multijugador en el que el Equipo 3 desarrolla la base de mundo en tiempo real y la interacción cliente-servidor. El foco actual está en la sincronización del mundo, la navegación del cliente, la recuperación ante desincronizaciones y la evolución hacia mecánicas jugables como movimiento, minería y combate.

Este repositorio CAPSTONE documenta los avances, decisiones técnicas y evidencias del proyecto de forma pública, sin incluir datos personales sensibles.

## Público objetivo
- Jugadores finales de Galactum.
- Equipos de desarrollo que dependen de los servicios del Equipo 3.
- Docente y evaluadores de la asignatura CAPSTONE.
- Contraparte que originó el proyecto.

## Tecnologías utilizadas
- Godot 4.6.2
- GDScript
- WebSocket
- JSON
- Git / GitHub
- PC y Android

## Integrantes y responsabilidades

### Lucas Orellana
Responsabilidades consignadas en la planificación del proyecto:
- Setup de entorno y WebSocket.
- Sistema de viaje.
- Sistema de minería.
- Harness de balance.
- Trabajo conjunto en resolver de combate y documentación.

### Mateo Orellana
Responsabilidades consignadas en la planificación del proyecto:
- Spatial hash.
- Snapshots.
- Spawning de xenoformas.
- Sistema de rallies.
- Soak test y profiling.
- Trabajo conjunto en resolver de combate y documentación.

## Metodología de trabajo
El proyecto se planificó con una metodología ágil basada en Scrum:
- Sprints de 2 semanas.
- Reuniones periódicas de coordinación.
- Git/GitHub con ramas por funcionalidad.
- GitHub Projects / Kanban para seguimiento.
- TDD para componentes críticos.
- Documentación en Markdown.

## Arquitectura de la solución

```text
┌────────────────────┐
│   Cliente Godot    │
│    PC / Android    │
└─────────┬──────────┘
          │ WebSocket JSON
          │
          ▼
┌────────────────────┐
│    SSS Headless    │
│ Servidor autorit.  │
└────────────────────┘
```

Características ya trabajadas:
- Conexión Cliente ↔ SSS.
- `full_snapshot` y `map_delta`.
- Manejo de entidades `added / updated / removed`.
- Validación de secuencias.
- Detección de desincronización.
- Recuperación mediante `request_full_snapshot`.
- Selección por tap/click.
- Paneo y zoom.
- Culling de entidades.

## Estado de hitos

| Hito | Estado | Resumen |
|---|---|---|
| M0 | Completado | Conexión y protocolo base Cliente ↔ SSS |
| M1 | Completado / integrado | WorldState, secuencias, desync e interacción del cliente |
| M2 | Activo | Integración y evolución del mundo jugable |

## Instrucciones generales de ejecución local
Requisitos:
- Godot 4.6.2.
- Git.
- Windows 10/11 para el flujo actualmente documentado.

Flujo general:
1. Clonar el repositorio técnico del proyecto Galactum.
2. Abrir el cliente desde `project.godot`.
3. Abrir el servidor desde `server/sss/project.godot`.
4. Iniciar primero el SSS.
5. Iniciar el cliente.
6. La configuración local usa el puerto **9100**.

> Este repositorio está orientado a las evidencias CAPSTONE. El código técnico del proyecto se mantiene en su repositorio de desarrollo.

## Evidencias CAPSTONE
- [Fase 1](./Fase%201/)
- [Fase 2](./Fase%202/)
- [Fase 3](./Fase%203/)
- [Arquitectura](./docs/ARCHITECTURE.md)
- [Estado del proyecto](./docs/PROJECT_STATUS.md)
- [Pruebas](./docs/TESTING.md)
- [Mapa de evidencias](./docs/EVIDENCE_MAP.md)

## Privacidad
La versión pública no contiene RUT ni otros identificadores personales sensibles. Las evidencias académicas se publican sanitizadas.
