import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String? username;
  final String? email;
  final String phoneNumber;
  final String? photo;

  UserModel({
    required this.uid,
    this.username,
    this.email,
    this.phoneNumber = '',
    this.photo,
  });

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? phoneNumber,
    String? photo,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username ?? '',
        'email': email ?? '',
        'phoneNumber': phoneNumber,
        'photoUrl': photo ?? '',
      };

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      username: data['username'],
      email: data['email'],
      phoneNumber: data['phoneNumber'] ?? '',
      photo: data['photoUrl'],
    );
  }
}
