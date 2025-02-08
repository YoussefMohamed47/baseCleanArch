import 'dart:async';
import 'dart:math';

import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/ItemModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamicModel.dart';
import 'package:questionnaire/domain/model/make_form_template/form_model.dart';
import 'package:questionnaire/domain/usecase/make_form_template_usecase.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import 'package:questionnaire/presentation/base/baseviewmodel.dart';

class AddQuestionairesViewModel extends BaseViewModel with AddQuestionairesViewModelInput, AddQuestionairesViewModelOutput {
  AddQuestionairesViewModel(this._questionairesUseCase) : super();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  StreamController<AddQuestionairesUseCaseModel> _addQuestionairesStreamController = StreamController<AddQuestionairesUseCaseModel>.broadcast();
  final AddQuestionairesUseCaseModel _model =
  AddQuestionairesUseCaseModel();

  int? selectedQuestionType ;

  bool isRequired=false;
  FormModel dynamicFormModel = FormModel

    (
      id:    const Uuid().v1(),
      formName: "form 1",questions: []);
  final MakeFormTemplateUseCase _questionairesUseCase;

  // output
  @override
  void dispose() {
    _addQuestionairesStreamController.close();
  }

  @override
  Sink get inputAddQuestionairesInput =>
      _addQuestionairesStreamController.sink;

  @override
  Stream<AddQuestionairesUseCaseModel> get outputAddQuestionairesContent =>
      _addQuestionairesStreamController.stream.map((home) => home);

  // input
  @override
  Future start() async {
    if (_addQuestionairesStreamController.isClosed) {
      _addQuestionairesStreamController =
      StreamController<AddQuestionairesUseCaseModel>.broadcast();
    }
    //  await getTermsAndConditions();
    postDataToView();
  }

  postDataToView() {
    if (!_addQuestionairesStreamController.isClosed) {
      inputAddQuestionairesInput.add(_model);
    }
  }

}

mixin AddQuestionairesViewModelInput {
  Sink get inputAddQuestionairesInput;
}

mixin AddQuestionairesViewModelOutput {
  Stream<AddQuestionairesUseCaseModel> get outputAddQuestionairesContent;
}

class AddQuestionairesUseCaseModel {
  List<FormModel> allQuestionaires = [];
  AddQuestionairesUseCaseModel();

}
