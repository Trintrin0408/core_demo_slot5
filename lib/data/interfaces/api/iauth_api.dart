import 'package:core_demo_slot5/data/dtos/login/login_request_dto.dart';
import 'package:core_demo_slot5/data/dtos/login/login_response_dto.dart';

abstract class IAuthApi {
  Future<LoginResponseDto> login(LoginRequestDto req);

  Future<LoginResponseDto?> getCurrentSession();
  Future<void> logout();
}