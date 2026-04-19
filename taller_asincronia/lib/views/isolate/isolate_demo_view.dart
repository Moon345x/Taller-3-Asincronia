import 'package:flutter/material.dart';

class IsolateDemoView extends StatelessWidget {
  const IsolateDemoView({super.key});

  static const routeName = '/isolate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate y Segundo Plano')),
      body: const Center(
        child: Text('Pantalla base lista. Implementacion en siguiente commit.'),
      ),
    );
  }
}
