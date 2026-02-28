class ManagedUser{
  final int id;
  final String fullName;
  final String dob;
  final String address;
  final String createdAt;

  ManagedUser({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.address,
    required this.createdAt,
  });
  ManagedUser copyWith({
    int? id,
    String? fullName,
    String? dob,
    String? address,
    String? createdAt,
  }){
    return ManagedUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}