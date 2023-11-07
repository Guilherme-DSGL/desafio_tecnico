import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String userName;
  User({
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
