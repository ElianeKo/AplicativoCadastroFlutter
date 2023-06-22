import 'package:flutter/material.dart';
import 'dart:core';

import 'package:controlaai/conexao/database_helper.dart';
import 'package:controlaai/home_page.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
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
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
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
              onPressed: () async {
                String email = emailController.text;
                bool isEmailValid =
                    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(email);

                if (!isEmailValid) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erro'),
                        content: Text('Por favor, insira um e-mail válido.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                await DatabaseHelper.salvarUsuario(
                  nomeController.text,
                  emailController.text,
                  senhaController.text,
                );

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Cadastro realizado com sucesso'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => HomePage()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Criar Conta'),
            ),
          ],
        ),
      ),
    );
  }
}
