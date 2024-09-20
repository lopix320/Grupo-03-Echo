import 'package:flutter/material.dart';

class ExperienceInfo extends StatefulWidget {
  List experienceInfo;
  dynamic setState;

  ExperienceInfo({
    super.key,
    required this.experienceInfo,
    required this.setState,
  });

  @override
  State<ExperienceInfo> createState() => _ExperienceInfoState();
}

class _ExperienceInfoState extends State<ExperienceInfo> {
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
                child: Text('Empresa:',
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
                  labelText: 'Digite o nome da empresa',
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
                child: Text('Título do cargo:',
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
                  labelText: 'Digite o título do cargo:',
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
                    width: 110,
                    height: 40,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                        labelText: '01/2024',
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
                    width: 110,
                    height: 40,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                        labelText: '12/2024',
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
