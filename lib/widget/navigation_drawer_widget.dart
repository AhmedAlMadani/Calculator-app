//import 'package:flutter/cupertino.dart';

import 'package:calculator/converter.dart';
import 'package:calculator/history.dart';
import 'package:calculator/main.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20, vertical: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blueGrey,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 48),
            buildMenuItem(
              text: 'Calculator',
              icon: Icons.calculate,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 00),
            buildMenuItem(
              text: 'Converter',
              icon: Icons.autorenew_rounded,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 24,
              width: 20,
            ),
            const Divider(color: Colors.white70),
            const SizedBox(height: 24, width: 20),
            buildMenuItem(
              text: 'History',
              icon: Icons.history_edu,
              onClicked: () => selectedItem(context, 2),
            ),
          ],
        ),
      ),
    );
  }

  buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MyApp(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Converter(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HistoryScreen(),
        ));
    }
  }
}
