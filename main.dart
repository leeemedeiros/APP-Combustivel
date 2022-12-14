// ignore_for_file: unused_element, unused_field, unused_local_variable

import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(
    // método principal da aplicação
    // carregando o framework
    const MaterialApp(
      home: Home(), // rota de inicialização do APP (start route)
      debugShowCheckedModeBanner: false, // esconde o debug
    ),
  );
}

// classe principal da aplicação
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 1. Esta classe terá todo o conteúdo da aplicação
  // 2. Lógica da aplicação (campos de entrada, botões e objetos)

  // Vamos implementar nossos "controles" (campos e formulário)
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();

  // Criação do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variável para receber o resultado sobre o abastecimento
  String _resultado = '';

  // Lógica da aplicação (realizando o cálculo)

  // Método para limpar (resetar) os campos do formulário
  void _reset() {
    setState(() {
      alcoolController.text = '';
      gasolinaController.text = '';
      _resultado = '';
      _formKey = GlobalKey<FormState>();
    });
  }

  // método para calcular o preço do combustível
  void _calcular() {
    double vAlcool = double.parse(alcoolController.text.replaceAll(',', '.'));
    double vGasolina =
        double.parse(gasolinaController.text.replaceAll(',', '.'));
    double proporcao = vAlcool / vGasolina; // proporção

    // não esquecer de colocar o setState quando for atualizar algo
    setState(() {
      // atualizar o valor da variável "_resultado"
      // if (proporcao < 0.7) {
      //   _resultado = 'Abasteça com Álcool';
      // } else {
      //   _resultado = 'Abasteça com Gasolina';
      // }

      // Operador ternário
      _resultado =
          (proporcao < 0.7) ? 'Abasteça com Álcool' : 'Abasteça com Gasolina';
    });
  }

  // O código abaixo irá construir a interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // monta a barra superior do aplicativo
      appBar: AppBar(
        title: const Text(
          "Álcool ou Gasolina?",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // chamar o método para dar o reset()
              _reset();
            },
          ),
        ], // esse atributo cria um botão
      ),

      // criando o corpo do formulário (Entrada de Dados)
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
        child: Form(
          key: _formKey, // associando o formulário ao controle
          child: Column(
            // coluna para inserir controles
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 80,
                color: Colors.lightBlue[900],
              ),

              // criando o campo de entrada para álcool
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number, // só via cel.
                // validação dos dados
                validator: (value) =>
                    value!.isEmpty ? 'Informe o valor do álcool' : null,
                decoration: const InputDecoration(
                  labelText: 'Valor do Álcool',
                ),
                style: const TextStyle(color: Colors.black, fontSize: 25),
              ),

              // criando o campo de entrada para gasolina
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number, // só via cel.
                // validação dos dados
                validator: (value) =>
                    value!.isEmpty ? 'Informe o valor da gasolina' : null,
                decoration: const InputDecoration(
                  labelText: 'Valor da Gasolina',
                ),
                style: const TextStyle(color: Colors.black, fontSize: 25),
              ),

              // botão para calcular
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: SizedBox(
                  height: 50,
                  child: RawMaterialButton(
                    onPressed: () {
                      // verificar se os campos estão preenchidos
                      if (_formKey.currentState!.validate()) {
                        _calcular(); // faz o cálculo
                      }
                    },
                    fillColor: Colors.lightBlue[900],
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                // caixa
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 25),
              ),
            ], // inserir um ícone
          ),
        ),
      ),
    );
  }
}

