import 'package:flutter/material.dart';

class ExperienceCard extends StatelessWidget {
  String title;
  String initialDate;
  String finalDate;
  String description;
  ExperienceCard(
      {super.key,
      required this.finalDate,
      required this.initialDate,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 2),
          child: Icon(
            Icons.circle,
            color: Colors.grey,
            size: 14,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              Text(
                "${initialDate} - ${finalDate}",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w300),
              ),
              Text(
                description,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w200),
              )
            ],
          ),
        ),
      ],
    );
  }
}
