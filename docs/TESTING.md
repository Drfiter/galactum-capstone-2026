# Pruebas y calidad

## Pruebas vigentes — 10 de noviembre de 2026

Todas se ejecutan sin interfaz gráfica con Godot 4.6.2 desde la carpeta `mvp-v0.12/` del repositorio técnico (`Ejecutar_Pruebas.bat` las corre en Windows). Las salidas completas de esta ejecución están en [docs/pruebas](./pruebas/).

| Suite | Comando | Qué cubre | Resultado | Salida |
|---|---|---|---|---|
| Canónicas | `godot --headless --path . res://tests/run_tests.tscn` | Resolver de combate (determinismo, triángulo, escudos), economía, colas, minería y formato de números | 24 OK, 0 fallidas | [run_tests.txt](./pruebas/run_tests.txt) |
| Bucle completo | `godot --headless --path . res://tests/server_smoke.tscn` | Servidor completo: minería, caza, PvP, galaxia, alianza, torneos, tripulación | FAILURES=0 | [server_smoke.txt](./pruebas/server_smoke.txt) |
| Errores del feedback | `godot --headless --path . res://tests/feedback_checks.tscn` | Regresión de los 7 errores del 26/10 (UI, cámara, textos, audio, chat, bots) | 24 OK, 0 fallidas | [feedback_checks.txt](./pruebas/feedback_checks.txt) |
| Funcionalidades | `godot --headless --path . res://tests/features_checks.tscn` | Las 9 fases: tripulantes, Comandante, Armería, alianzas y Asedio, progresión, LiveOps, Expediciones, endgame y cuentas | 206 OK, 0 fallidas | [features_checks.txt](./pruebas/features_checks.txt) |
| Balance | `godot --headless --path . res://tools/balance_harness.tscn -- --n=10000` | Triángulo Infantería > Drones > Pilotos > Infantería en N1-N5 (spec: 60–75 %) | 15/15 dentro del rango (61,9–70,2 %) | [balance_harness_10000.txt](./pruebas/balance_harness_10000.txt) |
| Docker | `docker compose up -d --build` y cliente de prueba WebSocket | Build, salud, web, cuentas por nginx `/ws`, rechazo sin cuenta, persistencia tras `down`/`up` | Verificado | [docker_verificacion_2026-11-10.txt](./pruebas/docker_verificacion_2026-11-10.txt) |

Notas:
- Los avisos `ObjectDB instances leaked at exit` y `resources still in use at exit` al final de algunas salidas los emite Godot al cerrar el proceso de prueba; no son fallas de las pruebas.
- Cada arreglo del feedback y cada fase agregó sus pruebas antes de subirse. Ejemplo del 10/11: una prueba nueva detectó que el Festival de la Flota dejaba de sumar aportes fuera de los Eventos de Singularidad; falla sin el arreglo y pasa con él.
- No se ejecutaron pruebas de carga con cientos de clientes concurrentes ni pruebas en un teléfono real en esta fecha.

---

## Registro histórico (M0–M2 y corte de Fase 2)

Lo que sigue se conserva sin cambios como registro de los cortes anteriores.

### Marcadores documentados
- `M1_CLIENT_WORLD_STATE_TEST_OK`
- `SSS_WORLD_TEST_OK`
- `M0_SMOKE_OK`
- `M1_SSS_CONNECTION_SEQUENCE_TEST_OK`

### Matriz resumida

| Área | Qué valida |
|---|---|
| M0 Smoke | Conexión base Cliente ↔ SSS |
| World State | Aplicación de snapshots y deltas |
| Secuencias | Orden y detección de gaps |
| Desync recovery | Solicitud y aplicación de snapshot completo |
| SSS World | Comportamiento del estado de mundo en servidor |

### Criterio de evidencia
Una prueba se considera ejecutada solamente cuando existe evidencia del comando y su salida.

### Pendiente
Crear un runner E2E específico para M2 y conservar M0/M1 como evidencia histórica.

### Alcance del complemento de arquitectura — Fase 2

La pendiente M2 anterior pertenece al registro histórico. Para MVP v0.12 se dispone de documentación del recorrido minero/PvE y de [stop/start Docker](../Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/REGISTRO_VERIFICACION_DOCKER.md). No son resultados nuevos de suites.

La tarea de arquitectura verifica coherencia de diagramas, enlaces, fuentes/exportaciones y Word. No ejecuta el juego, smoke, harness, carga ni Android. La existencia de semilla, request_id o escenas de prueba no certifica determinismo, idempotencia ni aprobación de pruebas. Véase [revisión documental](../Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/REVISION_Y_EXPOSICION.md).
