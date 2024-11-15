// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyle_quizziek/subject_screen.dart';
import 'package:kyle_quizziek/view_correct_answer_screen.dart';

import 'state/quiz_cubit.dart';

class CountScreen extends StatefulWidget {
  final String subject;
  const CountScreen({
    super.key,
    required this.subject,
  });

  @override
  State<CountScreen> createState() => _CountScreenState();
}

class _CountScreenState extends State<CountScreen> {
  @override
  void initState() {
    context.read<QuizCubit>().onGetQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const LinearProgressIndicator();
          } else if (state is QuizLoaded) {
            return Column(
              children: [
                buildCount(count: 20),
                buildCount(count: 40),
                buildCount(count: 60),
                buildCount(count: 80),
                buildCount(count: null),
                const Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.black),
                    fixedSize: MaterialStatePropertyAll(Size(
                      MediaQuery.sizeOf(context).width - 16,
                      40,
                    )),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewCorrectAnswerScreen(
                          quizzez: state.quizzes,
                        ),
                      ),
                    );
                  },
                  child: const Text('View all answer'),
                ),
                const SizedBox(height: 8),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget buildCount({int? count}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectScreen(
              count: count,
              subject: widget.subject,
            ),
          ),
        );
      },
      splashColor: Colors.black,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: MediaQuery.sizeOf(context).width,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text('${count ?? 'All'} Items'),
      ),
    );
  }
}
