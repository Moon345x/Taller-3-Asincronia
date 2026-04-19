import 'package:flutter/material.dart';

class TimerDemoView extends StatelessWidget {
  const TimerDemoView({super.key});

  static const routeName = '/timer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cronometro con Timer')),
      body: const Center(
        child: Text('Pantalla base lista. Implementacion en siguiente commit.'),
      ),
    );
  }
}
