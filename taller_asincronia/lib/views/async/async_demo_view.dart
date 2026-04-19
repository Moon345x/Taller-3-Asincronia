import 'package:flutter/material.dart';
import 'package:taller_asincronia/logic/async/async_demo_controller.dart';

class AsyncDemoView extends StatefulWidget {
  const AsyncDemoView({super.key});

  static const routeName = '/async';

  @override
  State<AsyncDemoView> createState() => _AsyncDemoViewState();
}

class _AsyncDemoViewState extends State<AsyncDemoView> {
  final AsyncDemoController _controller = AsyncDemoController();
  AsyncDemoState _state = AsyncDemoState.initial;

  Future<void> _loadData({bool forceError = false}) async {
    setState(() {
      _state = const AsyncDemoState(status: AsyncStatus.loading);
    });

    final nextState = await _controller.loadData(forceError: forceError);
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
      _state = AsyncDemoState.initial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Servicio Asincrono')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _StatusContent(state: _state),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: _state.status == AsyncStatus.loading
                      ? null
                      : () => _loadData(),
                  child: const Text('Cargar datos'),
                ),
                OutlinedButton(
                  onPressed: _state.status == AsyncStatus.loading
                      ? null
                      : () => _loadData(forceError: true),
                  child: const Text('Simular error'),
                ),
                TextButton(
                  onPressed: _state.status == AsyncStatus.loading
                      ? null
                      : _reset,
                  child: const Text('Reiniciar estado'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_state.status == AsyncStatus.error)
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.tonal(
                  onPressed: () => _loadData(),
                  child: const Text('Reintentar'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatusContent extends StatelessWidget {
  const _StatusContent({required this.state});

  final AsyncDemoState state;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case AsyncStatus.idle:
        return const _StatusMessage(
          title: 'Listo para iniciar',
          description: 'Presiona "Cargar datos" para ejecutar el Future.',
          icon: Icons.play_circle_outline,
        );
      case AsyncStatus.loading:
        return const Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2.8),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text('Cargando... esperando respuesta simulada (2-3s).'),
            ),
          ],
        );
      case AsyncStatus.success:
        return _StatusMessage(
          title: 'Exito',
          description: state.data ?? 'Sin datos',
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );
      case AsyncStatus.error:
        return _StatusMessage(
          title: 'Error',
          description: state.errorMessage ?? 'Error desconocido',
          icon: Icons.error_outline,
          color: Colors.red,
        );
    }
  }
}

class _StatusMessage extends StatelessWidget {
  const _StatusMessage({
    required this.title,
    required this.description,
    required this.icon,
    this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final foreground = color ?? Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        Icon(icon, color: foreground, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(description),
            ],
          ),
        ),
      ],
    );
  }
}
