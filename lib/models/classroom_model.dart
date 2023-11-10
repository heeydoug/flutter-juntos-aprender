class ClassroomModel {
  String id;
  String nomeSala;
  String data;
  String? urlImg;

  ClassroomModel(
      {required this.id, required this.nomeSala, required this.data});

  ClassroomModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nomeSala = map["nomeSala"],
        data = map["data"],
        urlImg = map["urlImg"];

  Map<String, dynamic> toMap() {
    return {"id": id, "nomeSala": nomeSala, "data": data, "urlImg": urlImg};
  }
}
