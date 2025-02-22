import 'package:questionnaire/app/app_enums.dart';

class QuestionairesItem {
  final String question;
  final FormItemType questionType;
   List<OptionQuestionnaireModel>? options;
  final bool isRequired;
  final bool isHide;


  QuestionairesItem({
    required this.question,
    required this.questionType,
    this.options,
    required this.isRequired,
    required this.isHide,
  });
}


class OptionQuestionnaireModel{

  String option;
  bool isHide;

  OptionQuestionnaireModel({required this.option,required this.isHide});
}
