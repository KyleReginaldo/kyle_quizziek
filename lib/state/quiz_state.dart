// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_cubit.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuizModel> quizzes;
  QuizLoaded({
    required this.quizzes,
  });
}

class QuizLoading extends QuizState {}

class QuizEmpty extends QuizState {}
