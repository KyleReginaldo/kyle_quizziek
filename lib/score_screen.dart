// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'quiz_model.dart';

class ScoreScreen extends StatelessWidget {
  final List<QuizModel> quizzez;
  const ScoreScreen({
    super.key,
    required this.quizzez,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(
              Icons.home,
            ),
          ),
        ],
      ),
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
                  ),
                ),
                Text(
                  'My answer: ${e.choices[e.currentAnswer ?? 0]}',
                  style: TextStyle(
                    fontSize: 14,
                    color: (e.currentAnswer ?? 0) == e.answer
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Correct answer: ${e.choices[e.answer]}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
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
