import 'package:flutter/material.dart';

class ButtomAppBar extends StatelessWidget {
  const ButtomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Container(
                height: 40,
                width: 45,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(48, 109, 195, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.calendar_month),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 58),
              child: Text(
                'Exibindo todas atividades',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
