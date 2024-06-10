import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chuva_dart/src/routes/routes.dart';
import 'package:chuva_dart/src/shared/controller/save_controller.dart';

class ChuvaDart extends StatelessWidget {
  const ChuvaDart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SaveController(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        routerDelegate: routes.routerDelegate,
        routeInformationParser: routes.routeInformationParser,
        routeInformationProvider: routes.routeInformationProvider,
      ),
    );
  }
}
