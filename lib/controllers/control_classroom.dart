import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_juntos_aprender/models/classroom_model.dart';

class ControlClassRoom {
  CollectionReference<Map<String, dynamic>> get _collection_classroom =>
      FirebaseFirestore.instance.collection('classroom');
  Stream<QuerySnapshot> get stream => _collection_classroom.snapshots();

  void _insert_classroom(ClassroomModel classroomModel) {
    DocumentReference docref = _collection_classroom.doc();
    docref.set(classroomModel.toMap());
  }

  void insert(ClassroomModel classroomModel) {
    _insert_classroom(classroomModel);
  }
}
