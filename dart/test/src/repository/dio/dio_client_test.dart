import 'package:chuva_dart/src/repository/dio/dio_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Teste de chamada do método get para múltiplas URLs', () async {
    final client = DioClient();
    final urls = [
      'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json',
      'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities-1.json',
    ];

    for (var url in urls) {
      final data = await client.get(url);
      print('Dados da URL $url: $data');
    }
  });
}
