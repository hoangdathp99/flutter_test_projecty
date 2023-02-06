class PostModel {
  final String id;
  final String userId;
  final String title;
  final String body;

  PostModel({this.id = "", this.userId = "", this.title = "", this.body = ""});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      title: json['title'].toString(),
      body: json['body'].toString(),
    );
  }
  Map<String, dynamic> toJson() =>
      {'id': id, 'userId': userId, 'title': title, 'body': body};
}
