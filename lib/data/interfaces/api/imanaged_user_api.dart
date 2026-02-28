import 'package:core_demo_slot5/data/dtos/usermanagement/managed_user_dto.dart';
import 'package:core_demo_slot5/data/dtos/usermanagement/update_insert_user_request_dto.dart';
import 'package:core_demo_slot5/domain/entities/managed_user.dart';

abstract class IManagedUserApi {
  Future<List<ManagedUserDto>> getAll();
  Future<ManagedUserDto?> getById(int id);
  Future<int> create(UpdateInsertUserRequestDto req);
  Future<int> update(int id, UpdateInsertUserRequestDto req);
  Future<int> delete(int id);

  Future<void> seedDemoIfEmpty();

}