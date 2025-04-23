import 'package:flutter/cupertino.dart';

class FormModel {
  String? formName;
  String? id;
  String? code;
  bool? validLocation;
  bool? showSurveyId;
  DateTime? questionnaireTime;
  List<Question>? questions;
  int? questionsCount;
  bool? isUsed;
  bool? isActive;
  bool? isTemplate;
  String? lat;
  String? lng;

  String? originalFormMasterId;


  FormModel({
    this.id,
    this.code,
    this.formName,
    this.validLocation,
    this.showSurveyId,
    this.questionnaireTime,
    this.questions,
    this.questionsCount,
    this.isUsed,
    this.isActive,
    this.isTemplate,
    this.lat,
    this.lng,
    this.originalFormMasterId,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      id: json['id'],
      code: json['code'],
      formName: json['formName'],
      validLocation: json['validLocation'],
      showSurveyId: json['showSurveyId'],
      questionnaireTime: json['questionnaireTime'] != null ? DateTime.parse(json['questionnaireTime']).toLocal() : null,
      questions: json['questions'] != null ? (json['questions'] as List).map((q) => Question.fromJson(q)).toList() : null,
      questionsCount: json['questionsCount'] ?? 0,
      isUsed: json['isUsed'],
      isActive: json['isActive'],
      isTemplate: json['isTemplate'],
      lat: json['lat'],
      lng: json['lng'],
      originalFormMasterId: json['originalFormMasterId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'formName': formName,
      'validLocation': validLocation,
      'showSurveyId': showSurveyId,
      'questionnaireTime': questionnaireTime?.toUtc().toIso8601String(),
      'questions': questions?.map((q) => q.toJson()).toList(),
      'questionsCount': questions?.length ?? 0,
      'isUsed': isUsed,
      'isActive': isActive,
      'isTemplate': isTemplate,
      'lat':lat,
      'lng':lng,
      'originalFormMasterId': (isTemplate ?? true) ? null:originalFormMasterId,
    };
  }
}

class Question {
  int? id;
  int? itemOrder;
  String question;
  dynamic answer;
  int? questionType;
  List<Option>? options;
  bool isRequired;
  bool isHide;
  bool isUsed;

  Question({
    this.id,
    this.itemOrder,
    this.question='',
    this.answer,
    this.questionType,
    this.options,
    this.isRequired=false,
    this.isHide =false,
    this.isUsed =false,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      itemOrder: json['itemOrder'],
      question: json['question'],
      answer: json['answer'],
      questionType: json['questionType'],
      options: json['options'] != null ? (json['options'] as List).map((o) => Option.fromJson(o)).toList() : null,
      isRequired: json['isRequired'],
      isHide: json['isHide'],
      isUsed: json['isUsed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'question': question,
      'itemOrder': itemOrder,
      'answer': answer,
      'questionType': questionType,
      'options': options?.map((o) => o.toJson()).toList(),
      'isRequired': isRequired ?? false,
      'isHide': isHide ,
      'isUsed': isUsed,
    };
  }
}

class Option {
  int? id;
  int? itemOrder;
  String? option;
  bool? isHide;
  bool isUsed;
  String? tenantId;
  int? questionId;
  TextEditingController? optionController;


  Option({
    this.id,
    this.itemOrder,
    this.option,
    this.isHide,
    this.isUsed =false,
    this.tenantId,
    this.questionId,
    TextEditingController? optionController,
  }) : optionController = optionController ?? TextEditingController(text: option);

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      itemOrder: json['itemOrder'],
      option: json['option'],
      isHide: json['isHide'] ?? false,
      isUsed: json['isUsed'] ?? false,
      tenantId: json['tenantId'],
      questionId: json['questionId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'itemOrder': itemOrder ?? 0,
      'option': option,
      'isUsed': isUsed ,
      'isHide': isHide ?? false,
      'tenantId': tenantId,
      'questionId': questionId ?? 0,
    };
  }
}
