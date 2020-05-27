import 'package:flutter/material.dart';
import 'package:listaprodutos/screens/login_screen.dart';
import 'package:listaprodutos/ui/cadastro.dart';
import 'package:listaprodutos/ui/produtos_form.dart';

class Produtos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Produtos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> Cadastro())
            );
          },),
          IconButton(icon: Icon(Icons.exit_to_app),
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=> LoginScreen())
              );
            },)

        ],
      ),
      body: Container(
        child: ProdutosForm(),
      ),
    );
  }
}
