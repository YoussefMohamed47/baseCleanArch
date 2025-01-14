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
//                             return 'This field is required';
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
//                             return 'This field is required';
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
//                             return 'Please select an option';
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
//                             return 'This field is required';
//                           }
//                           if (value != null &&
//                               int.tryParse(value) == null) {
//                             return 'Please enter a valid number';
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
//                             return 'This field is required';
//                           }
//                           if (value != null &&
//                               double.tryParse(value) == null) {
//                             return 'Please enter a valid number';
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
//                             return 'This field is required';
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
//                             return 'This field is required';
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
import 'package:questionnaire/domain/model/make_form_template/form_item_model.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_module/constants/app.consts.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:file_picker/file_picker.dart';

import '../widgets/attachment_widget.dart';
import '../widgets/location_widget.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_module/Widget/map.widget.dart';

import 'package:shared_module/Widget/toaster.widget.dart';

import 'package:geolocator/geolocator.dart';

class DynamicForm extends StatefulWidget {
  final String formName;
  final List<FormItem> formItems;

  DynamicForm({required this.formName, required this.formItems});

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};
  int _currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final FormItem currentFormItem = widget.formItems[_currentQuestionIndex];
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
                  return 'This field is required';
                }
                if (value != null && value.length > 50) {
                  return 'Must not exceed 50 characters';
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
                  return 'This field is required';
                }
                return null;
              },
              onSaved: (value) => _formData[formItem.question] = value,
            ),
          ],
        );
      case FormItemType.SingleChoice:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(formItem.question),
            // SizedBox(height: 12,),
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
              items: formItem.options!
                  .map((option) => DropdownMenuItem(
                        child: Text(option),
                        value: option,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _formData[formItem.question] = value;
                });
              },
              validator: (value) {
                if (formItem.isRequired && value == null) {
                  return 'Please select an option';
                }
                return null;
              },
            ),
          ],
        );
      case FormItemType.MultiChoice:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(formItem.question),
            // SizedBox(height: 12,),
            Column(
              children: formItem.options!
                  .map((option) => CheckboxListTile(
                        title: Text(option),
                        value: _formData[formItem.question] != null
                            ? _formData[formItem.question].contains(option)
                            : false,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              List<String> selectedOptions =
                                  _formData[formItem.question] != null
                                      ? List.from(_formData[formItem.question])
                                      : [];
                              if (value) {
                                selectedOptions.add(option);
                              } else {
                                selectedOptions.remove(option);
                              }
                              _formData[formItem.question] = selectedOptions;
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
          ],
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
                  return 'This field is required';
                }
                if (value != null && int.tryParse(value) == null) {
                  return 'Please enter a valid number';
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
                  return 'This field is required';
                }
                if ((value != null) &&
                    (double.tryParse(value) == null) &&
                    !(value.contains("."))) {
                  return 'Please enter a valid number';
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
                  return 'This field is required';
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
                  return 'This field is required';
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
      //           'This field is required',
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
