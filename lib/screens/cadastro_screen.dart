import 'package:flutter/material.dart';
import 'package:listaprodutos/datas/usuario.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_screen.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<Usuario>(
        builder: (context, child, model) {
          if (model.isCarregando) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    TextFormField(
                      validator: (text) {
                        if (text.isEmpty) {
                          return 'Insira seu nome';
                        }else{
                          return null;
                        }
                      },
                      controller: _nomeController,
                      decoration: InputDecoration(hintText: 'Nome'),
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty) {
                          return 'Insira o email';
                        } else if (!text.contains('@')) {
                          return 'Insira um e-mail válido';
                        }else{
                          return null;
                        }
                      },
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'E-mail'),
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: _senhaController,
                      validator: (text) {
                        if (text.isEmpty) {
                          return 'Insira uma senha';
                        } else if (text.length < 5) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }else{
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text('Criar Conta', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> usuarioData = {
                            'nome': _nomeController.text,
                            'email': _emailController.text,
                            'senha': _senhaController.text
                          };

                          model.criarUsuario(
                              usuarioData: usuarioData,
                              pass: _senhaController.text,
                              onSucess: _onSucess,
                              onFail: _onFail);
                        }
                      },
                    )
                  ],
                ),
            );
          }
        }
      ),
    );
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Usuário criado com sucesso'),
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2))
        .then((_) =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen())));
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Ocorreu um erro ao criar usuário'),
      duration: Duration(seconds: 2),
    ));
  }
}
