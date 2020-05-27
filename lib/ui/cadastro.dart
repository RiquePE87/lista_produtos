import 'package:flutter/material.dart';
import 'package:listaprodutos/ui/cadastro_form.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produtos'),
        centerTitle: true,
      ),
      body: Container(
        child: CadastroForm(),
      )
    );
  }
}
