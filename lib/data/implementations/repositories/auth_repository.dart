import 'package:core_demo_slot5/data/dtos/login/login_request_dto.dart';
import 'package:core_demo_slot5/data/dtos/login/login_response_dto.dart';
import 'package:core_demo_slot5/data/implementations/api/auth_api.dart';
import 'package:core_demo_slot5/data/interfaces/mapper/imapper.dart';
import 'package:core_demo_slot5/data/interfaces/repositories/iauth_repositories.dart';
import 'package:core_demo_slot5/domain/entities/auth_session.dart';

class AuthRepository implements IAuthRepositories {
  final AuthApi api;
  final IMapper<LoginResponseDto,AuthSession> mapper;
  AuthRepository({required this.api, required this.mapper});

  @override
  Future<AuthSession> login(String userName, String password) async {
    final req = LoginRequestDto(userName: userName, password: password);
    final dto = await api.login(req); //DTO response
    return mapper.map(dto);           // DTO-> entity

  }
  @override
  Future<AuthSession?> getCurrentSession() async {
    final dto = await api.getCurrentSession();
    if(dto == null) {return null;}
    return mapper.map(dto);
  }
  @override
  Future<void> logout() => api.logout();
}