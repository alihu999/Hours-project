import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<int> uploadRecord(String document, Map record) async {
  Map<String, dynamic> convertedRecord = {};
  record.forEach((key, value) {
    if (key.toString() != "upload" &&
        key.toString() != "breakFat" &&
        key.toString() != "breakSat") {
      convertedRecord[key.toString()] = value;
    }
  });
  Map<String, Map> dataToUpload = {
    "${convertedRecord["_id"]}": convertedRecord
  };
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    try {
      await FirebaseFirestore.instance
          .collection("branch1")
          .doc(document)
          .set(dataToUpload, SetOptions(merge: true));
      return 1;
    } catch (e) {
      return 0;
    }
  } else {
    return 0;
  }
}

deletDocument(String document) async {
  final connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult != ConnectivityResult.none) {
    try {
      await FirebaseFirestore.instance
          .collection("branch1")
          .doc(document)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  } else {
    return false;
  }
}

getAllFirebaseData() async {
  QuerySnapshot<Map<String, dynamic>> allData;
  Map<String, List> dataFirebase = {};
  try {
    allData = await FirebaseFirestore.instance.collection("branch1").get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> element in allData.docs) {
      List<Map> dataDocument = [];
      element.data().forEach(
        (key, value) {
          dataDocument.add(value);
        },
      );
      dataFirebase[element.id] = dataDocument;
    }
    return dataFirebase;
  } catch (e) {
    return {"error": e};
  }
}

handeldata(QueryDocumentSnapshot<Map<String, dynamic>> document) {}
