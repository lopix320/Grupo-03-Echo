import 'package:flutter/material.dart';

class FormationInfo extends StatefulWidget {
  List formationInfo;
  dynamic setState;

  FormationInfo({
    super.key,
    required this.formationInfo,
    required this.setState,
  });

  @override
  State<FormationInfo> createState() => _FormationInfoState();
}

class _FormationInfoState extends State<FormationInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text('Curso:',
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
              TextField(
                onChanged: (text) {
                  setState(() {});
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                  labelText: 'Digite o nome do curso',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  filled: true,
                  fillColor: Color.fromARGB(255, 232, 232, 232),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text('Universidade:',
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
              TextField(
                onChanged: (text) {
                  setState(() {});
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                  labelText: 'Digite o nome do universidade',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  filled: true,
                  fillColor: Color.fromARGB(255, 232, 232, 232),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Text('Inicio:',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                        labelText: 'Digite o nome do universidade',
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        filled: true,
                        fillColor: Color.fromARGB(255, 232, 232, 232),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Text('Fim:',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                        labelText: 'Digite o nome do universidade',
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        filled: true,
                        fillColor: Color.fromARGB(255, 232, 232, 232),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
