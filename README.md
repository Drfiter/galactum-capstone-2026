# Galactum — CAPSTONE 2026

## Nombre del proyecto
**Galactum — Sistema de Mundo y Combate en Tiempo Real (Equipo 3)**

## Descripción
Galactum es un videojuego de estrategia espacial multijugador (4X/MMO) para Android y PC. El Equipo 3 desarrolla el mundo en tiempo real y la interacción cliente-servidor: mapa y entidades, flotas y movimiento, minería, caza de xenoformas (PvE), combate PvP determinista, Asedios y la interfaz de estas funcionalidades.

El MVP v0.12 es jugable de punta a punta con un servidor autoritativo (embebido para jugar solo o dedicado por WebSocket para varios jugadores). Tras el feedback docente del 26/10/2026 se corrigieron los 7 errores reportados y se completaron las 9 funcionalidades que faltaban (ver [Estado del proyecto](./docs/PROJECT_STATUS.md)).

Este repositorio CAPSTONE reúne las evidencias académicas del proyecto. El código del juego está en el repositorio técnico **Drfiter/galactum** (carpeta `mvp-v0.12/`). Ver la nota de confidencialidad al final.

## Público objetivo
- Jugadores de Galactum (móvil y PC).
- Equipos del proyecto que dependen de los servicios del Equipo 3.
- Docente y evaluadores de la asignatura CAPSTONE.
- Contraparte que originó el proyecto.

## Tecnologías utilizadas

| Categoría | Tecnología |
|---|---|
| Motor y lenguaje | Godot 4.6.2, GDScript tipado |
| Red | WebSocket con JSON (protocolo `galactum-mvp-1`), servidor autoritativo |
| Autenticación | Cuentas con PBKDF2-HMAC-SHA256, JWT HS256 y tokens de renovación con rotación (servidor dedicado) |
| Datos | Catálogos de balance en JSON; guardado del estado en JSON |
| Infraestructura | Docker + Docker Compose (servidor headless y versión web con nginx) |
| Plataformas | Android (APK), PC Windows/Linux y navegador (HTML5/WebAssembly) |
| Calidad | Pruebas automáticas headless y arnés de balance de 10.000 combates |
| Gestión | Git/GitHub, Scrum con sprints de 2 semanas |

## Integrantes y responsabilidades

### Lucas Orellana
Responsabilidades consignadas en la planificación del proyecto:
- Setup de entorno y WebSocket.
- Sistema de viaje.
- Sistema de minería.
- Harness de balance.
- Trabajo conjunto en resolver de combate y documentación.

### Mateo Orellana
Responsabilidades consignadas en la planificación del proyecto:
- Spatial hash.
- Snapshots.
- Spawning de xenoformas.
- Sistema de rallies.
- Soak test y profiling.
- Trabajo conjunto en resolver de combate y documentación.

### Juan Castro
Se integró al equipo en la Fase 2. Aportes registrados en los repositorios:
- Diseño e implementación de asteroides y minería con cancelación por combate (M3).
- Documentación de arquitectura de la Fase 2: Vista Lógica, Diagrama de Componentes y Word consolidado.

## Metodología de trabajo
El proyecto se planificó con Scrum:
- Sprints de 2 semanas ([Sprint Backlog](./Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/Documento%2003%20-%20Sprint%20Backlog.md)).
- Reuniones periódicas de coordinación.
- Git/GitHub con ramas por funcionalidad y commits pequeños.
- Pruebas automáticas en cada cambio y TDD en componentes críticos (resolver de combate).
- Documentación en Markdown y PDF.

## Arquitectura de la solución

```text
 Navegador (HTML5)        PC / Android (Godot)
        │  http + ws /ws          │  ws :9100
        ▼                         │
 ┌──────────────┐                 │
 │ web (nginx)  │── /ws ──────────┤
 └──────────────┘                 ▼
                       ┌──────────────────────┐
                       │ server (Godot        │  cuentas JWT, mundo, flotas,
                       │ headless, SSS)       │  combate, PvE, Asedios
                       └──────────┬───────────┘
                                  ▼
                        volumen galactum-data
                     (galactum_server_save.json)
```

