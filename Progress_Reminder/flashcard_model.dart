// import 'package:Layout/data.dart';
import 'package:flutter/material.dart';
import 'data.dart';

class FlashcardModel {
  String title;
  int id;
  bool hasLevel;
  bool isDaily;
  String shortDescription;
  Map badge;
  Map visualization;
  Color color;
  Map difficulty;
  List<String> longDescription;
  int currentLevel;
  String question;
  List<String> options;
  bool hasReminder;
  Map category;
  int frequency;
  DateTime lastShown = DateTime(2000);
  DateTime timeAnswered = DateTime(2000);

  FlashcardModel({
    this.title,
    this.id,
    this.hasLevel,
    this.isDaily,
    this.shortDescription,
    this.badge,
    this.visualization,
    this.color,
    this.longDescription,
    this.currentLevel,
    this.question,
    this.options,
    this.hasReminder,
    this.category,
    this.difficulty,
    this.frequency,
  });
}

List<FlashcardModel> flashcardModels = data
    .map((e) => FlashcardModel(
  badge: e["badge"],
  category: e["category"],
  color: Color(e["color"]),
  difficulty: e["difficulty"],
  currentLevel: e["currentLevel"],
  hasLevel: e["hasLevel"],
  hasReminder: e["hasReminder"],
  id: e["id"],
  isDaily: e["isDaily"],
  longDescription: e["longDescription"],
  options: e["options"],
  question: e["question"],
  shortDescription: e["shortDescription"],
  title: e["title"],
  visualization: e["visualization"],
  frequency: e["frequency"],
))
    .toList();