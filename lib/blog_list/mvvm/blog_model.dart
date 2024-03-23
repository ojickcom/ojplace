class BlogModel {
  final String blogTitle;
  final String blogContent;
  final String blogGroup;
  int blogOrder;
  String blogId;
  final String id;
  String? blogType;

  BlogModel({
    required this.blogTitle,
    required this.blogContent,
    required this.blogGroup,
    this.blogOrder = 0,
    this.blogType,
    required this.id,
    required this.blogId,
  });

  BlogModel copyWith({
    String? blogTitle,
    String? blogContent,
    String? blogGroup,
    int? blogOrder,
    String? blogId,
    String? id,
    String? blogType,
  }) {
    return BlogModel(
      blogTitle: blogTitle ?? this.blogTitle,
      blogContent: blogContent ?? this.blogContent,
      blogGroup: blogGroup ?? this.blogGroup,
      blogOrder: blogOrder ?? this.blogOrder,
      blogId: blogId ?? this.blogId,
      id: id ?? this.id,
      blogType: blogType ?? this.blogType,
    );
  }

  factory BlogModel.fromJson(Map<String, dynamic> map, {required String id}) {
    return BlogModel(
      blogTitle: map['blogTitle'] as String,
      blogContent: map['blogContent'] as String,
      blogGroup: map['blogGroup'] as String,
      blogOrder: map['blogOrder'] as int,
      blogId: map['blogId'] as String,
      id: id,
      blogType: map['blogType'] as String?,
    );
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        "blogTitle": blogTitle,
        "blogContent": blogContent,
        "blogGroup": blogGroup,
        "blogOrder": blogOrder,
        "blogId": blogId,
        "blogType": blogType,
        // "id": id,
      };
}
