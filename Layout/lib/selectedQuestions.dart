import 'package:Layout/flashcard_model.dart';
import 'package:Layout/question.dart';

import 'data.dart';

List<Question> selectedQuestions = flashcardModels.map((e) {
  if (e.hasReminder) {
    return Question(
      e.question,
      e.options,
      data[flashcardModels.indexOf(e)],
      0,
      e,
    );
  }
}).toList();
