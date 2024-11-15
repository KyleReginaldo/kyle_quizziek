import 'package:bloc/bloc.dart';
import 'package:kyle_quizziek/questions.dart';
import 'package:meta/meta.dart';

import '../quiz_model.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  void onGetQuiz({int? count}) {
    emit(QuizLoading());
    Future.delayed(const Duration(seconds: 1));
    final quiz = INSYY55;

    final quizzzes = quiz.map((e) {
      return QuizModel.fromJson(e);
    }).toList();
    emit(QuizLoaded(quizzes: quizzzes.take(count ?? quizzzes.length).toList()));
  }
}
