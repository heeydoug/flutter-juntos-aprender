import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_juntos_aprender/models/student.model.dart';

class ControllStudent {
  CollectionReference<Map<String, dynamic>> get _collection_student =>
      FirebaseFirestore.instance.collection('student');
  Stream<QuerySnapshot> get stream => _collection_student.snapshots();

  void _insert_students(StudentModel studentModel) {
    DocumentReference docref = _collection_student.doc();
    docref.set(studentModel.toMap());
  }

  void insert(StudentModel studentModel) {
    _insert_students(studentModel);
  }
}
