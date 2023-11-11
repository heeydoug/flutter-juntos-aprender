class ClassroomModel {
  String? id;
  String nomeSala;
  late DateTime data;
  String? urlImg;

  ClassroomModel(
      {this.id = null,
      required this.nomeSala,
      required this.data,
      this.urlImg = null});

  ClassroomModel.fromMap(Map<String, dynamic> map)
      : nomeSala = map["nomeSala"],
        data = map["data"],
        urlImg = map["urlImg"];

  Map<String, dynamic> toMap() {
    return {"nomeSala": nomeSala, "data": data, "urlImg": urlImg};
  }
}
