import 'dart:math';

class AsyncDataService {
  AsyncDataService({Random? random}) : _random = random ?? Random();

  final Random _random;

  Future<String> fetchData({bool forceError = false}) async {
    final delaySeconds = 2 + _random.nextInt(2);

    print('[AsyncDataService] 1) Inicio de fetchData()');
    print('[AsyncDataService] 2) Simulando latencia de ${delaySeconds}s');

    await Future<void>.delayed(Duration(seconds: delaySeconds));

    if (forceError) {
      print('[AsyncDataService] 3) Error simulado luego de la espera');
      throw Exception('Error de red simulado');
    }

    final response =
        'Datos cargados correctamente en ${delaySeconds}s (simulado)';
    print('[AsyncDataService] 3) Respuesta lista: $response');
    return response;
  }
}
