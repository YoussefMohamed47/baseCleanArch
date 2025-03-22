import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:questionnaire/app/di.dart';
import 'package:questionnaire/screens/Questionaires/viewmodel/questionaires_viewmodel.dart';
import 'package:questionnaire/screens/forms/viewmodel/forms_viewmodel.dart';
import 'package:shared_module/Widget/app_scaffold.dart';
import 'package:shared_module/Widget/primary_container.widget.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:shared_module/theme/app.theme.dart';
import 'package:shared_module/theme/shared.icons.dart';
import '../../../domain/model/from_model.dart';
import '../../../presentation/resources/base_page_route.dart';
import '../../questionaires_info/view/questionaires_info_view.dart';
import '../viewmodel/add_questioaires_viewmodel.dart';


class AddQuestionairesView extends StatefulWidget {
  //QuestionairesUseCaseModel? data;
  QuestionairesViewModel questionViewModel;
  AddQuestionairesView({
    //required this.data
  //  ,
  required this.questionViewModel});

  @override
  State<AddQuestionairesView> createState() => _AddQuestionairesViewState();
}

class _AddQuestionairesViewState extends State<AddQuestionairesView> {

  ValueNotifier<bool>? isFiltering;
  final AddQuestionairesViewModel _viewModel =
  instance<AddQuestionairesViewModel>();

  final formkey = GlobalKey<FormState>();
  TextEditingController customerNameController = TextEditingController();
  FormModel questionairesTemp =FormModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
       _viewModel.start().then((onValue){
         setState(() {});
       });


