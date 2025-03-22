// import 'package:flutter/material.dart';
// import 'package:questionnaire/app/app_enums.dart';
// import 'package:questionnaire/domain/model/make_form_template/questionaires_item.dart';
// class DynamicForm extends StatefulWidget {
//   final formName;
//   final List<FormItem> formItems;
//
//   DynamicForm({required this.formName ,required this.formItems});
//
//   @override
//   _DynamicFormState createState() => _DynamicFormState();
// }
//
// class _DynamicFormState extends State<DynamicForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   Map<String, dynamic> _formData = {};
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.formName),
//       ),
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 14.0),
//         child: Form(
//           key: _formKey,
//           child: ListView.builder(
//             itemCount: formItemsLocal.length,
//             itemBuilder: (context, index) {
//               final formItem = formItemsLocal[index];
//               switch (formItem.questionType) {
//                 case FormItemType.ShortText:
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(formItem.question,style:  const TextStyle(
//                           fontWeight: FontWeight.bold),),
//                       SizedBox(height: 12,),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderSide:  BorderSide(width: 0.7,
//                                ),
//                               borderRadius: BorderRadius.circular(5)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide:  BorderSide(
//                                 width: 0.7,
//
//                               )),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (formItem.isRequired && value?.isEmpty == true) {
//                             return SharedLocalization.getLocalization!().filedRequired;
//                           }
//                           if (value != null && value.length > 50) {
//                             return 'Must not exceed 50 characters';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => _formData[formItem.question] = value,
//                       ),
//                     ],
//                   );
//                 case FormItemType.LongText:
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(formItem.question,style:  const TextStyle(
//                           fontWeight: FontWeight.bold),),
//                       SizedBox(height: 12,),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderSide:  BorderSide(width: 0.7,
//                               ),
//                               borderRadius: BorderRadius.circular(5)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide:  BorderSide(
//                                 width: 0.7,
//
//                               )),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                         maxLines: 6,
//                         validator: (value) {
//                           if (formItem.isRequired && value?.isEmpty == true) {
//                             return SharedLocalization.getLocalization!().filedRequired;
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => _formData[formItem.question] = value,
//                       ),
//                     ],
//                   );
//                 case FormItemType.SingleChoice:
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(formItem.question),
//                       SizedBox(height: 12,),
//                       DropdownButtonFormField<String>(
//                         value: null,
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderSide:  BorderSide(width: 0.7,
//                               ),
//                               borderRadius: BorderRadius.circular(5)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide:  BorderSide(
//                                 width: 0.7,
//
//                               )),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                         items: formItem.options!
//                             .map((option) => DropdownMenuItem(
//                           child: Text(option),
//                           value: option,
//                         ))
//                             .toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             _formData[formItem.question] = value;
//                           });
//                         },
//                         validator: (value) {
//                           if (formItem.isRequired && value == null) {
//                             return SharedLocalization.getLocalization!().pleaseSelectOption;
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   );
//                 case FormItemType.MultiChoice:
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(formItem.question),
//                       SizedBox(height: 12,),
//                       Column(
//                         children: formItem.options!
//                             .map((option) => CheckboxListTile(
//                           title: Text(option),
//                           value: _formData[formItem.question] != null
//                               ? _formData[formItem.question].contains(option)
//                               : false,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               if (value != null) {
//                                 List<String> selectedOptions =
//                                 _formData[formItem.question] != null
//                                     ? List.from(_formData[formItem.question])
//                                     : [];
//                                 if (value) {
//                                   selectedOptions.add(option);
//                                 } else {
//                                   selectedOptions.remove(option);
//                                 }
//                                 _formData[formItem.question] = selectedOptions;
//                               }
//                             });
//                           },
//                         ))
//                             .toList(),
//                       ),
//                     ],
//                   );
//                 case FormItemType.Number:
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(formItem.question,style:  const TextStyle(
//                           fontWeight: FontWeight.bold),),
//                       SizedBox(height: 12,),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderSide:  BorderSide(width: 0.7,
//                               ),
//                               borderRadius: BorderRadius.circular(5)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide:  BorderSide(
//                                 width: 0.7,
//
//                               )),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (formItem.isRequired && value!.isEmpty) {
//                             return SharedLocalization.getLocalization!().filedRequired;
//                           }
//                           if (value != null &&
//                               int.tryParse(value) == null) {
//                             return SharedLocalization.getLocalization!().validNumber;
//                           }
//                           return null;
//                         },
//                         onSaved: (value) =>
//                         _formData[formItem.question] = int.parse(value!),
//                       ),
//                     ],
//                   );
//                 case FormItemType.Float:
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(formItem.question,style:  const TextStyle(
//                           fontWeight: FontWeight.bold),),
//                       SizedBox(height: 12,),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderSide:  BorderSide(width: 0.7,
//                               ),
//                               borderRadius: BorderRadius.circular(5)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide:  BorderSide(
//                                 width: 0.7,
//
//                               )),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                         keyboardType: TextInputType.numberWithOptions(decimal: true),
//                         validator: (value) {
//                           if (formItem.isRequired && value!.isEmpty) {
//                             return SharedLocalization.getLocalization!().filedRequired;
//                           }
//                           if (value != null &&
//                               double.tryParse(value) == null) {
//                             return SharedLocalization.getLocalization!().validNumber;
//                           }
//                           return null;
//                         },
//                         onSaved: (value) =>
//                         _formData[formItem.question] = double.parse(value!),
//                       ),
//                     ],
//                   );
//                 case FormItemType.Date:
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(formItem.question,style:  const TextStyle(
//                           fontWeight: FontWeight.bold),),
//                       SizedBox(height: 12,),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderSide:  BorderSide(width: 0.7,
//                               ),
//                               borderRadius: BorderRadius.circular(5)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide:  BorderSide(
//                                 width: 0.7,
//
//                               )),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                         readOnly: true,
//                         onTap: () async {
//                           DateTime? selectedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                           );
//                           if (selectedDate != null) {
//                             setState(() {
//                               _formData[formItem.question] = selectedDate;
//                             });
//                           }
//                         },
//                         validator: (value) {
//                           if (formItem.isRequired && value!.isEmpty) {
//                             return SharedLocalization.getLocalization!().filedRequired;
//                           }
//                           return null;
//                         },
//                         controller: TextEditingController(
//                             text: _formData[formItem.question] != null
//                                 ? _formData[formItem.question].toString()
//                                 : ''),
//                       ),
//                     ],
//                   );
//                 case FormItemType.Time:
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(formItem.question,style:  const TextStyle(
//                           fontWeight: FontWeight.bold),),
//                       SizedBox(height: 12,),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderSide:  BorderSide(width: 0.7,
//                               ),
//                               borderRadius: BorderRadius.circular(5)),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide:  BorderSide(
//                                 width: 0.7,
//
//                               )),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                         readOnly: true,
//                         onTap: () async {
//                           TimeOfDay? selectedTime = await showTimePicker(
//                             context: context,
//                             initialTime: TimeOfDay.now(),
//                           );
//                           if (selectedTime != null) {
//                             setState(() {
//                               _formData[formItem.question] = selectedTime;
//                             });
//                           }
//                         },
//                         validator: (value) {
//                           if (formItem.isRequired && value!.isEmpty) {
//                             return SharedLocalization.getLocalization!().filedRequired;
//                           }
//                           return null;
//                         },
//                         controller: TextEditingController(
//                             text: _formData[formItem.question] != null
//                                 ? _formData[formItem.question].toString()
//                                 : ''),
//                       ),
//                     ],
//                   );
//                 default:
//                   return Container(height: 60,);
//               }
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             _formKey.currentState!.save();
//             // Do something with the form data
//             print(_formData);
//             Navigator.pop(context);
//           }
//         },
//         child: Icon(Icons.save),
//       ),
//     );
//   }
// }
//
import 'dart:convert';
import 'dart:developer';

import 'package:agent_module/repository/models/customer.output_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/app/app_shared.dart';
import 'package:questionnaire/domain/model/client_model.dart';
import 'package:questionnaire/domain/model/make_form_template/questionaires_item.dart';
import 'package:questionnaire/presentation/resources/base_page_route.dart';
import 'package:questionnaire/presentation/resources/color_manager.dart';
import 'package:questionnaire/screens/Questionaires/viewmodel/questionaires_viewmodel.dart';
import 'package:questionnaire/screens/build_questionnaire_form/view/build_questionnaire_form_view.dart';
import 'package:questionnaire/screens/questionaires_info/view/signature_widget.dart';
import 'package:shared_module/Widget/app_scaffold.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/questionaires_item.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_module/constants/app.consts.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_module/service/loader.service.dart';
import 'package:shared_module/service/localization.dart';
import 'package:shared_module/theme/app.theme.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../app/di.dart';
import '../../../domain/model/client_model.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_module/Widget/map.widget.dart';

import 'package:shared_module/Widget/toaster.widget.dart';

import 'package:geolocator/geolocator.dart';

import '../../../domain/model/from_model.dart';
import '../../build_questionnaire_form/widgets/attachment_widget.dart';
import '../../select_customer/select_customer_screen.dart';
import '../viewmodel/questionaires_info_viewmodel.dart';
class QuestionairesInfoView extends StatefulWidget {
  final String formName;
  // final ClientItemModel? customerName;
  //  List<QuestionairesItem> formItems;
    List<Question> formItems;
  final bool validLocation;
  final bool showSurveyId;
  final String surveyId;
  final String? code;
  final DateTime questionnaireTime;

  final bool isForm;

  QuestionairesInfoView({required this.formName,
  //  required this.customerName,
    required this.formItems,required this.validLocation,

  required this.surveyId,
  required this.showSurveyId,
  required this.questionnaireTime,
  required this.isForm,
  required this.code,
  });
// QuestionairesInfoViewModel

  @override
  _QuestionairesInfoViewState createState() => _QuestionairesInfoViewState();
}

class _QuestionairesInfoViewState extends State<QuestionairesInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};
  int _currentQuestionIndex = 0;




  double? lat;
  double? long;
  late List<Question> formItemsLocal;



  String fixJson(String jsonString) {
    try {
      // Remove "creationTime" and its value (with or without a trailing comma)
      jsonString = jsonString.replaceAll(RegExp(r'"?creationTime"?:\s*"?.+?"?(,)?'), '');

      // Ensure all keys are enclosed in double quotes
      jsonString = jsonString.replaceAllMapped(
          RegExp(r'(\b\w+\b)\s*:'),
              (match) => '"${match[1]}":'
      );

      // Ensure all values (except numbers, booleans, and null) are enclosed in double quotes
      jsonString = jsonString.replaceAllMapped(
          RegExp(r':\s*([^"\s\[\]{},]+)([,}])'),
              (match) {
            String value = match[1]!;
            String separator = match[2]!;

            // Keep numbers, booleans, and null as they are
            if (value == "true" || value == "false" || value == "null" || RegExp(r'^-?\d+(\.\d+)?$').hasMatch(value)) {
              return ': $value$separator';
            }

            // Ensure UUIDs are treated as strings (UUID format: 8-4-4-4-12 hex digits)
            if (RegExp(r'^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$').hasMatch(value)) {
              return ': "$value"$separator';
            }

            return ': "$value"$separator'; // Wrap all other values in quotes
          }
      );

      // Handle empty values properly
      jsonString = jsonString
          .replaceAll(": ,", ': "",')  // Replace `: ,` with `: ""`
          .replaceAll(":}", ': ""}')   // Replace `:}` with `: ""}`
          .replaceAll(":]", ': ""]');  // Replace `:]` with `: ""]`

      return jsonString;
    } catch (e) {
      print("Error fixing JSON: $e");
      return jsonString; // Return the original string if parsing fails
    }
  }



  @override
  void didChangeDependencies() {
    formItemsLocal=_viewModel.surveyData.questions?.where((form)=>form.isHide==false).toList() ?? [];
    //putClientQuestioninTop();
    super.didChangeDependencies();
  }
  final QuestionairesInfoViewModel _viewModel = instance<QuestionairesInfoViewModel>();

  bool isLoading =false;

  FormModel currentSurvey = FormModel();

  putClientQuestioninTop(){
    formItemsLocal.sort((a, b) {
      if (a.questionType == 10 && b.questionType != 10) {
        return -1; // `a` comes first
      } else if (a.questionType != 10 && b.questionType == 10) {
        return 1; // `b` comes first
      }
      return 0; // Keep relative order
    });
  }
  @override
  void initState() {
    print("validLocation............ ${widget.validLocation}");
    print("surveyId............ ${widget.surveyId}");
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      isLoading =true;
      setState(() {});
       currentSurvey = await _viewModel.getQuestionaireQuestion(surveyId: widget.surveyId);
     formItemsLocal=currentSurvey.questions?.where((form)=>form.isHide==false).toList() ?? [];
      //putClientQuestioninTop();
      isLoading =false;
      setState(() {});
    });
    // formItemsLocal=idget.formItems.where((form)=>form.isHide==false).toList();
        //widget.formItems.where((form)=>form.isHide==false).toList();
    super.initState();
  }


  Future<Map<String, double>> getCurrentLatLon() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    // Check and request permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          "Location permissions are permanently denied. Cannot access location.");
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Return latitude and longitude
    return {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };
  }

  @override
  Widget build(BuildContext context) {
    return

// ${SharedLocalization.getLocalization!().survey}
      AppScaffold(
        pageTitle: widget.formName,
      withDrawer: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // widget.customerName?.name == null ?
                    // const SizedBox():
                    // Container(
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.3)
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                    //     child: Text(
                    //       "${SharedLocalization
                    //           .getLocalization!().customerName} : ${widget.customerName?.name ?? ''}",
                    //       style: const TextStyle(fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),

                    // SizedBox(height: 22,),

                    // Container(
                    //   width: double.infinity,
                    //
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.3)
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                    //     child: Text(
                    //       "${SharedLocalization
                    //           .getLocalization!().surveyFormName} : ${widget.formName}",
                    //       style: const TextStyle(fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),



                    SizedBox(height: widget.showSurveyId?22:0,),
                    widget.showSurveyId?
                    Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                        child: Text(
                          "${SharedLocalization.getLocalization!().surveyNumber} : ${widget.code}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ):const SizedBox(),



                    const SizedBox(height: 22,),

                    Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                        child: Text(
                          // SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date())
                          "${SharedLocalization
                              .getLocalization!().surveyDate} : ${
                              AppConsts.dateFormat.format(widget.questionnaireTime)} \n ${SharedLocalization
                              .getLocalization!().surveyTime} : ${
                              DateFormat('HH:mm').format(widget.questionnaireTime)} ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Divider(color: ColorManager.black,),
                    const SizedBox(height: 12,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "${SharedLocalization
                            .getLocalization!().survey}",
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    isLoading?SizedBox():
                    formItemsLocal.isEmpty?
                        Text(
                          "${SharedLocalization
                              .getLocalization!().survey_question_number_error}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ):
                    Form(
                      key: _formKey,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: formItemsLocal.length,
                        itemBuilder: (BuildContext context, int index) {
                          Question currentFormItem = formItemsLocal[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentFormItem.question ?? '',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              // Render input field based on question type
                              renderInputField(currentFormItem),
                              SizedBox(height: 20),
                            ],
                          );
                        }, separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Divider(thickness: 1, height: 3,color: Colors.grey.withOpacity(0.3),),
                          );
                      },
                      ),
                    ),


                    const SizedBox(height: 62,),
                  ],
                ),
              ),
            )),
            // Container(
            //   width: double.infinity,
            //   height: 51,
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       ElevatedButton(
            //         onPressed:  () {
            //           Navigator.push(
            //               context,
            //               BasePageRoute(
            //                   builder: (context) => DynamicForm(
            //                     formName: widget.formName ,
            //                     formItems:  formItemsLocal,
            //                     validLocation: widget.validLocation,
            //                   )));
            //         }
            //         ,
            //         child: Container(
            //             width: MediaQuery.of(context).size.width /3.3,
            //             child: Center(child: Text('${SharedLocalization.getLocalization!().next}'))),
            //       ),
            //       ElevatedButton(
            //         onPressed:
            //              () {
            //           Navigator.pop(context);
            //         }
            //             ,
            //         child: Container(
            //             width: MediaQuery.of(context).size.width /3.3,
            //             child: Center(child: Text('${SharedLocalization.getLocalization!().cancel}'))),
            //       ),
            //     ],
            //   ),
            // )

          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // log("formItemsLocal ${json.encode(formItemsLocal)}");
            if (_formKey.currentState!.validate()) {

              print("widget.isForm :::: ${widget.isForm}");

              if(widget.isForm){


                if((widget.validLocation)){
                  print("wkkkkkkkkkkk ${widget.surveyId}");
                  LoaderService.show();
                  currentSurvey.id =widget.surveyId;
                  Future.microtask(() async {
                    try {
                      Map<String, double> coordinates = await getCurrentLatLon();
                      print("Latitude: ${coordinates['latitude']}");
                      print("Longitude: ${coordinates['longitude']}");
                      double? lat=coordinates['latitude'] ;
                      double? long=coordinates['longitude'];

                      _formKey.currentState!.save();
                      // Do something with the form data
                      print(_formData);
                      currentSurvey.questions=formItemsLocal;
                      currentSurvey.lat=lat.toString();
                      currentSurvey.lng=long.toString();
                      currentSurvey.id=null;
                      currentSurvey.isTemplate=false;
                    FormModel res =  await _viewModel.addSurvey(currentSurvey);
                    // allQuestionaires.add(res);
                      LoaderService.hide();
                      filteredQuestionnaires.value = [...filteredQuestionnaires.value, res];
                      setState(() {

                      });
                      Navigator.pop(context);

                    } catch (e) {
                      print("Error: $e");
                    }
                  });
                }else{
                  _formKey.currentState!.save();
                  // Do something with the form data
                  print(_formData);
                  log(formItemsLocal.toString());
                  currentSurvey.questions=formItemsLocal;
                  currentSurvey.id=null;
                  currentSurvey.isTemplate=false;
                 FormModel res = await _viewModel.addSurvey(currentSurvey);
                  LoaderService.hide();
                  // allQuestionaires.add(res);
                  //
                  filteredQuestionnaires.value = [...filteredQuestionnaires.value, res];
                  setState(() {});
                  Navigator.pop(context);

                }
              }else{
                if((widget.validLocation)){
                  print("wkkkkkkkkkkk ${widget.surveyId}");
                  LoaderService.show();
                  currentSurvey.id =widget.surveyId;
                  Future.microtask(() async {
                    try {
                      Map<String, double> coordinates = await getCurrentLatLon();
                      print("Latitude: ${coordinates['latitude']}");
                      print("Longitude: ${coordinates['longitude']}");
                      double? lat=coordinates['latitude'] ;
                      double? long=coordinates['longitude'];

                      _formKey.currentState!.save();
                      // Do something with the form data
                      print(_formData);
                      currentSurvey.questions=formItemsLocal;
                      currentSurvey.lat=lat.toString();
                      currentSurvey.lng=long.toString();

                      await _viewModel.submitSurvey(currentSurvey);
                      LoaderService.hide();
                      Navigator.pop(context);
                    } catch (e) {
                      print("Error: $e");
                    }
                  });
                }else{
                  _formKey.currentState!.save();
                  // Do something with the form data
                  print(_formData);
                  log(formItemsLocal.toString());
                  currentSurvey.questions=formItemsLocal;
                  await _viewModel.submitSurvey(currentSurvey);
                  LoaderService.hide();
                  Navigator.pop(context);
                }
              }


            }
          },
          child: Icon(Icons.save),
        ),

    );
  }


   bool isPermissionDeniedAlways = false;
   Future<LatLng?> getGeoLocationPosition(
      {bool isShowWarningGPSEnable = false}) async {
    if (isPermissionDeniedAlways) {
      return AppConsts.defaultPostition;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      LocationPermission requestPermission =
      await Geolocator.requestPermission();
      if (requestPermission != LocationPermission.always &&
          requestPermission != LocationPermission.whileInUse) {
        isPermissionDeniedAlways =
            requestPermission == LocationPermission.deniedForever;
        return AppConsts.defaultPostition;
      }
    }

    if (!await Geolocator.isLocationServiceEnabled()) {
      if (isShowWarningGPSEnable) {
        Toaster.warn(
            content: Text(SharedLocalization
                .getLocalization!().accessToLocationPermission));
      }
      return AppConsts.defaultPostition;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
  selectFirstBranchLocation(LatLng? location, bool isReadOnly) async {
    LatLng? defaultLocation;
    if (!isReadOnly) {
      defaultLocation = await getGeoLocationPosition(
          isShowWarningGPSEnable: false); //selected.location == null
      LoaderService.hide();
    }
    if (location == null && defaultLocation == null) {
      LoaderService.hide();
      return;
    }
    LoaderService.hide();
    if (!context.mounted) return;
    LoaderService.hide();
    final currentPostition = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => MapScreen(
        position: location ?? defaultLocation,
        isReadOnly: isReadOnly,
      ),
    ));
    if (currentPostition != null && currentPostition is LatLng) {
      defaultLocation =
          LatLng(currentPostition.latitude, currentPostition.longitude);
      print(
          "currentPostition::::::::: latitude:${currentPostition.latitude} , longitude :${currentPostition.longitude}");

      // if (mounted) {
      //   setState(() {});
      // }
    }
    return defaultLocation;
  }
  CustomerOutputModel? selectedClient;
  String timeOfDayToString(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0'); // Ensure two digits
    String minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(":"); // Split into ["03", "40"]
    int hour = int.parse(parts[0]); // Convert "03" to 3
    int minute = int.parse(parts[1]); // Convert "40" to 40
    return TimeOfDay(hour: hour, minute: minute);
  }
  Widget renderInputField(Question formItem) {
    switch (AppShared.questionTypeList[formItem.questionType??0].questionType) {
      case FormItemType.ShortText:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text(formItem.question,style:  const TextStyle(
            //     fontWeight: FontWeight.bold),),
            // SizedBox(height: 12,),
            TextFormField(
              controller: TextEditingController(text: "${formItem.answer ?? ''}"),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 0.7,
                    )),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) {
                if (formItem.isRequired && value?.isEmpty == true) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                if (value != null && value.length > 50) {
                  return SharedLocalization.getLocalization!().short_error;
                }
                if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
                  return SharedLocalization.getLocalization!().filedRequired; // Error message
                }
                return null;
              },
              onChanged: (String? value){
                formItem.answer = value;
              },
              onSaved: (value) => _formData[formItem.question??''] = value,
            ),
          ],
        );
      case FormItemType.LongText:

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text(formItem.question,style:  const TextStyle(
            //     fontWeight: FontWeight.bold),),
            // SizedBox(height: 12,),
            TextFormField(
              controller: TextEditingController(text: "${formItem.answer ?? ''}"),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 0.7,
                    )),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              maxLines: 6,
              validator: (value) {
                if (formItem.isRequired && value?.isEmpty == true) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
                  return SharedLocalization.getLocalization!().filedRequired; // Error message
                }
                return null;
              },
              onChanged: (String? value){
                formItem.answer = value;
              },
              onSaved: (value) => _formData[formItem.question] = value,
            ),
          ],
        );
      case FormItemType.SingleChoice:
        List<DropdownMenuItem<Option>> dropdownItems = [];
        if (!formItem.isRequired) {
          dropdownItems.add(
            DropdownMenuItem<Option>(
              child: Text(""),
              value: null,
            ),
          );
        }
        formItem.options ??= [];
        List<Option> options = formItem.options!
            .where((option) => option.isHide == false) // Filter hidden options
            .map((option) => option) // Extract the option string
            .toList();
        dropdownItems.addAll(
          options
              .where((option) => option.option?.isNotEmpty ?? false

          ) // Ignore empty or null options
              .map(
                (option) => DropdownMenuItem(
              value: option,
              child: Text(option.option ?? ''),
            ),
          ),
        );
        // formItem.answer="39";
        Option? selectedOption;
        print("formItem.answer::::::::: ${formItem.answer} ");
        if (formItem.answer != '' && formItem.answer != null) {
          selectedOption = options.firstWhere(
                (opt) => opt.id == int.tryParse(formItem.answer ?? ''),
            orElse: () => Option(id: -1, option: ''), // Provide a default invalid Option
          );

          // If a default option was used, set selectedOption to null
          if (selectedOption.id == -1) {
            selectedOption = null;
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<Option>(
              value: selectedOption,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.7),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.7)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              items: dropdownItems,
              onChanged: (value) {
                _formData[formItem.question] = value;
                formItem.answer=value?.id?.toString();
                print(" formItem.answer>>>>>>> ${ formItem.answer}");
              },
              validator: (value) {
                if (formItem.isRequired && value == null) {
                  return SharedLocalization.getLocalization!().pleaseSelectOption;
                }
                if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
                  return SharedLocalization.getLocalization!().filedRequired; // Error message
                }
                return null;
              },
            ),
          ],
        );
      case FormItemType.MultiChoice:
        formItem.options ??= [];
        List<String> options = formItem.options!
            .where((option) => option.isHide == false) // Filter hidden options
            .map((option) => option.option ?? '') // Extract the option string
            .where((option) => option.trim().isNotEmpty) // Remove empty options
            .toList();
        return FormField<List<String>>(
          validator: (value) {
            if (formItem.isRequired && (value == null || value.isEmpty)) {
              return SharedLocalization.getLocalization!().pleaseSelectOption; // Show error message
            }
            if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
              return SharedLocalization.getLocalization!().filedRequired; // Error message
            }
            return null; // No error
          },
          builder: (FormFieldState<List<String>> fieldState) {
            return StatefulBuilder(
              builder: (context, setInnerState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (options.isNotEmpty)
                      ...options.map((option) => CheckboxListTile(
                        activeColor: AppTheme.accentColor,
                        title: Text(option),
                        value: (formItem.answer as String?)?.split(',').contains(option) ?? false,
                        onChanged: (bool? value) {
                          if (value == null) return;

                          setInnerState(() {
                            List<String> selectedOptions = (formItem.answer as String?)?.split(',') ?? [];

                            if (value) {
                              selectedOptions.add(option);
                            } else {
                              selectedOptions.remove(option);
                            }

                            if (selectedOptions.isEmpty) {
                              formItem.answer = null;
                            } else {
                              formItem.answer = selectedOptions.join(',');
                            }

                            // Update FormField state
                            fieldState.didChange(selectedOptions);
                          });
                        },
                      )),

                    // Show validation error message
                    if (fieldState.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Text(
                          fieldState.errorText ?? '',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        );
      case FormItemType.Number:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: TextEditingController(text: formItem.answer ?? ''),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.7),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.7)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Ensures only integers
              validator: (value) {
                if (formItem.isRequired && (value == null || value.isEmpty)) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                if (value != null && int.tryParse(value) == null) {
                  return SharedLocalization.getLocalization!().validNumber;
                }
                if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
                  return SharedLocalization.getLocalization!().filedRequired; // Error message
                }
                return null;
              },
              onChanged: (String? value){
                formItem.answer = value;
              },
              onSaved: (value) =>
              _formData[formItem.question] = int.parse(value!),
            ),
          ],
        );
      case FormItemType.Float:
        TextEditingController controller =
        TextEditingController(text:
        formItem.answer == null || formItem.answer == ""?
        "00.00": formItem.answer );
        FocusNode focusNode = FocusNode();
        focusNode.addListener(() {
          if (!focusNode.hasFocus) {
            // Convert to decimal format when losing focus
            if (controller.text.isNotEmpty) {
              double? number = double.tryParse(controller.text);
              if (number != null) {
                controller.text = number.toStringAsFixed(2);
              }
            }
          }
        });
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller,
              focusNode: focusNode, // Attach focus node
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.7),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.7)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
              ],
              validator: (value) {
                if (formItem.isRequired && (value == null || value.isEmpty)) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                if (double.tryParse(value ?? '') == null) {
                  return SharedLocalization.getLocalization!().validNumber;
                }
                if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
                  return SharedLocalization.getLocalization!().filedRequired; // Error message
                }
                return null;
              },
              onTap: () {
                // Select all text when user taps
                controller.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller.text.length,
                );
              },
              onTapOutside: (val){
                if (controller.text.isNotEmpty) {
                  double? number = double.tryParse(controller.text);
                  if (number != null) {
                    controller.text = number.toStringAsFixed(2);
                  }
                }
              },
              onChanged: (String? value){
                formItem.answer = value;
              },
              onSaved: (value) {
                _formData[formItem.question] = double.parse(value ?? '0.00');
              },
            ),
          ],
        );
      case FormItemType.Date:
        if(formItem.answer!= null && formItem.answer != ''){
          _formData[formItem.question] =  DateTime.parse(formItem.answer);
        }
      // Create a controller for the text field
        TextEditingController dateController = TextEditingController(
          text: _formData[formItem.question] != null
              ? (_formData[formItem.question] as DateTime).toLocal().toString().split(' ')[0]
              : '',
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: dateController, // Use the controller
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 0.7),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: AppTheme.accentColor,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.accentColor,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (selectedDate != null) {
                  // Update the text field without setState
                  dateController.text = selectedDate.toLocal().toString().split(' ')[0];
                  _formData[formItem.question] = selectedDate;
                  formItem.answer = selectedDate.toString();
                }
              },
              validator: (value) {
                if (formItem.isRequired && value!.isEmpty) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
                  return SharedLocalization.getLocalization!().filedRequired; // Error message
                }
                return null;
              },
            ),
          ],
        );
      case FormItemType.Time:
      // Create a controller for the text field
       print("formItem.answer ${formItem.answer}");
        if(formItem.answer!= null && formItem.answer != ''){
          _formData[formItem.question] =
              stringToTimeOfDay(formItem.answer);

        }
        TextEditingController timeController = TextEditingController(
          text: _formData[formItem.question] != null
              ? (_formData[formItem.question] as TimeOfDay).format(context)
              : '',
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: timeController, // Use the controller
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 0.7),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  initialEntryMode: TimePickerEntryMode.inputOnly,
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: AppTheme.accentColor,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.accentColor,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (selectedTime != null) {
                  // Update the controller without using setState
                  timeController.text = selectedTime.format(context);
                  _formData[formItem.question] = selectedTime;

                  formItem.answer =  timeOfDayToString(selectedTime);
                }
              },
              validator: (value) {
                if (formItem.isRequired && value!.isEmpty) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
                  return SharedLocalization.getLocalization!().filedRequired; // Error message
                }
                return null;
              },
            ),
          ],
        );
      case FormItemType.Attachment:
        return AttachmentWidget(
          formItem: formItem,
        );
      case FormItemType.Location:
        if (formItem.answer != null && formItem.answer!.isNotEmpty) {
          _formData[formItem.question] = formItem.answer;
        }
        // Create a ValueNotifier to track location updates
        ValueNotifier<String?> locationNotifier = ValueNotifier<String?>(_formData[formItem.question]);
        return FormField<String>(
          validator: (value) {
            if (formItem.isRequired && (value== null || value.isEmpty)) {
              return SharedLocalization.getLocalization!().filedRequired; // Error message
            }
            if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
              return SharedLocalization.getLocalization!().filedRequired; // Error message
            }
            return null;
          },
          builder: (FormFieldState<String> fieldState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    LoaderService.show();
                    LatLng? t = await selectFirstBranchLocation(
                      LatLng(30.044420, 31.235712),
                      false,
                    );

                    if (t == null) {
                      // Reset the value if canceled
                      locationNotifier.value = null;
                      _formData.remove(formItem.question);
                      formItem.answer = null;
                      fieldState.didChange(null);
                    } else {
                      // Update with the new location
                      String newLocation = "${t.latitude},${t.longitude}";
                      locationNotifier.value = newLocation;
                      _formData[formItem.question] = newLocation;
                      formItem.answer = newLocation;
                      fieldState.didChange(newLocation);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: ValueListenableBuilder<String?>(
                      valueListenable: locationNotifier,
                      builder: (context, location, child) {
                        return Column(
                          children: [
                            (location == null || location.isEmpty)
                                ? Center(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: fieldState.hasError ? Colors.red : Colors.black54),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    SharedLocalization.getLocalization!().selectLocation,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                                : Container(
                              height: 200,
                              child: Stack(
                                children: [
                                  // Display the map
                                  StaticMapScreen(
                                    latitude: double.parse(location.split(',')[0]),
                                    longitude: double.parse(location.split(',')[1]),
                                  ),

                                  // Circular close button to reset location
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Reset location when clicking the close button
                                        locationNotifier.value = null;
                                        _formData.remove(formItem.question);
                                        formItem.answer = null;
                                        fieldState.didChange(null);
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                // Show validation error message if needed
                if (fieldState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text(
                      fieldState.errorText ?? '',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
              ],
            );
          },
        );
      case FormItemType.Client:
        CustomerOutputModel answer;
        if(formItem.answer != null &&formItem.answer != ''){

          // Parse JSON to Map
          // Map<String, dynamic> jsonMap = jsonDecode(formItem.answer.toString());
          // Map<String, dynamic> jsonMap = jsonDecode(formItem.answer);

         selectedClient = CustomerOutputModel.fromJson(jsonDecode(formItem.answer));
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              hintText: selectedClient != null
                  ? LocalizationService.isArabic?
                      selectedClient!.customerName:
                      selectedClient!.customerNameEn
                  : SharedLocalization.getLocalization!().selectClient,
              hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            style: const TextStyle(fontSize: 16, color: Colors.black),
            readOnly: true, // Prevent manual editing
            onTap: () async {
               CustomerOutputModel? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectCustomerScreen(),
                ),
              );

              if (result != null) {
                //formItem.answer = jsonEncode(result?.toJson());
                selectedClient = result;
                (context as Element).markNeedsBuild(); // Refresh UI without setState
              }
              print("id ..... ${result?.id}");
               formItem.answer =  jsonEncode(result?.toJson());
                 // "${result?.id},${result?.customerName},${result?.customerNameEn},";
            },
            validator: (value) {
              if (formItem.isRequired && selectedClient == null) {
                return SharedLocalization.getLocalization!().pleaseSelectAClient;
              }
              if (formItem.isRequired && (formItem.answer == null || formItem.answer.isEmpty)) {
                return SharedLocalization.getLocalization!().filedRequired; // Error message
              }
              return null;
            },
          ),
        );
      case FormItemType.ClientSignature:
        return SignatureWidget(

        question:formItem, formKey: _formKey,);

      default:
        return Container(
          height: 60,
        );
    }
  }
}
