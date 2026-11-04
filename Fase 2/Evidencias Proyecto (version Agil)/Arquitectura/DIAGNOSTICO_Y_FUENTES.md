# Diagnóstico y fuentes de arquitectura — Fase 2

Revisión: 4 de noviembre de 2026. Aporte documental de Juan Castro con asistencia de Codex. Versión representada: MVP v0.12, Godot 4.6.2. Base académica: `8985041`.

## Situación anterior

`docs/ARCHITECTURE.md` contenía texto y un esquema ASCII de sincronización. El Documento 05 describía componentes y decisiones. Ninguno contenía una Vista Lógica completa ni un Diagrama de Componentes formal. README, PROJECT_STATUS y EVIDENCE_MAP presentaban M2 como estado activo y minería/combate como planificación; los Word recientes ya documentan v0.12. Se conserva el contenido histórico y se diferencia del corte de Fase 2.

Las guías 2.4 y 2.6, en español e inglés, fueron leídas. En su contenido no se encontró una exigencia explícita de notación para estos diagramas. Se elige una Vista Lógica conceptual y un Diagrama de Componentes UML simplificado, con dependencias dirigidas y agrupación por contexto. No se propone una nueva arquitectura del juego.

## Fuentes revisadas

| ID | Fuente | Respaldo |
| --- | --- | --- |
| S1 | [README](../../../README.md), [arquitectura](../../../docs/ARCHITECTURE.md), [estado](../../../docs/PROJECT_STATUS.md), [pruebas](../../../docs/TESTING.md), [evidencias](../../../docs/EVIDENCE_MAP.md) | Antecedentes y criterio de evidencia |
| S2 | [Definición Fase 1](../../../Fase%201/Evidencias%20Grupales/01_Definicion_Proyecto_APT_PUBLICA.md), [prototipo](../../../Fase%201/Evidencias%20Grupales/02_Prototipo_SSS_Arquitectura.md), [M0](../../../Fase%201/Evidencias%20Grupales/03_Avance_M0.md) | Alcance, planificación y base cliente–SSS |
| S3 | [Documento 05](../Documento%2005%20-%20Documento%20de%20Diseño.md) | Decisiones válidas conservadas |
| S4 | [Guía 2.4](../../Evidencias%20Grupales/2.4_GuiaEstudiante_Fase_2_DesarrolloProyecto_APT_Galactum.docx), [Guía 2.6](../../Evidencias%20Grupales/2.6_GuiaEstudiante_Fase_2_Informe_Final_Proyecto_APT_Galactum.docx), [2.4 inglés](../../Evidencias%20Grupales/2_4_Student_Guide_Phase_2_Project_Development_APT_Galactum.docx), [2.6 inglés](../../Evidencias%20Grupales/2_6_Student_Guide_Phase_2_Final_Report_APT_Galactum.docx) | Desarrollo, alcance y límites de Fase 2 |
| S5 | [Evidencias de documentación](../Evidencias_Documentacion_Galactum.docx), Parte 2 §§4–9 | Módulos, protocolo, datos y despliegue |
| S6 | [Sistema, aplicación y datos](../Evidencias_Sistema_Aplicacion_y_BaseDeDatos_Galactum.docx), partes A/B | Recorrido minero/PvE, catálogos y JSON |
| S7 | [Dockerización](../Evidencia_Dockerizacion_Galactum.docx), §§2–6, figuras 1–8 | Servicios, imágenes, puertos, volumen y stop/start |
| S8 | [Operación](../OPERACION_DOCKER.md) y [verificación Docker](../REGISTRO_VERIFICACION_DOCKER.md) | Restauración informada en logs y límites |
| S9 | Repositorio técnico autorizado, objeto `origin/main` = `735902689558c59f5ff05ce80e6e14d83909c0e6`, subárbol `mvp-v0.12` | Revisión directa en lectura de LEEME, arranque, cliente, enlace WebSocket, gateway, servidor, mundo, índice espacial, flotas, resolver y Catalog |

El acceso a S9 se realizó mediante lectura de objetos Git, sin cambiar rama, archivos, configuración ni referencias del juego. Se publican responsabilidades y rutas ya descritas en S5; no código fuente ni partidas.

## Capturas y documentos Word

Se leyó el texto OOXML y se inspeccionaron las imágenes incorporadas. S5/S6 muestran inicio, nave, mapa, asteroide, composición minera, marcha, preparación PvE e informe. S7 muestra contenedores activos/detenidos, pérdida de conexión, rechazo HTTP, inicio posterior, logs, volumen y reingreso. No se repitieron esas acciones durante esta tarea.

Los diarios individuales existentes fueron consultados para conservar la organización por integrante. No se modifican ni se les atribuye retrospectivamente el trabajo nuevo.

## Decisiones y correcciones

| Hallazgo | Decisión |
| --- | --- |
| Falta de diagramas formales | Incorporar fuentes diagrams.net editables y exportaciones SVG/PNG a partir del mismo modelo |
| Mezcla M2/MVP | Conservar antecedentes M0–M2 y documentar v0.12 como corte Fase 2 |
| Minería dentro de flotas | Representar extracción, cancelación y retorno como responsabilidad de `fleets.gd` |
| Réplica y transporte distintos | Separar `game_client.gd` y `client/links/ws_link.gd` |
| Persistencia dentro del servidor | Mostrar guardado como responsabilidad de `game_server.gd`, no como microservicio |
| Acceso compartido a balance | Mostrar `shared/catalog.gd` y JSON como datos/configuración, disponibles en cliente y servidor |
| MVP integra otros dominios | Indicar economía/informes como apoyo acotado; no atribuir su desarrollo a Juan |

## Configuración aún no disponible

No están en el árbol técnico accesible `compose.yaml`, `docker/Dockerfile`, `docker/nginx.conf` ni `docker/healthcheck.py`. El despliegue se respalda documentalmente mediante S5–S8; no se afirma haber abierto esos archivos. S9 respalda el servidor dedicado y su puerto 9100, pero no verifica por sí solo la adaptación web `/ws` de la instalación Docker.

En S9 se comprobó que el cliente dedicado base construye una dirección por host/puerto. Los documentos describen una adaptación web al mismo origen `/ws`; el equipo debe identificar el commit exacto de esa adaptación y de Docker. No se copia el comportamiento nativo para negar la evidencia web ni se afirma que ambos árboles sean idénticos.

## Nivel de evidencia

- Implementado y revisado: responsabilidades, dependencias y mensajes en S9.
- Observado previamente: recorrido minero/PvE y stop/start en S5–S8.
- Comprobado en esta tarea: documentación, diagramas, enlaces, exportaciones y estructura/renderizado del Word, según el registro final.
- No ejecutado aquí: juego, Docker, suites, smoke, harness, carga, Android o dos clientes.

El stop/start conserva los mismos contenedores. No prueba recreación, borrado del volumen, nube ni concurrencia; `players=77` en logs no significa 77 conexiones simultáneas. La arquitectura no constituye una certificación de esos atributos.
