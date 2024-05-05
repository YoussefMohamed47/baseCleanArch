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

class QuestionairesInfoViewModel extends BaseViewModel with QuestionairesInfoViewModelInput, QuestionairesInfoViewModelOutput {
  QuestionairesInfoViewModel(this._questionairesUseCase) : super();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  StreamController<QuestionairesInfoUseCaseModel> _questionairesInfoStreamController = StreamController<QuestionairesInfoUseCaseModel>.broadcast();
  final QuestionairesInfoUseCaseModel _model =
  QuestionairesInfoUseCaseModel();

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
    _questionairesInfoStreamController.close();
  }

  @override
  Sink get inputQuestionairesInfoInput =>
      _questionairesInfoStreamController.sink;

  @override
  Stream<QuestionairesInfoUseCaseModel> get outputQuestionairesInfoContent =>
      _questionairesInfoStreamController.stream.map((home) => home);

  // input
  @override
  Future start() async {
    if (_questionairesInfoStreamController.isClosed) {
      _questionairesInfoStreamController =
      StreamController<QuestionairesInfoUseCaseModel>.broadcast();
    }
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
