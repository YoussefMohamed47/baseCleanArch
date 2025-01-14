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
import 'package:flutter/material.dart';
import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/client_model.dart';
import 'package:questionnaire/domain/model/make_form_template/form_item_model.dart';
import 'package:questionnaire/presentation/resources/base_page_route.dart';
import 'package:questionnaire/screens/build_questionnaire_form/view/build_questionnaire_form_view.dart';
import 'package:shared_module/Widget/app_scaffold.dart';
import 'package:shared_module/localization/shared.localization.dart';

class QuestionairesInfoView extends StatefulWidget {
  final String formName;
  final ClientItemModel? customerName;
  final List<FormItem> formItems;

  QuestionairesInfoView({required this.formName, required this.customerName, required this.formItems});

  @override
  _QuestionairesInfoViewState createState() => _QuestionairesInfoViewState();
}

class _QuestionairesInfoViewState extends State<QuestionairesInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};
  int _currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final FormItem currentFormItem = widget.formItems[_currentQuestionIndex];
    return


      AppScaffold(
        pageTitle: "معلومات الاستبيان",
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),

        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: 22,),
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
            Expanded(child: SizedBox()),
            Container(
              width: double.infinity,
              height: 51,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed:  () {
                      Navigator.push(
                          context,
                          BasePageRoute(
                              builder: (context) => DynamicForm(
                                formName: widget.formName ?? '',
                                formItems:  widget.formItems,
                              )));
                    }
                    ,
                    child: Container(
                        width: MediaQuery.of(context).size.width /3.3,
                        child: Center(child: Text('${SharedLocalization.getLocalization!().next}'))),
                  ),
                  ElevatedButton(
                    onPressed:
                         () {
                      Navigator.pop(context);
                    }
                        ,
                    child: Container(
                        width: MediaQuery.of(context).size.width /3.3,
                        child: Center(child: Text('${SharedLocalization.getLocalization!().cancel}'))),
                  ),
                ],
              ),
            )

          ],
        ),
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
                    borderSide:  BorderSide(width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:  BorderSide(
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
                    borderSide:  BorderSide(width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:  BorderSide(
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
                    borderSide:  BorderSide(width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:  BorderSide(
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
                    borderSide:  BorderSide(width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:  BorderSide(
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
                if (value != null &&
                    int.tryParse(value) == null) {
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
                    borderSide:  BorderSide(width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:  BorderSide(
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
                if (formItem.isRequired && value!.isEmpty) {
                  return 'This field is required';
                }
                if (value != null &&
                    double.tryParse(value) == null) {
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
                    borderSide:  BorderSide(width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:  BorderSide(
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
                    borderSide:  BorderSide(width: 0.7,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:  BorderSide(
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
      default:
        return Container(height: 60,);
    }
  }
}
