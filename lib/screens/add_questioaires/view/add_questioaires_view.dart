import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:questionnaire/app/di.dart';
import 'package:questionnaire/domain/model/make_form_template/form_item_model.dart';
import 'package:questionnaire/presentation/resources/base_page_route.dart';
import 'package:questionnaire/screens/Questionaires/viewmodel/questionaires_viewmodel.dart';
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

import '../../../app/app_enums.dart';
import '../../../domain/model/make_form_template/form_model.dart';


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
  final QuestionairesViewModel _viewModel =
  instance<QuestionairesViewModel>();

  final formkey = GlobalKey<FormState>();
  TextEditingController customerNameController = TextEditingController();
  FormModel temp =FormModel(id: Random().nextInt(100),questions: [],formName: "",customerName: '');

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _viewModel.start();
    });
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
          // _appService.cancel();
          // await Future.delayed(const Duration(milliseconds: 100));
          // _inputViewModel.filterText = value;
          // _pagingController.refresh();
        },
        onFilterFunction: (){

        },
        isFilteringListener: isFiltering,
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
                                        temp.customerName = value;
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
                                              color: Theme.of(context)
                                                  .errorColor,
                                            )),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .errorColor,
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
                                child: DropdownButtonFormField<int?>(
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
                                      if (_viewModel.selectedQuestionType != value) {
                                        _viewModel.selectedQuestionType = value;
                                        FormModel selectedForm = allForms.where((element) => element.id==value).first;
                                        temp.id =Random().nextInt(100);
                                        temp.formName=selectedForm.formName;
                                        temp.questions=selectedForm.questions;
                                      }
                                    },
                                    items: List.generate(
                                      allForms.length,
                                          (index) => DropdownMenuItem(
                                        child: Text(
                                          allForms[index].formName ??'',
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 16),
                                        ),
                                        value: allForms[index].id,
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
                          allQuestionaires.add(temp);
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
