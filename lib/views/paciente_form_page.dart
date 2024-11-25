import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_flutter/components/custom_checkbox.dart';
import 'package:pi_flutter/components/experience_info.dart';
import 'package:pi_flutter/components/formation_info.dart';
import 'package:pi_flutter/provider/api_user.dart';
import 'package:pi_flutter/repository/user_repository.dart';
import 'package:pi_flutter/views/main_page.dart';
import 'package:pi_flutter/views/register_page.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class PacienteFormPage extends StatefulWidget {
  dynamic firtForm;
  PacienteFormPage({super.key, required this.firtForm});
  @override
  _PacienteFormPageState createState() => _PacienteFormPageState();
}

class _PacienteFormPageState extends State<PacienteFormPage> {
  String email = '';
  String password = '';
  List formationInfo = [];
  List experienceInfo = [];
  bool isChecked = false;
  bool moreInfoChecked = false;
  Map checkedInfo = {
    "Matutino": false,
    "Tarde": false,
    "Noturno": false,
    "24 horas": false,
  };
  Map checkedInfo2 = {
    "Acompanhamento em saídas (supermercado, shopping, etc)": false,
    "Acompanhamento terapêutico (consultas, pós operatório, etc)": false,
    "Administração de medicamentos": false,
    "Banho": false,
    "Administração de refeições ": false,
    "Transporte": false,
    "Companhia": false,
    "Preparo de refeições": false,
    "Higiene pessoal": false,
    "Manutenção do ambiente": false,
    "Acompanhamento noturno": false,
    "Atividades lúdicas": false,
  };

  List servicoChecked = [];
  bool seePassword = false;
  bool loginStatus = false;
  List formacao = [1];
  List experiencia = [1];
  bool mobilidade = false;
  bool acompanhamento = false;
  bool acessibilidade = false;

  @override
  void initState() {
    print(widget.firtForm);
    // TODO: implement initState
    super.initState();
  }

  void updateSelectedValues(String value, bool isChecked) {
    setState(() {
      if (isChecked) {
        // Se marcada, adiciona o valor na lista
        servicoChecked.add(value);
      } else {
        // Se desmarcada, remove o valor da lista
        servicoChecked.remove(value);
      }
    });
  }

  Future<List> fetchCheckboxData() async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:4445/servico/getAll'));

    if (response.statusCode == 200) {
      // Se a requisição for bem-sucedida, converte o JSON para uma lista de títulos
      dynamic data = jsonDecode(response.body);
      print(data['servico']);
      return data['servico'];
    } else {
      // Se falhar, lança um erro
      throw Exception('Falha ao carregar dados');
    }
  }

  Future<bool> onSubmit(data) async {
    try {
      print(data);
      final response =
          await http.post(Uri.parse('http://10.0.2.2:4445/usuario/register'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode(data));

      if (response.statusCode == 200) {
        // Se a requisição for bem-sucedida, exibe o modal de sucesso
        _showSuccessDialog(context);
        return true;
      } else {
        // Caso contrário, exibe um modal de erro
        _showErrorDialog(context);
        return false;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      _showErrorDialog(context);
      return false;
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sucesso"),
          content: const Text("Seu cadastro foi concluído com sucesso!"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal
              },
            ),
          ],
        );
      },
    );
  }

