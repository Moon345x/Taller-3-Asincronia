import 'package:flutter/material.dart';
import 'package:taller_asincronia/views/async/async_demo_view.dart';
import 'package:taller_asincronia/views/isolate/isolate_demo_view.dart';
import 'package:taller_asincronia/views/timer/timer_demo_view.dart';

class TallerHomeView extends StatelessWidget {
  const TallerHomeView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taller 3: Asincronia y Segundo Plano')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flujo recomendado',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1) Servicio Asincrono  2) Cronometro  3) Isolate',
                  ),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, AsyncDemoView.routeName),
                    icon: const Icon(Icons.play_circle_outline),
                    label: const Text('Iniciar recorrido'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          _ModuleTile(
            order: '01',
            title: 'Servicio Asincrono',
            subtitle: 'Future, async/await y estados',
            routeName: AsyncDemoView.routeName,
            icon: Icons.cloud_download_outlined,
          ),
          _ModuleTile(
            order: '02',
            title: 'Cronometro',
            subtitle: 'Timer con iniciar, pausar, reanudar y reiniciar',
            routeName: TimerDemoView.routeName,
            icon: Icons.timer_outlined,
          ),
          _ModuleTile(
            order: '03',
            title: 'Segundo Plano (Isolate)',
            subtitle: 'Procesamiento pesado sin bloquear la UI',
            routeName: IsolateDemoView.routeName,
            icon: Icons.memory_outlined,
          ),
        ],
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.order,
    required this.title,
    required this.subtitle,
    required this.routeName,
    required this.icon,
  });

  final String order;
  final String title;
  final String subtitle;
  final String routeName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(order)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(icon),
        onTap: () => Navigator.pushNamed(context, routeName),
      ),
    );
  }
}
