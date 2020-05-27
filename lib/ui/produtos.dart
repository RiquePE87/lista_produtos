import 'package:flutter/material.dart';
import 'package:listaprodutos/ui/produtos_form.dart';

class Produtos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Produtos'),
      ),
      body: Container(
        child: ProdutosForm(),
      ),
    );
  }
}
