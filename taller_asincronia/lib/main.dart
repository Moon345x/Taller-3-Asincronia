import 'package:flutter/material.dart';
import 'package:taller_asincronia/views/async/async_demo_view.dart';
import 'package:taller_asincronia/views/home/taller_home_view.dart';
import 'package:taller_asincronia/views/isolate/isolate_demo_view.dart';
import 'package:taller_asincronia/views/timer/timer_demo_view.dart';

void main() {
  runApp(const TallerAsincroniaApp());
}

class TallerAsincroniaApp extends StatelessWidget {
  const TallerAsincroniaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller 3 Asincronia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      initialRoute: TallerHomeView.routeName,
      routes: {
        TallerHomeView.routeName: (_) => const TallerHomeView(),
        AsyncDemoView.routeName: (_) => const AsyncDemoView(),
        TimerDemoView.routeName: (_) => const TimerDemoView(),
        IsolateDemoView.routeName: (_) => const IsolateDemoView(),
      },
    );
  }
}
