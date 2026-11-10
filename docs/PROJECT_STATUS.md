# Estado del proyecto

## Estado vigente — 10 de noviembre de 2026

**MVP v0.12 jugable, con los 7 errores del feedback del 26/10 corregidos y las 9 funcionalidades que faltaban completadas.** Repositorio técnico: Drfiter/galactum, carpeta `mvp-v0.12/`.

### Feedback docente del 26/10/2026

| Parte | Resultado | Evidencia |
|---|---|---|
| 7 errores encontrados jugando | 7 corregidos (09/11) con pruebas de regresión | [Informe de correcciones](../Fase%203/Evidencias%20Proyecto/Informe_correcciones_feedback_2026-11-09.pdf) |
| 9 funcionalidades faltantes | 9 implementadas (09–10/11) en 9 fases | [Informe de funcionalidades](../Fase%203/Evidencias%20Proyecto/Informe_funcionalidades_feedback_2026-11-10.pdf) |
| Estado antes de completar | 4 parciales y 5 pendientes (09/11) | [Documento de estado](../Fase%203/Evidencias%20Proyecto/Estado_feedback_2026-11-09.pdf) |

### Funcionalidades agregadas

| Fase | Funcionalidad |
|---|---|
| 1 | Tripulantes en las flotas (hasta 5), Insignias, grados, rangos y regla de doble empleo |
| 2 | Comandante: 60 niveles, 18 Protocolos de Mando en 3 ramas y captura con rescate |
| 3 | Armería: 150 materiales, 90 equipos con 5 niveles y drops de cazas y minería |
| 4 | Alianzas completas (crear, buscar, R1-R5, Tesorería, Tienda, Bonos), Asedio (rally) y refuerzos |
| 5 | Puente hasta nivel 25, fuerzas N1-N5, árbol de investigación de 5 ramas, 5 formaciones y 24 salas |
| 6 | Pase de Expedición, Licencia de Comandante, Eventos de Singularidad y Festival de la Flota (pago simulado) |
| 7 | Expediciones: 6 capítulos × 8 etapas con tripulantes, modo Élite y barrido |
| 8 | Colmenas Xeno, Plataformas Orbitales, títulos y Operación de Rescate (30 % del Criosantuario) |
| 9 | Cuentas en el servidor dedicado: registro, login, JWT y tokens de renovación |

### Infraestructura

- **Docker (10/11):** `compose.yaml`, `docker/Dockerfile`, `docker/nginx.conf` y `docker/healthcheck.py` quedaron versionados en el repositorio técnico (commit `aa375ad`). Se verificaron la construcción, la salud del servidor, las cuentas a través de nginx, la persistencia tras recrear los contenedores y el juego completo en el navegador. [Registro](../Fase%203/Evidencias%20Proyecto/REGISTRO_VERIFICACION_DOCKER_2026-11-10.md).
- **Pruebas automáticas:** 4 suites y el arnés de balance, con salidas completas en [docs/pruebas](./pruebas/). [Detalle](./TESTING.md).

### Pendiente

- Pagos reales (Google Play Billing requiere una cuenta de Play Console; hoy las compras son simuladas).
- SGM en NestJS + PostgreSQL (Equipo 1) y recuperación de contraseña.
- HTTPS para publicar el servidor fuera del PC (proxy con certificado delante de nginx).
- Probar en un teléfono real el APK v0.12.3 (exportado y firmado el 10/11: `releases/android/Galactum-2026-11-10-v0.12.3.apk` del repositorio técnico).
- En el servidor dedicado, algunos textos generados por el servidor (misiones y eventos) se muestran en el idioma del servidor y no en el del jugador.

---

## Registro histórico (cortes del 3 y 4 de noviembre)

Lo que sigue se conserva sin cambios como registro de los cortes anteriores.

### Corte documental vigente — Fase 2, MVP v0.12

Las guías y evidencias del 3 de noviembre documentan minería y caza PvE observadas, además del despliegue local Docker. El complemento de arquitectura del 4 de noviembre añade Vista Lógica, Componentes y Word, cotejando los módulos v0.12 en lectura. [Índice de entrega](../Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/INDICE_ENTREGA_FASE_2.md).

Los apartados M0–M2 siguientes se conservan como antecedentes. La revisión de implementación y las capturas no equivalen a suites ejecutadas. La restauración documentada corresponde a stop/start de los mismos contenedores. Siguen pendientes la configuración Docker exacta, recreación, concurrencia, métricas y resultados de pruebas automatizadas de la entrega.

### M0 — Base técnica
**Estado: completado**

Incluye conexión Cliente ↔ SSS, mensajes JSON, `protocol_version`, `seq`, `server_time`, snapshot inicial y pong.

### M1 — Sincronización del mundo
**Estado: completado / integrado**

Incluye `WorldState`, `full_snapshot`, `map_delta`, `added / updated / removed`, validación de secuencias, detección de desync, recuperación y controles de interacción del cliente.

### M2 — Antecedente de integración
**Estado registrado históricamente: en desarrollo**

M2 concentró la integración de la base de mundo. El corte actual de Fase 2 se describe arriba como MVP v0.12.

### Alcance planificado
La Guía APT inicial contempla minería, PvE, combate, persistencia y otras integraciones. Las evidencias recientes respaldan un recorrido observado de minería/PvE y persistencia stop/start; esto no certifica todas las integraciones planificadas, el balance completo ni la escala MMO.
