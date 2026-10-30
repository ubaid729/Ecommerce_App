class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? phoneNumber;
  final String? profilePic;
  final String role; // 'customer' ya 'admin'
  final String? address;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.profilePic,
    this.role = 'customer',
    this.address,
    required this.createdAt,
  });

  // 1. Data badalne ke liye (Profile update / Address add karte waqt)
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? phoneNumber,
    String? profilePic,
    String? role,
    String? address,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePic: profilePic ?? this.profilePic,
      role: role ?? this.role,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // 2. App se Firestore mein data bhejne ke liye (Map format)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'role': role,
      'address': address,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  // 3. Firestore se data wapas Model mein convert karne ke liye
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'],
      profilePic: map['profilePic'],
      role: map['role'] ?? 'customer',
      address: map['address'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }
}