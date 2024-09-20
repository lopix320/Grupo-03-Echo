import 'package:flutter/material.dart';

class FormationCard extends StatelessWidget {
  String universidade;
  String curso;
  String finalDate;
  String initialDate;
  FormationCard(
      {super.key,
      required this.finalDate,
      required this.initialDate,
      required this.universidade,
      required this.curso});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          universidade,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        Text(
          curso,
          style: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w200),
        ),
        Text(
          "${initialDate} - ${finalDate}",
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
