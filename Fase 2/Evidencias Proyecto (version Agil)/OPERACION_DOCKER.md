# Operación local de Galactum con Docker

> **Actualización 10/11/2026.** La configuración Docker quedó versionada en el repositorio técnico y el servidor dedicado ahora exige cuenta. Pasos vigentes: en `mvp-v0.12/`, `copy .env.example .env` (completar `GALACTUM_JWT_SECRET`), `docker compose up -d --build`, abrir http://localhost:8080 → *Servidor dedicado* → *Crear cuenta* o *Entrar*. Verificación completa: [Registro Docker del 10/11](../../Fase%203/Evidencias%20Proyecto/REGISTRO_VERIFICACION_DOCKER_2026-11-10.md).

## Alcance

El despliegue del MVP v0.12 comprende un servidor Godot 4.6.2 sin interfaz gráfica y una exportación web servida por Nginx. Chrome ejecuta el cliente WebAssembly/WebGL. Este repositorio académico conserva el registro documental; los comandos se ejecutan en la copia autorizada del repositorio técnico que contiene `compose.yaml`.

## Puesta en marcha

Con Docker Desktop iniciado, abrir PowerShell en la carpeta del proyecto técnico:

```powershell
docker compose up -d --build
docker compose ps
```

Abrir `http://localhost:8080`. Compose publica el cliente en `127.0.0.1:8080` y el servidor en `127.0.0.1:9100`. El servicio web utiliza `/ws` para comunicarse con el servidor. Durante la puesta en marcha, web depende de la salud de server.

## Consultas y ciclo de operación

```powershell
docker compose logs --tail 100 server
docker volume inspect galactum_galactum-data
docker compose stop
docker compose start
docker compose ps
```

Durante la detención, el cliente puede mostrar pérdida de conexión y una recarga HTTP puede responder `ERR_CONNECTION_REFUSED`. Tras el inicio, recargar el navegador e ingresar al juego. El ciclo documentado se realizó con Stop y Start en Docker Desktop sobre el grupo `galactum`.

## Persistencia

El volumen nombrado `galactum_galactum-data` está montado en `/data`. El servidor conserva su estado en JSON bajo `/data/godot/app_userdata/Galactum/galactum_server_save.json`. No hay un servicio SQL separado en este despliegue. La evidencia demuestra restauración en un ciclo de detención/inicio de los mismos contenedores; no demuestra recuperación después de eliminar el volumen.

## Componentes documentados

| Componente | Imagen | Función |
|---|---|---|
| server | galactum-server:0.12 | Simulación y WebSocket, Godot headless |
| web | galactum-web:0.12 | Distribución web con Nginx |

Los archivos técnicos que implementan este despliegue son `compose.yaml`, `docker/Dockerfile`, `docker/nginx.conf` y `docker/healthcheck.py`. Desde el 10/11/2026 están versionados en el repositorio técnico (carpeta `mvp-v0.12/`, commit `aa375ad`); antes solo existían en la copia local usada el 3/11. Consultar el Word de dockerización para las capturas de la ejecución del 3/11.