- **Servidor autoritativo:** el cliente solo envía intenciones; el servidor valida, simula y replica por área de interés.
- **Resolver de combate determinista y versionado** (semilla + `combat_version`), puro y probado con TDD.
- **Datos separados de la lógica:** el balance vive en `data/*.json`.
- Vistas detalladas: [Vista Lógica](./Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/Vista_Logica_Galactum.md) y [Diagrama de Componentes](./Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/Diagrama_Componentes_Galactum.md).

## Estado de hitos

| Hito | Estado | Resumen |
|---|---|---|
| M0 | Completado | Conexión y protocolo base Cliente ↔ SSS |
| M1 | Completado | Mundo, área de interés, secuencias, desync y recuperación |
| M2 | Completado | Viaje autoritativo de la Astronave |
| M3 | Completado | Minería, combate, xenoformas y representación de la nave |
| MVP v0.12 | Completado | Juego jugable en Android y PC con servidor embebido o dedicado |
| Feedback 26/10 | Completado | 7 errores corregidos y 9 funcionalidades agregadas (09–10/11/2026) |
| Docker | Completado | Servidor + versión web con Compose, versionado en el repositorio técnico (10/11/2026) |

## Cómo ejecutar el proyecto

El código está en el repositorio técnico, carpeta `mvp-v0.12/`.

**Opción A — Docker (recomendada para revisar):** solo requiere Docker Desktop.

```powershell
cd mvp-v0.12
copy .env.example .env          # completar GALACTUM_JWT_SECRET (32+ caracteres)
docker compose up -d --build
```

Abrir http://localhost:8080 → *Servidor dedicado* → usuario y contraseña → *Crear cuenta* (la primera vez) o *Entrar*. Detalle y verificación: [Registro Docker 10/11](./Fase%203/Evidencias%20Proyecto/REGISTRO_VERIFICACION_DOCKER_2026-11-10.md).

**Opción B — Godot 4.6.2 en Windows:** `Ejecutar_Galactum.bat` (o abrir `mvp-v0.12/project.godot` y presionar F5). Servidor dedicado: `Ejecutar_Servidor_Dedicado.bat`; demo con dos clientes: `Ejecutar_Demo_2_Clientes.bat`; pruebas: `Ejecutar_Pruebas.bat`.

**Android:** exportar el preset Android de `mvp-v0.12` (instrucciones en el `LEEME.md` del repositorio técnico).

## Pruebas

| Suite | Resultado (10/11/2026) |
|---|---|
| Pruebas canónicas (`run_tests`) | 24 OK, 0 fallidas |
| Bucle completo del servidor (`server_smoke`) | 0 fallas |
| Errores del feedback (`feedback_checks`) | 24 OK, 0 fallidas |
| Funcionalidades nuevas (`features_checks`) | 206 OK, 0 fallidas |
| Arnés de balance, 10.000 combates por enfrentamiento | 15/15 enfrentamientos entre 60 % y 75 % |
| Docker: build, salud, cuentas por nginx, persistencia y navegador | Verificado |

Comandos y salidas completas: [docs/TESTING.md](./docs/TESTING.md).

## Evidencias CAPSTONE
- [Fase 1](./Fase%201/)
- [Fase 2](./Fase%202/)
- [Fase 3](./Fase%203/) — informes del feedback, video de demo y verificación Docker
- [Estado del proyecto](./docs/PROJECT_STATUS.md)
- [Pruebas](./docs/TESTING.md)
- [Mapa de evidencias](./docs/EVIDENCE_MAP.md)
- [Arquitectura](./docs/ARCHITECTURE.md)

## Privacidad y confidencialidad
La versión pública no contiene RUT ni otros datos personales sensibles; las evidencias académicas se publican sanitizadas. Este repositorio no incluye el código del juego ni credenciales: el código está en el repositorio técnico, cuyo acceso depende del acuerdo de confidencialidad con la contraparte.
