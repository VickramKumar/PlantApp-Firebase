// ignore_for_file: non_constant_identifier_names

class UserModel {
  String? name;
  String? email;
  String? password;
  String? image;
  String? user_id;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.user_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'image': image,
      'user_id': user_id,
    };
  }

  UserModel.fromMap(map) {
    name = map['name'];
    email = map['email'];
    image = map['image'];
    password = map['password'];
    user_id = map['user_id'];
  }
}
