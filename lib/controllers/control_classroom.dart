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

  Future<List<ClassroomModel>> getAllClassroom() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _collection_classroom.get();

    List<ClassroomModel> classrooms = querySnapshot.docs
        .map((e) => ClassroomModel.fromMap(e.data()))
        .toList();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var classroom = classrooms[i];
      var docSnapshot = querySnapshot.docs[i];

      // Associar o ID ao objeto ClassroomModel
      classroom.id = docSnapshot.reference.id;

      // print('ID: ${classroom.id}');
      // print('Nome da Sala: ${classroom.nomeSala}');
      // print('Tipo de Ensino: ${classroom.tipoEnsino}');
      // print('Quantidade de Alunos: ${classroom.quantidadeAlunos}');
      // print('Data: ${classroom.data}');
      // print('URL da Imagem: ${classroom.urlImg ?? 'N/A'}');
      // print('---');
    }

    return classrooms;
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

  void update(ClassroomModel updatedClassroom, int index) {
    DocumentSnapshot documentSnapshot = document_classrooms![index];
    documentSnapshot.reference.update(updatedClassroom.toMap());
  }

  Future<int?> getIndexClassroom(String? classroomId) async {
    print(classroomId);
    if (classroomId == null) {
      return null;
    }

    List<ClassroomModel> list = await getAllClassroom();

    for (int i = 0; i < list.length; i++) {
      if (list[i].id == classroomId) {
        return i;
      }
    }

    return null;
  }
}
