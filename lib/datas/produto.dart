
import 'package:cloud_firestore/cloud_firestore.dart';

class Produto{

  String usuarioId;
  String id;
  double preco;
  String titulo;
  String descricao;
  String imagem;

  Produto.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    usuarioId = snapshot.data['usuarioId'];
    titulo = snapshot.data['nome'];
    preco = snapshot.data['preco'];
    descricao = snapshot.data['descricao'];
    imagem = snapshot.data['imagem'];
  }
}