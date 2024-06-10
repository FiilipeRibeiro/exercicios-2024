import 'package:chuva_dart/src/shared/controller/save_controller.dart';
import 'package:chuva_dart/src/shared/data/db.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  test('Teste de abrir banco de dados existente', () async {
    // Obtém a instância do banco de dados
    final Database db = await getDatabase();

    // Consulta todos os registros na tabela
    final List<Map<String, dynamic>> results = await db.query(SaveController.tablename);

    // Imprime os resultados
    print('Registros encontrados:');
    for (var row in results) {
      print('Row: $row');
    }

    // Verifica se há registros
    if (results.isEmpty) {
      print('Nenhum registro encontrado.');
    } else {
      print('Registros encontrados:');
      for (var row in results) {
        print('Row: $row');
      }
    }
  });
}
