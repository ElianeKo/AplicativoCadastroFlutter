import 'package:flutter/material.dart';
class Boleto {
  int id;
  final String nome;
  final double valor;
  final int parcelas;
  final DateTime? dataVencimento;
  final int diasAntesAlerta;
  int parcelasRestantes;
  double valorTotal;
  int parcelasPagas;
  bool excluido;

  Boleto({
    required this.id,
    required this.nome,
    required this.valor,
    required this.parcelas,
    required this.dataVencimento,
    required this.diasAntesAlerta,
    this.parcelasRestantes = 0,
    required this.valorTotal,
    required this.parcelasPagas,
    this.excluido = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
      'parcelas': parcelas,
      'dataVencimento': dataVencimento?.toString() ?? '',
      'diasAntesAlerta': diasAntesAlerta,
    };
  }
}


class AdicionarBoletoPage extends StatefulWidget {
  @override
  _AdicionarBoletoPageState createState() => _AdicionarBoletoPageState();
}

class _AdicionarBoletoPageState extends State<AdicionarBoletoPage> {
  final TextEditingController nomeBoletoController = TextEditingController();
  final TextEditingController valorBoletoController = TextEditingController();
  final TextEditingController parcelasController = TextEditingController();
  DateTime? dataVencimento;
  int diasAntesAlerta = 0;

  // Restante do código...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Boleto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Restante do código...
          ],
        ),
      ),
    );
  }
}


