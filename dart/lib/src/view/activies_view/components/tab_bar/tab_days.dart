import 'package:chuva_dart/src/view/activies_view/components/cards_activies.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabDays extends StatefulWidget {
  const TabDays({super.key});

  @override
  State<TabDays> createState() => _TabDaysState();
}

class _TabDaysState extends State<TabDays> {
  final DateTime _currentDate = DateTime(2023, 11, 26);

  @override
  Widget build(BuildContext context) {
    String formattedMonth = DateFormat('MMM').format(_currentDate);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Row(
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
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 55,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
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
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            CardsActivies(),
            CardsActivies(),
            CardsActivies(),
            CardsActivies(),
            CardsActivies(),
          ],
        ),
      ),
    );
  }
}
