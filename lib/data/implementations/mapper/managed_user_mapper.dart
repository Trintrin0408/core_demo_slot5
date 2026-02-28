import 'package:core_demo_slot5/data/dtos/usermanagement/managed_user_dto.dart';
import 'package:core_demo_slot5/data/interfaces/mapper/imapper.dart';
import 'package:core_demo_slot5/domain/entities/managed_user.dart';

class ManagedUserMapper implements IMapper<ManagedUserDto, ManagedUser> {
  @override
  ManagedUser map(ManagedUserDto input) {
      return ManagedUser(
        id: input.id,
        fullName: input.fullName,
        dob: input.dob,
        address: input.address,
        createdAt: input.createdAt,
      );
  }
}