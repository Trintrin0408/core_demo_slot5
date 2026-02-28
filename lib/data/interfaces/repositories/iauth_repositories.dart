import 'package:core_demo_slot5/domain/entities/auth_session.dart';

abstract class IAuthRepositories {
  Future<AuthSession> login(String userName, String password);

  Future<AuthSession?> getCurrentSession();
  Future<void> logout();
}
