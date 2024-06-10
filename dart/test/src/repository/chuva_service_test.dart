import 'package:chuva_dart/src/shared/repository/chuva_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Teste de chamada do método getChuva', () async {
    final service = ChuvaService();
    final chuvaList = await service.getChuva();

    print(chuvaList[2].people[0].name);
  });
}
