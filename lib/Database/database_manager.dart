import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference calculationList =
      FirebaseFirestore.instance.collection("calculationInfo");

  Future<void> createHistoryData(String history) async {
    return await calculationList.doc().set({'history': history});
  }

  getData() {
    List<String> historyList = ["Test String"];
    calculationList.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        historyList.add(doc["history"]);
      });
    });
    return historyList;
  }
}
