import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KeywordModel {
  final String blogTitle;
  final String blogGroup;
  final String id;
  String? blogType;
  String? keywordStatus;
  final Timestamp? timestamp;
  final List<KeywordHistory> history;
  final DateTime? startDate;
  int nurak;
  int price;

  KeywordModel({
    required this.blogTitle,
    required this.blogGroup,
    this.blogType,
    this.keywordStatus,
    required this.id,
    this.timestamp,
    this.history = const [],
    this.startDate,
    this.nurak = 0,
    this.price = 120000,
  });

  KeywordModel copyWith({
    String? blogTitle,
    String? blogGroup,
    String? blogType,
    String? keywordStatus,
    String? id,
    Timestamp? timestamp,
    DateTime? startDate,
    List<KeywordHistory>? history,
    int? nurak,
    int? price,
  }) {
    return KeywordModel(
      blogTitle: blogTitle ?? this.blogTitle,
      blogGroup: blogGroup ?? this.blogGroup,
      blogType: blogType ?? this.blogType,
      nurak: nurak ?? this.nurak,
      keywordStatus: keywordStatus ?? this.keywordStatus,
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      startDate: startDate ?? this.startDate,
      history: history ?? this.history,
    );
  }

  factory KeywordModel.fromJson(Map<String, dynamic> map,
      {required String id}) {
    final history = (map['history'] as List?)
            ?.map((h) => KeywordHistory.fromJson(h))
            .toList() ??
        [];
    final startDate = map['startDate'] != null && map['startDate'] != ''
        ? DateFormat('yyyy-MM-dd').parse(map['startDate'] as String)
        : null;
    return KeywordModel(
      blogTitle: map['blogTitle'] as String,
      blogGroup: map['blogGroup'] as String,
      blogType: map['blogType'] as String?,
      timestamp: map['timestamp'] as Timestamp?,
      startDate: startDate,
      id: id,
      history: history,
      nurak: map['nurak'] as int? ?? 0,
      price: map['price'] as int? ?? 120000,
    );
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        "blogTitle": blogTitle,
        "blogGroup": blogGroup,
        "blogType": blogType,
        "keywordStatus": keywordStatus,
        "startDate": startDate?.toString(),
        "timestamp": timestamp,
        "history": history.map((h) => h.toJson()).toList(),
        "nurak": nurak,
        "price": price,
      };
  String get formattedStartDate {
    return DateFormat('yyyy-MM-dd').format(startDate ?? DateTime.now());
  }
}

class KeywordHistory {
  final DateTime
      modifiedDateTime; // Combined input, completion, and modification
  final String? description; // Optional description of the change

  KeywordHistory({required this.modifiedDateTime, this.description});

  factory KeywordHistory.fromJson(Map<String, dynamic> map) {
    return KeywordHistory(
      modifiedDateTime: DateFormat('yyyy-MM-dd').parse(map['modifiedDateTime']),
      description: map['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "modifiedDateTime": DateFormat('yyyy-MM-dd').format(modifiedDateTime),
        "description": description,
      };
}
