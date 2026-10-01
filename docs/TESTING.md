# Pruebas y calidad

## Marcadores documentados
- `M1_CLIENT_WORLD_STATE_TEST_OK`
- `SSS_WORLD_TEST_OK`
- `M0_SMOKE_OK`
- `M1_SSS_CONNECTION_SEQUENCE_TEST_OK`

## Matriz resumida

| Área | Qué valida |
|---|---|
| M0 Smoke | Conexión base Cliente ↔ SSS |
| World State | Aplicación de snapshots y deltas |
| Secuencias | Orden y detección de gaps |
| Desync recovery | Solicitud y aplicación de snapshot completo |
| SSS World | Comportamiento del estado de mundo en servidor |

## Criterio de evidencia
Una prueba se considera ejecutada solamente cuando existe evidencia del comando y su salida.

## Pendiente
Crear un runner E2E específico para M2 y conservar M0/M1 como evidencia histórica.
