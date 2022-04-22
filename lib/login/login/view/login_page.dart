import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/login/login/bloc/login_bloc.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (context) => LoginPage());
  }

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) => LoginBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