      print("allForms.lengthallForms.length ${allForms.items?.length}");
// if(allForms.items?.length==1){
//
//   FormModel selectedForm = allForms.items.first;
//   questionairesTemp =selectedForm;
//
//     allQuestionaires.add(LocalFormModel(
//         id: const Uuid().v1(),
//         questions: questionairesTemp.questions,
//         formName: questionairesTemp.formName,
//         customerName: questionairesTemp.customerName,
//         showSurveyId: questionairesTemp.showSurveyId,
//         validLocation: questionairesTemp.validLocation,
//         questionnaireTime: DateTime.now()
//
//     ));
//     print("gjhkjlhj ${allQuestionaires.length}");
//     Navigator.pop(context);
//
//     List<QuestionairesItem> temp2 = [];
//     for(int i =0 ; i < questionairesTemp.questions.length ; i ++){
//
//
//       List<OptionQuestionnaireModel> options = [];
//       for(int o =0 ; o < questionairesTemp.questions[i].options.length ; o ++){
//         for(int j =0 ; j < questionairesTemp.questions[i].options[o].optionController.text.split(",").length ; j ++){
//           options.add(
//
//
//               OptionQuestionnaireModel(
//                   option: questionairesTemp.questions[i].options[o].optionController.text.split(",")[j],
//                   isHide: questionairesTemp.questions[i].options[o].isHide
//               )
//               );
//         }
//       }
//       temp2.add(QuestionairesItem(question:questionairesTemp.questions[i].question ?? '',
//           questionType: questionairesTemp.questions[i].questionType ?? FormItemType.ShortText,
//           isRequired:  questionairesTemp.questions[i].isRequired,
//           options:options,
//         isHide:  questionairesTemp.questions[i].isHide
//       ));
//     }
//     // Navigator.push(
//     //     context,
//     //     BasePageRoute(
//     //         builder: (context) => DynamicForm(
//     //           formName: data.allQuestionaires[index].formName ?? '',
//     //           formItems:  temp,
//     //
//     //         )));
//     Navigator.push(
//         context,
//         BasePageRoute(
//             builder: (context) => QuestionairesInfoView(
//               formName: questionairesTemp.formName ?? '',
//               formItems:  temp2,
//               customerName:questionairesTemp.customerName,
//               validLocation: questionairesTemp.validLocation ?? false,
//               surveyId: questionairesTemp.id,
//               showSurveyId: questionairesTemp.showSurveyId ?? false,
//               questionnaireTime: questionairesTemp.questionnaireTime ?? DateTime.now() ,
//
//             )));
// }

    });
  }


  @override
  Widget build(BuildContext context) {
    return  AppScaffold(
        currentPageName: CurrentPageNameEnum.invoiceScreen,

        searchHintText: SharedLocalization
            .getLocalization!().surveySearchQuestionnaires,
        pageTitle: SharedLocalization
            .getLocalization!().selectForm,
        withDrawer: false,

        body:
        WillPopScope(
          onWillPop: () async{
            _viewModel.selectedQuestionType = null;
            _viewModel.postDataToView();
            return true;
          },
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: Colors.white,
              child:  Column(
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

                          ListView.builder(
                          itemCount:  allForms.items?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {

                                 // if (_viewModel.selectedQuestionType !=  allForms.items?[index].) {
                                  //  _viewModel.selectedQuestionType =  allForms.items?[index];
                                    FormModel selectedForm = allForms.items![index];
                                    questionairesTemp =selectedForm;

                                 //   if(formkey.currentState?.validate() ?? false){
                                      FormModel questionaireQuestions=   await _viewModel.formRepo.getFormDetail(id: questionairesTemp.id ?? '');
                                      FormModel questionaire=   FormModel(
                                          id: null,
                                          questions: questionaireQuestions.questions,
                                          formName: questionaireQuestions.formName,
                                          showSurveyId: questionaireQuestions.showSurveyId,
                                          validLocation: questionaireQuestions.validLocation,
                                          questionnaireTime: questionaireQuestions.questionnaireTime,
                                          isUsed: questionaireQuestions.isUsed,
                                          isActive: questionaireQuestions.isActive,
                                          isTemplate: false,
                                          originalFormMasterId: questionaireQuestions.originalFormMasterId

                                      );
                                      FormModel res = await _viewModel.formRepo.getFormDetail(id: questionairesTemp.id ?? '');
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          BasePageRoute(
                                              builder: (context) => QuestionairesInfoView(
                                                formName: res.formName ?? '',
                                                formItems:  res.questions ?? [],
                                                validLocation: res.validLocation ?? false,
                                                surveyId: res.id ?? '',
                                                code: res.code ?? 'لا يوجد كود للعرض',
                                                showSurveyId: res.showSurveyId ?? false,
                                                questionnaireTime: res.questionnaireTime ?? DateTime.now() ,
                                                isForm: true,
                                              )));







                                   // }
                                  //}
                                },
                                child: PrimaryContainer(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.0),
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
                                                border: Border.all(color: AppTheme.borderColor),
                                                color: AppTheme.orangeColor,
                                              ),
                                              child: Icon(
                                                SharedIcons.invoiceIcon,
                                                color: AppTheme.whiteColor,
                                                size: 25,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 270,
                                                  color: Colors.transparent,
                                                  child: Text(
                                                    allForms.items?[index].formName ?? '',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                // Text(
                                                //   (allForms.items?[index].showSurveyId ?? false)
                                                //       ? allForms.items?[index].code ?? 'لا يوجد كود للعرض'
                                                //       : '',
                                                //   style: const TextStyle(
                                                //     fontWeight: FontWeight.w500,
                                                //     fontSize: 12,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )

                          // Form(
                              //   key: formkey,
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         //  borderRadius: BorderRadius.circular(8),
                              //         border: Border.all(color: Colors.grey.withOpacity(0.6))
                              //     ),
                              //     padding: EdgeInsets.only(left: 8 ,right: 8 , top: 22),
                              //     child: DropdownButtonFormField<String?>(
                              //         decoration:  InputDecoration(
                              //           filled: true,
                              //           fillColor: Colors.grey.withOpacity(0.2),
                              //           border: InputBorder.none,
                              //         ),
                              //         iconSize:  20,
                              //         // icon: SvgPicture.asset(
                              //         //     Assets.assetsSvgImagesIconAwesomeMapMarkerAlt.path),
                              //         value: _viewModel.selectedQuestionType,
                              //         style: TextStyle(
                              //           fontSize: 16,
                              //         ),
                              //         hint: Text(
                              //           //"surveySelectQuestionType" : "Select Question Type",
                              //           SharedLocalization.getLocalization!().surveySelectForm,
                              //           style: TextStyle(
                              //             fontSize: 16,
                              //           ),
                              //         ),
                              //         onChanged: (value) async {
                              //           if (_viewModel.selectedQuestionType != value) {
                              //             _viewModel.selectedQuestionType = value;
                              //             FormModel selectedForm = allForms.items!.where((element) => element.id==value).first;
                              //             questionairesTemp =selectedForm;
                              //
                              //             if(formkey.currentState?.validate() ?? false){
                              //               FormModel questionaireQuestions=   await _viewModel.formRepo.getFormDetail(id: questionairesTemp.id ?? '');
                              //               FormModel questionaire=   FormModel(
                              //                   id: null,
                              //                   questions: questionaireQuestions.questions,
                              //                   formName: questionaireQuestions.formName,
                              //                   showSurveyId: questionaireQuestions.showSurveyId,
                              //                   validLocation: questionaireQuestions.validLocation,
                              //                   questionnaireTime: questionaireQuestions.questionnaireTime,
                              //                   isUsed: questionaireQuestions.isUsed,
                              //                   isActive: questionaireQuestions.isActive,
                              //                   isTemplate: false,
                              //                   originalFormMasterId: questionaireQuestions.originalFormMasterId
                              //
                              //               );
                              //               FormModel res = await _viewModel.formRepo.getFormDetail(id: questionairesTemp.id ?? '');
                              //               Navigator.pop(context);
                              //               Navigator.push(
                              //                   context,
                              //                   BasePageRoute(
                              //                       builder: (context) => QuestionairesInfoView(
                              //                         formName: res.formName ?? '',
                              //                         formItems:  res.questions ?? [],
                              //                         validLocation: res.validLocation ?? false,
                              //                         surveyId: res.id ?? '',
                              //                         code: res.code ?? 'لا يوجد كود للعرض',
                              //                         showSurveyId: res.showSurveyId ?? false,
                              //                         questionnaireTime: res.questionnaireTime ?? DateTime.now() ,
                              //                         isForm: true,
                              //                       )));
                              //
                              //
                              //
                              //
                              //
                              //
                              //
                              //             }
                              //           }
                              //         },
                              //         validator: (value) {
                              //           if (value == null) {
                              //             return SharedLocalization.getLocalization!().requiredFields;
                              //           }
                              //           return null; // Validation passes
                              //         },
                              //
                              //         items: List.generate(
                              //           allForms.items?.length ?? 0,
                              //               (index) => DropdownMenuItem(
                              //             value: allForms.items?[index].id,
                              //             child: Text(
                              //               allForms.items?[index].formName ??'',
                              //               style: TextStyle(
                              //                   color: Colors.black, fontSize: 16),
                              //             ),
                              //           ),
                              //         )),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),



                  // Container(
                  //   color: AppTheme.whiteColor,
                  //   child: GestureDetector(
                  //     onTap: (){
                  //       // addQuestionModel( _viewModel.selectedQuestionType );
                  //       if(formkey.currentState?.validate() ?? false){
                  //         allQuestionaires.add(FormModel(
                  //             id: const Uuid().v1(),
                  //             questions: questionairesTemp.questions,
                  //             formName: questionairesTemp.formName,
                  //             customerName: questionairesTemp.customerName,
                  //             showSurveyId: questionairesTemp.showSurveyId,
                  //             validLocation: questionairesTemp.validLocation,
                  //           questionnaireTime: DateTime.now()
                  //
                  //         ));
                  //         print("gjhkjlhj ${allQuestionaires.length}");
                  //         Navigator.pop(context);
                  //
                  //            List<FormItem> temp2 = [];
                  //           for(int i =0 ; i < questionairesTemp.questions.length ; i ++){
                  //             List<String> options = [];
                  //             for(int o =0 ; o < questionairesTemp.questions[i].options.length ; o ++){
                  //               for(int j =0 ; j < questionairesTemp.questions[i].options[o].optionController.text.split(",").length ; j ++){
                  //                 options.add(questionairesTemp.questions[i].options[o].optionController.text.split(",")[j]);
                  //               }
                  //             }
                  //             temp2.add(FormItem(question:questionairesTemp.questions[i].question ?? '',
                  //                 questionType: questionairesTemp.questions[i].questionType ?? FormItemType.ShortText,
                  //                 isRequired:  questionairesTemp.questions[i].isRequired,
                  //                 options:options
                  //             ));
                  //           }
                  //           // Navigator.push(
                  //           //     context,
                  //           //     BasePageRoute(
                  //           //         builder: (context) => DynamicForm(
                  //           //           formName: data.allQuestionaires[index].formName ?? '',
                  //           //           formItems:  temp,
                  //           //
                  //           //         )));
                  //           Navigator.push(
                  //               context,
                  //               BasePageRoute(
                  //                   builder: (context) => QuestionairesInfoView(
                  //                     formName: questionairesTemp.formName ?? '',
                  //                     formItems:  temp2,
                  //                     customerName:questionairesTemp.customerName,
                  //                     validLocation: questionairesTemp.validLocation ?? false,
                  //                     surveyId: questionairesTemp.id,
                  //                     showSurveyId: questionairesTemp.showSurveyId ?? false,
                  //                     questionnaireTime: questionairesTemp.questionnaireTime ?? DateTime.now() ,
                  //
                  //                   )));
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //       }
                  //
                  //     },
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 14),
                  //       child: Container(
                  //         width: double.infinity,
                  //         height: 48,
                  //         decoration: BoxDecoration(
                  //             color: AppTheme.secondaryColor,
                  //             borderRadius: BorderRadius.circular(8)
                  //         ),
                  //         child: Center(
                  //           child: Text(SharedLocalization.getLocalization!().next,
                  //             style: TextStyle(
                  //                 fontSize: 24,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: AppColors.whiteColor
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
        )
        // StreamBuilder<QuestionairesUseCaseModel>(
        //     stream: _viewModel.outputQuestionairesContent,
        //     builder: (context, snapshot) {
        //       QuestionairesUseCaseModel? data = snapshot.data;
        //       return
        //         data != null ?
        //         WillPopScope(
        //           onWillPop: () async{
        //             _viewModel.selectedQuestionType = null;
        //             _viewModel.postDataToView();
        //             return true;
        //           },
        //           child: Padding(
        //             padding:  EdgeInsets.only(
        //                 bottom: MediaQuery.of(context).viewInsets.bottom
        //             ),
        //             child: Container(
        //               color: Colors.white,
        //               child: StatefulBuilder(
        //                 builder: (BuildContext context, setState) => Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     Expanded(
        //                       child: SingleChildScrollView(
        //                         child: Container(
        //                           color: Colors.white,
        //                           child: Padding(
        //                             padding: const EdgeInsets.only(top: 16),
        //                             child:  Column(
        //                               children: [
        //                                 Container(
        //                                   decoration: BoxDecoration(
        //                                       color: Colors.white,
        //                                       //  borderRadius: BorderRadius.circular(8),
        //                                       border: Border.all(color: Colors.grey.withOpacity(0.6))
        //                                   ),
        //                                   padding: EdgeInsets.only(left: 8 ,right: 8 , top: 0),
        //                                   child: Form(
        //                                     key: formkey,
        //                                     child: TextFormField(
        //                                         controller: customerNameController,
        //                                         keyboardType: TextInputType.multiline,
        //                                         maxLines: 6,
        //                                         minLines: 1,
        //                                         autofocus: false,
        //                                         style: TextStyle(
        //                                             color: Colors.black,
        //                                             fontSize:  16),
        //                                         inputFormatters: [
        //                                           // LengthLimitingTextInputFormatter(
        //                                           //     AppConsts.chatMessageMaxLength),
        //                                         ],
        //                                         onChanged: (value) {
        //                                           temp.customerName = value;
        //                                         },
        //                                         onTap: () {
        //
        //                                         },
        //                                         validator: (val){
        //                                           if(val?.isEmpty ?? false){
        //                                             return SharedLocalization.getLocalization!().surveyFiledRequired;
        //                                           }
        //                                           return null;
        //                                         },
        //                                         decoration: InputDecoration(
        //                                           border: InputBorder.none,
        //                                           errorStyle: TextStyle(
        //                                             fontSize: 14,
        //                                           ),
        //                                           errorMaxLines: 2,
        //                                           hintText:
        //                                           SharedLocalization.getLocalization!().surveyWriteCustomerName,
        //                                           hintStyle: TextStyle(
        //                                               color: Colors.grey,
        //                                               fontSize:
        //                                               16),
        //
        //                                           filled: true,
        //                                           contentPadding: EdgeInsets.only(
        //                                               top: 4, left: 6, right: 6),
        //                                           // suffixIcon: Row(
        //                                           //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
        //                                           //   mainAxisSize: MainAxisSize.min, // added line
        //                                           //   children: [
        //                                           //
        //                                           //
        //                                           //
        //                                           //   ],
        //                                           // ),
        //
        //                                           fillColor:
        //                                           Colors.white.withOpacity(0.2),
        //                                           enabledBorder: OutlineInputBorder(
        //                                             borderRadius:
        //                                             BorderRadius.circular(4.0),
        //                                             borderSide:  BorderSide(
        //                                               color: Colors.grey.withOpacity(0.3),
        //                                             ),
        //                                           ),
        //                                           focusedBorder: OutlineInputBorder(
        //                                             borderRadius:
        //                                             BorderRadius.circular(4.0),
        //                                             borderSide:  BorderSide(
        //                                               color: Colors.grey.withOpacity(0.3),
        //                                             ),
        //                                           ),
        //                                           focusedErrorBorder:
        //                                           OutlineInputBorder(
        //                                               borderRadius:
        //                                               BorderRadius.circular(
        //                                                   4.0),
        //                                               borderSide: BorderSide(
        //                                                 color: Theme.of(context)
        //                                                     .errorColor,
        //                                               )),
        //                                           errorBorder: OutlineInputBorder(
        //                                               borderRadius:
        //                                               BorderRadius.circular(4.0),
        //                                               borderSide: BorderSide(
        //                                                 color: Theme.of(context)
        //                                                     .errorColor,
        //                                               )),
        //                                         )),
        //                                   ),
        //                                 ),
        //                                 Container(
        //                                   decoration: BoxDecoration(
        //                                       color: Colors.white,
        //                                       //  borderRadius: BorderRadius.circular(8),
        //                                       border: Border.all(color: Colors.grey.withOpacity(0.6))
        //                                   ),
        //                                   padding: EdgeInsets.only(left: 8 ,right: 8 , top: 22),
        //                                   child: DropdownButtonFormField<int?>(
        //                                       decoration:  InputDecoration(
        //                                         filled: true,
        //                                         fillColor: Colors.grey.withOpacity(0.2),
        //                                         border: InputBorder.none,
        //                                       ),
        //                                       iconSize:  20,
        //                                       // icon: SvgPicture.asset(
        //                                       //     Assets.assetsSvgImagesIconAwesomeMapMarkerAlt.path),
        //                                       value: _viewModel.selectedQuestionType,
        //                                       style: TextStyle(
        //                                         fontSize: 16,
        //                                       ),
        //                                       hint: Text(
        //                                         //"surveySelectQuestionType" : "Select Question Type",
        //                                         SharedLocalization.getLocalization!().surveySelectForm,
        //                                         style: TextStyle(
        //                                           fontSize: 16,
        //                                         ),
        //                                       ),
        //                                       onChanged: (value) {
        //                                         if (_viewModel.selectedQuestionType != value) {
        //                                           _viewModel.selectedQuestionType = value;
        //                                           FormModel selectedForm = allForms.where((element) => element.id==value).first;
        //                                           temp.id =Random().nextInt(100);
        //                                           temp.formName=selectedForm.formName;
        //                                           temp.questions=selectedForm.questions;
        //                                         }
        //                                       },
        //                                       items: List.generate(
        //                                         allForms.length,
        //                                             (index) => DropdownMenuItem(
        //                                           child: Text(
        //                                             allForms[index].formName ??'',
        //                                             style: TextStyle(
        //                                                 color: Colors.black, fontSize: 16),
        //                                           ),
        //                                           value: allForms[index].id,
        //                                         ),
        //                                       )),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //
        //
        //
        //                     Container(
        //                       color: AppTheme.whiteColor,
        //                       child: GestureDetector(
        //                         onTap: (){
        //                           // addQuestionModel( _viewModel.selectedQuestionType );
        //                           if(formkey.currentState?.validate() ?? false){
        //                             allQuestionaires.add(temp);
        //                             Navigator.pop(context);
        //                           }
        //
        //                         },
        //                         child: Padding(
        //                           padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 14),
        //                           child: Container(
        //                             width: double.infinity,
        //                             height: 48,
        //                             decoration: BoxDecoration(
        //                                 color: AppTheme.secondaryColor,
        //                                 borderRadius: BorderRadius.circular(8)
        //                             ),
        //                             child: Center(
        //                               child: Text(SharedLocalization.getLocalization!().next,
        //                                 style: TextStyle(
        //                                     fontSize: 24,
        //                                     fontWeight: FontWeight.bold,
        //                                     color: AppColors.whiteColor
        //                                 ),),
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     )
        //
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ):const SizedBox();
        //     })
    );
  }
}
