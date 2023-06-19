import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false, // tira a marca dgua debug
    home: Home(), // tela principal, o home espera um widget e o widget espera um StatefulWidget que será a nossa tela
  ));
}

class Home extends StatefulWidget {
  // Um StatefulWidget é usado quando você precisa de um widget que possa ser atualizado e reagir a mudanças de estado.
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}
//_HomeState é responsável por atualizar o estado do widget Home e redessinhar a interface do usuário sempre que necessário.
class _HomeState extends State<Home> {
  //TextEditingController é uma classe fornecida pelo Flutter que permite controlar e interagir com um campo de texto
  TextEditingController weightController = TextEditingController(); // declarando weightController peso
  TextEditingController heightController = TextEditingController(); // declarando weightController altura

  // chave global para ser ultilizada no formulario
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // variael para colocar no lugar no text
  String _infoText = "Informe seus dados!";

  // a função _resetFieldsmétodo limparar o texto nos campos weightController e heightController e em seguida chamar a variavel _inforText.
  void  _resetFields(){
    weightController.text = "";
    heightController.text = "";
    // precisar usar o setSatate para redesenhar a tela
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }
  // função para calcular o imc
  void _calculate(){
    // setState printar na tela
    setState(() {
      double weight = double.parse(weightController.text); // weight vai pegar os numeros (peso) no campo de text
      double height = double.parse(heightController.text) / 100; // height vai pegar os numeros (altura) no campo de text
      double imc = weight / (height * height);
      print(imc);
      if(imc < 18.6){
        _infoText = "Abaixo do peso! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do peso! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 29.9 && imc < 34.9){
      _infoText = "Obesidade Grau I! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 34.9 && imc < 39.9){
      _infoText = "Obesidade Grau II! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 40) {
        _infoText = "Obesidade Grau III! (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Widget que fornece uma estrutura básica para construir interfaces de usuário.
      appBar: AppBar(
        // Widget que representa a barra de aplicativo na parte superior de uma tela.
        title: const Text("Calculadora de IMC"),
        centerTitle: true, // Centralizar título (title).
        backgroundColor: Colors.green,
        actions: <Widget>[
          // "actions" refere-se a um conjunto de elementos interativos que podem ser exibidos na AppBar.
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields, // onPressed esta chamando a funçao de limpar
          ), // Ícone de atualizar.
        ],
      ),
      backgroundColor: Colors.white, // Cor de fundo do meu Scaffold.
      body: SingleChildScrollView( // SingleChildScrollView é um widget que permite rolar seu conteúdo verticalmente quando o espaço disponível é menor do que o necessário para exibir todo o conteúdo.
        padding:  const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0), // espaçamento da
        //Formwidget para gerenciar um grupo de formulário
        child: Form(
            // Column é um widget que organiza os seus filhos em uma única coluna vertical.
          key: _formKey, // chamando a chave global la em cima
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // crossAxisAlignment Estica os widgets filhos para preencher todo o espaço disponível ao longo do eixo transversal.
            children: [
              // children é usada para adicionar vários widgets como filhos de um widget pai e permite criar layouts mais complexos combinando diferentes widgets.

              const Icon(Icons.account_circle, size: 120.0, color: Colors.green), // Ícone, tamanho, cor.
              // TextField é um widget do Flutter que permite a entrada de texto por parte do usuário.
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  // Decorar o TextField.
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                // textAlign Centraliza o que tem dentro do TextField.
                textAlign: TextAlign.center,
                // style Estilizar o que tem dentro do TextField.
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: weightController,
                validator: (value) {
                  if(value!.isEmpty){ // se o valor estiver vazio ele  "Insira seu Peso!"
                    return "Insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                // TextField é um widget do Flutter que permite a entrada de texto por parte do usuário.
                decoration: const InputDecoration(
                  // Decorar o TextField.
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                // Centralizar o que tem dentro do TextField.
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ), // Estilizar o que tem dentro do TextField.
                controller: heightController,
                validator: (value) {
                  if(value!.isEmpty){ // se o valor estiver vazio ele  "Insira sua Altura!"
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding( // coloquei o botao dentro do padding para dar o espaçamento encima e embaixo
                padding: const EdgeInsets.only(top:20.0 , bottom:20.0 ,), //espaçamento
                child: Container( // container dentro do ElevatedButton
                  height: 50.0, // preenchimento do botao
                  child: ElevatedButton( //botao calcular
                    onPressed: (){
                      // esse if verifica se meu formulario esta valido
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    style: ElevatedButton.styleFrom( //estilo do botao
                      primary: Colors.green,// Definindo a cor de fundo do botão.
                    ),
                    child: const Text('Calcular', style: TextStyle(fontSize: 20.0)), // o texto do botao esta dentro de um chid (filho)
                  ),
                ),
              ),
              Text( _infoText, //texto da informaçao
                textAlign: TextAlign.center, // alinhar o texto
                style: const TextStyle(color: Colors.green, fontSize: 25.0), //
              ),
              const SizedBox(height: 200.0),
              const Text('Desenvolvedor:',
              textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.bold,),
              ),
              const Text('- Peterson Macedo -',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 18.0),
              ),
            ],
          ),
        ),
      )
    );
  }
}
