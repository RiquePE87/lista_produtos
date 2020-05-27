import 'package:flutter/material.dart';
import 'package:listaprodutos/blocs/login_bloc.dart';

class LoginBlocProvider extends InheritedWidget{
  final bloc = LoginBloc();

  @override
  bool updateShouldNotify(_) => true;

  LoginBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LoginBlocProvider) as LoginBlocProvider).bloc;
  }
}