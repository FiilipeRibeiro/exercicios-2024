import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget {
  final Widget? buttonAppBar;
  final String? subtitle;

  const HeaderAppBar({super.key, this.buttonAppBar, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(1),
      backgroundColor: const Color.fromRGBO(69, 97, 137, 1),
      centerTitle: true,
      toolbarHeight: 100,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Chuva 💜 Flutter',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                if (subtitle != null)
                  TextSpan(
                    text: subtitle,
                    style: const TextStyle(color: Colors.white),
                  ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottom: buttonAppBar != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: buttonAppBar!,
            )
          : null,
    );
  }
}
