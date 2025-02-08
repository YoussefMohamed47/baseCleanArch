import 'package:questionnaire/app/app_enums.dart';

class FormItem {
  final String question;
  final FormItemType questionType;
   List<OptionQuestionnaireModel>? options;
  final bool isRequired;
  final bool isHide;

  FormItem({
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
