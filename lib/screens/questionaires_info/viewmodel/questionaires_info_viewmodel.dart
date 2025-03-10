import 'dart:async';
import 'dart:math';

import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/QuestionOptionModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamicModel.dart';
import 'package:questionnaire/domain/model/make_form_template/form_model.dart';
import 'package:questionnaire/domain/usecase/make_form_template_usecase.dart';
import 'package:shared_module/app_services/attachment.app_service.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import 'package:questionnaire/presentation/base/baseviewmodel.dart';

import '../../../domain/model/from_model.dart';
import '../../../domain/repository/forms/forms_repo.dart';

class QuestionairesInfoViewModel extends BaseViewModel with QuestionairesInfoViewModelInput, QuestionairesInfoViewModelOutput {
  QuestionairesInfoViewModel() : super();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  StreamController<QuestionairesInfoUseCaseModel> _questionairesInfoStreamController = StreamController<QuestionairesInfoUseCaseModel>.broadcast();
  final QuestionairesInfoUseCaseModel _model =
  QuestionairesInfoUseCaseModel();

  int? selectedQuestionType ;

  bool isRequired=false;
  AttachmentAppService attachmentAppService = AttachmentAppService();

  LocalFormModel dynamicFormModel = LocalFormModel

    (
      id:   const Uuid().v1(),
      formName: "form 1",questions: []);
  // final MakeFormTemplateUseCase _questionairesUseCase;

  // output
  @override
  void dispose() {
    _questionairesInfoStreamController.close();
  }

  @override
  Sink get inputQuestionairesInfoInput =>
      _questionairesInfoStreamController.sink;

  @override
  Stream<QuestionairesInfoUseCaseModel> get outputQuestionairesInfoContent =>
      _questionairesInfoStreamController.stream.map((home) => home);

  FormRepository formRepo = FormRepository();


  FormModel surveyData =FormModel();


  Future<FormModel> submitSurvey(FormModel input ) async {
    return await  formRepo.updateFormDetail(id: input.id ?? '' ,input:  input);
  }
  Future<FormModel> addSurvey(FormModel input ) async {
    return await  formRepo.addForm(input);
  }
  Future<FormModel> getQuestionaireQuestion({required String surveyId}) async {
     surveyData= await formRepo.getFormDetail(id: surveyId);
     return surveyData;
  }
  @override
  Future start() async {
    if (_questionairesInfoStreamController.isClosed) {
      _questionairesInfoStreamController =
      StreamController<QuestionairesInfoUseCaseModel>.broadcast();
    }
    print("get questions ......");
    //  await getTermsAndConditions();
    postDataToView();
  }

  postDataToView() {
    if (!_questionairesInfoStreamController.isClosed) {
      inputQuestionairesInfoInput.add(_model);
    }
  }

}

mixin QuestionairesInfoViewModelInput {
  Sink get inputQuestionairesInfoInput;
}

mixin QuestionairesInfoViewModelOutput {
  Stream<QuestionairesInfoUseCaseModel> get outputQuestionairesInfoContent;
}

class QuestionairesInfoUseCaseModel {
  QuestionairesInfoUseCaseModel();

}
