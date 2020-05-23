import 'package:flutter/material.dart';
import 'package:listaprodutos/datas/usuario.dart';
import 'package:listaprodutos/screens/cadastro_screen.dart';
import 'package:listaprodutos/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
              child: Text('Criar Conta', style: TextStyle(color: Colors.white, fontSize: 14.0)),
          onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> CadastroScreen())
                );
          },)
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.0,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Insira o email';
                  }else if (!text.contains('@')){
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
                keyboardType: TextInputType.emailAddress,
                controller: _senhaController,
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Insira uma senha';
                  }else if (text.length < 5){
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
                child: Text( 'Entrar', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                onPressed: () {
                  if (_formKey.currentState.validate()){
                    Usuario.of(context).fazerLogin(email: _emailController.text, pass: _senhaController.text, onSucess: _onSucess, onFail: _onFail);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  void _onSucess(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao efetuar login!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    ));
  }
}
