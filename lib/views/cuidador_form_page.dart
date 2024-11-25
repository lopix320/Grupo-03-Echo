import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pi_flutter/components/custom_checkbox.dart';
import 'package:pi_flutter/components/experience_info.dart';
import 'package:pi_flutter/components/formation_info.dart';
import 'package:pi_flutter/provider/api_user.dart';
import 'package:pi_flutter/repository/user_repository.dart';
import 'package:pi_flutter/views/login_page.dart';
import 'package:pi_flutter/views/main_page.dart';
import 'package:pi_flutter/views/register_page.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class CuidadorPageForm extends StatefulWidget {
  dynamic firtForm;
  CuidadorPageForm({super.key, required this.firtForm});
  @override
  _CuidadorPageFormState createState() => _CuidadorPageFormState();
}

class _CuidadorPageFormState extends State<CuidadorPageForm> {
  String email = '';
  String password = '';
  String especialidade = '';
  List formationInfo = [];
  List experienceInfo = [];
  bool isChecked = false;

  bool seePassword = false;
  bool loginStatus = false;
  List formacao = [1];
  List experiencia = [1];
  String especializacao = '';
  String tempo = '';
  String curriculo = '';

  Future<bool> onSubmit(data) async {
    try {
      print(data);
      final response = await http.post(
          Uri.parse('http://10.0.2.2:4445/usuario/registerCuidador'),
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
                Navigator.of(context).pushReplacement(
                    //-- Para eliminar o botao voltar da HomePage
                    MaterialPageRoute(builder: (context) => LoginPage()));
                // Fecha o modal
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                            'Cuidador',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DM Sans'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                          child: Text(
                            'Por favor, passe suas informações abaixo:',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 131, 133, 137)),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Text('Link do curriculo',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            TextField(
                              onChanged: (text) {
                                setState(() {
                                  curriculo = text;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 25),
                                labelText: 'Link do seu curriculo(drive)',
                                labelStyle: TextStyle(fontSize: 15),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Text('Especialidade',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            TextField(
                              onChanged: (text) {
                                setState(() {
                                  especialidade = text;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 25),
                                labelText: 'Digite sua especialidade',
                                labelStyle: TextStyle(fontSize: 15),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Text('Tempo de profissão',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            TextField(
                              onChanged: (text) {
                                setState(() {
                                  tempo = text;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 25),
                                labelText: 'Digite seu tempo de profissão',
                                labelStyle: TextStyle(fontSize: 15),
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

                        // ListView.separated(
                        //     separatorBuilder: (context, index) =>
                        //         const SizedBox(
                        //           height: 40,
                        //         ),
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemCount: formacao.length,
                        //     itemBuilder: (ctx, index) {
                        //       return FormationInfo(
                        //           formationInfo: formationInfo,
                        //           setState: setState);
                        //     }),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Container(
                        //           decoration: BoxDecoration(
                        //               boxShadow: const [
                        //                 BoxShadow(
                        //                     color: Colors.black,
                        //                     offset: Offset(0, 4),
                        //                     blurRadius: 10,
                        //                     spreadRadius: -4)
                        //               ],
                        //               borderRadius: BorderRadius.circular(40),
                        //               color: const Color.fromARGB(
                        //                   255, 54, 105, 201)),
                        //           child: IconButton(
                        //             onPressed: formationInfo.isNotEmpty
                        //                 ? () {
                        //                     setState(() {
                        //                       setState(() {
                        //                         formacao.add(1);
                        //                       });
                        //                     });
                        //                   }
                        //                 : null,
                        //             icon: const Icon(
                        //               Icons.add,
                        //               color: Colors.white,
                        //             ),
                        //           ))
                        //     ],
                        //   ),
                        // ),
                        // ListView.separated(
                        //     separatorBuilder: (context, index) =>
                        //         const SizedBox(
                        //           height: 40,
                        //         ),
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemCount: experiencia.length,
                        //     itemBuilder: (ctx, index) {
                        //       return ExperienceInfo(
                        //           experienceInfo: experienceInfo,
                        //           setState: setState);
                        //     }),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Container(
                        //           decoration: BoxDecoration(
                        //               boxShadow: const [
                        //                 BoxShadow(
                        //                     color: Colors.black,
                        //                     offset: Offset(0, 4),
                        //                     blurRadius: 10,
                        //                     spreadRadius: -4)
                        //               ],
                        //               borderRadius: BorderRadius.circular(40),
                        //               color: const Color.fromARGB(
                        //                   255, 54, 105, 201)),
                        //           child: IconButton(
                        //             onPressed: formationInfo.isNotEmpty
                        //                 ? () {
                        //                     setState(() {
                        //                       setState(() {
                        //                         formacao.add(1);
                        //                       });
                        //                     });
                        //                   }
                        //                 : null,
                        //             icon: const Icon(
                        //               Icons.add,
                        //               color: Colors.white,
                        //             ),
                        //           ))
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 80, 0, 40),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Color.fromARGB(255, 54, 105, 201)),
                        onPressed: () async {
                          dynamic response = await onSubmit({
                            "firtFormData": widget.firtForm,
                            "secondFormData": {
                              "tempo": tempo,
                              "curriculo": curriculo,
                              "especialidade": especialidade,
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
                          //         builder: (context) => LoginPage()));
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
