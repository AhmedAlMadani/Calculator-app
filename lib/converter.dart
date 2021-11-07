import 'package:calculator/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// class ConverterScreen extends StatelessWidget {
//   const ConverterScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: NavigationDrawerWidget(),
//       appBar: AppBar(
//         title: const Text("Unit Converter"),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey,
//       ),
//     );
//   }
// }

class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override
  void initState() {
    userInput = 0;
    super.initState();
  }

  final List<String> measures = ['Meters', 'Kilometers'];

  final Map<String, int> measuresMap = {'Meters': 0, 'Kilometers': 1};

  dynamic formulas = {
    '0': [1, 0.001],
    '1': [1000, 1]
  };

  void convert(double value, String from, String to) {
    int nFrom = measuresMap[from] as int;
    int nTo = measuresMap[to] as int;
    var multi = formulas[nFrom.toString()][nTo];
    var result = value * multi;

    if (result == 0) {
      resultMessage = 'Can not perform this conversion';
    } else {
      resultMessage =
          '${userInput.toString()} $_startMeasures are ${result.toString()} $_convertMeasures';
    }
    setState(() {
      resultMessage = resultMessage;
    });
  }

  double? userInput;
  String? _startMeasures;
  String? _convertMeasures;
  String? resultMessage;

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Unit Converter"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: TextField(
                  onChanged: (text) {
                    var input = double.tryParse(
                        text); //change string to double#############################################################################################
                    if (input != null) {
                      setState(() {
                        userInput = input;
                      });
                    }
                  },
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey,
                      hintText: 'Enter Your Value',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'From',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: DropdownButton(
                  value: _startMeasures,
                  isExpanded: true,
                  dropdownColor: Colors.blueGrey,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                  borderRadius: BorderRadius.circular(20),
                  hint: Text(
                    'Choose a unit',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  items: measures.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startMeasures = value as String?;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'To',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: DropdownButton(
                  value: _convertMeasures,
                  isExpanded: true,
                  dropdownColor: Colors.blueGrey,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                  borderRadius: BorderRadius.circular(20),
                  hint: Text(
                    'Choose a unit',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  items: measures.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _convertMeasures = value as String?;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                onPressed: () {
                  if (userInput == 0 ||
                      _startMeasures!.isEmpty ||
                      _convertMeasures!.isEmpty)
                    return;
                  else
                    convert(userInput!, _startMeasures!, _convertMeasures!);
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    child: Text(
                      'Convert',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                (resultMessage.toString() == null)
                    ? ''
                    : resultMessage.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
