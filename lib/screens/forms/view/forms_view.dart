import 'package:flutter/material.dart';
import 'package:questionnaire/domain/model/make_form_template/form_item_model.dart';
import 'package:questionnaire/presentation/resources/base_page_route.dart';
import 'package:questionnaire/screens/build_questionnaire_form/view/build_questionnaire_form_view.dart';
import 'package:questionnaire/screens/forms/viewmodel/forms_viewmodel.dart';
import 'package:questionnaire/screens/make_form_template/view/make_form_template_view.dart';
import 'package:shared_module/Widget/app_scaffold.dart';
import 'package:shared_module/Widget/no_items_found_indicator.wdiget.dart';
import 'package:shared_module/Widget/primary_container.widget.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:shared_module/theme/app.theme.dart';
import 'package:shared_module/theme/shared.icons.dart';

import '../../../app/app_enums.dart';
import '../../../domain/model/make_form_template/form_model.dart';

import 'dart:math';

class FormsScreen extends StatefulWidget {
  bool isQuestionnaires;
   FormsScreen({required this.isQuestionnaires});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {

  ValueNotifier<bool>? isFiltering;
  var rng = Random();
  @override
  Widget build(BuildContext context) {
    return  AppScaffold(
      currentPageName: CurrentPageNameEnum.invoiceScreen,
      searchHintText: SharedLocalization.getLocalization!().surveySearchForms,
      pageTitle: SharedLocalization.getLocalization!().surveyForms,
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

      SingleChildScrollView(
        child: Column(
          children: [
            //
            allForms.isEmpty ?
                   SizedBox(
                     height: MediaQuery.of(context).size.height -200,
                     child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    NoItemsFoundIndicatorWidget()
                                  ],
                     ),
                   ) :
            ListView.builder(
                itemCount: allForms.length,
                shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context ,index){
                  return GestureDetector(
                    onTap: (){
                      if(widget.isQuestionnaires){
                              List<FormItem> temp = [];
                              for(int i =0 ; i < allForms[index].questions.length ; i ++){
                                List<String> options = [];
                                for(int o =0 ; o < allForms[index].questions[i].options.length ; o ++){
                                  for(int j =0 ; j < allForms[index].questions[i].options[o].optionController.text.split(",").length ; j ++){
                                    options.add(allForms[index].questions[i].options[o].optionController.text.split(",")[j]);
                                  }
                                }
                                temp.add(FormItem(question:allForms[index].questions[i].question ?? '',
                                    questionType: allForms[index].questions[i].questionType ?? FormItemType.ShortText,
                                    isRequired:  allForms[index].questions[i].isRequired,
                                    options:options
                                ));
                              }
                              Navigator.push(
                                  context,
                                  BasePageRoute(
                                      builder: (context) => DynamicForm(
                                        formName: allForms[index].formName ?? '',
                                        formItems:  temp,

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
                                      Text(allForms[index].formName ??'',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                      ),),
                                      SizedBox(height: 3,),
                                      Text(" ${SharedLocalization.getLocalization!().surveyQuestionNumber} ${allForms[index].questions.length.toString() ?? '0'}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,

                                          )),
                                    ],
                                  )

                                ],
                              ),
                              widget.isQuestionnaires ? SizedBox():
                              
                              GestureDetector(
                                onTap: () async {
                                  await  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>  BuildFormsScreens(
                                        form: FormModel(
                                          id: rng.nextInt(100),
                                          formName: allForms[index].formName,questions: allForms[index].questions,),
                                        isEdit: true,
                                        formIndex: index,
                                      )));
                                  setState(() {});
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                    child: Icon(Icons.edit,color: AppTheme.orangeColor,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ) ,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton:  !widget.isQuestionnaires ? FloatingActionButton(
          elevation: 0.0,
          //  backgroundColor: AppColors.blackColor,
          onPressed: () async {
          await  Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>  BuildFormsScreens(
                    form: FormModel(
                        id: rng.nextInt(100),
                        formName: '',questions: []),
                  isEdit: false,
                )));
          setState(() {});
          },
          child:  const Icon(Icons.add,color: Colors.white,)
      ):SizedBox(),
    );
  }
}
