import 'package:flutter/material.dart';
import 'package:listaprodutos/blocs/login_bloc.dart';
import 'package:listaprodutos/blocs/login_bloc_provider.dart';
import 'package:listaprodutos/ui/login_screen.dart';
import 'package:listaprodutos/ui/produtos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LoginBloc bloc;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = LoginBlocProvider.of(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bloc.statusLogin != null ? Produtos() : LoginScreen();
  }
}
