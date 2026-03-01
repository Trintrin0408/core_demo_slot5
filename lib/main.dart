import 'package:core_demo_slot5/di.dart';
import 'package:core_demo_slot5/viewmodels/login/login_viewmodel.dart';
import 'package:core_demo_slot5/viewmodels/usermanagment/users_viewmodel.dart';
import 'package:core_demo_slot5/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => buildLoginVM(),
        ),
        ChangeNotifierProvider<UsersViewmodel>(
          create: (_) => buildUsersViewModel(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
