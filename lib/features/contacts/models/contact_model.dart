class ContactModel {
  final int? id;
  final String name;
  final String phone;
  final String? email;
  final String? company;
  final String? address;
  final String? notes;
  final String? image;
  final bool isFavorite;
  final String createdAt;

  const ContactModel({
    this.id,
    required this.name,
    required this.phone,
    this.email,
    this.company,
    this.address,
    this.notes,
    this.image,
    this.isFavorite = false,
    required this.createdAt,
  });

  ContactModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? company,
    String? address,
    String? notes,
    String? image,
    bool? isFavorite,
    String? createdAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      company: company ?? this.company,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'],
      company: map['company'],
      address: map['address'],
      notes: map['notes'],
      image: map['image'],
      isFavorite: map['isFavorite'] == 1,
      createdAt: map['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'company': company,
      'address': address,
      'notes': notes,
      'image': image,
      'isFavorite': isFavorite ? 1 : 0,
      'createdAt': createdAt,
    };
  }
}
