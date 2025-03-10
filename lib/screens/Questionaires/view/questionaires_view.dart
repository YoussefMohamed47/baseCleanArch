import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:questionnaire/app/di.dart';
import 'package:questionnaire/domain/model/make_form_template/questionaires_item.dart';
import 'package:questionnaire/presentation/resources/base_page_route.dart';
import 'package:questionnaire/screens/Questionaires/viewmodel/questionaires_viewmodel.dart';
import 'package:questionnaire/screens/add_questioaires/view/add_questioaires_view.dart';
import 'package:questionnaire/screens/build_questionnaire_form/view/build_questionnaire_form_view.dart';
import 'package:questionnaire/screens/forms/viewmodel/forms_viewmodel.dart';
import 'package:questionnaire/screens/make_form_template/view/make_form_template_view.dart';
import 'package:questionnaire/screens/questionaires_info/view/questionaires_info_view.dart';
import 'package:questionnaire/utils/colors/appColors.dart';
import 'package:shared_module/Widget/app_scaffold.dart';
import 'package:shared_module/Widget/no_items_found_indicator.wdiget.dart';
import 'package:shared_module/Widget/primary_container.widget.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:shared_module/theme/app.theme.dart';
import 'package:shared_module/theme/shared.icons.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app_enums.dart';
import '../../../app/app_shared.dart';
import '../../../domain/model/client_model.dart';
import '../../../domain/model/from_model.dart';
import '../../../domain/model/make_form_template/form_model.dart';
import '../../../presentation/resources/color_manager.dart';


class QuestionairesView extends StatefulWidget {
  bool isQuestionnaires;
  QuestionairesView({required this.isQuestionnaires});

  @override
  State<QuestionairesView> createState() => _QuestionairesViewState();
}

class _QuestionairesViewState extends State<QuestionairesView> {

  ValueNotifier<bool>? isFiltering;
  final QuestionairesViewModel _viewModel =
  instance<QuestionairesViewModel>();


