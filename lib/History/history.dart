import 'package:flutter/material.dart';
import '../Components/navigation.dart';
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
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: display(),
    );
  }
}
