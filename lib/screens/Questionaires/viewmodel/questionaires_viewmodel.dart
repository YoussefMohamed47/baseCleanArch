import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/QuestionOptionModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamicModel.dart';
import 'package:questionnaire/domain/model/make_form_template/form_model.dart';
import 'package:questionnaire/domain/usecase/make_form_template_usecase.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import 'package:questionnaire/presentation/base/baseviewmodel.dart';

import '../../../domain/model/from_model.dart';
import '../../../domain/model/make_form_template/form_list.dart';
import '../../../domain/repository/forms/forms_repo.dart';
List<FormModel> allQuestionaires = [];
class QuestionairesViewModel extends BaseViewModel with QuestionairesViewModelInput, QuestionairesViewModelOutput {
  QuestionairesViewModel() : super();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  StreamController<QuestionairesUseCaseModel> _questionairesStreamController = StreamController<QuestionairesUseCaseModel>.broadcast();
  final QuestionairesUseCaseModel _model =
  QuestionairesUseCaseModel();


  String? selectedQuestionType ;
  ValueNotifier<List<FormModel>> filteredQuestionnaires = ValueNotifier([]);


  bool isRequired=false;
  LocalFormModel dynamicFormModel = LocalFormModel

    (
    id:    const Uuid().v1(),
      formName: "form 1",questions: []);
  // final MakeFormTemplateUseCase _questionairesUseCase;

  // output
  @override
  void dispose() {
    _questionairesStreamController.close();
  }

  @override
  Sink get inputQuestionairesInput =>
      _questionairesStreamController.sink;

  @override
  Stream<QuestionairesUseCaseModel> get outputQuestionairesContent =>
      _questionairesStreamController.stream.map((home) => home);

  FormRepository formRepo = FormRepository();

  FormListModel res = FormListModel();
  bool isLoading = false;
  // input
  @override
  Future start() async {
    if (_questionairesStreamController.isClosed) {
      _questionairesStreamController =
      StreamController<QuestionairesUseCaseModel>.broadcast();
    }

    print("before ......... $isLoading");
    res = await formRepo.getForm(isTemplate: false);
    allQuestionaires = res.items ?? [];
    filteredQuestionnaires.value = res.items ?? [];
    postDataToView();
  }

  postDataToView() {
    if (!_questionairesStreamController.isClosed) {
      inputQuestionairesInput.add(_model);
    }
  }

}

mixin QuestionairesViewModelInput {
  Sink get inputQuestionairesInput;
}

mixin QuestionairesViewModelOutput {
  Stream<QuestionairesUseCaseModel> get outputQuestionairesContent;
}

class QuestionairesUseCaseModel {

  QuestionairesUseCaseModel();

}
