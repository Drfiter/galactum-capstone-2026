# Documento de Diseño — Galactum Equipo 3

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
M2 es el hito activo de integración.
