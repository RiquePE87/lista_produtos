import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listaprodutos/datas/produto.dart';
import 'package:listaprodutos/screens/login_screen.dart';
import 'package:listaprodutos/widgets/card_produto.dart';
import 'package:listaprodutos/datas/usuario.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Bem Vindo! ${Usuario.of(context).usuarioData['nome']}'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[800],
          actions: <Widget>[
            IconButton(icon: Icon(Icons.exit_to_app,),
            onPressed: (){
              Usuario.of(context).fazerLogOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen()));
            },)
          ],
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('produtos').getDocuments(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    Produto produto =
                        Produto.fromDocument(snapshot.data.documents[index]);
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CardProduto(produto),
                    );
                  });
            } else {
              return Container();
            }
          },
        ));
  }
}
