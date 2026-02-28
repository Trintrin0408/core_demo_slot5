import 'package:core_demo_slot5/data/implementations/api/auth_api.dart';
import 'package:core_demo_slot5/data/implementations/api/managed_user_api.dart';
import 'package:core_demo_slot5/data/implementations/local/app_database.dart';
import 'package:core_demo_slot5/data/implementations/mapper/auth_mapper.dart';
import 'package:core_demo_slot5/data/implementations/mapper/managed_user_mapper.dart';
import 'package:core_demo_slot5/data/implementations/repositories/auth_repository.dart';
import 'package:core_demo_slot5/data/implementations/repositories/managed_user_respository.dart';
import 'package:core_demo_slot5/viewmodels/login/login_viewmodel.dart';
import 'package:core_demo_slot5/viewmodels/usermanagment/users_viewmodel.dart';

LoginViewModel buildLoginVM(){
  final api= AuthApi(AppDatabase.instance);
  final mapper = AuthSessionMapper();
  final repo = AuthRepository(api: api, mapper: mapper);
  return LoginViewModel(repo);

}

ManagedUserRespository buildManagedUserRepository(){
  // Sửa lại cách gọi constructor ở đây
  final api = ManagedUserApi(database: AppDatabase.instance);
  final mapper = ManagedUserMapper();
  return ManagedUserRespository(api: api, mapper: mapper);
}

UsersViewmodel buildUsersViewModel(){
  return UsersViewmodel(repo: buildManagedUserRepository());
}
