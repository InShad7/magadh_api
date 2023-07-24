class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final double latitude;
  final double longitude;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      latitude: json['location']['latitude'] ?? 0.0,
      longitude: json['location']['longitude'] ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, latitude: $latitude, longitude: $longitude}';
  }
}
