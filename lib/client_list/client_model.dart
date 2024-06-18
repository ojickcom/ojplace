class ClientModel {
  final String clientsName;
  String? clientsMemo;
  String? id;

  ClientModel({
    required this.clientsName,
    this.clientsMemo,
    this.id,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json, String id) {
    return ClientModel(
      clientsName: json["clients_name"] ?? "",
      clientsMemo: json["clientsMemo"] ?? "",
      id: id,
    );
  }
}
