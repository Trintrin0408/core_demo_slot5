import 'package:core_demo_slot5/data/dtos/login/login_response_dto.dart';
import 'package:core_demo_slot5/data/interfaces/mapper/imapper.dart';
import 'package:core_demo_slot5/domain/entities/auth_session.dart';
import 'package:core_demo_slot5/domain/entities/user.dart';

class AuthSessionMapper implements IMapper<LoginResponseDto, AuthSession>{
  @override
  AuthSession map(LoginResponseDto input) {
    return AuthSession(
      token: input.token,
      user: User(
        id: input.user.id,
        userName: input.user.userName
      )
    );

  }
}