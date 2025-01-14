import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:questionnaire/app/app_shared.dart';
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
  final bool isQuestionnaires;

  FormsScreen({required this.isQuestionnaires});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  ValueNotifier<List<FormModel>> filteredForms = ValueNotifier([]);
  final rng = Random();

  List<FormModel> allLocalForms = [];

  @override
  void initState() {
    allLocalForms = allForms;
    filteredForms.value = allForms; // Initialize with all forms
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
    return allLocalForms.where((form) {
      final matchesId = form.id.toString().contains(searchKey);
      final matchesFormName = form.formName?.toLowerCase().contains(lowerKey) ?? false;
      final matchesClientName = form.customerName?.name.toLowerCase().contains(lowerKey) ?? false;

      // Check if the searchKey matches the index
      final matchesIndex = (allLocalForms.indexOf(form)+1).toString() == searchKey;
      return
        matchesId || matchesFormName || matchesClientName ||
          matchesIndex;
    }).toList();
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
          filteredForms.value = searchForms(value);
        }
      },
      body: SingleChildScrollView(
        child: ValueListenableBuilder<List<FormModel>>(
          valueListenable: filteredForms,
          builder: (context, forms, child) {
            return Column(
              children: [
                forms.isEmpty
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
                  itemCount: forms.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
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
                                          "${index + 1} - ${forms[index].formName ?? ''}",
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
                                        "${SharedLocalization.getLocalization!().surveyQuestionNumber} ${forms[index].questions.length}",
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
                                  await  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>  BuildFormsScreens(
                                        form: FormModel(
                                          id: rng.nextInt(100),
                                          customerName: allForms[index].customerName,
                                          formName: allForms[index].formName,
                                          questions: allForms[index].questions,),
                                        isEdit: true,
                                        formIndex: index,
                                      )));
                                  setState(() {});
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
