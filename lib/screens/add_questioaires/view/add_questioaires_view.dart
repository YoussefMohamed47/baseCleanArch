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
  QuestionairesViewModel? questionViewModel;
  AddQuestionairesView({
    //required this.data
  //  ,
   this.questionViewModel});

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

       _viewModel.start().then((onValue){
         setState(() {});
       });
      print("allForms.lengthallForms.length ${allForms.items?.length}");

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return

      AppScaffold(
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
                          itemCount:  allForms.items?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {

                            print("allForms.items  ${allForms.items?.length}");
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
                                                validLocation: res.validLocation ?? true,
                                                surveyId: res.id ?? '',
                                                code: res.code ?? 'لا يوجد كود للعرض',
                                                showSurveyId: res.showSurveyId ?? true,
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


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),




                ],
              ),
            ),
          ),
        )

    );
  }
}
