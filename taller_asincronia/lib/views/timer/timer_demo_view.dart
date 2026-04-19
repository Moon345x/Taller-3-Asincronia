import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taller_asincronia/logic/timer/stopwatch_controller.dart';

class TimerDemoView extends StatefulWidget {
  const TimerDemoView({super.key});

  static const routeName = '/timer';

  @override
  State<TimerDemoView> createState() => _TimerDemoViewState();
}

class _TimerDemoViewState extends State<TimerDemoView> {
  final StopwatchController _controller = StopwatchController();
  Timer? _uiRefreshTimer;

  StopwatchState get _state => _controller.state;

  @override
  void initState() {
    super.initState();
    _uiRefreshTimer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _uiRefreshTimer?.cancel();
    _uiRefreshTimer = null;
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    _controller.start();
    setState(() {});
  }

  void _pause() {
    _controller.pause();
    setState(() {});
  }

  void _resume() {
    _controller.resume();
    setState(() {});
  }

  void _reset() {
    _controller.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final canStart = _state.status == StopwatchStatus.idle;
    final canPause = _state.status == StopwatchStatus.running;
    final canResume = _state.status == StopwatchStatus.paused;
    final canReset =
        _state.elapsedSeconds > 0 ||
        _state.status == StopwatchStatus.paused ||
        _state.status == StopwatchStatus.running;

    return Scaffold(
      appBar: AppBar(title: const Text('Cronometro con Timer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Text(
                      _state.formattedTime,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(_statusLabel(_state.status)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: canStart ? _start : null,
                  child: const Text('Iniciar'),
                ),
                FilledButton.tonal(
                  onPressed: canPause ? _pause : null,
                  child: const Text('Pausar'),
                ),
                OutlinedButton(
                  onPressed: canResume ? _resume : null,
                  child: const Text('Reanudar'),
                ),
                TextButton(
                  onPressed: canReset ? _reset : null,
                  child: const Text('Reiniciar'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'La vista cancela sus timers en dispose para evitar fugas de memoria.',
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(StopwatchStatus status) {
    switch (status) {
      case StopwatchStatus.idle:
        return 'Estado: Listo';
      case StopwatchStatus.running:
        return 'Estado: En ejecucion';
      case StopwatchStatus.paused:
        return 'Estado: Pausado';
    }
  }
}
