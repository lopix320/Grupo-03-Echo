import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pi_flutter/components/experience_card.dart';
import 'package:pi_flutter/components/formation_card.dart';
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

class CuidadorPage extends StatefulWidget {
  // var product;
  CuidadorPage({super.key});

  @override
  State<CuidadorPage> createState() => _CuidadorPageState();
}

class _CuidadorPageState extends State<CuidadorPage> {
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
        title: const Text("Detalhes do cuidador"),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PacienteCardBig(nome: "Gabriel Lopes"),
              Text("Telefone:"),
              Text("(11)93320-9295"),
              const SizedBox(
                height: 20,
              ),
              Text("Email:"),
              Text("gabriel.lp2008@gmail.com"),
              SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  'Horário disponível:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("24 horas"),
              ),
              SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  'Experiência:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ExperienceCard(
                    finalDate: "01/09/2024",
                    initialDate: "01/05/2024",
                    title: "Cuidador de idosos",
                    description:
                        "De janeiro de 2022 a dezembro de 2023, atuei como cuidador de idoso, prestando assistência pessoal nas atividades diárias, administração de medicamentos, apoio na mobilidade e oferecendo suporte emocional ..."),
              ),
              SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  'Formação acadêmica:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                child: FormationCard(
                    finalDate: "01/09/2024",
                    initialDate: "01/05/2024",
                    universidade: "SENAC",
                    curso: "Sistemas de informação"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
