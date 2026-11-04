# Registro de revisión documental — Arquitectura

Fecha: 4 de noviembre de 2026. Alcance: documentación nueva de arquitectura y enlaces actualizados. No es un registro de pruebas del juego.

| Comprobación | Resultado |
| --- | --- |
| Fuentes y alcance | Texto de Word y capturas revisados; lógica v0.12 cotejada en lectura; archivos Docker exactos pendientes |
| Vista Lógica | Ocho nodos y nueve relaciones, mismas cantidades en JSON, diagrams.net y SVG |
| Componentes | Doce elementos y catorce relaciones, mismas cantidades en las fuentes/exportaciones |
| Semántica | Cada flecha L1–L9 y C1–C14 tiene explicación; dependencias del consumidor al proveedor |
| Representaciones | SVG y PNG revisados visualmente; títulos, elementos, rutas e IDs corresponden al modelo |
| PNG | Exportaciones 2x: 3200×2000 y 3600×2200 |
| Word | Microsoft Word 16.0 abrió el archivo: doce páginas, dos figuras, tablas completas y numeración |
| Revisión visual Word | Doce páginas renderizadas mediante Pages.EnhMetaFileBits; revisión conjunta y detallada de figuras/tablas; capturas de contacto adjuntas |
| Estilo | Fondo blanco, texto negro, títulos negros en negrita, Arial y tablas simples; propiedad Bold del cuerpo comprobada en 0 |
| Imágenes en Word | Los dos PNG del paquete corresponden byte a byte a las exportaciones publicadas |
| OOXML | Diecisiete partes XML/relaciones analizadas; sin errores de sintaxis |
| Enlaces | Ochenta y siete rutas relativas de documentos nuevos y actualizados comprobadas; cero destinos ausentes |
| Confidencialidad | Sin código del juego, partidas, credenciales, configuración Docker ni material de otro proyecto en los archivos nuevos |
| Alcance Git | Cambios limitados al repositorio académico; nombre/correo confirmados; repositorio técnico conservado sin cambios |

La exportación PDF de Office no se utilizó como entregable; la comprobación visual final se hizo con el renderizado nativo de páginas de Word. Las vistas de contacto sirven como registro; las figuras completas están disponibles en Diagramas/ y en el consolidado.

- [Páginas 1–6](Revision/Word_Paginas_01_06.png).
- [Páginas 7–12](Revision/Word_Paginas_07_12.png).

## Qué demuestra y qué no

La revisión acredita coherencia documental, fuentes/exportaciones y legibilidad del consolidado. No certifica el juego, determinismo, idempotencia, rendimiento, seguridad de producción ni funcionamiento de Docker en una ejecución nueva. El stop/start documentado se mantiene como evidencia previa de los mismos contenedores.

## Pendientes para el equipo

Localizar el commit de la adaptación Docker/web y sus cuatro archivos; confirmar si el docente exige otra notación; revisar el contenido con Juan; ejecutar y documentar las pruebas pendientes del software cuando corresponda. La aprobación académica y el merge a main no se presuponen.
