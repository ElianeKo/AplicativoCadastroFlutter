import 'package:flutter/material.dart';
import 'package:controlaai/home_page.dart';

import 'package:controlaai/cadastrodeusuario/signup_page.dart';
import 'package:controlaai/recuperarsenha/reset_password_page.dart';

//import 'package:controlaai/conexao/database_helper.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/imagens/1.jpg',
              height: 200,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Entrar'),
            ),

            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                );
              },
              child: Text('Esqueci minha senha'),
            ),

            SizedBox(height: 8.0),

            // BOTÃO - NÃO TEM UMA CONTA CADASTRE AQUI
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text(
                'Não tem uma conta? Cadastre-se aqui',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
