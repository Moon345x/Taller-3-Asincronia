import 'package:taller_asincronia/services/async/async_data_service.dart';

enum AsyncStatus { idle, loading, success, error }

class AsyncDemoState {
  const AsyncDemoState({required this.status, this.data, this.errorMessage});

  final AsyncStatus status;
  final String? data;
  final String? errorMessage;

  static const initial = AsyncDemoState(status: AsyncStatus.idle);

  AsyncDemoState copyWith({
    AsyncStatus? status,
    String? data,
    String? errorMessage,
  }) {
    return AsyncDemoState(
      status: status ?? this.status,
      data: data,
      errorMessage: errorMessage,
    );
  }
}

class AsyncDemoController {
  AsyncDemoController({AsyncDataService? service})
    : _service = service ?? AsyncDataService();

  final AsyncDataService _service;

  AsyncDemoState _state = AsyncDemoState.initial;
  AsyncDemoState get state => _state;

  Future<AsyncDemoState> loadData({bool forceError = false}) async {
    _setState(const AsyncDemoState(status: AsyncStatus.loading));
    print('[AsyncDemoController] A) Estado -> Cargando');

    try {
      final result = await _service.fetchData(forceError: forceError);
      _setState(AsyncDemoState(status: AsyncStatus.success, data: result));
      print('[AsyncDemoController] B) Estado -> Exito');
    } catch (error) {
      _setState(
        AsyncDemoState(
          status: AsyncStatus.error,
          errorMessage: error.toString(),
        ),
      );
      print('[AsyncDemoController] B) Estado -> Error');
    }

    return _state;
  }

  void reset() {
    _setState(AsyncDemoState.initial);
    print('[AsyncDemoController] Reset a estado inicial');
  }

  void _setState(AsyncDemoState newState) {
    _state = newState;
  }
}
