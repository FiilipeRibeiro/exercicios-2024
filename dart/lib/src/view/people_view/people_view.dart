import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/chuva_model.dart';
import '../widgets/header_app_bar.dart';

class PeopleView extends StatelessWidget {
  final PeopleModel people;
  final List<ChuvaModel> relatedActivities;

  const PeopleView({
    Key? key,
    required this.people,
    required this.relatedActivities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> uniqueDates = relatedActivities
        .map((activity) => DateFormat('E, dd/MM/yyyy', 'pt_BR')
            .format(DateTime.parse(activity.start)))
        .toSet()
        .toList();

    bool hasBio = people.bio != null && people.bio!.isNotEmpty;
    bool hasActivities = relatedActivities.isNotEmpty;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: HeaderAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: people.picture != null && people.picture!.isNotEmpty
                        ? Image.network(
                            people.picture!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 120,
                                height: 120,
                                decoration:
                                    const BoxDecoration(color: Colors.grey),
                                child: const Icon(
                                  Icons.person,
                                  size: 120,
                                  color: Colors.white,
                                ),
                              );
                            },
                          )
                        : Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(color: Colors.grey),
                            child: const Icon(
                              Icons.person,
                              size: 120,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            people.name ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            people.institution ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (hasBio)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Bio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (hasBio)
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  people.bio!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            if (hasActivities)
              const Padding(
                padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                child: Text(
                  'Atividades',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (hasActivities)
              ...uniqueDates
                  .map((date) => Padding(
                        padding: const EdgeInsets.only(left: 24, top: 5),
                        child: Text(
                          date,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  .toList(),
            if (hasActivities)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  key: key,
                  separatorBuilder: (context, index) => Container(
                    height: 8,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: relatedActivities.length,
                  itemBuilder: (context, index) {
                    final activity = relatedActivities[index];
                    final name =
                        activity.people.map((person) => person.name).join(', ');

                    String extractTime(String dateTimeStr) {
                      DateTime dateTime = DateTime.parse(dateTimeStr);
                      return DateFormat('HH:mm').format(dateTime);
                    }

                    int hexColorToInt(String? hexColor) {
                      if (hexColor == null || hexColor.isEmpty) {
                        return 0xFF000000;
                      }
                      hexColor = hexColor.toUpperCase().replaceAll('#', '');
                      if (hexColor.length == 6) {
                        hexColor = 'FF$hexColor';
                      }
                      return int.parse(hexColor, radix: 16);
                    }

                    return Padding(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 7,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Color(hexColorToInt(activity.color)),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${activity.type} de ${extractTime(activity.start)} até ${extractTime(activity.end)}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(
                                            activity.title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            name,
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
