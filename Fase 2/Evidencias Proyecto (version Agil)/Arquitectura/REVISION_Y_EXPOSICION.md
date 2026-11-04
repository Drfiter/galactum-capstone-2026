# Revisión y exposición — Juan Castro

## Cómo regenerar

En Windows, con PowerShell y System.Drawing:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\Diagramas\Generar_Diagramas.ps1"
```

La política se aplica solo al proceso de ese comando. El generador transforma cada modelo JSON en drawio, SVG y PNG 2x. No accede al juego ni modifica su configuración. Para cambios reproducibles, editar el JSON y regenerar; diagrams.net permite también edición manual, pero esos cambios deben trasladarse al modelo antes de regenerar.

Las tres representaciones incluyen los mismos nodos, rutas de flechas, IDs, títulos y notas. Las fuentes diagrams.net permiten editar cajas, textos y trazados; los extremos se conservan como coordenadas explícitas. La tipografía puede variar ligeramente entre renderizadores. GitHub muestra SVG/PNG; no necesita ejecutar el generador.

## Guion para explicar los diagramas

1. La Vista Lógica responde qué responsabilidades existen. El Diagrama de Componentes identifica qué módulos las implementan. Docker responde dónde se ejecutan.
2. La UI usa una fachada no autoritativa. El enlace WebSocket transporta JSON; el gateway abre sesiones y entrega mensajes a GameServer.
3. GameServer dirige el tick y la réplica. Mundo mantiene entidades y usa el índice espacial para consultas AOI.
4. Flotas administra marchas, minería y retorno. No se inventó un componente minero independiente: así está organizado fleets.gd.
5. El resolver calcula el resultado. Flotas y los módulos de apoyo aplican consecuencias e informes; una respuesta visual no decide el resultado.
6. Persistencia está en GameServer. Los catálogos son definiciones, el guardado JSON es estado. Ninguno implica una base SQL.
7. Nginx sirve archivos y reenvía /ws; el navegador ejecuta el cliente. Godot headless ejecuta la autoridad.
8. Explicar una flecha por su ID y consultar la tabla correspondiente. Las dependencias discontinuas apuntan del consumidor al proveedor; una respuesta puede circular al revés. Un cruce sin nodo no crea una dependencia adicional.
9. Distinguir revisión de implementación, recorrido observado y prueba formal. El stop/start previo no es recreación ni recuperación tras borrar datos.

## Preguntas que debe resolver el equipo

- ¿Dónde están el commit y los archivos de la adaptación web/Docker documentada?
- ¿El docente exige una variante específica de UML u otro formato adicional?
- ¿Juan revisó ambos diagramas y puede explicar cada relación? Esta tarea entrega el material; la comprensión personal debe comprobarse con él.
- ¿Qué pruebas automatizadas y métricas se ejecutarán para los atributos pendientes? No se declaran aprobadas por existir sus escenas.

## Publicación

Los commits son documentación nueva realizada con asistencia de Codex y autoría Git confirmada por Juan. No acreditan que Juan programara los módulos ni ejecutara las pruebas históricas. Se trabaja en una rama académica; mantener los commits al integrar, sin squash si se requiere evidencia individual en el historial.
