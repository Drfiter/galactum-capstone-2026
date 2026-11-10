# Correspondencia con Docker — Fase 2

## Propósito

Relacionar las dos vistas de arquitectura con el despliegue documentado del MVP v0.12. No se crea ni se modifica Docker. Esta sección es de despliegue y no reemplaza la Vista Lógica ni el Diagrama de Componentes.

| Lugar | Contenido y responsabilidad | Fuente |
| --- | --- | --- |
| Navegador | Ejecuta el cliente Godot WebAssembly/WebGL: UI, réplica y enlace WebSocket | S5/S7 |
| Servicio web | Imagen galactum-web:0.12; Nginx sirve la exportación en puerto interno 80 y reenvía /ws hacia server:9100 | S7 §§2–3; S8 |
| Servicio server | Imagen galactum-server:0.12; Godot headless ejecuta gateway, GameServer, mundo, índice, flotas, resolver y apoyos integrados | S7; módulos comprobados en S9 |
| Acceso local | http://localhost:8080; publicaciones a 127.0.0.1:8080 y 127.0.0.1:9100 | S7/S8 |
| Almacenamiento | Volumen galactum_galactum-data montado en /data; JSON bajo /data/godot/app_userdata/Galactum/galactum_server_save.json | S7/S8; ruta user:// y guardado comprobados en S9 |

Nginx distribuye el cliente y actúa como proxy; el renderizado ocurre en el navegador. El cliente no conecta usando un nombre interno de Docker. Los componentes del servidor comparten proceso: no son un contenedor por script. No hay un servicio SQL independiente.

## Comunicación y autoridad

El transporte dedicado intercambia JSON por WebSocket, protocolo galactum-mvp-1. El jugador solicita acciones; el servidor valida y modifica el estado. La réplica y la proyección temporal sirven para presentación. Los catálogos JSON contienen balance y el guardado contiene estado mutable: cumplen funciones diferentes.

## Alcance de la evidencia Docker

El registro del 3 de noviembre documenta Stop y Start sobre los mismos contenedores: pérdida de conexión, rechazo HTTP al recargar, posterior arranque, log de restauración, volumen en uso y reingreso al juego. Se conservaron sus identificadores. Esa comprobación previa no se atribuye a Juan ni se presenta como una prueba ejecutada en esta tarea.

No acredita eliminación/recreación de contenedores, recuperación tras borrar el volumen, nube, carga o alta disponibilidad. El volumen no equivale a un respaldo. Los conteos de jugadores guardados no son concurrencia. La existencia de perfiles tests/smoke no acredita su ejecución.

## Confirmación pendiente

La copia técnica revisada permite comprobar lógica v0.12, arranque dedicado, JSON y puerto 9100. No incluye los cuatro archivos Docker citados en S7 ni la adaptación de conexión web al mismo origen. Es necesario registrar su ubicación y commit para cerrar esa comprobación directa. Hasta entonces, los detalles Docker anteriores se identifican como respaldados por documentación y capturas, no por inspección de configuración en esta tarea.

[Fuentes S1–S9](DIAGNOSTICO_Y_FUENTES.md).

## Actualización del 10 de noviembre

La confirmación pendiente quedó resuelta: `compose.yaml`, `docker/Dockerfile`, `docker/nginx.conf` y `docker/healthcheck.py`, junto con la conexión web al mismo origen (`/ws`), están versionados en el repositorio técnico (carpeta `mvp-v0.12/`, commits `612a27a` y `aa375ad`). Se verificaron construcción, salud del servidor, cuentas a través de nginx, persistencia tras recrear los contenedores y el juego en el navegador: [registro del 10/11](../../../Fase%203/Evidencias%20Proyecto/REGISTRO_VERIFICACION_DOCKER_2026-11-10.md). El despliegue verificado mantiene los servicios, puertos, `/ws` y volumen descritos arriba; además, el servidor dedicado ahora exige cuenta (JWT).
