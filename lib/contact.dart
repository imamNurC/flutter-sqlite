class Contact {
  int id;
  String name;
  String email;
  String phone;

  Contact({
      required this.id,
      required this.name,
      required this.email,
      required this.phone
  });

  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "email": email, "phone": phone};

  factory Contact.fromMap(Map<String, dynamic> map) => Contact(
        id: map["id"],
        name: map["name"],
        email: map['email'],
        phone: map["phone"],
      );

  // static fromMap(Map<String, Object?> e) {}
}
