# Taller 3: Asincronía, Segundo Plano y Servicios

Aplicación Flutter desarrollada para demostrar tres conceptos clave de programación concurrente en Dart:

1. Asincronía con Future y async/await.
2. Control temporal con Timer.
3. Procesamiento CPU-bound en segundo plano con Isolates.

## Objetivo general

Construir una aplicación modular y limpia que evidencie buenas prácticas de separación por capas y el uso correcto de recursos asíncronos sin bloquear la interfaz de usuario.

## Requisitos del taller y evidencia

1. Servicio asíncrono
- Simulación de carga de datos con retardo de 2 a 3 segundos.
- Estados manejados: Cargando, Éxito, Error.
- Logs de consola para mostrar el orden de ejecución.
- Archivos principales:
	- lib/services/async/async_data_service.dart
	- lib/logic/async/async_demo_controller.dart
	- lib/views/async/async_demo_view.dart

2. Cronómetro con Timer
- Controles implementados: Iniciar, Pausar, Reanudar, Reiniciar.
- Manejo de estado del cronómetro (idle, running, paused).
- Limpieza de recursos con cancelación de Timer en dispose para evitar fugas de memoria.
- Archivos principales:
	- lib/logic/timer/stopwatch_controller.dart
	- lib/views/timer/timer_demo_view.dart

3. Isolate para segundo plano
- Ejecución de tarea pesada en isolate separado para no bloquear la UI.
- Comunicación entre isolate y UI usando puertos (ReceivePort y SendPort).
- Manejo de resultado, duración y errores.
- Archivos principales:
	- lib/services/isolate/heavy_task_service.dart
	- lib/logic/isolate/isolate_controller.dart
	- lib/views/isolate/isolate_demo_view.dart

## Arquitectura del proyecto

Se utiliza una estructura modular por responsabilidades dentro de lib:

- services: acceso a operaciones técnicas (latencia simulada, isolate, puertos).
- logic: controladores y estado de negocio de cada módulo.
- views: pantallas y componentes de presentación.

Estructura principal:

lib
- services
	- async
	- isolate
- logic
	- async
	- timer
	- isolate
- views
	- home
	- async
	- timer
	- isolate

## Flujo funcional de la app

Pantalla de inicio del taller con recorrido recomendado:

1. Servicio Asíncrono.
2. Cronómetro.
3. Isolate.

Cada módulo tiene su propia pantalla y mantiene su estado de forma independiente.

## Cómo ejecutar el proyecto

1. Instalar dependencias:

flutter pub get

2. Ejecutar en un dispositivo o emulador:

flutter run

## Cómo probar cada módulo

1. Servicio Asíncrono
- Presionar Cargar datos.
- Verificar estado Cargando y transición a Éxito.
- Presionar Simular error y verificar estado Error.
- Revisar logs en consola del servicio y controlador.

2. Cronómetro
- Presionar Iniciar y verificar incremento de tiempo.
- Probar Pausar y Reanudar.
- Probar Reiniciar y verificar retorno a 00:00.

3. Isolate
- Presionar Ejecutar tarea pesada.
- Confirmar que la UI sigue respondiendo durante el cálculo (pulso y toques).
- Verificar resultado final y duración reportada.

## Conceptos técnicos aplicados

- Future y async/await para orquestar operaciones no bloqueantes.
- Timer.periodic para control de tiempo y refresco de estado.
- Isolate.spawn para trabajo CPU-bound fuera del hilo principal.
- Comunicación entre isolates con puertos y protocolo de mensajes.
- Gestión de ciclo de vida en widgets para liberar recursos correctamente.

## Estado del desarrollo

Este repositorio fue construido con flujo GitFlow en la rama de trabajo:

feature/taller_segundo_plano

Integrando progresivamente los módulos hasta completar los requisitos del Taller 3.
