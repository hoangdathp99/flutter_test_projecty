class Category {
  final int? id;
  final String? name;
  final String? image;

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
