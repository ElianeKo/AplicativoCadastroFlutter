import 'package:flutter/material.dart';
import 'boleto.dart';
import 'dart:core';

import 'package:controlaai/adicionar_boletos/boleto.dart';


 class BoletoProvider extends ChangeNotifier {
  List<Boleto> boletos = [];

  void adicionarBoleto(Boleto boleto) {
    boletos.add(boleto);
    notifyListeners();
  }

  void excluirBoleto(Boleto boleto) {
    boletos.remove(boleto);
    notifyListeners();
  }

  double calcularGastoMensal() {
    double gastoMensal = 0.0;
    for (var boleto in boletos) {
      gastoMensal += boleto.valor;
    }
    return gastoMensal;
  }

  void pagarParcela(Boleto boleto) {
    boleto.parcelasPagas++;
    boleto.parcelasRestantes--;
    notifyListeners();
  }







}//fechamento

