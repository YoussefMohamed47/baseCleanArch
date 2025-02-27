import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:uuid/uuid.dart';
import '../domain/model/from_model.dart';
import '../domain/model/make_form_template/QuestionOptionModel.dart';
import '../domain/model/make_form_template/question_item_model.dart';
import '../presentation/resources/color_manager.dart';
import '../presentation/resources/font_manager.dart';
import '../screens/make_form_template/viewmodel/make_form_template_viewmodel.dart';
import 'Caching/generic_cache.dart';
import 'app_enums.dart';
import 'di.dart';

class AppShared {
  static final navKey = GlobalKey<NavigatorState>();
  static bool hasToken = false;
  static String token = '';
  static String remebertoken = '';
  static String deviceId = '';
  static GenericCache genericCache = GenericCache.instance;
  static noSupportAlert() {
    return showDialog(
        context: AppShared.navKey.currentContext!,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'ملف غير مدعوم',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorManager.mnsaColorlack,
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "صيغة هذا الملف غير مدعومة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorManager.secondTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          constraints: BoxConstraints(minWidth: 48.w),
                          decoration: BoxDecoration(
                            color: ColorManager.mnsaColorlack,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.0.w, vertical: 8.h),
                            child: Text(
                              'موافق',
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])
              ],
            ),
          );
        });
  }
  // List<QuestionItemModel> convertToQuestionItem(List<Question> questionItems) {
  //   return questionItems.map((item) {
  //     return QuestionItemModel(
  //       question: item.question,
  //       questionType: item.questionType != null
  //           ? FormItemType.values[item.questionType!] // Convert int to enum
  //           : null,
  //       options: item.options?.map((opt) => QuestionOptionModel(
  //        TextEditingController(text: opt.option), // Assuming QuestionOptionModel has 'option' field
  //         isHide: opt.isHide ?? false, // Assuming QuestionOptionModel has 'isHide' field
  //       )).toList() ?? [],
  //       isRequired: item.isRequired ?? false,
  //       isHide: item.isHide ?? false,
  //     );
  //   }).toList();
  // }
 static  FormItemType getFormItemTypeByIndex(int index) {
    return FormItemType.values[index];
  }


  static List<Question> convertQuestions(List<QuestionItemModel> questionItems) {
    return questionItems.map((item) {
      int questionId =const Uuid().v4().hashCode.abs();
      return Question(
        id: 0,
        question: item.question ?? '',
        questionType: item.questionType?.index, // Convert enum to int
        options: item.options.map((opt) => Option(
          id:0 , //const Uuid().v4().hashCode.abs()
          option: opt.optionController?.text,
          questionId: questionId,
          isHide: opt.isHide, // Assuming QuestionOptionModel has 'isHide' field
        )).toList(),
        isRequired: item.isRequired,
        isHide: item.isHide,
      );
    }).toList();
  }


  static List<QuestionTypeModel> questionTypeList = [
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
}
