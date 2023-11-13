import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_juntos_aprender/models/classroom_model.dart';

class ControlClassRoom {
  List<ClassroomModel>? classrooms;
  List<DocumentSnapshot>? document_classrooms;

  CollectionReference<Map<String, dynamic>> get _collection_classroom =>
      FirebaseFirestore.instance.collection('classroom');
  Stream<QuerySnapshot> get stream => _collection_classroom.snapshots();

  void getClassrooms(QuerySnapshot data) {
    document_classrooms = data.docs;
    classrooms = document_classrooms!.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      return ClassroomModel.fromMap(data);
    }).toList();
  }

  void _insert_classroom(ClassroomModel classroomModel) {
    DocumentReference docref = _collection_classroom.doc();
    docref.set(classroomModel.toMap());
  }

  void insert(ClassroomModel classroomModel) {
    _insert_classroom(classroomModel);
  }

  void deleteClassroom(int index) {
    DocumentSnapshot documentSnapshot = document_classrooms![index];
    documentSnapshot.reference.delete();
  }

  void update(ClassroomModel updatedClassroom) {
    DocumentReference docRef = _collection_classroom.doc(updatedClassroom
        .id); // Assumindo que `id` é o identificador exclusivo da sala
    docRef.update(updatedClassroom.toMap());
  }
}
