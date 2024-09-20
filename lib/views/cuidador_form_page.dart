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

class CuidadorPageForm extends StatefulWidget {
  @override
  _CuidadorPageFormState createState() => _CuidadorPageFormState();
}

class _CuidadorPageFormState extends State<CuidadorPageForm> {
  String email = '';
  String password = '';
  List formationInfo = [];
  List experienceInfo = [];
  bool isChecked = false;
  Map checkedInfo = {
    "Matutino": false,
    "Tarde": false,
    "Noturno": false,
    "24 horas": false,
  };
  bool seePassword = false;
  bool loginStatus = false;
  List formacao = [1];
  List experiencia = [1];
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
                          padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                          child: Text(
                            'Por favor, passe suas informações abaixo:',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 131, 133, 137)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            'Horário disponível:',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
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
                        ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 40,
                                ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: formacao.length,
                            itemBuilder: (ctx, index) {
                              return FormationInfo(
                                  formationInfo: formationInfo,
                                  setState: setState);
                            }),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 4),
                                            blurRadius: 10,
                                            spreadRadius: -4)
                                      ],
                                      borderRadius: BorderRadius.circular(40),
                                      color: const Color.fromARGB(
                                          255, 54, 105, 201)),
                                  child: IconButton(
                                    onPressed: formationInfo.isNotEmpty
                                        ? () {
                                            setState(() {
                                              setState(() {
                                                formacao.add(1);
                                              });
                                            });
                                          }
                                        : null,
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 40,
                                ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: experiencia.length,
                            itemBuilder: (ctx, index) {
                              return ExperienceInfo(
                                  experienceInfo: experienceInfo,
                                  setState: setState);
                            }),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 4),
                                            blurRadius: 10,
                                            spreadRadius: -4)
                                      ],
                                      borderRadius: BorderRadius.circular(40),
                                      color: const Color.fromARGB(
                                          255, 54, 105, 201)),
                                  child: IconButton(
                                    onPressed: formationInfo.isNotEmpty
                                        ? () {
                                            setState(() {
                                              setState(() {
                                                formacao.add(1);
                                              });
                                            });
                                          }
                                        : null,
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                        ),
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
                          // loginStatus = await UserRepository(
                          //         apiUser: ApiUser(
                          //             httpClient: http.Client()))
                          //     .login(email, password);
                          // if (loginStatus) {
                          //   print('Correto');
                          //   // Navigator.of(context).pushNamed('/home');
                          Navigator.of(context).pushReplacement(
                              //-- Para eliminar o botao voltar da HomePage
                              MaterialPageRoute(
                                  builder: (context) => MainPage()));
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