// Função para mostrar o modal de erro
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erro"),
          content: const Text("Ocorreu um erro ao concluir seu cadastro."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal
              },
            ),
          ],
        );
      },
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Material(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: Text(
                            'Paciente',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DM Sans'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                          child: Text(
                            'Por favor, nos informe abaixo as características do seu caso:',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 131, 133, 137)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.assist_walker, size: 24),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Mobilidade reduzida"),
                                ),
                              ],
                            ),
                            CupertinoSwitch(
                              value: mobilidade,
                              onChanged: (value) {
                                setState(() {
                                  mobilidade = value;
                                });
                              },
                              activeColor: Colors
                                  .green, // Cor quando o switch está ativado
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.local_convenience_store, size: 24),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Acompanhamento 24 horas"),
                                ),
                              ],
                            ),
                            CupertinoSwitch(
                              value: acompanhamento,
                              onChanged: (value) {
                                setState(() {
                                  acompanhamento = value;
                                });
                              },
                              activeColor: Colors
                                  .green, // Cor quando o switch está ativado
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.other_houses, size: 24),
                                    Padding(
                                      padding: EdgeInsets.only(top: 3.0),
                                      child: Icon(
                                        Icons.favorite,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Acessibilidade na casa"),
                                ),
                              ],
                            ),
                            CupertinoSwitch(
                              value: acessibilidade,
                              onChanged: (value) {
                                setState(() {
                                  acessibilidade = value;
                                });
                              },
                              activeColor: Colors
                                  .green, // Cor quando o switch está ativado
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            'Horário de necessiade:',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: CustomCheckbox(
                              checkedInfo: checkedInfo,
                              isChecked: isChecked,
                              setState: setState,
                              text: "Matutino"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: CustomCheckbox(
                              checkedInfo: checkedInfo,
                              isChecked: isChecked,
                              setState: setState,
                              text: "Tarde"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: CustomCheckbox(
                              checkedInfo: checkedInfo,
                              isChecked: isChecked,
                              setState: setState,
                              text: "Noturno"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: CustomCheckbox(
                              checkedInfo: checkedInfo,
                              isChecked: isChecked,
                              setState: setState,
                              text: "24 horas"),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            'Qual serviço você procura?',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        FutureBuilder<List>(
                          future:
                              fetchCheckboxData(), // Chama a função assíncrona
                          builder: (context, snapshot) {
                            // if (snapshot.connectionState ==
                            //     ConnectionState.waiting) {
                            //   return Center(child: CircularProgressIndicator());
                            // }

                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Erro: ${snapshot.error}'));
                            }

                            if (snapshot.hasData) {
                              List data = snapshot.data!;
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final checkboxData = data[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: CheckboxListTile(
                                      title: Text(checkboxData['descricao']),
                                      value: servicoChecked.contains(checkboxData[
                                          'id_servico']), // Verifica se o valor já está na lista
                                      onChanged: (bool? value) {
                                        updateSelectedValues(
                                            checkboxData['id_servico'], value!);
                                      },
                                    ),
                                  );
                                },
                              );
                            }

                            return Center(
                                child: Text('Nenhum dado encontrado'));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Text(
                                  'Quer nos contar mais alguma informação importante? Clique na caixinha ao lado:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 131, 133, 137)),
                                ),
                              ),
                            ),
                            Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: moreInfoChecked,
                                onChanged: (value) {
                                  setState(() {
                                    moreInfoChecked = value!;
                                  });
                                }),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            'Outros:',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        TextField(
                          onChanged: (text) {
                            setState(() {
                              email = text;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          minLines: 5,
                          maxLines: null,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                            // labelText:
                            //     'Digite as informações adicionais aqui caso tenha marcado a caixinha acima:',
                            // labelStyle: TextStyle(fontSize: 15),
                            label: Text(
                              "Digite as informações adicionais aqui caso tenha marcado a caixinha acima:",
                              textAlign: TextAlign.left,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            filled: true,
                            fillColor: Color.fromARGB(255, 232, 232, 232),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Color.fromARGB(255, 54, 105, 201)),
                        onPressed: () async {
                          // print({
                          //   "firtFormData": widget.firtForm,
                          //   "secondFormData": {
                          //     "acessibilidade": acessibilidade,
                          //     "mobilidade": mobilidade,
                          //     "acompanhamento": acompanhamento,
                          //     "servico": servicoChecked
                          //   }
                          // });
                          dynamic response = await onSubmit({
                            "firtFormData": widget.firtForm,
                            "secondFormData": {
                              "acessibilidade": acessibilidade,
                              "mobilidade": mobilidade,
                              "acompanhamento": acompanhamento,
                              "servico": servicoChecked
                            }
                          });
                          // loginStatus = await UserRepository(
                          //         apiUser: ApiUser(
                          //             httpClient: http.Client()))
                          //     .login(email, password);
                          // if (loginStatus) {
                          //   print('Correto');
                          //   // Navigator.of(context).pushNamed('/home');
                          // Navigator.of(context).pushReplacement(
                          //     //-- Para eliminar o botao voltar da HomePage
                          //     MaterialPageRoute(
                          //         builder: (context) => MainPage()));
                          // } else {
                          //   print('Login Invalido');
                          // }
                        },
                        child: const Text('Continuar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
