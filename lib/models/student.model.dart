import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  String? id;
  String nome;
  late DateTime data;
  String? urlImg;
  String? id_class;

  StudentModel(
      {this.id = null,
      required this.nome,
      required this.data,
      this.urlImg = null,
      this.id_class = null});

  StudentModel.fromMap(Map<String, dynamic> map)
      : nome = map["nome"],
        data = (map["data"] as Timestamp).toDate(),
        urlImg = map["urlImg"],
        id_class = map["id_class"];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nome'] = this.nome;
    data['urlImg'] = this.urlImg;
    data['data'] = this.data;
    data['id_class'] = this.id_class;
    if (this.id != null) {
      data['id'] = this.id;
    }
    return data;
  }
}
