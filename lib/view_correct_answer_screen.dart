// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'quiz_model.dart';

class ViewCorrectAnswerScreen extends StatelessWidget {
  final List<QuizModel> quizzez;
  const ViewCorrectAnswerScreen({
    super.key,
    required this.quizzez,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: quizzez.map((e) {
          return Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${quizzez.indexOf(e) + 1}. ${e.question}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: e.choices
                      .map((ee) => Text(
                            '${e.choices.indexOf(ee) + 1}.$ee',
                            style: TextStyle(
                                fontWeight: ee == e.choices[e.answer]
                                    ? FontWeight.w500
                                    : FontWeight.w300,
                                color: ee == e.choices[e.answer]
                                    ? Colors.green
                                    : Colors.black),
                          ))
                      .toList(),
                ),
                Text(
                  'Correct answer: ${e.choices[e.answer]}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
