import 'package:flutter/material.dart';
import 'package:controlaai/login/login_page.dart';

///import 'Splash/splash_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Text(
              'Bem-vindo ao ControlaAI',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/imagens/1.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
