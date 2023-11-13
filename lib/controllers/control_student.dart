import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_juntos_aprender/models/student.model.dart';

class ControllStudent {
  List<StudentModel>? students;
  List<DocumentSnapshot>? document_students;
  CollectionReference<Map<String, dynamic>> get _collection_student =>
      FirebaseFirestore.instance.collection('student');
  Stream<QuerySnapshot> get stream => _collection_student.snapshots();

  void getStudents(QuerySnapshot data) {
    document_students = data.docs;
    students = document_students!.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      return StudentModel.fromMap(data);
    }).toList();
  }

  void _insert_students(StudentModel studentModel) {
    DocumentReference docref = _collection_student.doc();
    docref.set(studentModel.toMap());
  }

  void insert(StudentModel studentModel) {
    _insert_students(studentModel);
  }

  void deleteStudent(int index) {
    DocumentSnapshot documentSnapshot = document_students![index];
    documentSnapshot.reference.delete();
  }

  void update(StudentModel updatedStudent) {
    DocumentReference docRef = _collection_student.doc(updatedStudent.id);
    docRef.update(updatedStudent.toMap());
  }
}
