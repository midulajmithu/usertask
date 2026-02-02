import 'package:flutter_application_1/features/Demo/domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final String lat;
  final String lng;
  final String companyName;
  final String catchPhrase;
  final String bs;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.lat,
    required this.lng,
    required this.companyName,
    required this.catchPhrase,
    required this.bs,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      website: map['website'] ?? '',
      street: map['address']['street'] ?? '',
      suite: map['address']['suite'] ?? '',
      city: map['address']['city'] ?? '',
      zipcode: map['address']['zipcode'] ?? '',
      lat: map['address']['geo']['lat'] ?? '',
      lng: map['address']['geo']['lng'] ?? '',
      companyName: map['company']['name'] ?? '',
      catchPhrase: map['company']['catchPhrase'] ?? '',
      bs: map['company']['bs'] ?? '',
    );
  }
  UserEntity toEntity() {
    return UserEntity(
      userId: id,
      name: name,
      username: username,
      email: email,
      phone: phone,
      website: website,
      street: street,
      suite: suite,
      city: city,
      zipcode: zipcode,
      lat: lat,
      lng: lng,
      companyName: companyName,
      companyCatchPhrase: catchPhrase,
      companyBs: bs,
    );
  }
}
