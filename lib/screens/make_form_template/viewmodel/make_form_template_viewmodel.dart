import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/client_model.dart';
import 'package:questionnaire/domain/model/make_form_template/ItemModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamicModel.dart';
import 'package:questionnaire/domain/model/make_form_template/form_model.dart';
import 'package:questionnaire/domain/usecase/make_form_template_usecase.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import 'package:questionnaire/presentation/base/baseviewmodel.dart';

class MakeFormTemplateViewModel extends BaseViewModel
    with MakeFormTemplateViewModelInput, MakeFormTemplateViewModelOutput {
  MakeFormTemplateViewModel(this._makeFormTemplateUseCase) : super();

  final AppPreferences _appPreferences = instance<AppPreferences>();


  StreamController<MakeFormTemplateUseCaseModel>
  _makeFormTemplateStreamController =
  StreamController<MakeFormTemplateUseCaseModel>.broadcast();
  final MakeFormTemplateUseCaseModel _model =
  MakeFormTemplateUseCaseModel();

  FormItemType? selectedQuestionType ;
//=FormItemType.ShortText
  bool isRequired=false;
  FormModel dynamicFormModel = FormModel(  id:const Uuid().v1(),formName: "",questions: []);
  TextEditingController formName = TextEditingController();
  ClientItemModel? selectedFormId;

  bool validLocation = false;
  bool showSurveyID = false;

  toggleLocation(bool val){
    validLocation =val;
    postDataToView();
  }

  toggleShowSurveyId(bool val){
    showSurveyID =val;
    postDataToView();
  }

  List<QuestionTypeModel> questionTypeList = [
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.ShortText] ?? 2,
    "${SharedLocalization.getLocalization!().shortText}",
        FormItemType.ShortText
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.LongText] ?? 1,
        "${SharedLocalization.getLocalization!().longText}",
        FormItemType.LongText
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.SingleChoice] ?? 3,
    '${SharedLocalization.getLocalization!().singleChoice}',
        FormItemType.SingleChoice
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.MultiChoice] ?? 4,
    '${SharedLocalization.getLocalization!().multiChoice}',
        FormItemType.MultiChoice
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.Number] ?? 5,
    '${SharedLocalization.getLocalization!().number}',
        FormItemType.Number
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.Float] ?? 6,
    '${SharedLocalization.getLocalization!().float}',
        FormItemType.Float
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.Date] ?? 7,
    '${SharedLocalization.getLocalization!().date} ',
        FormItemType.Date
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.Time] ?? 8,
    '${SharedLocalization.getLocalization!().time}',
        FormItemType.Time
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.Attachment] ?? 9,
    '${SharedLocalization.getLocalization!().attachment}',
        FormItemType.Attachment
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.Location] ?? 10,
    '${SharedLocalization.getLocalization!().location}',
        FormItemType.Location
    ),
    QuestionTypeModel(FormItemTypeEnum.toInt[FormItemType.Location] ?? 11,
    '${SharedLocalization.getLocalization!().client}',
        FormItemType.Client
    ),


  ];
  final MakeFormTemplateUseCase _makeFormTemplateUseCase;

  // output
  @override
  void dispose() {
    _makeFormTemplateStreamController.close();
  }

  @override
  Sink get inputMakeFormTemplateInput =>
      _makeFormTemplateStreamController.sink;

  @override
  Stream<MakeFormTemplateUseCaseModel> get outputMakeFormTemplateContent =>
      _makeFormTemplateStreamController.stream.map((home) => home);

  // input
  @override
  Future start() async {

  }

  List<ClientItemModel> allClients = [
    ClientItemModel(id: 1, name: 'عميل رقم ١'),
    ClientItemModel(id: 2, name: 'عميل رقم ٢'),
    ClientItemModel(id: 3, name: 'عميل رقم ٣'),
  ];
  startViewModel(FormModel form) {

    if (_makeFormTemplateStreamController.isClosed) {
      _makeFormTemplateStreamController =
      StreamController<MakeFormTemplateUseCaseModel>.broadcast();
    }
    dynamicFormModel = form;
    print("dynamicFormModel.customerName ${dynamicFormModel.showSurveyId}");
    formName.text= dynamicFormModel.formName ?? '';
    validLocation = dynamicFormModel.validLocation ?? false;
    showSurveyID = dynamicFormModel.showSurveyId ?? false;
    //selectedFormId= allClients[0];//dynamicFormModel.customerName;

    if(dynamicFormModel.customerName?.name != null){
      selectedFormId = allClients.firstWhere(
            (client) => client.id == dynamicFormModel.customerName?.id,);
    }

    //  await getTermsAndConditions();
    postDataToView();
  }

  postDataToView() {
    if (!_makeFormTemplateStreamController.isClosed) {
      inputMakeFormTemplateInput.add(_model);
    }
  }

}

mixin MakeFormTemplateViewModelInput {
  Sink get inputMakeFormTemplateInput;
}

mixin MakeFormTemplateViewModelOutput {
  Stream<MakeFormTemplateUseCaseModel> get outputMakeFormTemplateContent;
}

class MakeFormTemplateUseCaseModel {
  MakeFormTemplateUseCaseModel();

}

class QuestionTypeModel{
  int id;
  String name;
  FormItemType questionType;
  QuestionTypeModel(this.id,this.name,this.questionType);
}
