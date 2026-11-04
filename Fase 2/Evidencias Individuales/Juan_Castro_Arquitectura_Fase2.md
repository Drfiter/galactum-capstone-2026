# Juan Castro — Evidencia individual de arquitectura, Fase 2

Fecha: 4 de noviembre de 2026. Proyecto Galactum, Equipo 3, Ingeniería en Informática, Duoc UC. Trabajo documental realizado con asistencia de Codex. Identidad Git autorizada por Juan: JuanCastroC., cuenta juanCastro7, correo jua.castroc@duocuc.cl.

## Objetivo y alcance del aporte

Revisar la arquitectura existente y completar la Vista Lógica y el Diagrama de Componentes del MVP v0.12 para la entrega académica. Incluye fuentes editables, exportaciones, explicaciones, Word consolidado, enlaces y registro de revisión. No se atribuyen a Juan programación del juego, dockerización, pruebas históricas ni documentos anteriores.

## Fuentes revisadas

README, docs/ARCHITECTURE, PROJECT_STATUS, TESTING y EVIDENCE_MAP; definición y evidencias grupales de Fase 1; Documento 05; guías 2.4/2.6 y sus traducciones; tres Word de documentación, sistema/datos y Docker con sus capturas; índice, operación y registro Docker. Se consultó el diario existente de Juan para conservar la organización por integrante, sin reemplazarlo.

La lectura técnica autorizada comprobó el subárbol mvp-v0.12 del objeto 735902689558c59f5ff05ce80e6e14d83909c0e6: arranque, fachada cliente, enlace WebSocket, gateway, servidor, mundo, índice, flotas, resolver y Catalog. No se modificó ese repositorio. El [diagnóstico](../Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/DIAGNOSTICO_Y_FUENTES.md) desarrolla las fuentes S1–S9 y sus límites.

## Vacíos detectados y decisiones

- La arquitectura anterior tenía texto y ASCII, pero faltaban los dos diagramas formales. Se crearon sin duplicar una vista ya completa.
- Los documentos generales seguían en M2 mientras las evidencias recientes describen v0.12. Se preservó lo histórico y se identificó el corte vigente de Fase 2.
- Minería se mantuvo dentro de flotas; persistencia dentro del servidor. Se separaron réplica y enlace WebSocket usando los módulos reales.
- Se distinguieron datos de balance y estado persistido. No se agregó SQL, microservicios ni componentes hipotéticos.
- Docker se explicó aparte, identificando navegador, Nginx, Godot headless y volumen. No se ejecutó de nuevo la dockerización.
- No se encontraron los archivos de la adaptación Docker/web en el árbol accesible. Se dejó el cotejo directo pendiente y se identificó el respaldo documental disponible.

## Archivos entregados

En [Arquitectura](../Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/):

- [Vista Lógica](../Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/Vista_Logica_Galactum.md): ocho responsabilidades y nueve relaciones explicadas.
- [Componentes](../Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/Diagrama_Componentes_Galactum.md): doce elementos dibujados, incluidos el artefacto y el apoyo integrado, y catorce dependencias.
- Diagramas/: modelos JSON, fuentes diagrams.net y SVG/PNG, con generador reproducible.
- [Word consolidado](../Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/Arquitectura_Galactum_Vista_Logica_y_Componentes.docx) y Generar_Word.ps1.
- Diagnóstico, correspondencia Docker, guía de exposición y [registro de revisión](../Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/REGISTRO_REVISION.md).

También se actualizaron README, arquitectura, estado, pruebas, mapa de evidencias, Documento 05, índice de Fase 2 y README grupal para enlazar la entrega y evitar contradicciones.

## Comprobaciones realizadas

Revisión de fuentes y capturas; contraste de responsabilidades con el código autorizado; revisión visual de SVG/PNG y de las doce páginas renderizadas por Microsoft Word; comprobación de enlaces, XML, cantidad de relaciones y coincidencia de imágenes incorporadas. No se ejecutaron juego, suites, smoke, harness, carga ni Android. El ensayo Docker anterior no se presenta como propio.

## Commits de esta tarea

| Commit | Aporte |
| --- | --- |
| 6fca48b | Diagnóstico y fuentes |
| 638f21b | Vista Lógica editable y exportaciones |
| a83bcbc | Componentes y dependencias verificadas |
| 7256454 | Correspondencia Docker y preparación de revisión |
| 7cf4ead | Consolidado Word revisado visualmente |
| 2bdc28f | Enlaces y separación entre antecedentes y MVP |
| Commit que incorpora este archivo | Evidencia individual y registro final de revisión; mensaje docs(evidencia): registrar aporte de Juan y comprobaciones finales |

El hash del último registro puede consultarse en el historial de este archivo; no se escribe un hash autorreferencial. Los commits se conservan en la rama docs/juan-arquitectura-fase2. La publicación de la rama no implica aprobación ni integración en main.

## Revisión personal pendiente

Juan debe revisar las figuras, explicar L1–L9 y C1–C14 y comprobar su comprensión con el equipo. La [guía de exposición](../Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/REVISION_Y_EXPOSICION.md) facilita esa revisión. Este registro no afirma que ya haya realizado la exposición o aprobado el contenido.
