import 'package:cloud_firestore/cloud_firestore.dart';

class ClassroomModel {
  String? id;
  String nomeSala;
  String tipoEnsino;
  int quantidadeAlunos;
  late DateTime data;
  String? urlImg;

  ClassroomModel(
      {this.id = null,
      required this.nomeSala,
      required this.tipoEnsino,
      required this.quantidadeAlunos,
      required this.data,
      this.urlImg = null});

  ClassroomModel.fromMap(Map<String, dynamic> map)
      : nomeSala = map["nomeSala"],
        tipoEnsino = map["tipoEnsino"],
        quantidadeAlunos = map["quantidadeAlunos"],
        data = (map["data"] as Timestamp).toDate(),
        urlImg = map["urlImg"];

  Map<String, dynamic> toMap() {
    return {
      "nomeSala": nomeSala,
      "tipoEnsino": tipoEnsino,
      "quantidadeAlunos": quantidadeAlunos,
      "data": data,
      "urlImg": urlImg
    };
  }
}
