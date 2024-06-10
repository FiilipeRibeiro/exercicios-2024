import 'dart:convert';

import 'package:dio/dio.dart';

class DioClient {
  final dio = Dio();

  Future get(String url) async {
    final response = await dio.get(url);
    final decodedData = jsonDecode(response.data);
    return decodedData;
  }
}
