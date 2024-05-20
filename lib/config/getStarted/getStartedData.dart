// Get started card options
import 'dart:convert';

import '../../model/get_started_page_card_choices_model.dart';

String cardsJson = '''[
    {
      "title": "Sağlık",
      "description": ""
    },
    {
      "title": "Egzersiz",
      "description": ""
    },
    {
      "title": "Diyet",
      "description": ""
    }
  ]''';

List<ChoiceCard> handledCardsList = List<ChoiceCard>.from(
  jsonDecode(cardsJson).map(
    (choiceCardJson) => ChoiceCard.fromJson(
      choiceCardJson,
    ),
  ),
);
