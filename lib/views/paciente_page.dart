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
import 'package:shimmer/shimmer.dart';

import '../components/custom_checkbox.dart';

class PacientePage extends StatefulWidget {
  // var product;
  PacientePage({super.key});

  @override
  State<PacientePage> createState() => _PacientePageState();
}

class _PacientePageState extends State<PacientePage> {
  var quantity = 1;
  var orderTotal;
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
  void initState() {
    // TODO: implement initState
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
              PacienteCardBig(nome: "Gabriel Lopes"),
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
                    value: true,
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
                    value: true,
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
                    value: true,
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
                    'Observações:',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
              TextField(
                onChanged: (text) {
                  setState(() {
                    // email = text;
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
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  filled: true,
                  fillColor: Color.fromARGB(255, 232, 232, 232),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(alignment: Alignment.bottomLeft, child: Text("Telefone:")),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("(11)93320-9295")),
              SizedBox(
                height: 20,
              ),
              Align(alignment: Alignment.bottomLeft, child: Text("Email:")),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("gabriel.lp2008@gmail.com")),
            ],
          ),
        ),
      ),
    );
  }
}
