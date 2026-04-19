import 'package:flutter/material.dart';

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
          _ModuleTile(
            title: 'Servicio Asincrono',
            subtitle: 'Future, async/await y estados',
            routeName: '/async',
          ),
          _ModuleTile(
            title: 'Cronometro',
            subtitle: 'Timer con iniciar, pausar, reanudar y reiniciar',
            routeName: '/timer',
          ),
          _ModuleTile(
            title: 'Segundo Plano (Isolate)',
            subtitle: 'Procesamiento pesado sin bloquear la UI',
            routeName: '/isolate',
          ),
        ],
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.title,
    required this.subtitle,
    required this.routeName,
  });

  final String title;
  final String subtitle;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, routeName),
      ),
    );
  }
}
