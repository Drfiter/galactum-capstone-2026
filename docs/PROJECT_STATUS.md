# Estado del proyecto

## M0 — Base técnica
**Estado: completado**

Incluye conexión Cliente ↔ SSS, mensajes JSON, `protocol_version`, `seq`, `server_time`, snapshot inicial y pong.

## M1 — Sincronización del mundo
**Estado: completado / integrado**

Incluye `WorldState`, `full_snapshot`, `map_delta`, `added / updated / removed`, validación de secuencias, detección de desync, recuperación y controles de interacción del cliente.

## M2 — Hito activo
**Estado: en desarrollo**

M2 representa el estado activo del proyecto y concentra la integración hacia un mundo cada vez más jugable.

## Alcance planificado
La Guía APT inicial contempla además minería, PvE, combate, persistencia y otras integraciones. Estas funciones se consideran **planificadas** mientras no exista evidencia verificable de implementación.
