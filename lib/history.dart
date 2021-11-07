import 'package:calculator/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
