class StudentModel {
  String id;
  String nome;
  String data;
  String? urlImg;

  StudentModel({required this.id, required this.nome, required this.data});

  StudentModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome = map["nome"],
        data = map["data"],
        urlImg = map["urlImg"];

  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome, "data": data, "urlImg": urlImg};
  }
}
