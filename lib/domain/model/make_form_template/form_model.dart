
import 'package:questionnaire/domain/model/make_form_template/question_item_model.dart';

import '../client_model.dart';
import '../from_model.dart';

class LocalFormModel {
  String id;
  String? originalFormMasterId;
  String? formName;
  bool? validLocation;
  bool? showSurveyId;
  //ClientItemModel? customerName;
  DateTime? questionnaireTime;
  List<Question> questions = [];

  LocalFormModel(
      {
        required this.id,
       // this.customerName,
        this.formName,
        required this.questions ,
         this.validLocation ,
         this.showSurveyId ,
         this.questionnaireTime ,
         this.originalFormMasterId ,
       });
}


