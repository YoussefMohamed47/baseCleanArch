import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/QuestionOptionModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamic_form_validator.dart';

import '../from_model.dart';

class QuestionItemModel {
  String? question;
  FormItemType? questionType;

  List<Option> options;
  bool isRequired;

  bool isHide;
  //List<DynamicFormValidator> validators;
  QuestionItemModel(
      {
        this.question, this.questionType,
        this.options = const [],
        this.isRequired = false,
      //  this.validators = const [],
        this.isHide = false,

      });
}