import 'package:core_demo_slot5/data/dtos/usermanagement/managed_user_dto.dart';
import 'package:core_demo_slot5/data/dtos/usermanagement/update_insert_user_request_dto.dart';
import 'package:core_demo_slot5/data/interfaces/api/imanaged_user_api.dart';
import 'package:core_demo_slot5/data/interfaces/mapper/imapper.dart';
import 'package:core_demo_slot5/data/interfaces/repositories/imanaged_user_repository.dart';
import 'package:core_demo_slot5/domain/entities/managed_user.dart';

class ManagedUserRespository implements IManagedUserRepository {
  final IManagedUserApi api;
  final IMapper<ManagedUserDto, ManagedUser> mapper;
  ManagedUserRespository({
    required this.api,
    required this.mapper,
  });

  @override
  Future<void> seedDemoIfEmpty() => api.seedDemoIfEmpty();

  @override
  Future<List<ManagedUser>> getAll() async{
    final dtos = await api.getAll();
    return dtos.map(mapper.map).toList();
  }
  @override
  Future<ManagedUser?> getById(int id) async {
    final dto = await api.getById(id);
    return dto == null ? null : mapper.map(dto);
  }
  @override
  Future<ManagedUser> create(String fullName, String dob, String address) async {
    final req = UpdateInsertUserRequestDto( fullName: fullName, dob: dob, address: address);
    final id = await api.create(req);
    final dto = await api.getById(id);
    if (dto == null) throw Exception('Failed to create user');
    return mapper.map(dto);

  }

  @override
  Future<ManagedUser> update(int id,String fullName, String dob, String address) async {
    final req = UpdateInsertUserRequestDto( fullName: fullName, dob: dob, address: address);
    await api.update(id, req);
    final dto = await api.getById(id);
    if (dto == null) throw Exception('User not found');
    return mapper.map(dto);

  }

  @override
  Future<void> delete(int id) async {
    await api.delete(id);
  }



}