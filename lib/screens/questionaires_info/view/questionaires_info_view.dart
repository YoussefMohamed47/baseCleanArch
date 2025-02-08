// import 'package:flutter/material.dart';
// import 'package:questionnaire/app/app_enums.dart';
// import 'package:questionnaire/domain/model/make_form_template/form_item_model.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/client_model.dart';
import 'package:questionnaire/domain/model/make_form_template/form_item_model.dart';
import 'package:questionnaire/presentation/resources/base_page_route.dart';
import 'package:questionnaire/presentation/resources/color_manager.dart';
import 'package:questionnaire/screens/build_questionnaire_form/view/build_questionnaire_form_view.dart';
import 'package:shared_module/Widget/app_scaffold.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/form_item_model.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_module/constants/app.consts.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_module/theme/app.theme.dart';

import '../../../domain/model/client_model.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_module/Widget/map.widget.dart';

import 'package:shared_module/Widget/toaster.widget.dart';

import 'package:geolocator/geolocator.dart';

import '../../build_questionnaire_form/widgets/attachment_widget.dart';
class QuestionairesInfoView extends StatefulWidget {
  final String formName;
  final ClientItemModel? customerName;
   List<FormItem> formItems;
  final bool validLocation;
  final bool showSurveyId;
  final String surveyId;
  final DateTime questionnaireTime;

  QuestionairesInfoView({required this.formName, required this.customerName, required this.formItems,required this.validLocation,

  required this.surveyId,
  required this.showSurveyId,
  required this.questionnaireTime,
  });

  @override
  _QuestionairesInfoViewState createState() => _QuestionairesInfoViewState();
}

