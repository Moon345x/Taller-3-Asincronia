import 'package:taller_asincronia/services/isolate/heavy_task_service.dart';

enum IsolateStatus { idle, running, success, error }

class IsolateDemoState {
  const IsolateDemoState({
    required this.status,
    this.result,
    this.durationMs,
    this.errorMessage,
  });

  final IsolateStatus status;
  final int? result;
  final int? durationMs;
  final String? errorMessage;

  static const initial = IsolateDemoState(status: IsolateStatus.idle);
}

class IsolateController {
  IsolateController({HeavyTaskService? service})
    : _service = service ?? HeavyTaskService();

  final HeavyTaskService _service;

  IsolateDemoState _state = IsolateDemoState.initial;
  IsolateDemoState get state => _state;

  Future<IsolateDemoState> runHeavyTask({int iterations = 25000000}) async {
    _state = const IsolateDemoState(status: IsolateStatus.running);
    print('[IsolateController] A) Estado -> Running');

    try {
      final result = await _service.runHeavyTask(iterations: iterations);
      _state = IsolateDemoState(
        status: IsolateStatus.success,
        result: result.value,
        durationMs: result.durationMs,
      );
      print('[IsolateController] B) Estado -> Success');
    } catch (error) {
      _state = IsolateDemoState(
        status: IsolateStatus.error,
        errorMessage: error.toString(),
      );
      print('[IsolateController] B) Estado -> Error');
    }

    return _state;
  }

  void reset() {
    _state = IsolateDemoState.initial;
    print('[IsolateController] Reset a estado inicial');
  }
}
