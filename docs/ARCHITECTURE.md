# Arquitectura de Galactum — Equipo 3

## Entrega vigente de Fase 2 — MVP v0.12

La entrega documental de Fase 2 representa el MVP v0.12 en Godot 4.6.2. Los apartados históricos siguientes describen la base M0–M2; sus mensajes de snapshot/secuencia no deben trasladarse automáticamente al protocolo `galactum-mvp-1`.

- [Vista Lógica y responsabilidades](../Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/Vista_Logica_Galactum.md).
- [Diagrama de Componentes e interfaces](../Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/Diagrama_Componentes_Galactum.md).
- [Word consolidado](../Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/Arquitectura_Galactum_Vista_Logica_y_Componentes.docx).
- [Diagnóstico, fuentes y límites](../Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/DIAGNOSTICO_Y_FUENTES.md).
- [Correspondencia con Docker](../Fase%202/Evidencias%20Proyecto%20%28version%20Agil%29/Arquitectura/CORRESPONDENCIA_DOCKER.md).

La Vista Lógica explica funciones; el Diagrama de Componentes identifica módulos y dependencias; Docker describe lugares de ejecución. Minería pertenece a flotas. Persistencia JSON pertenece al servidor. Catalog y los datos de balance se utilizan en los contextos que los necesitan. No se incorpora SQL ni un servicio por script.

La lógica v0.12 se cotejó en lectura con el repositorio técnico. La configuración Docker exacta aún debe localizarse; los servicios, imágenes, puertos, /ws y volumen se respaldan en las evidencias publicadas. La verificación previa acredita stop/start de los mismos contenedores y restauración informada en logs; no recreación ni borrado del volumen.

## Antecedentes M0–M2

## Componentes principales

### Cliente Godot
- Proyecto Godot para PC y Android.
- Representa el estado recibido desde el servidor.
- Implementa selección, cámara y navegación del usuario.

### SSS Headless
- Proyecto Godot ejecutado sin interfaz gráfica.
- Mantiene la autoridad del estado del mundo.
- Expone comunicación WebSocket JSON.

## Flujo de sincronización

```text
SSS
 │
 ├── full_snapshot ──────► Cliente
 │
 ├── map_delta ──────────► Cliente
 │                         │
 │                         ├── added
 │                         ├── updated
 │                         └── removed
 │
 ◄──── request_full_snapshot ─ Cliente
```

## Secuencias y recuperación
Si el cliente detecta un salto de secuencia:
1. Marca una condición de desincronización.
2. Solicita `request_full_snapshot`.
3. Reemplaza su baseline local.
4. Continúa desde un estado coherente.

## Parámetros documentados
- Puerto local: **9100**
- Mapa de pruebas: **600 × 600**
- Comunicación: **WebSocket JSON**
- Servidor: **autoritativo**
