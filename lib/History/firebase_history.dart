import 'package:flutter/material.dart';
import '../database/database_manager.dart';
import '../Components/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseData extends StatefulWidget {
  const FirebaseData({Key? key}) : super(key: key);

  @override
  _FirebaseDataState createState() => _FirebaseDataState();
}

class _FirebaseDataState extends State<FirebaseData> {
  @override
  void initState() {
    super.initState();
    getDataFirebase();
  }

  getDataFirebase() async {
    DatabaseManager dbManager = DatabaseManager();
    var history = await dbManager.getData();
    return history;
  }

  @override
  Widget build(BuildContext context) {
    display() {
      return FutureBuilder(
          future:
              FirebaseFirestore.instance.collection("calculationInfo").get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text('Loading....');
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                      // padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Column(children: [
                              Text(
                                'Equation : ${snapshot.data!.docs[index]["history"]}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              )
                            ]));
                      });
                }
            }
          });
    }

    return Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text("Firebase History"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: display());
  }
}
