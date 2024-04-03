import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(), // primeira tela do aplicativo (rota)
    debugShowCheckedModeBanner: false, // tira o logo do debug
  ));
}

// Stateful - permite alterar valores no ambiente (variáveis)
// Stateless - apenas para a apresentação de conteúdo
// classe que configura o ambiente como "editável"
class Home extends StatefulWidget {
  const Home({super.key});
  @override // sobrescrita de método da classe pai
  // criação de um controle de estado para a aplicação
  _HomeState createState() => _HomeState();
}

// Classe que fará o controle das variáveis da aplicação
class _HomeState extends State<Home> {
  // definição dos objetos (controladores ou controllers)
  // TextEditingController: campo de entrada de dados texto (input)
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = ''; // texto de resposta da aplicação

  // objeto para controlar o fomulário onde estarão os inputs
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // método que altera o "estado" das variáveis
  // limpa os campos do formulário e o seu estado
  void _reset() {
    setState(() {
      alcoolController.text = '';
      gasolinaController.text = '';
      _resultado = '';
      _formKey = GlobalKey<FormState>();
    });
  }

  // realiza o cálculo dos valores dos combustíveis
  // não pode esquecer de usar o setState() dentro de um
  // método que fará alguma alteração em variáveis e/ou objetos
  void _calcularCombustivel() {
    double varGasolina =
        double.parse(gasolinaController.text.replaceAll(',', '.'));
    double varAlcool = double.parse(alcoolController.text.replaceAll(',', '.'));
    double proporcao = varAlcool / varGasolina; // proporção de 70%
    setState(() {
      // abaixo está sendo usado um operador ternário (substitui o if-else)
      _resultado =
          (proporcao < 0.7) ? 'Abasteça com álcool' : 'Abastaça com gasolina';
    });
  }

  // construtor que implementa a interface do usuário
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // barra superior
      appBar: AppBar(
        title: const Text(
          'Gasolina ou Álcool?',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _reset();
              },
              icon: const Icon(Icons.refresh, color: Colors.white)),
        ],
      ),
      // vamos montar o corpo da aplicação
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0), // margem interna
        child: Form(
          key: _formKey, // é a referência para o formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // alargar
            // aqui vamos colocar os campos de entrada (inputs)
            children: <Widget>[
              const Icon(
                Icons.local_gas_station,
                size: 70.0,
                color: Colors.black,
              ),
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Esse valor é obrigatorio:' : null,
                decoration: InputDecoration(
                  labelText: 'Valor do litro do Álcool',
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                ),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 25.0),
              ),
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Valor do litro da Gasolina',
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                ),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 25.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: SizedBox(
                  height: 50,
                  child: RawMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calcularCombustivel();
                      }
                    }, // falta implementar
                    fillColor: Colors.red,
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              Text(
                _resultado, //variavel com o valor do resultado retornado
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
