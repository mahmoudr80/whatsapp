import 'package:whatsapp/core/services/firebase_constants.dart';

class UserModel {
  final String name;
  final String image;
  final String email;
  final String? uid;

  const UserModel({
    required this.name,
    required this.image,
    required this.email,
     this.uid,
  });

  UserModel copyWith({
    String?name,
    String?image,
    String?email,
    String? uid,
})=>UserModel(name: name??this.name, image: image??this.image,
      email: email??this.email);

  factory UserModel.fromJson(Map<String, dynamic> ?json) => UserModel(
        name: json?['name'] ?? '',
        image: json?['image'] ?? '',
        email: json?['email'] ?? '',
      );
  factory UserModel.fromFirestore(Map<String, dynamic> ?json) => UserModel(
    name: json?[FirebaseConstants.nameKey] ?? '',
    image: json?[FirebaseConstants.imagePathKey] ?? '',
    email: json?[FirebaseConstants.emailKey]??'',
    uid: json?['uid']??'',
  );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'email': email,
      };
}
