class ClientModel {
  final String clientsName;
  final String targetKeywords;
  String? id;

  ClientModel({
    required this.clientsName,
    required this.targetKeywords,
    this.id,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json, String id) {
    return ClientModel(
      clientsName: json["clients_name"] ?? "",
      targetKeywords: json["keyword"] ?? "",
      id: id,
    );
  }
}
