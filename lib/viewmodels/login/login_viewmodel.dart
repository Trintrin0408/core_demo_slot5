

import 'package:core_demo_slot5/data/implementations/repositories/auth_repository.dart';
import 'package:core_demo_slot5/domain/entities/auth_session.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository repo;
  LoginViewModel(this.repo);

  bool loading = false;
  String? error;
  AuthSession? session;

  Future<bool> login(String username, String password) async {

    loading = true;
    error = null;
    notifyListeners();


    try{
      final u = username.trim();
      final p = password.trim();
      if(u.isEmpty || p.isEmpty){
        throw Exception('Username or password is empty');
      }
      session = await repo.login(u, p);
      return true;
    }catch(e){
      session = null;
      error = e.toString().replaceFirst('Exception: ', '');
      return false;
    }finally{
      loading = false;
      notifyListeners();

    }
  }

  Future<void> logout() async{
    await repo.logout();
    session = null;
    notifyListeners();
  }
  void clearError(){
    if(error!=null){
      error = null;
      notifyListeners();
    }
  }


}

