import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:controlaai/conexao/database_helper.dart';
import 'package:controlaai/adicionar_boletos/boleto.dart';
import 'package:controlaai/adicionar_boletos/boleto_provider.dart';
import 'package:controlaai/home_page.dart';

class AdicionarBoletoPage extends StatefulWidget {
  @override
  _AdicionarBoletoPageState createState() => _AdicionarBoletoPageState();
}

class _AdicionarBoletoPageState extends State<AdicionarBoletoPage> {
  final TextEditingController nomeBoletoController = TextEditingController();
  final TextEditingController valorBoletoController = TextEditingController();
  final TextEditingController parcelasController = TextEditingController();
  DateTime? dataVencimento;
  int diasAntesAlerta = 1;
  List<int> diasAlertaOpcoes = [1, 3, 7, 15, 30];
  int _parcelasPagas = 0;


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
            Text(
              'Nome do boleto:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: nomeBoletoController,
            ),
            SizedBox(height: 16.0),
            Text(
              'Valor do boleto:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: valorBoletoController,
            ),
            SizedBox(height: 16.0),
            Text(
              'Quantidade de parcelas:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: parcelasController,
            ),
            SizedBox(height: 16.0),
            Text(
              'Data de vencimento:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text(
                    dataVencimento != null
                        ? dataVencimento!.toString().split(' ')[0]
                        : 'Selecionar Data',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Lembrar quantos dias antes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<int>(
              value: diasAntesAlerta,
              onChanged: (value) {
                setState(() {
                  diasAntesAlerta = value!;
                });
              },
              items: diasAlertaOpcoes.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value dia(s)'),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  String nomeBoleto = nomeBoletoController.text;
                  double valorBoleto = double.parse(
                      valorBoletoController.text.replaceAll(',', '.'));
                  int parcelas = int.parse(parcelasController.text);

                  double valorTotal =
                      valorBoleto * parcelas; // Cálculo do valor total
                
                  Boleto boleto = Boleto(
                    id: 1,
                    nome: nomeBoleto,
                    valor: valorBoleto,
                    parcelas: parcelas,
                    dataVencimento: dataVencimento,
                    diasAntesAlerta: diasAntesAlerta,
                    valorTotal: valorTotal, // Atribuição do valor total
                    parcelasPagas: _parcelasPagas, // Atribuição das parcelas pagas

                  );

                  // Adicionar o boleto ao Provider
                  final boletoProvider =
                      Provider.of<BoletoProvider>(context, listen: false);
                  boletoProvider.adicionarBoleto(boleto);

                 // Definir a quantidade de parcelas restantes
                  boleto.parcelasRestantes = boleto.parcelas;
                  boleto.parcelasRestantes = boleto.parcelas - _parcelasPagas;
                  
                  // Mostrar a mensagem de sucesso
                  final scaffold = ScaffoldMessenger.of(context);
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text('Boleto adicionado com sucesso!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Retornar à página anterior (Home Page)
                  Navigator.pop(context);

                  // ...
                } catch (error) {
                  print('Erro ao salvar o boleto: $error');
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      setState(() {
        dataVencimento = pickedDate;
      });
    }
  }
}
