import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/app/app_shared.dart';
import 'package:questionnaire/app/di.dart';
import 'package:questionnaire/domain/model/make_form_template/QuestionOptionModel.dart';
import 'package:questionnaire/domain/model/make_form_template/form_model.dart';
import 'package:questionnaire/domain/model/make_form_template/question_item_model.dart';
import 'package:questionnaire/presentation/resources/color_manager.dart';
import 'package:questionnaire/screens/forms/viewmodel/forms_viewmodel.dart';
import 'package:questionnaire/screens/make_form_template/viewmodel/make_form_template_viewmodel.dart';
import 'package:questionnaire/utils/colors/appColors.dart';
import 'package:shared_module/Widget/toaster.widget.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:shared_module/service/custom.validators.dart';
import 'package:shared_module/theme/app-input-decoration.theme.dart';
import 'package:shared_module/theme/app.theme.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/model/from_model.dart';


class BuildFormsScreens extends StatefulWidget {
  LocalFormModel form;
  bool isEdit;
  int? formIndex;
  bool? validLocation;
   BuildFormsScreens({required this.form,required this.isEdit,this.formIndex,this.validLocation});

  @override
  State<BuildFormsScreens> createState() => _BuildFormsScreensState();
}

class _BuildFormsScreensState extends State<BuildFormsScreens> {

  final MakeFormTemplateViewModel _viewModel = instance<MakeFormTemplateViewModel>();



