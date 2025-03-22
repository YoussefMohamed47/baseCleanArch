import 'dart:async';
import 'dart:math';

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


//List<LocalFormModel> allForms = [];
FormListModel allForms=FormListModel();


class FormsViewModel extends BaseViewModel with FormsViewModelInput, FormsViewModelOutput {
  FormsViewModel() : super();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  FormRepository formRepo = FormRepository();

  StreamController<FormsUseCaseModel> _formsStreamController = StreamController<FormsUseCaseModel>.broadcast();
  final FormsUseCaseModel _model =
  FormsUseCaseModel();

  FormItemType selectedQuestionType =FormItemType.ShortText;

  bool isRequired=false;
  LocalFormModel dynamicFormModel = LocalFormModel(
      id: const Uuid().v1(),
      formName: "form 1",questions: []);
  // final MakeFormTemplateUseCase _formsUseCase;

  // output
  @override
  void dispose() {
    _formsStreamController.close();
  }

  @override
  Sink get inputFormsInput =>
      _formsStreamController.sink;

  @override
  Stream<FormsUseCaseModel> get outputMakeFormTemplateContent =>
      _formsStreamController.stream.map((home) => home);

  bool isLoading=false;
  // input
  @override
  Future start() async {
    if (_formsStreamController.isClosed) {
      _formsStreamController =
      StreamController<FormsUseCaseModel>.broadcast();
    }
    isLoading = true;
    postDataToView();
    //  await getTermsAndConditions();
    allForms=FormListModel();
    allForms = await formRepo.getForm(isTemplate: true);
    isLoading = false;
    postDataToView();
  }


  Future<FormModel> changeFormActiveStatus({required String id,required FormModel input}) async {
    FormModel res = await formRepo.updateFormDetail(id: id,input: input);
    return res;
  }
  postDataToView() {
    if (!_formsStreamController.isClosed) {
      inputFormsInput.add(_model);
    }
  }

}

mixin FormsViewModelInput {
  Sink get inputFormsInput;
}

mixin FormsViewModelOutput {
  Stream<FormsUseCaseModel> get outputMakeFormTemplateContent;
}

class FormsUseCaseModel {
  FormsUseCaseModel();

}
