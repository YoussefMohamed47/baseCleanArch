import 'dart:async';
import 'dart:math';

import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/ItemModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamicModel.dart';
import 'package:questionnaire/domain/model/make_form_template/form_model.dart';
import 'package:questionnaire/domain/usecase/make_form_template_usecase.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import 'package:questionnaire/presentation/base/baseviewmodel.dart';
List<FormModel> allQuestionaires = [];
class QuestionairesViewModel extends BaseViewModel with QuestionairesViewModelInput, QuestionairesViewModelOutput {
  QuestionairesViewModel(this._questionairesUseCase) : super();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  StreamController<QuestionairesUseCaseModel> _questionairesStreamController = StreamController<QuestionairesUseCaseModel>.broadcast();
  final QuestionairesUseCaseModel _model =
  QuestionairesUseCaseModel();


  int? selectedQuestionType ;

  bool isRequired=false;
  FormModel dynamicFormModel = FormModel

    (
    id:    Random().nextInt(100),
      formName: "form 1",questions: []);
  final MakeFormTemplateUseCase _questionairesUseCase;

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

  // input
  @override
  Future start() async {
    if (_questionairesStreamController.isClosed) {
      _questionairesStreamController =
      StreamController<QuestionairesUseCaseModel>.broadcast();
    }
    //  await getTermsAndConditions();
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
