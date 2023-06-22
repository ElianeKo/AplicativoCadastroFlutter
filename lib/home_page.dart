import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:controlaai/adicionar_boletos/boleto_provider.dart';
import 'package:controlaai/adicionar_boletos/boleto.dart';
import 'package:controlaai/adicionar_boletos/adicionar_boleto.dart'
    as adicionar_boleto;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ControlaAI'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32.0,
                    backgroundImage: AssetImage('assets/foto_perfil.jpg'),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'FacilitaAi@hotmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'adicionar_boletos/login_page'); // Redireciona para a tela de login
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          Image.asset(
            'assets/imagens/1.jpg',
            width: 48,
            height: 48,
          ),
          SizedBox(height: 8.0),
          Text(
            'Suas contas em um só lugar',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          SizedBox(height: 16.0),
          Consumer<BoletoProvider>(
            builder: (context, boletoProvider, _) {
              double gastoMensal = boletoProvider.calcularGastoMensal();
              return Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepOrange,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    'R\$ ${(gastoMensal ?? 0.0).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => adicionar_boleto.AdicionarBoletoPage(),
                ),
              );
            },
            child: Text('Adicionar boletos'),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              onPrimary: Colors.white,
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: Consumer<BoletoProvider>(
              builder: (context, boletoProvider, _) {
                return ListView.builder(
                  itemCount: boletoProvider.boletos.length,
                  itemBuilder: (context, index) {
                    Boleto boletoItem = boletoProvider.boletos[index];
                    return ListTile(
                      title: Text(boletoItem.nome),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Valor: R\$ ${boletoItem.valor.toStringAsFixed(2)}',
                          ),
                          Text(
                            'Data de Vencimento: ${DateFormat('dd/MM/yyyy').format(boletoItem.dataVencimento!)}',
                          ),
                          Text(
                            'Parcelas Restantes: ${boletoItem.parcelasRestantes}',
                          ),
                          Text(
                            'Total do Boleto: R\$ ${boletoItem.valorTotal.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              boletoProvider.pagarParcela(boletoItem);
                            },
                            child: Text('Pagar'),
                          ),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              boletoProvider.excluirBoleto(boletoItem);
                            },
                            child: Text('Excluir'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
