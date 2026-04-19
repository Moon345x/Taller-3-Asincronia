import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taller_asincronia/logic/isolate/isolate_controller.dart';

class IsolateDemoView extends StatefulWidget {
  const IsolateDemoView({super.key});

  static const routeName = '/isolate';

  @override
  State<IsolateDemoView> createState() => _IsolateDemoViewState();
}

class _IsolateDemoViewState extends State<IsolateDemoView> {
  final IsolateController _controller = IsolateController();

  IsolateDemoState _state = IsolateDemoState.initial;
  Timer? _pulseTimer;
  int _pulseTicks = 0;
  int _tapCounter = 0;

  @override
  void initState() {
    super.initState();
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _pulseTicks++;
      });
    });
  }

  @override
  void dispose() {
    _pulseTimer?.cancel();
    _pulseTimer = null;
    super.dispose();
  }

  Future<void> _runHeavyTask() async {
    setState(() {
      _state = const IsolateDemoState(status: IsolateStatus.running);
    });

    final nextState = await _controller.runHeavyTask();
    if (!mounted) {
      return;
    }

    setState(() {
      _state = nextState;
    });
  }

  void _reset() {
    _controller.reset();
    setState(() {
      _state = IsolateDemoState.initial;
      _tapCounter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = _state.status == IsolateStatus.running;

    return Scaffold(
      appBar: AppBar(title: const Text('Isolate y Segundo Plano')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _ResultPanel(state: _state),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: isRunning ? null : _runHeavyTask,
                  child: const Text('Ejecutar tarea pesada'),
                ),
                TextButton(
                  onPressed: isRunning ? null : _reset,
                  child: const Text('Reiniciar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prueba de UI responsiva',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pulso UI: $_pulseTicks (debe seguir cambiando durante el calculo)',
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _tapCounter++;
                        });
                      },
                      icon: const Icon(Icons.touch_app),
                      label: Text('Toques en UI: $_tapCounter'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({required this.state});

  final IsolateDemoState state;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case IsolateStatus.idle:
        return const _StatusLine(
          icon: Icons.hourglass_empty,
          title: 'Listo',
          subtitle: 'Inicia la tarea pesada para ejecutarla en un isolate.',
        );
      case IsolateStatus.running:
        return const Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2.8),
            ),
            SizedBox(width: 12),
            Expanded(child: Text('Procesando en segundo plano (CPU-bound)...')),
          ],
        );
      case IsolateStatus.success:
        return _StatusLine(
          icon: Icons.check_circle_outline,
          title: 'Completado',
          subtitle:
              'Resultado: ${state.result} | Duracion isolate: ${state.durationMs} ms',
          color: Colors.green,
        );
      case IsolateStatus.error:
        return _StatusLine(
          icon: Icons.error_outline,
          title: 'Error',
          subtitle: state.errorMessage ?? 'Error desconocido',
          color: Colors.red,
        );
    }
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        Icon(icon, color: activeColor, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(subtitle),
            ],
          ),
        ),
      ],
    );
  }
}
