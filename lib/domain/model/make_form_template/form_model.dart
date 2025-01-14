import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/ItemModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamic_form_validator.dart';
import 'package:questionnaire/domain/model/make_form_template/question_item_model.dart';

import '../client_model.dart';

class FormModel {
  int id;
  String? formName;
  ClientItemModel? customerName;
  List<QuestionItemModel> questions = [];

  FormModel(
      {
        required this.id,
        this.customerName,
        this.formName,
        required this.questions ,
       });
}