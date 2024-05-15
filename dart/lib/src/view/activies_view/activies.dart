import 'package:flutter/material.dart';

import 'components/cards_activies.dart';
import 'components/tab_bar/tab_days.dart';

class Activies extends StatelessWidget {
  const Activies({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TabDays(),
      ),
      body: Expanded(
        child: CardsActivies(),
      ),
    );
  }
}
