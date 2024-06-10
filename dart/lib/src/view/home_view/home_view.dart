import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/model/chuva_model.dart';
import '../../shared/repository/chuva_service.dart';
import 'components/activies.dart';
import 'components/buttom_app_bar.dart';
import '../widgets/header_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DateTime _currentDate = DateTime(2023, 11, 26);

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat('MMM').format(_currentDate);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: HeaderAppBar(
          subtitle: '\nProgramação',
          buttonAppBar: ButtomAppBar(),
        ),
      ),
      body: FutureBuilder<List<ChuvaModel>>(
        future: ChuvaService().getChuva(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ChuvaModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<ChuvaModel> chuvaList = snapshot.data!;
            return DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6),
                        child: Column(
                          children: [
                            Text(
                              formattedMonth,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              '${_currentDate.year}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Container(
                            height: 55,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(48, 109, 195, 1),
                            ),
                            child: TabBar(
                              tabAlignment: TabAlignment.start,
                              indicator: const BoxDecoration(),
                              isScrollable: true,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                for (var day = 26; day <= 30; day++)
                                  Tab(
                                    text: day.toString(),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Activities(
                          chuvaList: chuvaList
                              .where((chuva) =>
                                  DateTime.parse(chuva.start).day == 26)
                              .toList(),
                        ),
                        Activities(
                          chuvaList: chuvaList
                              .where((chuva) =>
                                  DateTime.parse(chuva.start).day == 27)
                              .toList(),
                        ),
                        Activities(
                          chuvaList: chuvaList
                              .where((chuva) =>
                                  DateTime.parse(chuva.start).day == 28)
                              .toList(),
                        ),
                        Activities(
                          chuvaList: chuvaList
                              .where((chuva) =>
                                  DateTime.parse(chuva.start).day == 29)
                              .toList(),
                        ),
                        Activities(
                          chuvaList: chuvaList
                              .where((chuva) =>
                                  DateTime.parse(chuva.start).day == 30)
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
