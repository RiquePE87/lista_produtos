import 'package:flutter/material.dart';
import 'package:listaprodutos/blocs/login_bloc.dart';
import 'package:listaprodutos/blocs/login_bloc_provider.dart';
import 'package:listaprodutos/ui/produtos.dart';
import 'package:listaprodutos/ui/produtos_form.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc.fazerLogOut();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        campoNome(),
        campoSenha(),
        botaoEntrar()
      ],
    );
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
  }

  @override
  void initState() {

  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  Widget campoNome() {
    return StreamBuilder(
      stream: _bloc.email,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: _bloc.mudarEmail,
          decoration: InputDecoration(errorText: snapshot.error, hintText: 'E-mail'),
        );
      },
    );
  }

  Widget campoSenha() {
    return StreamBuilder(
      stream: _bloc.senha,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: _bloc.mudarSenha,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Senha',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget button() {
    return RaisedButton(
      child: Text('Entrar'),
      onPressed: () {
        if (_bloc.validarCamposLogin()){
          _autenticarUsuario();
        } else {
          showErrorMessage();
        }
      },
    );
  }

  Widget botaoEntrar() {
    return StreamBuilder(
      stream: _bloc.isLogado,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData || snapshot.error) {
          return button();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  _autenticarUsuario() {
    _bloc.entrarConta().then((onValue){
      Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Produtos()));
    });
//    _bloc.entrarConta().then((onValue) {
//      if (!onValue) {
//        Navigator.of(context)
//            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
//      }
//      else{
//        showErrorMessage();
//      }
//    });
  }

  void showErrorMessage() {
    final snackbar = SnackBar(
        content: Text('Erro ao entrar'),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
