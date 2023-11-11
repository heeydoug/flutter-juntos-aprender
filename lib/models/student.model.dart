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
        data = map["data"],
        urlImg = map["urlImg"],
        id_class = map["id_class"];

  Map<String, dynamic> toMap() {
    return {"nome": nome, "data": data, "urlImg": urlImg, "id_class": id_class};
  }
}
