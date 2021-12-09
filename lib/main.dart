import 'package:calculator/widget/navigation_drawer_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Database/database_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double firstNum = 0;
  double secondNum = 0;
  String value = '';
  String history = '';
  String textToDisplay = '';
  String result = '';
  String operation = '';

  List<String> historyList = [];
  List<String> newHList = [];

  String newHistory = '';

  buttonPressed(String buttonText) async {
    print(buttonText);
    history = '';
    if (buttonText == "CLEAR") {
      textToDisplay = '';
      firstNum = 0;
      secondNum = 0;
      result = '';
      history = '';
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      firstNum = double.parse(textToDisplay);
      result = '';
      operation = buttonText;
    } else if (buttonText == "=") {
      secondNum = double.parse(textToDisplay);

      if (operation == '+') {
        result = (firstNum + secondNum).toString();
      }
      if (operation == '-') {
        result = (firstNum - secondNum).toString();
      }
      if (operation == '*') {
        result = (firstNum * secondNum).toString();
      }
      if (operation == '/') {
        result = (firstNum / secondNum).toString();
      }
    } else if (buttonText == "^2") {
      firstNum = double.parse(textToDisplay);
      operation = buttonText;
      result = (firstNum * firstNum).toString();
    } else {
      result = (textToDisplay + buttonText).toString();
    }

    setState(() {
      textToDisplay = result;
    });

    if (buttonText == "=") {
      history = firstNum.toString() +
          " " +
          operation.toString() +
          " " +
          secondNum.toString() +
          " = $result";
      historyList.add(history);
      await DatabaseManager().createHistoryData(history);
    }
    if (buttonText == "^2") {
      history = firstNum.toString() +
          " (" +
          operation.toString() +
          ") " +
          " = $result";
      historyList.add(history);
      await DatabaseManager().createHistoryData(history);
    }

    //historyList.remove('');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('history', historyList);
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      // ignore: deprecated_member_use
      child: OutlineButton(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(
                      vertical: 36.0, horizontal: 12.0),
                  child: Text(
                    textToDisplay,
                    style: const TextStyle(
                        fontSize: 48.0, fontWeight: FontWeight.bold),
                  )),
              const Expanded(child: Divider()),
              Column(
                children: [
                  Row(
                    children: [
                      buildButton("7"),
                      buildButton("8"),
                      buildButton("9"),
                      buildButton("/"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("4"),
                      buildButton("5"),
                      buildButton("6"),
                      buildButton("*"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("1"),
                      buildButton("2"),
                      buildButton("3"),
                      buildButton("-"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("."),
                      buildButton("0"),
                      buildButton("^2"),
                      buildButton("+"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("CLEAR"),
                      buildButton("="),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
