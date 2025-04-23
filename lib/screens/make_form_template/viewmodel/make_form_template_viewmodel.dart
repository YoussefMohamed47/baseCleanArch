import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/app/app_shared.dart';
import 'package:questionnaire/domain/model/client_model.dart';
import 'package:questionnaire/domain/model/make_form_template/QuestionOptionModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamicModel.dart';
import 'package:questionnaire/domain/model/make_form_template/form_model.dart';
import 'package:questionnaire/domain/usecase/make_form_template_usecase.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import 'package:questionnaire/presentation/base/baseviewmodel.dart';

import '../../../domain/model/from_model.dart';
import '../../../domain/repository/forms/forms_repo.dart';

class MakeFormTemplateViewModel extends BaseViewModel
    with MakeFormTemplateViewModelInput, MakeFormTemplateViewModelOutput {
  MakeFormTemplateViewModel() : super();

  final AppPreferences _appPreferences = instance<AppPreferences>();


  StreamController<MakeFormTemplateUseCaseModel>
  _makeFormTemplateStreamController =
  StreamController<MakeFormTemplateUseCaseModel>.broadcast();
  final MakeFormTemplateUseCaseModel _model =
  MakeFormTemplateUseCaseModel();


  FormRepository formRepo = FormRepository();
  FormItemType? selectedQuestionType ;
//=FormItemType.ShortText
  bool isRequired=false;
  LocalFormModel dynamicFormModel = LocalFormModel(  id:const Uuid().v1(),formName: "",questions: []);
  TextEditingController formName = TextEditingController();
  ClientItemModel? selectedFormId;

  bool validLocation = true;
  bool showSurveyID = true;

  toggleLocation(bool val){
    validLocation =val;
    postDataToView();
  }

  toggleShowSurveyId(bool val){
    showSurveyID =val;
    postDataToView();
  }


  // final MakeFormTemplateUseCase _makeFormTemplateUseCase;

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
  startViewModel(LocalFormModel form, bool isEdit) async {

    if (_makeFormTemplateStreamController.isClosed) {
      _makeFormTemplateStreamController =
      StreamController<MakeFormTemplateUseCaseModel>.broadcast();
    }
    
    dynamicFormModel = form;
    print("dynamicFormModel.customerName ${dynamicFormModel.showSurveyId}");
    formName.text= dynamicFormModel.formName ?? '';
    // validLocation = dynamicFormModel.validLocation ?? true;
    // showSurveyID = dynamicFormModel.showSurveyId ?? true;
    validLocation = true;
    showSurveyID =  true;
    dynamicFormModel.originalFormMasterId = form.originalFormMasterId ;


    if(isEdit){
      FormModel res= await formRepo.getFormDetail(id: dynamicFormModel.id);
      print("object:::::: ${res.questions?.length}");
      //AppShared.convertQuestions(questionItems);
      dynamicFormModel.questions = res.questions ?? [];
      dynamicFormModel.questionnaireTime = res.questionnaireTime;
      formName.text= res.formName ?? '';
      // validLocation = res.validLocation ?? true;
      // showSurveyID = res.showSurveyId ?? true;
      validLocation =  true;
      showSurveyID =  true;
      dynamicFormModel.originalFormMasterId = res.originalFormMasterId ;

    }

    //selectedFormId= allClients[0];//dynamicFormModel.customerName;

    // if(dynamicFormModel.customerName?.name != null){
    //   selectedFormId = allClients.firstWhere(
    //         (client) => client.id == dynamicFormModel.customerName?.id,);
    // }

    //  await getTermsAndConditions();
    postDataToView();
  }


  Future<FormModel> addForm(FormModel input ) async {
    return await  formRepo.addForm( input);
  }

  Future<FormModel> updateForm(String id , FormModel input ) async {
    return await  formRepo.updateFormDetail(
      id: id,input: input
    );
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
