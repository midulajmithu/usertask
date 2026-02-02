class UserEntity {
  final int userId;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  // Address
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  // Geo
  final String lat;
  final String lng;

  // Company
  final String companyName;
  final String companyCatchPhrase;
  final String companyBs;

  UserEntity({
    required this.userId,
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
    required this.companyCatchPhrase,
    required this.companyBs,
  });

  /// Convert to DB Map
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
      'lat': lat,
      'lng': lng,
      'company_name': companyName,
      'company_catch_phrase': companyCatchPhrase,
      'company_bs': companyBs,
    };
  }

  /// Create from DB Map
  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      userId: map['user_id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      website: map['website'],
      street: map['street'],
      suite: map['suite'],
      city: map['city'],
      zipcode: map['zipcode'],
      lat: map['lat'],
      lng: map['lng'],
      companyName: map['company_name'],
      companyCatchPhrase: map['company_catch_phrase'],
      companyBs: map['company_bs'],
    );
  }
}
