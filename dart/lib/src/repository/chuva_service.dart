import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/chuva_model.dart';

class ChuvaService {
  final urls = [
    'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json',
    'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities-1.json',
  ];
  final Dio dio = Dio();

  Future<List<ChuvaModel>> getChuva() async {
    List<ChuvaModel> chuvaList = [];

    for (var url in urls) {
      final response = await dio.get(url);
      final Map<String, dynamic> jsonData = jsonDecode(response.data);
      final List<dynamic> body = jsonData['data'];

      List<ChuvaModel> iChuvaList = [];

      for (var map in body) {
        iChuvaList.add(
          ChuvaModel(
            start: map['start'] ?? '',
            end: map['end'] ?? '',
            title: map['title'] != null ? map['title']['pt-br'] ?? '' : '',
            description: map['description'] != null
                ? map['description']['pt-br'] ?? ''
                : '',
            category: map['category'] != null
                ? map['category']['title']['pt-br'] ?? ''
                : '',
            color:
                map['category'] != null ? map['category']['color'] ?? '' : '',
            location: map['locations'] != null
                ? (map['locations'] as List).map<LocationModel>((location) {
                    return LocationModel(
                      title: location['title']['pt-br'],
                    );
                  }).toList()
                : [],
            type:
                map['type'] != null ? map['type']['title']['pt-br'] ?? '' : '',
            people: map['people'] != null
                ? (map['people'] as List).map<PeopleModel>((people) {
                    return PeopleModel(
                      name: people['name'],
                      institution: people['institution'],
                      bio: people['bio']['pt-br'],
                      picture: people['picture'],
                      role: people['role']['label']['pt-br'],
                    );
                  }).toList()
                : [],
          ),
        );
      }

      chuvaList.addAll(iChuvaList);
    }

    return chuvaList;
  }
}