  addQuestionaires(QuestionairesUseCaseModel? data){
    final formkey = GlobalKey<FormState>();
    TextEditingController customerNameController = TextEditingController();
    LocalFormModel temp =LocalFormModel(id:const Uuid().v1(),questions: [],formName: "");
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
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
            _viewModel.selectedQuestionType = null;
            _viewModel.postDataToView();
            return true;
          },
          child: Padding(
            padding:  EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: FractionallySizedBox(
              heightFactor: 0.32,
              child: Container(
                color: Colors.white,
                child: StatefulBuilder(
                  builder: (BuildContext context, setState) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child:  Column(
                                children: [
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
                                          controller: customerNameController,
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
                                            // temp.customerName =
                                            //     ClientItemModel(id: 0, name: value);
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
                                            border: InputBorder.none,
                                            errorStyle: TextStyle(
                                              fontSize: 14,
                                            ),
                                            errorMaxLines: 2,
                                            hintText:
                                            SharedLocalization.getLocalization!().surveyWriteCustomerName,
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
                                                  color: ColorManager.error
                                                )),
                                          )),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        //  borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey.withOpacity(0.6))
                                    ),
                                    padding: EdgeInsets.only(left: 8 ,right: 8 , top: 22),
                                    child: DropdownButtonFormField<String?>(
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
                                          SharedLocalization.getLocalization!().surveySelectForm,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          // if (_viewModel.selectedQuestionType != value) {
                                          //   _viewModel.selectedQuestionType = value;
                                          //   LocalFormModel selectedForm = allForms.where((element) => element.id==value).first;
                                          //   temp.id =const Uuid().v1();
                                          //   temp.formName=selectedForm.formName;
                                          //   temp.questions=selectedForm.questions;
                                          // }
                                        },
                                        items: List.generate(
                                          allForms.items?.length ?? 0,
                                              (index) => DropdownMenuItem(
                                            value: allForms.items?[index].id,
                                            child: Text(
                                              allForms.items?[index].formName ??'',
                                              style: const TextStyle(
                                                  color: Colors.black, fontSize: 16),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),



                      Container(
                        color: AppTheme.whiteColor,
                        child: GestureDetector(
                          onTap: (){
                           // addQuestionModel( _viewModel.selectedQuestionType );
                            if(formkey.currentState?.validate() ?? false){
                            //  allQuestionaires.add(temp);
                              Navigator.pop(context);
                            }

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 14),
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: AppTheme.secondaryColor,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(
                                child: Text(SharedLocalization.getLocalization!().next,
                                  style: TextStyle(
                                      fontSize: 24,
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
            ),
          ),
        );
      },
    ).then((value) {
      _viewModel.selectedQuestionType = null;
      _viewModel.postDataToView();
    });
  }
  List<FormModel> localQuestionnaires=[];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _viewModel.isLoading =true;
      setState(() {});
      await _viewModel.start();
      _viewModel.isLoading =false;
      setState(() {});
      // localQuestionnaires=allQuestionaires;
      // filteredQuestionnaires.value=allQuestionaires;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {}); // Forces UI rebuild
  }
  List<FormModel> searchForms(String searchKey) {
    final lowerKey = searchKey.toLowerCase();
    return localQuestionnaires.where((form) {
      final matchesId = form.id.toString().contains(searchKey);
      final matchesFormName = form.formName?.toLowerCase().contains(lowerKey) ?? false;
      // final matchesClientName = form.customerName?.name.toLowerCase().contains(lowerKey) ?? false;

      // Check if the searchKey matches the index
      final matchesIndex = (localQuestionnaires.indexOf(form)+1).toString() == searchKey;

      return matchesId || matchesFormName
          //|| matchesClientName
          || matchesIndex;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return  AppScaffold(
      currentPageName: CurrentPageNameEnum.invoiceScreen,
      searchHintText: SharedLocalization
          .getLocalization!().surveySearchQuestionnaires,
      pageTitle: SharedLocalization
          .getLocalization!().surveyQuestionnaires,
      onSearchFunction: (value) async {
        if (value.trim() == '') {
          filteredQuestionnaires.value = localQuestionnaires;
        } else {
          filteredQuestionnaires.value = searchForms(value);
        }
      },
      body: SingleChildScrollView(
        child:


        ValueListenableBuilder<List<FormModel>>(
          valueListenable: filteredQuestionnaires,
          builder: (context, forms, child) {
            print("filteredQuestionnaires........ ${forms.length}");
            return

              Column(
                children: [
                  _viewModel.isLoading?
                  SizedBox():
                  forms.isEmpty ?
                  SizedBox(
                    height:600,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NoItemsFoundIndicatorWidget()
                      ],
                    ),
                  ) :
                  ListView.builder(
                      itemCount: forms.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context ,index){
                        return GestureDetector(
                          onTap: (){


                            if(widget.isQuestionnaires){
                              // List<QuestionairesItem> temp = [];
                              // for(int i =0 ; i < forms[index].questions.length ; i ++){
                              //   List<OptionQuestionnaireModel> options = [];
                              //   for(int o =0 ; o < (forms[index].questions[i].options?.length ?? 0); o ++){
                              //     for(int j =0 ; j < forms[index].questions[i].options![o].optionController!.text.split(",").length ; j ++){
                              //       options.add(
                              //
                              //           OptionQuestionnaireModel(
                              //             option: forms[index].questions[i].options![o].optionController!.text.split(",")[j],
                              //             isHide: forms[index].questions[i].options![o].isHide ?? false
                              //           )
                              //           );
                              //     }
                              //   }
                              //   temp.add(QuestionairesItem(question:forms[index].questions[i].question ?? '',
                              //       questionType:
                              //       AppShared.getFormItemTypeByIndex(forms[index].questions[i].questionType ?? 1),
                              //       isRequired:  forms[index].questions[i].isRequired ?? false,
                              //       options:options,
                              //     isHide:  forms[index].questions[i].isHide ?? false
                              //   ));
                              // }
                              // Navigator.push(
                              //     context,
                              //     BasePageRoute(
                              //         builder: (context) => DynamicForm(
                              //           formName: data.allQuestionaires[index].formName ?? '',
                              //           formItems:  temp,
                              //
                              //         )));
                              Navigator.push(
                                  context,
                                  BasePageRoute(
                                      builder: (context) => QuestionairesInfoView(
                                        formName: forms[index].formName ?? '',
                                        formItems:  forms[index].questions ?? [],
                                        // customerName:forms[index].customerName,
                                        validLocation: forms[index].validLocation ?? false,
                                        surveyId: forms[index].id ?? '',
                                        showSurveyId: forms[index].showSurveyId ?? false,
                                        questionnaireTime: forms[index].questionnaireTime ?? DateTime.now(),
                                        isForm: false ,

                                      )));
                            }else{

                            }
                          },
                          child: PrimaryContainer(

                            child: Container(
                              //height: 120,
                              width: double.infinity,
                              // color: Colors.white,
                              child:Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border:
                                              Border.all(color: AppTheme.borderColor),
                                              color:  AppTheme.orangeColor
                                          ),
                                          child: Icon(
                                            SharedIcons.invoiceIcon,
                                            color: AppTheme.whiteColor,
                                            size: 25,),

                                        ),
                                        SizedBox(width: 8,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width:270,
                                              color: Colors.transparent,
                                              child: Text(forms[index].formName ??'',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                ),),
                                            ),
                                            const SizedBox(height: 3,),
                                            Text("  ${
                                                (forms [index].showSurveyId ?? false)?
                                                forms [index].id : ''}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,

                                                )),

                                          ],
                                        ),


                                      ],
                                    ),
                                  ],
                                ),
                              ) ,
                            ),
                          ),
                        );
                      }),
                ],
              );
          },
        ),

      ),
      floatingActionButton:
      FloatingActionButton(
          elevation: 0.0,
          //  backgroundColor: AppColors.blackColor,
          onPressed: () async {
            //addQuestionaires(data);
            await Navigator.push(
                context,
                BasePageRoute(
                    builder: (context) => AddQuestionairesView(
                     // data: data,
                      questionViewModel: _viewModel,
                    )));
            setState(() {

            });

          },
          child:  const Icon(Icons.add,color: Colors.white,)
      )
      // StreamBuilder<QuestionairesUseCaseModel>(
      //     stream: _viewModel.outputQuestionairesContent,
      //     builder: (context, snapshot) {
      //       QuestionairesUseCaseModel? data = snapshot.data;
      //       return
      //         data != null ?
      //         FloatingActionButton(
      //             elevation: 0.0,
      //             //  backgroundColor: AppColors.blackColor,
      //             onPressed: () async {
      //               //addQuestionaires(data);
      //               await Navigator.push(
      //                   context,
      //                   BasePageRoute(
      //                       builder: (context) => AddQuestionairesView(
      //                            data: data,
      //                            questionViewModel: _viewModel,
      //                       )));
      //               setState(() {
      //
      //               });
      //
      //             },
      //             child:  const Icon(Icons.add,color: Colors.white,)
      //         ):SizedBox();
      //     })

    );
  }
}
