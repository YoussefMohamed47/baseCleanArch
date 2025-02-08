import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/ItemModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamic_form_validator.dart';
import 'package:questionnaire/domain/model/make_form_template/question_item_model.dart';

import '../client_model.dart';

class FormModel {
  String id;
  String? formName;

  bool? validLocation;
  bool? showSurveyId;
  ClientItemModel? customerName;
  DateTime? questionnaireTime;
  List<QuestionItemModel> questions = [];

  FormModel(
      {
        required this.id,
        this.customerName,
        this.formName,
        required this.questions ,
         this.validLocation ,
         this.showSurveyId ,
         this.questionnaireTime ,
       });
}