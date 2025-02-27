import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:questionnaire/app/app_shared.dart';
import 'package:questionnaire/domain/model/make_form_template/questionaires_item.dart';
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
import 'package:uuid/uuid.dart';

import '../../../app/app_enums.dart';
import '../../../app/di.dart';
import '../../../domain/model/from_model.dart';
import '../../../domain/model/make_form_template/form_list.dart';
import '../../../domain/model/make_form_template/form_model.dart';

import 'dart:math';

class FormsScreen extends StatefulWidget {
  final bool isQuestionnaires;

  FormsScreen({required this.isQuestionnaires});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  ValueNotifier<FormListModel> filteredForms = ValueNotifier(FormListModel());
  final rng = Random();

  final FormsViewModel _viewModel = instance<FormsViewModel>();


  FormListModel allLocalForms = FormListModel();

  @override
  void initState() {
    // allLocalForms = allForms;
    // filteredForms.value = allForms; // Initialize with all forms
    _viewModel.start().then((onValue){
       allLocalForms = allForms;
       filteredForms.value = allForms; // Initialize with all forms
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    filteredForms.dispose();
    super.dispose();
  }

  List<FormModel> searchForms(String searchKey) {
    final lowerKey = searchKey.toLowerCase();
    return allLocalForms.items?.where((form) {
      final matchesId = form.id.toString().contains(searchKey);
      final matchesFormName = form.formName?.toLowerCase().contains(lowerKey) ?? false;

      // Check if the searchKey matches the index
    //  final matchesIndex = (allLocalForms.items?.indexOf(form)+1).toString() == searchKey;
      return
        matchesId || matchesFormName
          //   ||
          // matchesIndex
      ;
    }).toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentPageName: CurrentPageNameEnum.formsScreen,
      searchHintText: SharedLocalization.getLocalization!().surveySearchForms,
      pageTitle: SharedLocalization.getLocalization!().surveyForms,
      onSearchFunction: (value) async {
        if (value.trim() == '') {
          filteredForms.value = allLocalForms;
        } else {
        //  filteredForms.value = searchForms(value);
        }
      },
      body: SingleChildScrollView(
        child: ValueListenableBuilder<FormListModel>(
          valueListenable: filteredForms,
          builder: (context, forms, child) {
            return
              _viewModel.isLoading ?
              const SizedBox():
              Column(
              children: [
                (forms.items?.isEmpty ?? true)
                    ? const SizedBox(
                  height: 600,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NoItemsFoundIndicatorWidget(),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: forms.items?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if(widget.isQuestionnaires){
                              // List<QuestionairesItem> temp = [];
                              // for(int i =0 ; i < allForms[index].questions.length ; i ++){
                              //   List<OptionQuestionnaireModel> options = [];
                              //   for(int o =0 ; o < allForms[index].questions[i].options.length ; o ++){
                              //     for(int j =0 ; j < allForms[index].questions[i].options[o].optionController.text.split(",").length ; j ++){
                              //       options.add(
                              //           OptionQuestionnaireModel(
                              //             option:  allForms[index].questions[i].options[o].optionController.text.split(",")[j],
                              //             isHide:  allForms[index].questions[i].options[o].isHide)
                              //          );
                              //     }
                              //   }
                              //   temp.add(QuestionairesItem(question:allForms[index].questions[i].question ?? '',
                              //       questionType: allForms[index].questions[i].questionType ?? FormItemType.ShortText,
                              //       isRequired:  allForms[index].questions[i].isRequired,
                              //       options:options,
                              //     isHide: allForms[index].questions[i].isHide
                              //   ));
                              // }
                              // Navigator.push(
                              //     context,
                              //     BasePageRoute(
                              //         builder: (context) => DynamicForm(
                              //           formName: allForms[index].formName ?? '',
                              //           formItems:  temp,
                              //
                              //
                              //         )));
                            }else{

                              print("form id : ${allForms.items?[index].id}");
                              await  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>  BuildFormsScreens(
                                    form: LocalFormModel(
                                        id: allForms.items?[index].id ?? '',
                                        formName: allForms.items?[index].formName,
                                        validLocation: allForms.items?[index].validLocation,
                                        showSurveyId: allForms.items?[index].showSurveyId,
                                        questions: []),
                                    isEdit: true,
                                    formIndex: index,
                                  )));
                              getData();
                            }

                            print("ffffdfsfdsfdsfdsffsdd");
                          },
                          child: PrimaryContainer(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              "${index + 1} - ${forms.items?[index].formName ?? ''}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            "${SharedLocalization.getLocalization!().surveyQuestionNumber} ${forms.items?[index].questionsCount ??0}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  widget.isQuestionnaires
                                      ? SizedBox()
                                      : GestureDetector(
                                    onTap: () async {

                                      print("form id : ${allForms.items?[index].id}");
                                      await  Navigator.of(context).push(MaterialPageRoute(
                                          builder: (ctx) =>  BuildFormsScreens(
                                            form: LocalFormModel(
                                              id: allForms.items?[index].id ?? '',
                                              formName: allForms.items?[index].formName,
                                              validLocation: allForms.items?[index].validLocation,
                                              showSurveyId: allForms.items?[index].showSurveyId,
                                              questions: []),
                                            isEdit: true,
                                            formIndex: index,
                                          )));
                                      getData();

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                      child: Icon(Icons.edit, color: AppTheme.orangeColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: index+1 == (forms.items?.length ?? 0) ?54:0,)

                      ],
                    );
                  },
                ),
              ],
            );

          },
        ),
      ),
      floatingActionButton:  !widget.isQuestionnaires ? FloatingActionButton(
          elevation: 0.0,
          //  backgroundColor: AppColors.blackColor,
          onPressed: () async {
            await  Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>  BuildFormsScreens(
                  form: LocalFormModel(
                      id: const Uuid().v1(),
                      validLocation: false,

                      formName: '',questions: []),
                  isEdit: false,
                )));
            getData();

          },
          child:  const Icon(Icons.add,color: Colors.white,)
      ):SizedBox(),
    );
  }

   getData(){
     allLocalForms = allForms;
     filteredForms.value = allForms; // Initialize with all forms
     setState(() {});

     //   allLocalForms = allForms;
     //   filteredForms.value = allForms; // Initialize with all forms
    // _viewModel.start().then((onValue){
    //   allLocalForms = allForms;
    //   filteredForms.value = allForms; // Initialize with all forms
    //   setState(() {});
    // });

  }
}
