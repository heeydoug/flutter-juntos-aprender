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

  void update(StudentModel updatedStudent, int index) {
    DocumentSnapshot documentSnapshot = document_students![index];
    documentSnapshot.reference.update(updatedStudent.toMap());
  }

  Future<List<StudentModel>> getStudentsByIdClass(String idClass) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _collection_student.where('id_class', isEqualTo: idClass).get();

    List<StudentModel> studentsList = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> document) {
      Map<String, dynamic> data = document.data()!;
      return StudentModel.fromMap(data);
    }).toList();

    return studentsList;
  }
}
