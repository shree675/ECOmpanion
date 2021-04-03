// import 'package:Layout/flashcard_model.dart';
// import 'package:Layout/question.dart';
import 'flashcard_model.dart';
import 'question.dart';
import 'data.dart';

List<Question> selectedQuestions = flashcardModels.map((e) {
  if (e.isDaily) {
    return Question(e.question, e.options, data[flashcardModels.indexOf(e)], 0,
        e, flashcardModels.indexOf(e));
  }
}).toList();