class _QuestionairesInfoViewState extends State<QuestionairesInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};
  int _currentQuestionIndex = 0;




  double? lat;
  double? long;
  late List<FormItem> formItemsLocal;

  @override
  void didChangeDependencies() {
    formItemsLocal=widget.formItems.where((form)=>form.isHide==false).toList();
    super.didChangeDependencies();
  }
  @override
  void initState() {
    print("validLocation............ ${widget.validLocation}");
    formItemsLocal=widget.formItems.where((form)=>form.isHide==false).toList();
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
                    widget.customerName?.name == null ?
                    const SizedBox():
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                        child: Text(
                          "${SharedLocalization
                              .getLocalization!().customerName} : ${widget.customerName?.name ?? ''}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    // SizedBox(height: 22,),

                    Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                        child: Text(
                          "${SharedLocalization
                              .getLocalization!().surveyFormName} : ${widget.formName}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),



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
                          "${SharedLocalization.getLocalization!().surveyNumber} : ${widget.surveyId}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ):const SizedBox(),



                    const SizedBox(height: 22,),

                    Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                        child: Text(
                          "${SharedLocalization
                              .getLocalization!().surveyDate} : ${
                              DateFormat('dd-MM-yyyy').format(widget.questionnaireTime)}          ${SharedLocalization
                              .getLocalization!().surveyTime} : ${
                              DateFormat('hh:mm a').format(widget.questionnaireTime)} ",
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
                          var currentFormItem = formItemsLocal[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentFormItem.question,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if((widget.validLocation)){
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
                    Navigator.pop(context);
                  } catch (e) {
                    print("Error: $e");
                  }
                });
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
    }
    if (location == null && defaultLocation == null) {
      return;
    }
    if (!context.mounted) return;
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
  ClientItemModel? selectedFormId;

  List<ClientItemModel> allClients = [
    ClientItemModel(id: 1, name: 'عميل رقم ١'),
    ClientItemModel(id: 2, name: 'عميل رقم ٢'),
    ClientItemModel(id: 3, name: 'عميل رقم ٣'),
  ];
  Widget renderInputField(FormItem formItem) {
    switch (formItem.questionType) {
      case FormItemType.ShortText:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text(formItem.question,style:  const TextStyle(
            //     fontWeight: FontWeight.bold),),
            // SizedBox(height: 12,),
            TextFormField(
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
                return null;
              },
              onSaved: (value) => _formData[formItem.question] = value,
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
                return null;
              },
              onSaved: (value) => _formData[formItem.question] = value,
            ),
          ],
        );
      case FormItemType.SingleChoice:
        List<DropdownMenuItem<String>> dropdownItems = [];

        if (!formItem.isRequired) {
          dropdownItems.add(
            DropdownMenuItem<String>(
              child: Text(""),
              value: null,
            ),
          );
        }


        formItem.options ??= [];
        List<String> options = formItem.options!
            .where((option) => option.isHide == false) // Filter hidden options
            .map((option) => option.option) // Extract the option string
            .toList();
        dropdownItems.addAll(
          options
              .where((option) => option.trim().isNotEmpty

          ) // Ignore empty or null options
              .map(
                (option) => DropdownMenuItem(
              child: Text(option),
              value: option,
            ),
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: null,
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
              },
              validator: (value) {
                if (formItem.isRequired && value == null) {
                  return SharedLocalization.getLocalization!().pleaseSelectOption;
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
            .map((option) => option.option) // Extract the option string
            .toList();

        List<String> validOptions = options
            .where((option) => option.trim().isNotEmpty)
            .toList(); // Filter out empty options

        return StatefulBuilder(
          builder: (context, setInnerState) { // Only rebuild this part
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: validOptions.isEmpty
                  ? [] // If no valid options, return an empty widget
                  : validOptions.map((option) => CheckboxListTile(
                activeColor: AppTheme.accentColor,
                title: Text(option),
                value: (_formData[formItem.question] as List<String>?)?.contains(option) ?? false,
                onChanged: (bool? value) {
                  if (value == null) return;

                  setInnerState(() { // Update only this part
                    List<String> selectedOptions =
                        (_formData[formItem.question] as List<String>?) ?? [];

                    if (value) {
                      selectedOptions.add(option);
                    } else {
                      selectedOptions.remove(option);
                    }

                    _formData[formItem.question] = selectedOptions;
                  });
                },
              )).toList(),
            );
          },
        );


      case FormItemType.Number:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
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
                return null;
              },
              onSaved: (value) =>
              _formData[formItem.question] = int.parse(value!),
            ),
          ],
        );
      case FormItemType.Float:
        TextEditingController controller = TextEditingController(text: "00.00");
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
                return null;
              },
              onTap: () {
                // Select all text when user taps
                controller.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller.text.length,
                );
              },
              onSaved: (value) {
                _formData[formItem.question] = double.parse(value ?? '0.00');
              },
            ),
          ],
        );
      case FormItemType.Date:
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
                }
              },
              validator: (value) {
                if (formItem.isRequired && value!.isEmpty) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                return null;
              },
            ),
          ],
        );
      case FormItemType.Time:
      // Create a controller for the text field
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
                }
              },
              validator: (value) {
                if (formItem.isRequired && value!.isEmpty) {
                  return SharedLocalization.getLocalization!().filedRequired;
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
      // Create a ValueNotifier to track location updates
        ValueNotifier<String?> locationNotifier = ValueNotifier<String?>(_formData[formItem.question]);

        return GestureDetector(
          onTap: () async {
            LatLng t = await selectFirstBranchLocation(
              LatLng(30.044420, 31.235712),
              false,
            );

            String newLocation = "${t.latitude},${t.longitude}";

            // Update the ValueNotifier to trigger a UI refresh
            locationNotifier.value = newLocation;
            _formData[formItem.question] = newLocation;
          },
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
            child: ValueListenableBuilder<String?>(
              valueListenable: locationNotifier,
              builder: (context, location, child) {
                return (location == null || location.isEmpty)
                    ? Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
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
                  child: StaticMapScreen(
                    latitude: double.parse(location.split(',')[0]),
                    longitude: double.parse(location.split(',')[1]),
                  ),
                );
              },
            ),
          ),
        );


      case FormItemType.Client:
      // Create a modified list with an empty choice if required
        List<ClientItemModel?> clientList = List.from(allClients);

        if (formItem.isRequired) {
          clientList.insert(0, null); // Insert an empty choice at the beginning
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: DropdownButtonFormField<ClientItemModel?>(
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
            ),
            iconSize: 20,
            style: TextStyle(fontSize: 16),
            hint: Text(
              SharedLocalization.getLocalization!().selectClient,
              style: TextStyle(fontSize: 16),
            ),
            value: selectedFormId,
            onChanged: (value) {
             // setState(() {
                selectedFormId = value;
             // });
            },
            items: clientList.map((formItem) {
              return DropdownMenuItem<ClientItemModel?>(
                value: formItem,
                child: Text(
                  formItem == null ? SharedLocalization.getLocalization!().selectClient : formItem.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
            validator: (value) {
              if (formItem.isRequired && value == null) {
                return SharedLocalization.getLocalization!().pleaseSelectAClient;
              }
              return null; // Validation passes
            },
          ),
        );




    //   Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     // Text(formItem.question,style: const TextStyle(
    //     //     fontWeight: FontWeight.bold),),
    //     // SizedBox(height: 12,),
    //     GestureDetector(
    //       onTap: () async {
    //         final picker = ImagePicker();
    //         final XFile? image = await showModalBottomSheet<XFile>(
    //           context: context,
    //           builder: (context) => Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               ListTile(
    //                 leading: const Icon(Icons.camera_alt),
    //                 title:  Text(SharedLocalization.getLocalization!().from_camera),
    //                 onTap: () async {
    //                   final cameraImage = await picker.pickImage(source: ImageSource.camera);
    //                   Navigator.pop(context, cameraImage);
    //                 },
    //               ),
    //               ListTile(
    //                 leading: const Icon(Icons.photo_library),
    //                 title:  Text(SharedLocalization.getLocalization!().from_gallery),
    //                 onTap: () async {
    //                   final galleryImage = await picker.pickImage(source: ImageSource.gallery);
    //                   Navigator.pop(context, galleryImage);
    //                 },
    //               ),
    //             ],
    //           ),
    //         );
    //
    //         if (image != null) {
    //           setState(() {
    //             _formData[formItem.question] = image.path;
    //           });
    //         }
    //       },
    //       child: Container(
    //         height: 150,
    //         width: double.infinity,
    //         decoration: BoxDecoration(
    //           border: Border.all(width: 0.7),
    //           borderRadius: BorderRadius.circular(5),
    //           color: Colors.white,
    //         ),
    //         child: _formData[formItem.question] == null
    //             ? Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children:  [
    //               Icon(Icons.add_photo_alternate_outlined, size: 50, color: Colors.grey),
    //               Text(
    //                 "${SharedLocalization.getLocalization!().tap_upload_image}",
    //                 style: TextStyle(color: Colors.grey),
    //               ),
    //             ],
    //           ),
    //         )
    //             : Image.file(
    //           File(_formData[formItem.question]!),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //     if (formItem.isRequired && (_formData[formItem.question]?.isEmpty ?? true))
    //       const Padding(
    //         padding: EdgeInsets.only(top: 8.0),
    //         child: Text(
    //           SharedLocalization.getLocalization!().filedRequired,
    //           style: TextStyle(color: Colors.red, fontSize: 12),
    //         ),
    //       ),
    //   ],
    // );
    // 1- permission for ask photo / location
    // 2- get loction for form on save
    // 3- serail number for each form
    // display can show serail number or not
    // drop down to select client for form for back end
    // filter form name / client / seiral number / third date
    //permission for form can show forms
    // can add form or not
    // can edit form or not

      default:
        return Container(
          height: 60,
        );
    }
  }
}
