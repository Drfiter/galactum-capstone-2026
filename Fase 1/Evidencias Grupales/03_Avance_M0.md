# Evidencia: Hito M0

## Alcance
M0 estableció el protocolo y la conexión mínima necesaria para comenzar el desarrollo del mundo sincronizado.

## Componentes
- Conexión WebSocket.
- JSON.
- `protocol_version`.
- `seq`.
- `server_time`.
- Snapshot inicial.
- Pong.
- Puerto 9100.

## Valor
Permitió comprobar que cliente y servidor podían intercambiar estado antes de agregar interacción, deltas y recuperación ante desincronización.