  //QuestionairesViewModel
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  selectQuestionType(){
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.blackColor.withOpacity(0.0),
      // shape: RoundedRectangleBorder(
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(32),
      //     topRight: Radius.circular(32),
      //   ),
      // ),

      isScrollControlled: true,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async{
            _viewModel.selectedQuestionType ;
            _viewModel.postDataToView();
            return true;
          },
          child: FractionallySizedBox(
            heightFactor: 0.2,
            child: StatefulBuilder(
              builder: (BuildContext context, setState) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child:  Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        //  borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.withOpacity(0.6))
                        ),
                        padding: EdgeInsets.only(left: 8 ,right: 8 , top: 22),
                        child: DropdownButtonFormField<FormItemType>(
                            decoration:  InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.2),
                              border: InputBorder.none,
                            ),
                            iconSize:  20,
                            // icon: SvgPicture.asset(
                            //     Assets.assetsSvgImagesIconAwesomeMapMarkerAlt.path),
                            value: _viewModel.selectedQuestionType,
                            style: TextStyle(
                                fontSize: 16,
                                ),
                            hint: Text(
                              //"surveySelectQuestionType" : "Select Question Type",
                              SharedLocalization.getLocalization!().surveySelectQuestionType,
                              style: TextStyle(
                                  fontSize: 16,
                                  ),
                            ),
                            onChanged: (value) {
                              if (_viewModel.selectedQuestionType != value) {
                                _viewModel.selectedQuestionType = value ?? FormItemType.ShortText;
                                addQuestionModel( _viewModel.selectedQuestionType! );
                              }
                            },
                            items: List.generate(
                              AppShared.questionTypeList.length,
                                  (index) => DropdownMenuItem(
                                child: Text(
                                  AppShared.questionTypeList[index].name,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                value: AppShared.questionTypeList[index].questionType,
                              ),
                            )),
                      ),
                    ),
                  ),



                  // Container(
                  //   color: AppTheme.whiteColor,
                  //   child: GestureDetector(
                  //     onTap: (){
                  //       addQuestionModel( _viewModel.selectedQuestionType );
                  //     },
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 14),
                  //       child: Container(
                  //         width: double.infinity,
                  //         height: 48,
                  //         decoration: BoxDecoration(
                  //           color: AppTheme.secondaryColor,
                  //             borderRadius: BorderRadius.circular(8)
                  //         ),
                  //         child: Center(
                  //           child: Text(SharedLocalization.getLocalization!().next,
                  //             style: TextStyle(
                  //               fontSize: 24,
                  //               fontWeight: FontWeight.bold,
                  //               color: AppColors.whiteColor
                  //             ),),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )

                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      _viewModel.selectedQuestionType=null;
      _viewModel.postDataToView();
    });
  }


  addQuestionModel(FormItemType selectedQuestionType){
    TextEditingController questionController = TextEditingController();
    List<Option> options=[];
    final formkey = GlobalKey<FormState>();

    if(selectedQuestionType == FormItemType.SingleChoice || selectedQuestionType == FormItemType.MultiChoice){
      options.add(Option(
          optionController:TextEditingController(),
          isHide: false
      ));
    }
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteColor,
      // shape: RoundedRectangleBorder(
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(32),
      //     topRight: Radius.circular(32),
      //   ),
      // ),

      isScrollControlled: true,
      builder: (context) {
        print("selectedQuestionType ======= $selectedQuestionType");
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for the keyboard
            ),
            child: StatefulBuilder(
              builder: (BuildContext context, setState) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 22,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${SharedLocalization.getLocalization!().surveyQuestionType}',style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,

                                    ),),

                                    Text('   ${selectedQuestionType.index==1?

                                    SharedLocalization.getLocalization!().shortText:
                                    selectedQuestionType.index==0?
                                    SharedLocalization.getLocalization!().longText:
                                    selectedQuestionType.index==2?
                                    SharedLocalization.getLocalization!().singleChoice:

                                    selectedQuestionType.index==3?
                                    SharedLocalization.getLocalization!().multiChoice:

                                    selectedQuestionType.index==4?
                                    SharedLocalization.getLocalization!().number:

                                    selectedQuestionType.index==5?
                                    SharedLocalization.getLocalization!().float:

                                    selectedQuestionType.index==6?
                                    SharedLocalization.getLocalization!().date:
                                    selectedQuestionType.index==7?
                                    SharedLocalization.getLocalization!().time:
                                        ""

                                    }',style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),),


                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  //  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.withOpacity(0.6))
                              ),
                              padding: EdgeInsets.only(left: 8 ,right: 8 , top: 0),
                              child: Form(
                                key: formkey,
                                child: TextFormField(
                                    controller: questionController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 6,
                                    minLines: 1,
                                    autofocus: false,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:  16),
                                    inputFormatters: [
                                      // LengthLimitingTextInputFormatter(
                                      //     AppConsts.chatMessageMaxLength),
                                    ],
                                    onChanged: (value) {

                                    },
                                    onTap: () {

                                    },
                                    validator: (val){
                                      if(val?.isEmpty ?? false){
                                        return SharedLocalization.getLocalization!().surveyFiledRequired;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                        fontSize: 14,
                                      ),
                                      errorMaxLines: 2,
                                      hintText:
                                      SharedLocalization.getLocalization!().surveyWriteQuestion,
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                       16),

                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                          top: 4, left: 6, right: 6),
                                      // suffixIcon: Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                                      //   mainAxisSize: MainAxisSize.min, // added line
                                      //   children: [
                                      //
                                      //
                                      //
                                      //   ],
                                      // ),

                                      fillColor:
                                      Colors.white.withOpacity(0.2),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(4.0),
                                        borderSide:  BorderSide(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(4.0),
                                        borderSide:  BorderSide(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      ),
                                      focusedErrorBorder:
                                      OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              4.0),
                                          borderSide: BorderSide(
                                            color: ColorManager.error,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(4.0),
                                          borderSide: BorderSide(
                                            color: ColorManager.error,
                                          )),
                                    )),
                              ),
                            ),
                            SizedBox(height: 12,),
                            Container(
                              color: Colors.white,
                                child: ElevatedButton(


                                    onPressed: () => setState(() => _viewModel.isRequired = !_viewModel.isRequired),


                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                                      elevation: WidgetStateProperty.all<double>(0),
                                    ),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: Checkbox(
                                                  value: _viewModel.isRequired,
                                                  activeColor: AppTheme.accentColor,
                                                  onChanged: (value){
                                                    setState(() => _viewModel.isRequired = value ?? false);
                                                  }
                                              )
                                          ),
                                          // You can play with the width to adjust your
                                          // desired spacing
                                          SizedBox(width: 10.0),
                                          Text(SharedLocalization.getLocalization!().surveyIsRequired,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,

                                          ),
                                          )
                                        ]
                                    )
                                )
                            ),

                            selectedQuestionType == FormItemType.SingleChoice ||
                            selectedQuestionType == FormItemType.MultiChoice ?
                            Container(
                              color: Colors.white,
                              child: ReorderableListView.builder(
                                itemCount: options.length,
                                shrinkWrap: true,
                                primary: false,
                                onReorderStart: (int x){
                                  FocusScope.of(context).unfocus();

                                },
                                onReorder: (oldIndex, newIndex) {
                                  setState(() {
                                    if (newIndex > oldIndex) {
                                      newIndex -= 1;
                                    }
                                    final item = options.removeAt(oldIndex);
                                    options.insert(newIndex, item);
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return Padding(
                                    key: ValueKey(options[index]), // Ensure unique keys
                                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: options[index].optionController,
                                            keyboardType: TextInputType.multiline,
                                            maxLines: 6,
                                            minLines: 1,
                                            autofocus: false,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                            onChanged: (value) {},
                                            onTap: () {},
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                fontSize: 14,
                                              ),
                                              errorMaxLines: 2,
                                              hintText:
                                              "${SharedLocalization.getLocalization!().surveyWriteOption} ${index + 1}",
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                              filled: true,
                                              contentPadding: EdgeInsets.only(top: 4, left: 6, right: 6),
                                              fillColor: Colors.white.withOpacity(0.2),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.3),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withOpacity(0.3),
                                                ),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                                borderSide: BorderSide(
                                                  color: ColorManager.error,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4.0),
                                                borderSide: BorderSide(
                                                  color: ColorManager.error,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 8,),
                                            GestureDetector(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 8.0, right: 1),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppTheme.accentColor,
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                    child: Icon(Icons.add, color: ColorManager.white, size: 16),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                options.add(Option(optionController:TextEditingController(), isHide: false));
                                                setState(() {});
                                              },
                                            ),

                                            GestureDetector(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 8.0, right: 1),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  //  color: AppTheme.errorColor,
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                    child: Icon(Icons.hide_source_sharp,
                                                        color:
                                                        (options[index].isHide ?? false) ?
                                                        ColorManager.primary:
                                                        ColorManager.grey, size: 16),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                  options[index].isHide = !(options[index].isHide ?? false);
                                                  setState(() {});

                                              },
                                            ),

                                            GestureDetector(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 8.0, right: 1),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppTheme.errorColor,
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(3.0),
                                                    child: Icon(Icons.close, color: ColorManager.white, size: 16),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                if (options.length > 1) {
                                                  options.removeAt(index);
                                                  setState(() {});
                                                }
                                              },
                                            ),

                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                              ),
                                              child: Icon(Icons.reorder, color: ColorManager.grey2, size: 32),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                                :SizedBox()



                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    color: AppTheme.whiteColor,
                    child: GestureDetector(
                      onTap: (){
                        if(formkey.currentState?.validate() ?? false){
                          _viewModel.dynamicFormModel.formName= _viewModel.formName.text;
                          _viewModel.dynamicFormModel.questions.add(Question(
                              question: questionController.text,
                              questionType: _viewModel.selectedQuestionType?.index,
                              options: options,
                              isRequired: _viewModel.isRequired,
                              // validators: []
                          ));
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 14),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor,
                             borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text(SharedLocalization.getLocalization!().surveyAddQuestion,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor
                              ),),
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      _viewModel.isRequired=false;
    });
  }


  editQuestionModel(FormItemType selectedQuestionType, Question question,int questionIndex){
    TextEditingController questionController = TextEditingController();
    questionController.text=question.question ?? '';
    List<Option>? options=[];
    options=question.options;
    _viewModel.isRequired = question.isRequired ?? false;

    final formkey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteColor,
      // shape: RoundedRectangleBorder(
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(32),
      //     topRight: Radius.circular(32),
      //   ),
      // ),

      isScrollControlled: true,
      builder: (context) {
        print("selectedQuestionType ======= $selectedQuestionType");
        return


          FractionallySizedBox(
            heightFactor: 0.8,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: StatefulBuilder(
                builder: (BuildContext context, setState) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 22,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${SharedLocalization.getLocalization!().surveyQuestionType}',style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,

                                        ),),

                                        Text('   ${selectedQuestionType.name}',style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),),


                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12,),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      //  borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey.withOpacity(0.6))
                                  ),
                                  padding: EdgeInsets.only(left: 8 ,right: 8 , top: 0),
                                  child: Form(
                                    key: formkey,
                                    child: TextFormField(
                                        controller: questionController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 6,
                                        minLines: 1,
                                        autofocus: false,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:  16),
                                        inputFormatters: [
                                          // LengthLimitingTextInputFormatter(
                                          //     AppConsts.chatMessageMaxLength),
                                        ],
                                        onChanged: (value) {

                                        },
                                        onTap: () {

                                        },
                                        validator: (val){
                                          if(val?.isEmpty ?? false){
                                            return SharedLocalization.getLocalization!().surveyFiledRequired;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                            fontSize: 14,
                                          ),
                                          errorMaxLines: 2,
                                          hintText:
                                          SharedLocalization.getLocalization!().surveyWriteQuestion,
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize:
                                              16),

                                          filled: true,
                                          contentPadding: EdgeInsets.only(
                                              top: 4, left: 6, right: 6),
                                          // suffixIcon: Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                                          //   mainAxisSize: MainAxisSize.min, // added line
                                          //   children: [
                                          //
                                          //
                                          //
                                          //   ],
                                          // ),

                                          fillColor:
                                          Colors.white.withOpacity(0.2),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(4.0),
                                            borderSide:  BorderSide(
                                              color: Colors.grey.withOpacity(0.3),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(4.0),
                                            borderSide:  BorderSide(
                                              color: Colors.grey.withOpacity(0.3),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  4.0),
                                              borderSide: BorderSide(
                                                color: ColorManager.error,
                                              )),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.0),
                                              borderSide: BorderSide(
                                                color: ColorManager.error,
                                              )),
                                        )),
                                  ),
                                ),
                                SizedBox(height: 12,),
                                Container(
                                    color: Colors.white,
                                    child: ElevatedButton(


                                        onPressed: () => setState(() => _viewModel.isRequired = !_viewModel.isRequired),


                                        style: ButtonStyle(
                                          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                                          elevation: WidgetStateProperty.all<double>(0),
                                        ),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: 24.0,
                                                  width: 24.0,
                                                  child: Checkbox(
                                                      value: _viewModel.isRequired,
                                                      activeColor: AppTheme.accentColor,
                                                      onChanged: (value){
                                                        setState(() => _viewModel.isRequired = value ?? false);
                                                      }
                                                  )
                                              ),
                                              // You can play with the width to adjust your
                                              // desired spacing
                                              SizedBox(width: 10.0),
                                              Text(SharedLocalization.getLocalization!().surveyIsRequired,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,

                                                ),
                                              )
                                            ]
                                        )
                                    )
                                ),

                                selectedQuestionType == FormItemType.SingleChoice ||
                                    selectedQuestionType == FormItemType.MultiChoice ?
                                Container(
                                  color: Colors.white,
                                  child: ReorderableListView.builder(
                                    itemCount: options?.length ?? 0,
                                    shrinkWrap: true,
                                    primary: false,
                                    onReorderStart: (int x){
                                      FocusScope.of(context).unfocus();
                                    },
                                    onReorder: (oldIndex, newIndex) {
                                      setState(() {
                                        if (newIndex > oldIndex) {
                                          newIndex -= 1;
                                        }
                                        final item = options?.removeAt(oldIndex);
                                        options?.insert(newIndex, item!);
                                      });
                                    },
                                    //  physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      return Padding(
                                        key: ValueKey(options?[index]), // Unique Key for ReorderableListView
                                        padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                  controller: options?[index].optionController,
                                                  keyboardType: TextInputType.multiline,
                                                  maxLines: 6,
                                                  minLines: 1,
                                                  autofocus: false,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:  16),
                                                  inputFormatters: [
                                                    // LengthLimitingTextInputFormatter(
                                                    //     AppConsts.chatMessageMaxLength),
                                                  ],
                                                  onChanged: (value) {

                                                  },
                                                  onTap: () {

                                                  },
                                                  decoration: InputDecoration(
                                                    errorStyle: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    errorMaxLines: 2,
                                                    hintText:
                                                    "${SharedLocalization.getLocalization!().surveyWriteOption} ${index+1}",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize:
                                                        16),

                                                    filled: true,
                                                    contentPadding: EdgeInsets.only(
                                                        top: 4, left: 6, right: 6),
                                                    // suffixIcon: Row(
                                                    //   mainAxisAlignment: MainAxisAlignmentaceBetween, // added line
                                                    //   mainAxisSize: MainAxisSize.min, // added line
                                                    //   children: [
                                                    //
                                                    //
                                                    //
                                                    //   ],
                                                    // ),

                                                    fillColor:
                                                    Colors.white.withOpacity(0.2),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(4.0),
                                                      borderSide:  BorderSide(
                                                        color: Colors.grey.withOpacity(0.3),
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(4.0),
                                                      borderSide:  BorderSide(
                                                        color: Colors.grey.withOpacity(0.3),
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                        borderSide: BorderSide(
                                                          color: ColorManager.error,
                                                        )),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(4.0),
                                                        borderSide: BorderSide(
                                                          color: ColorManager.error,
                                                        )),
                                                  )),
                                            ),

                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 8,),
                                                GestureDetector(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 8.0, right: 1),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppTheme.accentColor,
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(3.0),
                                                        child: Icon(Icons.add, color: ColorManager.white, size: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    options?.add(Option(optionController:TextEditingController(), isHide: false));
                                                    setState(() {});
                                                  },
                                                ),

                                                GestureDetector(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 8.0, right: 1),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        //  color: AppTheme.errorColor,
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(3.0),
                                                        child: Icon(Icons.hide_source_sharp,
                                                            color:
                                                           ( options?[index].isHide ?? false) ?
                                                            ColorManager.primary:
                                                            ColorManager.grey, size: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    options?[index].isHide = !(options?[index].isHide ?? false);
                                                    setState(() {});

                                                  },
                                                ),

                                                GestureDetector(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 8.0, right: 1),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppTheme.errorColor,
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(3.0),
                                                        child: Icon(Icons.close, color: ColorManager.white, size: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    if ((options?.length ?? 0) > 1) {
                                                      options?.removeAt(index);
                                                      setState(() {});
                                                    }
                                                  },
                                                ),

                                                Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.transparent,
                                                  ),
                                                  child: Icon(Icons.reorder, color: ColorManager.grey2, size: 32),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ) :SizedBox()



                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        if(formkey.currentState?.validate() ?? false){
                          _viewModel.dynamicFormModel.formName= _viewModel.formName.text;
                          _viewModel.dynamicFormModel.questions[questionIndex]= Question(
                              question: questionController.text,
                              questionType: question.questionType ?? 0,
                              options: options,
                              isRequired: _viewModel.isRequired,
                             // validators: []
                          );
                          Navigator.pop(context);
                        }

                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor,
                          // borderRadius: BorderRadius.circular(12.r)
                        ),
                        child: Center(
                          child: Text(SharedLocalization.getLocalization!().surveyEditQuestion,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor
                            ),),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          );
      },
    ).then((value) {
      _viewModel.isRequired=false;
      setState(() {

      });
    });
  }



  // Currently selected form

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print("widget.formwidget.form............. ${widget.form.validLocation}");
      _viewModel.startViewModel( widget.form,widget.isEdit);
      if(!widget.isEdit){
        selectQuestionType();
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child:
        StreamBuilder<MakeFormTemplateUseCaseModel>(
            stream: _viewModel.outputMakeFormTemplateContent,
            builder: (context, snapshot) {
              MakeFormTemplateUseCaseModel? data = snapshot.data;
              return
                data != null ?
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 32,),

                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(

                            children: [
                              TextFormField(
                                controller: _viewModel.formName,
                                onTapOutside: (PointerDownEvent v){
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                },
                                decoration:
                                AppInputDecorationTheme.standardInput(
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      SharedLocalization
                                          .getLocalization!().surveyFormName,
                                    ),
                                  ),

                                  hintText: SharedLocalization
                                      .getLocalization!().surveyWriteFormName,
                                  isEnabled: false,
                                ),
                                validator: (value) {
                                  return CustomValidators.isEmptyValidator(
                                      value);
                                },
                                onChanged: (String val){
                                  _viewModel.dynamicFormModel.formName =val;
                                },
                              ),
                             SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Text(
                                    '${SharedLocalization.getLocalization!().verifySite}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Switch(
                                    value: _viewModel.validLocation,
                                    activeColor: AppTheme.whiteColor ,
                                    activeTrackColor: AppTheme.accentColor,
                                    inactiveThumbColor: AppTheme.whiteColor,
                                    inactiveTrackColor: const Color(0xffE5E5E5),
                                    onChanged: (bool value) {
                                      _viewModel.toggleLocation(value);
                                    },
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Text(
                                    '${SharedLocalization.getLocalization!().showSurveyID}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Switch(
                                    value: _viewModel.showSurveyID,
                                    activeColor: AppTheme.whiteColor ,
                                    activeTrackColor: AppTheme.accentColor,
                                    inactiveThumbColor: AppTheme.whiteColor,
                                    inactiveTrackColor: const Color(0xffE5E5E5),
                                    onChanged: (bool value) {
                                      _viewModel.toggleShowSurveyId(value);
                                    },
                                  ),
                                ],
                              ),





                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ReorderableListView.builder(
                          itemCount: _viewModel.dynamicFormModel.questions.length,
                          shrinkWrap: true,
                          primary: false,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex -= 1;
                              final item = _viewModel.dynamicFormModel.questions.removeAt(oldIndex);
                              _viewModel.dynamicFormModel.questions.insert(newIndex, item);
                            });
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              key: ValueKey(_viewModel.dynamicFormModel.questions[index]), // Unique Key for ReorderableListView
                              onTap: (){
                                        editQuestionModel(

                                          AppShared.getFormItemTypeByIndex(_viewModel.dynamicFormModel.questions[index].questionType ?? 1),
                                          _viewModel.dynamicFormModel.questions[index],
                                          index,
                                        );
                              },
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                margin: EdgeInsets.only(bottom: 12),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      /// **Row: Drag Handle & Delete Button**
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.drag_handle, color: Colors.grey), // Drag Indicator
                                              SizedBox(width: 8),
                                              Text(
                                                "Q${index + 1}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.deepPurple,
                                                ),
                                              ),
                                            ],
                                          ),


                                          Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.hide_source, color:
                                                (_viewModel.dynamicFormModel.questions[index].isHide??false)?
                                                AppTheme.primaryColor:
                                                Colors.grey),
                                                onPressed: () {
                                                  setState(() {
                                                    _viewModel.dynamicFormModel.questions[index].isHide=

                                                        !(_viewModel.dynamicFormModel.questions[index].isHide ?? false);
                                                  });
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.close, color: Colors.redAccent),
                                                onPressed: () {
                                                  setState(() {
                                                    _viewModel.dynamicFormModel.questions.removeAt(index);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      /// **Question Title**
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          _viewModel.dynamicFormModel.questions[index].question ?? '',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),

                                      /// **Question Type & Required Indicator**
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppShared.questionTypeList[_viewModel.dynamicFormModel.questions[index].questionType??0].name,                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (_viewModel.dynamicFormModel.questions[index].isRequired ?? false)
                                            Text(
                                              "${SharedLocalization.getLocalization!().surveyIsRequired}",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  // ReorderableListView.builder(
                  //   itemCount: _viewModel.dynamicFormModel.questions.length,
                  //   shrinkWrap: true,
                  //   primary: false,
                  //   onReorder: (oldIndex, newIndex) {
                  //     setState(() {
                  //       if (newIndex > oldIndex) {
                  //         newIndex -= 1;
                  //       }
                  //       final item = _viewModel.dynamicFormModel.questions.removeAt(oldIndex);
                  //       _viewModel.dynamicFormModel.questions.insert(newIndex, item);
                  //     });
                  //   },
                  //   itemBuilder: (context, index) {
                  //     return GestureDetector(
                  //       key: ValueKey(_viewModel.dynamicFormModel.questions[index]), // Ensure unique keys
                  //       onTap: () {
                  //         editQuestionModel(
                  //           _viewModel.dynamicFormModel.questions[index].questionType ?? FormItemType.ShortText,
                  //           _viewModel.dynamicFormModel.questions[index],
                  //           index,
                  //         );
                  //       },
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8.0),
                  //             border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  //           ),
                  //           child: Padding(
                  //             padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 SizedBox(height: 12),
                  //                 Row(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisAlignment: MainAxisAlignment.end,
                  //                   children: [
                  //                     GestureDetector(
                  //                       child: Icon(Icons.close, color: AppTheme.errorColor),
                  //                       onTap: () {
                  //                         _viewModel.dynamicFormModel.questions.removeAt(index);
                  //                         setState(() {});
                  //                       },
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Row(
                  //                       crossAxisAlignment: CrossAxisAlignment.center,
                  //                       mainAxisAlignment: MainAxisAlignment.start,
                  //                       children: [
                  //                         Container(
                  //                           width: MediaQuery.of(context).size.width * 0.6,
                  //                           child: Text(
                  //                             "${_viewModel.dynamicFormModel.questions[index].question}",
                  //                             style: TextStyle(
                  //                               color: Colors.black,
                  //                               fontSize: 16,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         SizedBox(width: 6),
                  //                         Text(
                  //                           _viewModel.dynamicFormModel.questions[index].isRequired ? '*' : '',
                  //                           style: TextStyle(
                  //                             color: Colors.red,
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.bold,
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     Text(
                  //                       _viewModel.dynamicFormModel.questions[index].questionType
                  //                           .toString()
                  //                           .replaceAll('FormItemType.', ''),
                  //                       style: TextStyle(
                  //                         fontSize: 16,
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 // if (_viewModel.dynamicFormModel.questions[index].options.length > 2)
                  //                 //   Container(
                  //                 //     width: double.infinity,
                  //                 //     height: 24,
                  //                 //     color: Colors.transparent,
                  //                 //     child: ListView.builder(
                  //                 //       itemCount: _viewModel.dynamicFormModel.questions[index].options.length,
                  //                 //       scrollDirection: Axis.horizontal,
                  //                 //       itemBuilder: (context, i) {
                  //                 //         return Text(
                  //                 //           "${_viewModel.dynamicFormModel.questions[index].options[i].optionController.text}, ",
                  //                 //           style: TextStyle(
                  //                 //             color: Colors.black,
                  //                 //             fontSize: 16,
                  //                 //             fontWeight: FontWeight.bold,
                  //                 //           ),
                  //                 //         );
                  //                 //       },
                  //                 //     ),
                  //                 //   ),
                  //                 SizedBox(height: 12),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // )

                  ],
                  ),
                ):const SizedBox();
            })

      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(left: 12.0,right:12.0,bottom: 12),
        child: ElevatedButton(
          onPressed: () async {
            if(_formKey.currentState!.validate()){

              if(_viewModel.dynamicFormModel.questions.isNotEmpty){
                print(" _viewModel.selectedFormId ${ _viewModel.selectedFormId?.name}");
                if(widget.isEdit){



                  FormModel res = await _viewModel.updateForm(
                      _viewModel.dynamicFormModel.id,
                      FormModel(
                      formName: _viewModel.formName.text,
                      validLocation:_viewModel.validLocation,
                      showSurveyId: _viewModel.showSurveyID,
                      questionnaireTime:_viewModel.dynamicFormModel.questionnaireTime,
                        isTemplate: true,
                      isActive: true,
                      questions: _viewModel.dynamicFormModel.questions,
                      originalFormMasterId: _viewModel.dynamicFormModel.originalFormMasterId,
                      isUsed: true
                  ));

                  allForms.items?[widget.formIndex ?? 0]=FormModel(
                      id: res.id,
                      formName: res.formName,
                      validLocation: res.validLocation,
                      showSurveyId: res.showSurveyId,
                      questions: res.questions,
                    questionnaireTime: res.questionnaireTime,
                    originalFormMasterId: res.originalFormMasterId

                  );
                }
                else{
                  FormModel res = await _viewModel.addForm(FormModel(
                    formName: _viewModel.formName.text,
                    validLocation:_viewModel.validLocation,
                    showSurveyId: _viewModel.showSurveyID,
                    questionnaireTime:DateTime.now(),
                    isTemplate: true,
                    isActive: true,
                    questions: _viewModel.dynamicFormModel.questions,
                    originalFormMasterId: const Uuid().v1(),
                    isUsed: true
                  ));
                  allForms.items?.add(FormModel(
                      id: res.id,
                      formName: _viewModel.formName.text,
                      validLocation: _viewModel.validLocation,
                      showSurveyId: _viewModel.showSurveyID,
                      questions: _viewModel.dynamicFormModel.questions));
                }
               Navigator.pop(context);
              }else{
                Toaster.error(
                    content: Text(SharedLocalization
                        .getLocalization!().survey_question_number_error));
              }

            }
          },
          child:  Text(
            widget.isEdit?
            SharedLocalization.getLocalization!().surveyEdit:
            SharedLocalization.getLocalization!().save,
          ),
        ),
      ),
      floatingActionButton:  FloatingActionButton(
          elevation: 0.0,
        //  backgroundColor: AppColors.blackColor,
          onPressed: (){
            selectQuestionType();
          },
          child:  const Icon(Icons.add,color: Colors.white,)
      ),
    );
  }
}
