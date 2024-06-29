class UserModel {
  dynamic id;
  String email;
  String url;

  UserModel({this.id, required this.email, required this.url});

  factory UserModel.fromMap(Map<String, dynamic> map, {dynamic key}) {
    return UserModel(
      id: key ?? map['id'],
      email: map['email'],
      url: map["url"],
    );
  }

  Map<String, dynamic> toMap({dynamic key}) {
    return {
      'id': key ?? id,
      'email': email,
      "url": url,
    };
  }
}
