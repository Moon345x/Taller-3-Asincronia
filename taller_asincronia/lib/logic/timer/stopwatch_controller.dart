import 'dart:async';

enum StopwatchStatus { idle, running, paused }

class StopwatchState {
  const StopwatchState({required this.status, required this.elapsedSeconds});

  final StopwatchStatus status;
  final int elapsedSeconds;

  static const initial = StopwatchState(
    status: StopwatchStatus.idle,
    elapsedSeconds: 0,
  );

  String get formattedTime {
    final minutes = elapsedSeconds ~/ 60;
    final seconds = elapsedSeconds % 60;
    final mm = minutes.toString().padLeft(2, '0');
    final ss = seconds.toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  StopwatchState copyWith({StopwatchStatus? status, int? elapsedSeconds}) {
    return StopwatchState(
      status: status ?? this.status,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    );
  }
}

class StopwatchController {
  StopwatchState _state = StopwatchState.initial;
  StopwatchState get state => _state;

  Timer? _timer;

  bool get isRunning => _state.status == StopwatchStatus.running;
  bool get isPaused => _state.status == StopwatchStatus.paused;

  void start() {
    if (isRunning) {
      return;
    }

    _state = _state.copyWith(status: StopwatchStatus.running);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _state = _state.copyWith(elapsedSeconds: _state.elapsedSeconds + 1);
    });
  }

  void pause() {
    if (!isRunning) {
      return;
    }

    _timer?.cancel();
    _timer = null;
    _state = _state.copyWith(status: StopwatchStatus.paused);
  }

  void resume() {
    if (!isPaused) {
      return;
    }

    _state = _state.copyWith(status: StopwatchStatus.running);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _state = _state.copyWith(elapsedSeconds: _state.elapsedSeconds + 1);
    });
  }

  void reset() {
    _timer?.cancel();
    _timer = null;
    _state = StopwatchState.initial;
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
