import 'package:chuva_dart/src/view/cards_view/card_view.dart';
import 'package:chuva_dart/src/view/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shared/model/chuva_model.dart';
import '../view/people_view/people_view.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/cards',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final chuva = extra['chuva'] as ChuvaModel?;
        final chuvaList = extra['chuvaList'] as List<ChuvaModel>?;

        if (chuva != null && chuvaList != null) {
          return CardView(chuva: chuva, chuvaList: chuvaList);
        } else {
          return Container();
        }
      },
    ),
    GoRoute(
      path: '/people',
      builder: (context, state) {
        final Map<String, dynamic>? extra =
            state.extra as Map<String, dynamic>?;

        if (extra != null) {
          final people = extra['people'] as PeopleModel?;
          final relatedActivities =
              extra['relatedActivities'] as List<ChuvaModel>?;

          if (people != null && relatedActivities != null) {
            return PeopleView(
                people: people, relatedActivities: relatedActivities);
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    ),
  ],
);
