class QuizModel {
  String question;
  List<String> choices;
  int answer;
  int? currentAnswer;

  QuizModel({
    required this.question,
    required this.choices,
    required this.answer,
    this.currentAnswer,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        question: json["question"],
        choices: List<String>.from(json["choices"].map((x) => x)),
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "choices": List<dynamic>.from(choices.map((x) => x)),
        "answer": answer,
      };
}
