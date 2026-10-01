# Evidencia: WorldState y recuperación ante desync

## WorldState
El cliente mantiene una copia local del estado combinando:
- `full_snapshot`
- `map_delta`

Los deltas distinguen:
- `added`
- `updated`
- `removed`

## Validación de secuencias
El cliente valida la continuidad de `seq`. Si detecta un gap, evita asumir que el estado local sigue siendo correcto.

## Recuperación
El flujo solicita `request_full_snapshot` y establece un nuevo baseline.
