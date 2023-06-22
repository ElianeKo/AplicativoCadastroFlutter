import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:controlaai/splash/splash_screen.dart';
import 'package:controlaai/adicionar_boletos/boleto_provider.dart';

void main() {
  runApp(ControlaAIApp());
}

class ControlaAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BoletoProvider>(
          create: (_) => BoletoProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'ControlaAI',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
