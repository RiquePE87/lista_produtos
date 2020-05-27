import 'package:flutter/material.dart';
import 'package:listaprodutos/ui/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginForm(),
      alignment: Alignment(0.0, 0.0),
      padding: EdgeInsets.all(16.0),
    );
  }
}
