import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listaprodutos/datas/produto.dart';

class CardProduto extends StatelessWidget {

  final Produto produto;

  CardProduto(this.produto);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Row(
        children: <Widget>[
          Flexible(
              flex: 1,
              child: produto.image.contains('image') ? Image.asset(('images/placeholder.png'), fit: BoxFit.cover, height: 150)
          : Image.network(produto.image, fit: BoxFit.cover, height: 150)),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(produto.titulo, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                Text(produto.descricao,  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500))
              ],
            ),
          )
        ],
      ),
    );
  }
}
