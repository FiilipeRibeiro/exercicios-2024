import 'package:chuva_dart/src/shared/controller/save_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../shared/model/chuva_model.dart';
import '../widgets/header_app_bar.dart';
import 'package:provider/provider.dart';

class CardView extends StatefulWidget {
  final ChuvaModel chuva;
  final List<ChuvaModel> chuvaList;

  const CardView({
    super.key,
    required this.chuva,
    required this.chuvaList,
  });

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
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

  String extractTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return DateFormat('HH:mm').format(dateTime);
  }

  String getDayOfWeek(String dateTime) {
    initializeDateFormatting('pt_BR', null);
    DateTime date = DateTime.parse(dateTime);
    String dayOfWeek = DateFormat('EEEE', 'pt_BR').format(date);
    return dayOfWeek[0].toUpperCase() + dayOfWeek.substring(1);
  }

  String extractParagraphContent(String description) {
    StringBuffer buffer = StringBuffer();
    RegExp exp = RegExp(r'<p>(.*?)<\/p>');
    Iterable<Match> matches = exp.allMatches(description);
    for (Match match in matches) {
      String content = match.group(1) ?? "";
      buffer.write(content);
      buffer.write('\n\n');
    }
    return buffer.toString();
  }

  late SaveController saves;

  @override
  Widget build(BuildContext context) {
    final location =
        widget.chuva.location.map((location) => location.title).join();
    final role =
        widget.chuva.people.isNotEmpty ? widget.chuva.people.first.role : '';

    saves = context.watch<SaveController>();

    Future<void> handleSave() async {
      await saves.save(widget.chuva);
      saves.printAllData();
    }

    Future<void> handleDelete() async {
      await saves.deleteOne(widget.chuva);
      saves.printAllData();
    }

    var isSaved = widget.chuva.isSaved;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: HeaderAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8),
              alignment: Alignment.centerLeft,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(hexColorToInt(widget.chuva.color)),
              ),
              child: Text(
                widget.chuva.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      widget.chuva.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Color.fromRGBO(48, 109, 195, 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              '${getDayOfWeek(widget.chuva.start)} ${extractTime(widget.chuva.start)}h - ${extractTime(widget.chuva.end)}h',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color.fromRGBO(48, 109, 195, 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            location,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ElevatedButton(
                onPressed: () async {
                  if (isSaved) {
                    await handleDelete();
                  } else {
                    await handleSave();
                  }
                  setState(() {
                    isSaved = !isSaved;
                    if (isSaved == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vamos te lembrar dessa atividade.'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Não vamos mais te lembrar dessa atividade'),
                        ),
                      );
                    }
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color.fromRGBO(48, 109, 195, 1),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        isSaved == false ? Icons.star : Icons.star_border,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      isSaved == false
                          ? 'Adicionar à sua agenda'
                          : 'Remover da sua agenda',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 45, 16, 45),
              child: Text(
                extractParagraphContent(widget.chuva.description),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...widget.chuva.people.map(
                    (people) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            onTap: () {
                              List<ChuvaModel> relatedActivities = widget
                                  .chuvaList
                                  .where((chuva) => chuva.people.any(
                                      (person) => person.name == people.name))
                                  .toList();
                              context.push(
                                '/people',
                                extra: {
                                  'people': people,
                                  'relatedActivities': relatedActivities,
                                },
                              );
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: people.picture != null &&
                                      people.picture!.isNotEmpty
                                  ? Image.network(
                                      people.picture!,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          width: 60,
                                          decoration: const BoxDecoration(
                                              color: Colors.grey),
                                          child: const Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      width: 60,
                                      decoration: const BoxDecoration(
                                          color: Colors.grey),
                                      child: const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            title: Text(people.name ?? ''),
                            subtitle: Text(people.institution ?? ''),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
