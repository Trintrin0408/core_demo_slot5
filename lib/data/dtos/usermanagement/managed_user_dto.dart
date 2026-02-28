class ManagedUserDto {
  final int id;
  final String fullName;
  final String dob;
  final String address;
  final String createdAt;

  ManagedUserDto({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.address,
    required this.createdAt,
  });


  factory ManagedUserDto.fromMap(Map<String, dynamic> map) {
    return ManagedUserDto(
      id: map['id'] as int,
      fullName: (map['full_name'] ?? '').toString(),
      dob: (map['dob'] ?? '').toString(),
      address: (map['address'] ?? '').toString(),
      createdAt: (map['created_at'] ?? '').toString(),
    );}
  Map<String, dynamic> toMap() =>{
    'id': id,
    'full_name': fullName,
    'dob': dob,
    'address': address,
    'created_at': createdAt,
  };
}
