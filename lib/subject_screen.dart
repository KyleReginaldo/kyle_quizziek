// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyle_quizziek/score_screen.dart';
import 'package:kyle_quizziek/state/quiz_cubit.dart';

class SubjectScreen extends StatefulWidget {
  final int? count;
  final String subject;
  const SubjectScreen({
    super.key,
    this.count,
    required this.subject,
  });

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final pageConroller = PageController();
  @override
  void initState() {
    context.read<QuizCubit>().onGetQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const LinearProgressIndicator();
          }
          if (state is QuizLoaded) {
            final quizzes = state.quizzes;
            return PageView(
              controller: pageConroller,
              physics: const NeverScrollableScrollPhysics(),
              children: quizzes.map((e) {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                          '${quizzes.indexOf(e) + 1}/${widget.count ?? quizzes.length} '),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        child: Text(
                          e.question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Column(
                        children: e.choices.map((choice) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                e.currentAnswer = e.choices.indexOf(choice);
                              });
                            },
                            leading: Checkbox(
                              value:
                                  e.choices.indexOf(choice) == e.currentAnswer,
                              onChanged: (bool? value) {},
                            ),
                            title: Text(
                              choice,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      if (quizzes.indexOf(e) == quizzes.length - 1 ||
                          widget.count == quizzes.indexOf(e) + 1)
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(
                              Size(
                                MediaQuery.sizeOf(context).width * 0.8,
                                44,
                              ),
                            ),
                            backgroundColor: const MaterialStatePropertyAll(
                              Colors.black,
                            ),
                            foregroundColor: const MaterialStatePropertyAll(
                              Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (e.currentAnswer != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScoreScreen(
                                            quizzez: quizzes
                                                .take(widget.count ??
                                                    quizzes.length)
                                                .toList(),
                                          )));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'please select an answer',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(8),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text('View score'),
                        ),
                      if (quizzes.indexOf(e) < quizzes.length - 1 &&
                          !(widget.count == quizzes.indexOf(e) + 1))
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(
                              Size(
                                MediaQuery.sizeOf(context).width * 0.8,
                                44,
                              ),
                            ),
                            backgroundColor: const MaterialStatePropertyAll(
                              Colors.black,
                            ),
                            foregroundColor: const MaterialStatePropertyAll(
                              Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (e.currentAnswer != null) {
                              pageConroller.jumpToPage(quizzes.indexOf(e) + 1);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'please select an answer',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(8),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text('Next'),
                        ),
                      const SizedBox(height: 8),
                      if (quizzes.indexOf(e) > 0)
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(
                              Size(
                                MediaQuery.sizeOf(context).width * 0.8,
                                44,
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.grey.shade200,
                            ),
                            foregroundColor: const MaterialStatePropertyAll(
                              Colors.black,
                            ),
                          ),
                          onPressed: () {
                            pageConroller.jumpToPage(quizzes.indexOf(e) - 1);
                          },
                          child: const Text('back'),
                        ),
                    ],
                  ),
                );
              }).toList(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
