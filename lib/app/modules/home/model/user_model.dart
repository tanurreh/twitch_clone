import 'dart:convert';

class UserModel {
  final String uid;
  final String username;
  final String email;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'uid': uid});
    result.addAll({'username': username});
    result.addAll({'email': email});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
