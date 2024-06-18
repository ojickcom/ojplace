class BlogModel {
  final String blogTitle;
  final String clientGroup;
  String? blogContent;
  String? blogStatus;
  final String id;

  BlogModel({
    required this.blogTitle,
    required this.clientGroup,
    this.blogContent,
    this.blogStatus,
    required this.id,
  });
  factory BlogModel.fromJson(Map<String, dynamic> map, {required String id}) {
    return BlogModel(
      blogTitle: map['blogTitle'] as String,
      clientGroup: map['clientGroup'] as String,
      blogContent: map['blogContent'] as String?,
      blogStatus: map['blogStatus'] as String?,
      id: id,
    );
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        "blogTitle": blogTitle,
        "clientGroup": clientGroup,
        "blogContent": blogContent,
        "blogStatus": blogStatus,
      };
}
