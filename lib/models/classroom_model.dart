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

  // Map<String, dynamic> toMap() {
  //   return {
  //     "nomeSala": nomeSala,
  //     "tipoEnsino": tipoEnsino,
  //     "quantidadeAlunos": quantidadeAlunos,
  //     "data": data,
  //     "urlImg": urlImg
  //   };
  // }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nomeSala'] = this.nomeSala;
    data['tipoEnsino'] = this.tipoEnsino;
    data['quantidadeAlunos'] = this.quantidadeAlunos;
    data['data'] = this.data;
    data['urlImg'] = this.urlImg;
    if (this.id != null) {
      data['id'] = this.id;
    }
    return data;
  }
}
