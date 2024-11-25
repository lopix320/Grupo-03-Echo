import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pi_flutter/components/paciente_card.dart';
import 'package:pi_flutter/components/paciente_card_big.dart';
import 'package:pi_flutter/models/product_model.dart';
import 'package:pi_flutter/provider/api_cart.dart';
import 'package:pi_flutter/provider/api_product.dart';
import 'package:pi_flutter/repository/cart_repository.dart';
import 'package:pi_flutter/repository/product_repository.dart';
import 'package:http/http.dart' as http;
import 'package:pi_flutter/views/home_page.dart';
import 'package:pi_flutter/views/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/custom_checkbox.dart';

class PacientePage extends StatefulWidget {
  dynamic paciente;
  // var product;
  PacientePage({super.key, required this.paciente});

  @override
  State<PacientePage> createState() => _PacientePageState();
}

class _PacientePageState extends State<PacientePage> {
  var quantity = 1;
  var orderTotal;
  final String message = "Olá, tudo bem?";

  Future<bool> openWhatsApp(phoneNumber) async {
    final Uri url = Uri.parse(
        "https://wa.me/55$phoneNumber?text=${Uri.encodeComponent(message)}");
    // if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
    // } else {
    //   print("Não foi possível abrir o WhatsApp.");
    // }

    return true;
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

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  Future<bool> onSubmit(id_paciente) async {
    try {
      dynamic user = await getUser();
      dynamic id_cuidador = user['user'][0]['cuidador'][0]['id_cuidador'];

      Map body = {
        'id_paciente': id_paciente,
        'id_cuidador': id_cuidador,
      };

      print(body);

      final response = await http.post(
        Uri.parse('http://10.0.2.2:4445/usuario/acceptContratacao'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['ok']) {
          print('Contratacao feita ');
        }

        // Salvar informações do usuário no SharedPreferences

        return true;
      } else {
        print('Erro na requisição: ${response.statusCode} ');
        return false;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print('paciente user: ${widget.paciente}');
    super.initState();
    // orderTotal = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                //-- Para eliminar o botao voltar da HomePage
                MaterialPageRoute(builder: (context) => MainPage()));
          },
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            wordSpacing: 3),
        title: const Text("Detalhes do paciente"),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PacienteCardBig(nome: widget.paciente['nome']),
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
                    value: widget.paciente['paciente'][0]
                        ['mobilidade_reduzida'],
                    onChanged: (value) {
                      setState(() {
                        // tru = value;
                      });
                    },
                    activeColor:
                        Colors.green, // Cor quando o switch está ativado
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
                    value: widget.paciente['paciente'][0]['acomp_24'],
                    onChanged: (value) {
                      setState(() {
                        // _value = value;
                      });
                    },
                    activeColor:
                        Colors.green, // Cor quando o switch está ativado
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
                    value: widget.paciente['paciente'][0]['acessibilidade'],
                    onChanged: (value) {
                      setState(() {
                        // _value = value;
                      });
                    },
                    activeColor:
                        Colors.green, // Cor quando o switch está ativado
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    'Serviços:',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                  shrinkWrap: true,
                  itemCount:
                      widget.paciente['paciente'][0]['pacienteServico'].length,
                  itemBuilder: (_, index) {
                    return Text(
                        " - ${widget.paciente['paciente'][0]['pacienteServico'][index]['servico']['descricao']}");
                  }),
              const SizedBox(
                height: 20,
              ),
              const Align(
                  alignment: Alignment.bottomLeft, child: Text("Telefone:")),
              widget.paciente['paciente'][0]['contratacoes'][0]['confirmacao']
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(widget.paciente['numero_telefone']))
                  : const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Contato indisponivel')),
              const SizedBox(
                height: 20,
              ),
              const Align(
                  alignment: Alignment.bottomLeft, child: Text("Email:")),
              widget.paciente['paciente'][0]['contratacoes'][0]['confirmacao']
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(widget.paciente['email']))
                  : const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Contato indisponivel')),
              widget.paciente['paciente'][0]['contratacoes'][0]['confirmacao']
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 70, 0, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.green),
                        onPressed:
                            // email.isEmpty && password.isEmpty
                            //     ? null
                            //     :
                            () async {
                          await openWhatsApp(
                              widget.paciente['numero_telefone']);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Mandar mensgem'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.message_outlined)
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 70, 0, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color.fromARGB(255, 54, 105, 201)),
                        onPressed:
                            // email.isEmpty && password.isEmpty
                            //     ? null
                            //     :
                            () async {
                          await onSubmit(
                              widget.paciente['paciente'][0]['id_paciente']);
                        },
                        child: const Text('Aceitar contato'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
