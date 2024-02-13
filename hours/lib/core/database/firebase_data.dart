import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hours/core/share/custom_snackbar.dart';

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
}

firebsaeSignIn(String email, String password) async {
  try {
    var respons = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return respons;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      errorSnackBar("Make sure the email is correct");
    } else if (e.code == 'wrong-password') {
      errorSnackBar("Make sure the password is correct");
    } else {
      errorSnackBar("Make sure the password and Email is correct");
    }
  }
}
