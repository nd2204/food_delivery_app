import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';
import 'dart:convert';

void main() async {
  print(File("firebase.json").openSync().toString());

  // FirebaseFirestore.instance.useFirestoreEmulator("localhost", )
}
