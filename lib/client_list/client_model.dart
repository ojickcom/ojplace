class ClientModel {
  String id;
  final String clientsName;
  String? memo;
  String? grade;
  int? basePrice;
  int? pushPrice;
  int? placePrice;
  int amountPrice;
  int amountKeyword;
  int? amountNurakKeyword;
  Map<String, int> keywords; // 키워드와 가격을 매핑하는 맵 추가
  DateTime? paymentDate; // 결재일 필드 추가

  ClientModel({
    required this.clientsName,
    this.memo = "",
    this.id = "",
    this.grade = "A",
    this.basePrice = 30,
    this.pushPrice = 30,
    this.placePrice = 400000,
    this.amountPrice = 0,
    this.amountKeyword = 0,
    this.amountNurakKeyword = 0,
    this.keywords = const {}, // 초기화
    this.paymentDate, // 초기화
  });

  Map<String, dynamic> toJson() {
    return {
      'clientsName': clientsName,
      'id': id,
      'memo': memo,
      'grade': grade,
      'basePrice': basePrice,
      'pushPrice': pushPrice,
      'placePrice': placePrice,
      'amountPrice': amountPrice,
      'amountKeyword': amountKeyword,
      'amountNurakKeyword': amountNurakKeyword,
      'keywords': keywords, // 맵을 JSON으로 변환
      'paymentDate': paymentDate?.toIso8601String(), // 결재일을 ISO 8601 문자열로 변환
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> json, String id) {
    return ClientModel(
      clientsName: json['clientsName'] ?? "준비중입니다.",
      id: id,
      memo: json['memo'] ?? "",
      grade: json['grade'] ?? "A",
      basePrice: json['basePrice'] ?? 30,
      pushPrice: json['pushPrice'] ?? 30,
      placePrice: json['placePrice'] ?? 400000,
      amountPrice: json['amountPrice'] ?? 0,
      amountKeyword: json['amountKeyword'] ?? 0,
      amountNurakKeyword: json['amountNurakKeyword'] ?? 0,
      keywords: Map<String, int>.from(json['keywords'] ?? {}), // 맵을 생성
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'])
          : null, // 결재일을 DateTime으로 변환
    );
  }
}
