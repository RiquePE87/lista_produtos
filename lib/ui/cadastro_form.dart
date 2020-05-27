import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listaprodutos/blocs/login_bloc.dart';
import 'package:listaprodutos/blocs/login_bloc_provider.dart';
import 'package:listaprodutos/blocs/produto_bloc.dart';
import 'package:listaprodutos/blocs/produto_bloc_provider.dart';
import 'package:listaprodutos/ui/produtos.dart';

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  ProdutoBloc _bloc;
  LoginBloc _loginBloc;
  FirebaseUser usuario;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          imagem(),
          Text('Adicionar Foto'),
          campoNome(),
          campoDescricao(),
          campoPreco(),
          botaoEntrar()
        ],
      ),
    );
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = ProdutoBlocProvider.of(context);
    _loginBloc = LoginBlocProvider.of(context);
    _loginBloc.getUsuario().then((onValue){
      usuario = onValue;
    });
  }


  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  Widget campoNome() {
    return StreamBuilder(
      stream: _bloc.nome,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: _bloc.mudarNome,
          decoration: InputDecoration(errorText: snapshot.error, hintText: 'Título'),
        );
      },
    );
  }
  
  Widget imagem(){
    return StreamBuilder(
      stream: _bloc.imagem,
      builder: (context, AsyncSnapshot<String> snapshot){
        return Container(
         width: 150,
          height: 200,
          child: AspectRatio(
            aspectRatio: 0.9,
            child: Image.asset('images/placeholder.png')
          )
        );
      },
    );
  }

  Widget campoDescricao() {
    return StreamBuilder(
      stream: _bloc.descricao,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: _bloc.mudarDescricao,
          decoration: InputDecoration(errorText: snapshot.error, hintText: 'Descrição'),
        );
      },
    );
  }

  Widget campoPreco() {
    return StreamBuilder(
      stream: _bloc.preco,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          keyboardType: TextInputType.numberWithOptions(),
          onChanged: _bloc.mudarPreco,
          decoration: InputDecoration(errorText: snapshot.error, hintText: 'Preço'),
        );
      },
    );
  }

  Widget button() {
    return RaisedButton(
      child: Text('Salvar'),
      onPressed: () {
        if (_bloc.validarCampos()){
          _bloc.mudarUsuarioId(usuario.uid);
          _bloc.mudarImagem('imagem');
          _bloc.registrarProduto();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Produtos()));
//          Navigator.pop(context);
        } else {
          showErrorMessage();
        }
      },
    );
  }

  Widget botaoEntrar() {
    return StreamBuilder(
      stream: _loginBloc.statusLogin,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData || snapshot.error) {
          return button();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  void showErrorMessage() {
    final snackbar = SnackBar(
        content: Text('Erro ao entrar'),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
