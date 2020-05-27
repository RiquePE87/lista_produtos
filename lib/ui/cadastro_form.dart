import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listaprodutos/blocs/login_bloc.dart';
import 'package:listaprodutos/blocs/login_bloc_provider.dart';
import 'package:listaprodutos/blocs/produto_bloc.dart';
import 'package:listaprodutos/blocs/produto_bloc_provider.dart';

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
    return Column(
      children: <Widget>[
        campoNome(),
        campoDescricao(),
        campoPreco(),
        button()
      ],
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
          decoration: InputDecoration(errorText: snapshot.error, hintText: 'Nome'),
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
          decoration: InputDecoration(errorText: snapshot.error, hintText: 'E-mail'),
        );
      },
    );
  }

  Widget campoPreco() {
    return StreamBuilder(
      stream: _bloc.preco,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: _bloc.mudarPreco,
          decoration: InputDecoration(errorText: snapshot.error, hintText: 'E-mail'),
        );
      },
    );
  }

  Widget button() {
    return RaisedButton(
      child: Text('Entrar'),
      onPressed: () {
        if (_bloc.validarCampos()){

          _bloc.mudarUsuarioId(usuario.uid);
          _bloc.registrarProduto();
        } else {
          showErrorMessage();
        }
      },
    );
  }

//  Widget botaoEntrar() {
//    return StreamBuilder(
//      stream: _bloc.isLogado,
//      builder: (context, AsyncSnapshot<bool> snapshot) {
//        if (!snapshot.hasData || snapshot.error) {
//          return button();
//        } else {
//          return CircularProgressIndicator();
//        }
//      },
//    );
//  }

  void showErrorMessage() {
    final snackbar = SnackBar(
        content: Text('Erro ao entrar'),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
