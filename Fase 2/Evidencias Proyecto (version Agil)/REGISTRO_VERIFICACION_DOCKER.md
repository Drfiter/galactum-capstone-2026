# Registro de verificación de Docker — Galactum

Fecha de la comprobación: 3 de noviembre de 2026, horario de Chile. Entorno local: Windows, Docker Desktop y Chrome. Versión del MVP: 0.12.

| Paso | Acción | Resultado observado | Evidencia en el Word |
|---|---|---|---|
| 1 | Observar el grupo galactum | server-1 y web-1 en ejecución, imágenes 0.12 | Figura 1 |
| 2 | Detener únicamente el grupo galactum | Ambos servicios detenidos, sin eliminación | Figura 2 |
| 3 | Observar el cliente abierto | Mensaje de imposibilidad de conexión | Figura 3 |
| 4 | Recargar localhost:8080 | Chrome muestra ERR_CONNECTION_REFUSED | Figura 4 |
| 5 | Iniciar el mismo grupo | Ambos contenedores vuelven a ejecutarse | Figura 5 |
| 6 | Consultar logs del servidor | Estado restaurado y WebSocket en 9100 | Figura 6 |
| 7 | Consultar volúmenes | galactum_galactum-data en uso | Figura 7 |
| 8 | Recargar e ingresar con evidencia | Astronave e interfaz disponibles | Figura 8 |

Fuente de las figuras: [Evidencia_Dockerizacion_Galactum.docx](Evidencia_Dockerizacion_Galactum.docx).

## Identificación de la ejecución

- Servidor: identificador abreviado `40930d4bf774`.
- Servicio web: identificador abreviado `37cd2158655d`.
- Los identificadores se conservaron al detener e iniciar; no se recrearon los contenedores.
- Al finalizar, ambos servicios quedaron activos y se pudo acceder al juego.

## Extracto observado en logs

```text
Estado restaurado desde user://galactum_server_save.json
SSS_READY protocol=galactum-mvp-1 systems=16 entities=3208 players=77
SSS WebSocket escuchando en el puerto 9100
```

Los conteos describen el estado de esa ejecución; `players=77` no acredita 77 conexiones simultáneas.

## Límites

No se ejecutaron en esta sesión los perfiles automatizados tests y smoke, pruebas de carga, eliminación/recreación de contenedores, borrado de volúmenes ni un despliegue en nube. El resultado verificado es la disponibilidad y restauración local durante stop/start.
