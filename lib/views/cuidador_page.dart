import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pi_flutter/components/cuidador_card_big.dart';
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
import 'package:pi_flutter/util/FontSizeProvider.dart';
import 'package:pi_flutter/views/home_page.dart';
import 'package:pi_flutter/views/main_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../components/custom_checkbox.dart';

class CuidadorPage extends StatefulWidget {
  dynamic cuidador;

  CuidadorPage({super.key, required this.cuidador});
  // var product;

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

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  Future<bool> onSubmit(id_cuidador) async {
    try {
      dynamic user = await getUser();
      dynamic id_paciente = user['user'][0]['paciente'][0]['id_paciente'];

      Map body = {
        'id_paciente': id_paciente,
        'id_cuidador': id_cuidador,
      };

      print(body);

      final response = await http.post(
        Uri.parse('http://10.0.2.2:4445/usuario/setContratacao'),
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
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
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
              CuidadorCardBig(nome: widget.cuidador['nome']),
              Text(
                "Telefone:",
                style: TextStyle(fontSize: fontSizeProvider.fontSize),
              ),
              Text(
                widget.cuidador['numero_telefone'],
                style: TextStyle(fontSize: fontSizeProvider.fontSize),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Email:",
                style: TextStyle(fontSize: fontSizeProvider.fontSize),
              ),
              Text(
                widget.cuidador['email'],
                style: TextStyle(fontSize: fontSizeProvider.fontSize),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Descrição:",
                style: TextStyle(fontSize: fontSizeProvider.fontSize),
              ),
              Text(
                widget.cuidador['cuidador'][0]['bio'].split("/")[0],
                style: TextStyle(fontSize: fontSizeProvider.fontSize),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Anos de profissão:",
                style: TextStyle(fontSize: fontSizeProvider.fontSize),
              ),
              Text(
                widget.cuidador['cuidador'][0]['bio'].split("/")[1],
                style: TextStyle(fontSize: fontSizeProvider.fontSize),
              ),
              Text(
                "Link do curriculo:",
                style: TextStyle(fontSize: fontSizeProvider.fontSize),
              ),
              InkWell(
                child: Text(
                  "https://drive.google.com/file/d/17-AS7FuM8GDgJuSht52EJzdXV_Sgbigd/view?usp=drive_link",
                  style: TextStyle(
                      fontSize: fontSizeProvider.fontSize,
                      color: Colors.lightBlue),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // const Padding(
              //   padding: EdgeInsets.only(left: 8.0),
              //   child: Text("24 horas"),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // const Padding(
              //   padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              //   child: Text(
              //     'Experiência:',
              //     style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.w700,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
              //   child: ExperienceCard(
              //       finalDate: "01/09/2024",
              //       initialDate: "01/05/2024",
              //       title: "Cuidador de idosos",
              //       description:
              //           "De janeiro de 2022 a dezembro de 2023, atuei como cuidador de idoso, prestando assistência pessoal nas atividades diárias, administração de medicamentos, apoio na mobilidade e oferecendo suporte emocional ..."),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // const Padding(
              //   padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              //   child: Text(
              //     'Formação acadêmica:',
              //     style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.w700,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
              //   child: FormationCard(
              //       finalDate: "01/09/2024",
              //       initialDate: "01/05/2024",
              //       universidade: "SENAC",
              //       curso: "Sistemas de informação"),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 60),
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
                        widget.cuidador['cuidador'][0]['id_cuidador']);
                  },
                  child: const Text('Alertar interesse'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
