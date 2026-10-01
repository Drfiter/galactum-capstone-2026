# Arquitectura de Galactum — Equipo 3

## Componentes principales

### Cliente Godot
- Proyecto Godot para PC y Android.
- Representa el estado recibido desde el servidor.
- Implementa selección, cámara y navegación del usuario.

### SSS Headless
- Proyecto Godot ejecutado sin interfaz gráfica.
- Mantiene la autoridad del estado del mundo.
- Expone comunicación WebSocket JSON.

## Flujo de sincronización

```text
SSS
 │
 ├── full_snapshot ──────► Cliente
 │
 ├── map_delta ──────────► Cliente
 │                         │
 │                         ├── added
 │                         ├── updated
 │                         └── removed
 │
 ◄──── request_full_snapshot ─ Cliente
```

## Secuencias y recuperación
Si el cliente detecta un salto de secuencia:
1. Marca una condición de desincronización.
2. Solicita `request_full_snapshot`.
3. Reemplaza su baseline local.
4. Continúa desde un estado coherente.

## Parámetros documentados
- Puerto local: **9100**
- Mapa de pruebas: **600 × 600**
- Comunicación: **WebSocket JSON**
- Servidor: **autoritativo**
