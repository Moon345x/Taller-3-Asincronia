import 'dart:async';
import 'dart:isolate';

class HeavyTaskResult {
  const HeavyTaskResult({required this.value, required this.durationMs});

  final int value;
  final int durationMs;
}

class HeavyTaskService {
  Future<HeavyTaskResult> runHeavyTask({int iterations = 25000000}) async {
    final receivePort = ReceivePort();
    final errorPort = ReceivePort();

    Isolate? isolate;

    try {
      isolate = await Isolate.spawn<_HeavyTaskConfig>(
        _heavyTaskIsolateEntry,
        _HeavyTaskConfig(
          responsePort: receivePort.sendPort,
          iterations: iterations,
        ),
        onError: errorPort.sendPort,
      );

      final resultFuture = receivePort.first;
      final errorFuture = errorPort.first;

      final firstEvent = await Future.any([resultFuture, errorFuture]);

      if (firstEvent is List && firstEvent.isNotEmpty) {
        throw Exception('Error en isolate: ${firstEvent.first}');
      }

      if (firstEvent is! Map<String, Object>) {
        throw Exception('Respuesta invalida del isolate');
      }

      final type = firstEvent['type'];
      if (type != 'result') {
        throw Exception('Mensaje inesperado del isolate: $type');
      }

      final value = firstEvent['value'];
      final durationMs = firstEvent['durationMs'];

      if (value is! int || durationMs is! int) {
        throw Exception('Payload de resultado invalido');
      }

      return HeavyTaskResult(value: value, durationMs: durationMs);
    } finally {
      isolate?.kill(priority: Isolate.immediate);
      receivePort.close();
      errorPort.close();
    }
  }
}

class _HeavyTaskConfig {
  const _HeavyTaskConfig({
    required this.responsePort,
    required this.iterations,
  });

  final SendPort responsePort;
  final int iterations;
}

void _heavyTaskIsolateEntry(_HeavyTaskConfig config) {
  final stopwatch = Stopwatch()..start();

  try {
    final computedValue = _performCpuBoundWork(config.iterations);
    stopwatch.stop();

    config.responsePort.send({
      'type': 'result',
      'value': computedValue,
      'durationMs': stopwatch.elapsedMilliseconds,
    });
  } catch (error) {
    config.responsePort.send({'type': 'error', 'message': error.toString()});
  }
}

int _performCpuBoundWork(int iterations) {
  var accumulator = 0;
  for (var i = 1; i <= iterations; i++) {
    accumulator = (accumulator + ((i * i) % 97)) % 1000000007;
  }
  return accumulator;
}
