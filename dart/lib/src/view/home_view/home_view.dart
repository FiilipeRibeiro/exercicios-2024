import 'package:flutter/material.dart';
import '../activies_view/activies.dart';
import 'components/buttom_app_bar.dart';
import '../widgets/header_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: HeaderAppBar(
          subtitle: '\nProgramação',
          buttonAppBar: ButtomAppBar(),
        ),
      ),
      body: Activies(),
    );
  }
}
