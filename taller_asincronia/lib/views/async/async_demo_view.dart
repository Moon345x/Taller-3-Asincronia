import 'package:flutter/material.dart';

class AsyncDemoView extends StatelessWidget {
  const AsyncDemoView({super.key});

  static const routeName = '/async';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Servicio Asincrono')),
      body: const Center(
        child: Text('Pantalla base lista. Implementacion en siguiente commit.'),
      ),
    );
  }
}
