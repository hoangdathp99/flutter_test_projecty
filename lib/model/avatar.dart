import 'dart:convert';

class Avatar {
  final String location;
  final String originalname;
  final String filename;
  Avatar(
      {this.filename = "", this.location = "", this.originalname = ""});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filename': filename,
      'location': location,
      'originalname': originalname
    };
  }

  factory Avatar.fromMap(Map<String, dynamic> map) {
    return Avatar(
      filename: map['filename'] as String,
      location: map['location'] as String,
      originalname: map['originalname'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  factory Avatar.fromJson(Map<String, dynamic> source) =>
      Avatar.fromMap(source);
}