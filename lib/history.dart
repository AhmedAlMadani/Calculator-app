import 'package:calculator/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> historyList = [];

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      historyList = prefs.getStringList('history')!.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    display() {
      return ListView.builder(
          // padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          itemCount: historyList.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Column(children: [
                  Text(
                    'Equation : ${historyList[index]}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  )
                ]));
          });
    }

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: display(),
          ),
        ],
      ),
    );
  }
}
