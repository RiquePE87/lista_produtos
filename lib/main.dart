import 'package:flutter/material.dart';
import 'package:listaprodutos/datas/usuario.dart';
import 'package:listaprodutos/screens/cadastro_produtos_screen.dart';
import 'package:listaprodutos/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'screens/home_screen.dart';
import 'screens/cadastro_screen.dart';

void main() {

  runApp(myApp());
}

class myApp extends StatefulWidget {

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<Usuario>(
        model: Usuario(),
        child: ScopedModelDescendant<Usuario>(
          builder: (context, child, model) {
            return MaterialApp(
              theme: ThemeData(
                  primaryColor: Colors.grey[800]
              ),
              title: 'Lista de Produtos',
              home: CadastroProdutosScreen(),
            );
          },
        ));
  }
}

