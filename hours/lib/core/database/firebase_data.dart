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

deleteRecord(String document, int id) async {
  final connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult != ConnectivityResult.none) {
    try {
      await FirebaseFirestore.instance
          .collection("branch1")
          .doc(document)
          .update({"$id": FieldValue.delete()});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  } else {
    return false;
  }
}

getRecord(String document) async {
  DocumentSnapshot<Map<String, dynamic>> res = await FirebaseFirestore.instance
      .collection("branch1")
      .doc(document)
      .get();
  List<Map> listData = [];
  res.data()!.forEach(
    (key, value) {
      listData.add(value);
    },
  );
  return listData;
}
