# Documento de Diseño — Galactum Equipo 3

## Diseño documentado para la entrega de Fase 2

La versión representada en las evidencias recientes es MVP v0.12, con Godot 4.6.2. Se completa el diseño mediante dos entregables complementarios:

- [Vista Lógica](Arquitectura/Vista_Logica_Galactum.md): organización funcional, autoridad, réplica, flotas/minería, combate y datos.
- [Diagrama de Componentes](Arquitectura/Diagrama_Componentes_Galactum.md): módulos verificados, interfaces y dependencias con tablas que explican cada flecha.
- [Word consolidado](Arquitectura/Arquitectura_Galactum_Vista_Logica_y_Componentes.docx), con ambas figuras y explicaciones.
- [Fuentes y decisiones](Arquitectura/DIAGNOSTICO_Y_FUENTES.md) y [correspondencia Docker](Arquitectura/CORRESPONDENCIA_DOCKER.md).

Se conservan las decisiones válidas de la base histórica: servidor autoritativo, separación cliente/servidor y réplica visible. Para v0.12, el contrato revisado usa hello/view/intent y welcome/player/map_delta/report/ack/error; no se asume que todos los mensajes de M0–M2 sigan vigentes.

La revisión no añade componentes al juego: minería permanece en fleets.gd, persistencia en game_server.gd y balance en Catalog/JSON. El despliegue existente utiliza navegador, Nginx y Godot headless, sin servicio SQL independiente. Los sistemas de apoyo del MVP no se atribuyen automáticamente al Equipo 3 ni a Juan.

## Diseño histórico de la base M0–M2

## Componentes

### Cliente Godot
Responsable de visualización e interacción. Mantiene una réplica local del estado informado por el SSS.

### SSS Headless
Servidor autoritativo que mantiene el estado de mundo y publica actualizaciones.

### Contrato WebSocket
Define estructura de mensajes JSON, versiones de protocolo, secuencias y payloads.

## Decisiones
- El servidor es fuente de verdad.
- Los deltas reducen transmisión innecesaria.
- Los snapshots completos permiten recuperación.
- Las secuencias detectan pérdida o salto de mensajes.
- Cliente y SSS permanecen como proyectos Godot separados.

## Evolución
M0 validó conexión y protocolo.
M1 agregó estado sincronizado e interacción.
M2 era el hito activo al redactar este diseño histórico. Para el corte actual de Fase 2, consultar las vistas del MVP v0.12 enlazadas arriba.
