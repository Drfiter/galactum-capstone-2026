# Estado del proyecto

## Corte documental vigente — Fase 2, MVP v0.12

Las guías y evidencias del 3 de noviembre documentan minería y caza PvE observadas, además del despliegue local Docker. El complemento de arquitectura del 4 de noviembre añade Vista Lógica, Componentes y Word, cotejando los módulos v0.12 en lectura. [Índice de entrega](../Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/INDICE_ENTREGA_FASE_2.md).

Los apartados M0–M2 siguientes se conservan como antecedentes. La revisión de implementación y las capturas no equivalen a suites ejecutadas. La restauración documentada corresponde a stop/start de los mismos contenedores. Siguen pendientes la configuración Docker exacta, recreación, concurrencia, métricas y resultados de pruebas automatizadas de la entrega.

## M0 — Base técnica
**Estado: completado**

Incluye conexión Cliente ↔ SSS, mensajes JSON, `protocol_version`, `seq`, `server_time`, snapshot inicial y pong.

## M1 — Sincronización del mundo
**Estado: completado / integrado**

Incluye `WorldState`, `full_snapshot`, `map_delta`, `added / updated / removed`, validación de secuencias, detección de desync, recuperación y controles de interacción del cliente.

## M2 — Antecedente de integración
**Estado registrado históricamente: en desarrollo**

M2 concentró la integración de la base de mundo. El corte actual de Fase 2 se describe arriba como MVP v0.12.

## Alcance planificado
La Guía APT inicial contempla minería, PvE, combate, persistencia y otras integraciones. Las evidencias recientes respaldan un recorrido observado de minería/PvE y persistencia stop/start; esto no certifica todas las integraciones planificadas, el balance completo ni la escala MMO.
