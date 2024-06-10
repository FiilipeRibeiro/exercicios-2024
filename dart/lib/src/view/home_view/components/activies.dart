import 'package:chuva_dart/src/shared/controller/save_controller.dart';
import 'package:chuva_dart/src/shared/model/chuva_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Activities extends StatefulWidget {
  final List<ChuvaModel> chuvaList;

  const Activities({super.key, required this.chuvaList});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  late SaveController saves;
  @override
  Widget build(BuildContext context) {
    saves = context.watch<SaveController>();
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

    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 5,
      ),
      itemCount: widget.chuvaList.length,
      itemBuilder: (_, int index) {
        final chuva = widget.chuvaList[index];

        final names = chuva.people.map((person) => person.name).join(', ');

        String extractTime(String dateTimeStr) {
          DateTime dateTime = DateTime.parse(dateTimeStr);
          return DateFormat('HH:mm').format(dateTime);
        }

        return Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
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
                      spreadRadius: 2,
                      blurRadius: 5,
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
                        color: Color(hexColorToInt(chuva.color)),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        onTap: () {
                          context.push(
                            '/cards',
                            extra: {
                              'chuva': chuva,
                              'chuvaList': widget.chuvaList,
                            },
                          );
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${chuva.type} de ${extractTime(chuva.start)} até ${extractTime(chuva.end)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  saves.isActivitySaved(chuva.title)
                                      ? Icons.star
                                      : null,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                chuva.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                names,
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
    );
  }
}
