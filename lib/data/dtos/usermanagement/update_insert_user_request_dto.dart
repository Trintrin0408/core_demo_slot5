class UpdateInsertUserRequestDto {

  final String fullName;
  final String dob;
  final String address;


 const UpdateInsertUserRequestDto({
    required this.fullName,
    required this.dob,
    required this.address,
  });

 Map<String, dynamic> toMapForInsert() =>{
    'full_name': fullName,
    'dob': dob,
    'address': address,
     'created_at': DateTime.now().toIso8601String(),
  };

 Map<String, dynamic> toMapForUpdate() =>{
    'full_name': fullName,
    'dob': dob,
    'address': address,
 };



}