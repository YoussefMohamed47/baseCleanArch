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
//             itemCount: widget.formItems.length,
//             itemBuilder: (context, index) {
//               final formItem = widget.formItems[index];
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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/questionaires_item.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_module/constants/app.consts.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:file_picker/file_picker.dart';

import '../../../domain/model/client_model.dart';
import '../widgets/attachment_widget.dart';
import '../widgets/location_widget.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_module/Widget/map.widget.dart';

import 'package:shared_module/Widget/toaster.widget.dart';

import 'package:geolocator/geolocator.dart';

class DynamicForm extends StatefulWidget {
  final String formName;
  final List<QuestionairesItem> formItems;
   bool? validLocation;

  DynamicForm({required this.formName, required this.formItems,this.validLocation =  false});

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};
  int _currentQuestionIndex = 0;
  ClientItemModel? selectedFormId;


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


  List<ClientItemModel> allClients = [
    ClientItemModel(id: 1, name: 'عميل رقم ١'),
    ClientItemModel(id: 2, name: 'عميل رقم ٢'),
    ClientItemModel(id: 3, name: 'عميل رقم ٣'),
  ];

  @override
  void initState() {
    print("kkkkkkkkk lavalidLocationt : ${widget.validLocation}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final QuestionairesItem currentFormItem = widget.formItems[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formName),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: widget.formItems.length,
            itemBuilder: (BuildContext context, int index) {
              var currentFormItem = widget.formItems[index];
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
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if((widget.validLocation ?? false)){
              Future.microtask(() async {
                try {
                    Map<String, double> coordinates = await getCurrentLatLon();
                    print("Latitude: ${coordinates['latitude']}");
                    print("Longitude: ${coordinates['longitude']}");
                    double? lat=coordinates['latitude'] ;
                    double? long=coordinates['longitude'];
                } catch (e) {
                  print("Error: $e");
                }
              });
            }
            _formKey.currentState!.save();
            // Do something with the form data
            print(_formData);
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }

  Widget renderInputField(QuestionairesItem formItem) {
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

        formItem.options ??= [];
        List<String> options = formItem.options!
            .where((option) => option.isHide == false) // Filter hidden options
            .map((option) => option.option) // Extract the option string
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: null,
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
              items: [
                if (!formItem.isRequired)
                  DropdownMenuItem<String>(
                    child: Text(""),
                    value: null,
                  ),
                ...options!.map((option) => DropdownMenuItem(
                  child: Text(option),
                  value: option,
                )),
              ],
              onChanged: (value) {
                setState(() {
                  _formData[formItem.question] = value;
                });
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
            .where((option) {
              print("fdfsdfdf ${option}");
              return  option.trim().isNotEmpty;
        })
            .toList(); // Convert to a list once to avoid multiple iterations

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: validOptions.isEmpty
              ? [] // If no valid options, return an empty widget (prevents empty space)
              : validOptions.map((option) => CheckboxListTile(
            title: Text(option),
            value: (_formData[formItem.question] as List<String>?)?.contains(option) ?? false,
            onChanged: (bool? value) {
              if (value == null) return;

              //setState(() {
                List<String> selectedOptions =
                    (_formData[formItem.question] as List<String>?) ?? [];

                if (value) {
                  selectedOptions.add(option);
                } else {
                  selectedOptions.remove(option);
                }

                _formData[formItem.question] = selectedOptions;
              //});
            },
          )).toList(),
        );


      case FormItemType.Number:
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
              keyboardType: TextInputType.number,
              validator: (value) {
                if (formItem.isRequired && value!.isEmpty) {
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
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                print("value:..... ${value?.contains(".")}");
                print("22222:..... ${(value != null)}");
                print("333:..... ${double.tryParse(value ?? '') == null}");
                if (formItem.isRequired && value!.isEmpty) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                if ((value != null) &&
                    (double.tryParse(value) == null) &&
                    !(value.contains("."))) {
                  return SharedLocalization.getLocalization!().validNumber;
                }
                return null;
              },
              onSaved: (value) =>
                  _formData[formItem.question] = double.parse(value!),
            ),
          ],
        );
      case FormItemType.Date:
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
              readOnly: true,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  setState(() {
                    _formData[formItem.question] = selectedDate;
                  });
                }
              },
              validator: (value) {
                if (formItem.isRequired && value!.isEmpty) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                return null;
              },
              controller: TextEditingController(
                  text: _formData[formItem.question] != null
                      ? _formData[formItem.question].toString()
                      : ''),
            ),
          ],
        );
      case FormItemType.Time:
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
              readOnly: true,
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  setState(() {
                    _formData[formItem.question] = selectedTime;
                  });
                }
              },
              validator: (value) {
                if (formItem.isRequired && value!.isEmpty) {
                  return SharedLocalization.getLocalization!().filedRequired;
                }
                return null;
              },
              controller: TextEditingController(
                  text: _formData[formItem.question] != null
                      ? _formData[formItem.question].toString()
                      : ''),
            ),
          ],
        );
      case FormItemType.Attachment:
        return AttachmentWidget(
          formItem: formItem,
        );
      case FormItemType.Location:
        return GestureDetector(
          onTap: () async {
            LatLng t = await selectFirstBranchLocation(
                LatLng(30.044420, 31.235712), false);
            _formData[formItem.question] = "${t.latitude},${t.longitude}";

            print(
                "yiuyiuyiuyiuyiuy :${_formData[formItem.question].toString().split(',')[0]} ,,,, ${_formData[formItem.question].toString().split(',')[1]}");
            setState(() {});
          },
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
            child: _formData[formItem.question] == '' ||
                    _formData[formItem.question] == null
                ? Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          SharedLocalization.getLocalization!().selectLocation,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 200,
                    child: StaticMapScreen(
                      latitude: double.parse(_formData[formItem.question]
                          .toString()
                          .split(',')[0]),
                      longitude: double.parse(_formData[formItem.question]
                          .toString()
                          .split(',')[1]),
                    ),
                  ),
          ),
        );
      case FormItemType.Client:
        return  Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          //  border: Border.all(color: Colors.grey.withOpacity(0.6)),
          ),
         // padding: const EdgeInsets.only(left: 8, right: 8, top: 0 ),
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
              setState(() {
                selectedFormId = value;
              });
            },
            items: allClients.map((formItem) {
              return DropdownMenuItem<ClientItemModel?>(
                value: formItem,
                child: Text(
                  formItem.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
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

  static bool isPermissionDeniedAlways = false;

  static Future<LatLng?> getGeoLocationPosition(
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
}

class StaticMapScreen extends StatelessWidget {
  String apiKey =
      "AIzaSyBD_JWlPC70MLYCxXqZmNvQ3nbejeveuz0"; // Replace with your actual API key
  double latitude;
  double longitude;

  StaticMapScreen({
    required this.latitude,
    required this.longitude,
  });
  @override
  Widget build(BuildContext context) {
    String staticMapUrl = Uri.parse(
      "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=14&size=600x400&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=AIzaSyBD_JWlPC70MLYCxXqZmNvQ3nbejeveuz0",
    ).toString();

    return Center(
      child: Image.network(
        staticMapUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const CircularProgressIndicator();
        },
        errorBuilder: (context, error, stackTrace) {
          return const Text('Failed to load map image');
        },
      ),
    );
  }
}
