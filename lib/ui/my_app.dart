import 'package:flutter/material.dart';
import 'package:listaprodutos/blocs/login_bloc_provider.dart';
import 'package:listaprodutos/blocs/produto_bloc_provider.dart';
import 'package:listaprodutos/ui/home.dart';
import 'package:listaprodutos/ui/login_screen.dart';
import 'package:listaprodutos/ui/login_form.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProdutoBlocProvider(
      child: LoginBlocProvider(
          child: MaterialApp(
            title: "Produtos",
            theme: ThemeData(
              primaryColor: Colors.grey[800]
            ),
            home: Scaffold(
              body: Home(),
            ),
          )
      ),
    );
  }
}
