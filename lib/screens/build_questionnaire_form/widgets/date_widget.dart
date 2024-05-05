//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:questionnaire/screens/build_questionnaire_form/widgets/date_picker.dart';
// import 'package:questionnaire/utils/colors/appColors.dart';
// import 'package:questionnaire/utils/strings/hex_color_strings.dart';
//
// class TextQuestion extends StatefulWidget {
//   final TextEditingController textEditingController;
//   final TextInputType keyboardType;
//   final Widget? suffixWidget;
//   final Widget? prefixWidget;
//   final ValueChanged<String>? onChanged;
//   Function()? onTap;
//   final String? hint;
//   TextAlign? textAlign;
//   double? hintFontSize;
//   bool isEnabled;
//   bool isReadOnly;
//   Color? hintTextColor = Colors.black;
//   String? hintFontFamily;
//   double borderRadius;
//   Color fillColor;
//   int? maxLength;
//   int? maxLines;
//   int? minLines;
//
//   EdgeInsets? contentPadding;
//   final String? Function(String?)? fieldValidator;
//
//   bool isPassword;
//   List<TextInputFormatter>? inputFormatters;
//   TextQuestion({
//     Key? key,
//     required this.textEditingController,
//     required this.keyboardType,
//     this.onChanged,
//     this.hint,
//     this.textAlign = TextAlign.start,
//     this.isPassword = false,
//     required this.fieldValidator,
//     this.hintFontSize,
//     this.maxLength,
//     this.contentPadding,
//     this.hintFontFamily,
//     this.fillColor = Colors.white,
//     this.hintTextColor,
//     this.isEnabled = true,
//     this.borderRadius = 20,
//     this.isReadOnly = false,
//     this.onTap,
//     this.suffixWidget,
//     this.prefixWidget,
//     this.maxLines,
//     this.minLines,
//     this.inputFormatters,
//   }) : super(key: key);
//
//   @override
//   State<TextQuestion> createState() => _TextQuestionState();
// }
//
// class _TextQuestionState extends State<TextQuestion> {
//   bool visible = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: TextfieldDatePicker(
//         // key: _formKey,
//         textfieldDatePickerWidth: 1.sw,
//         materialDatePickerInitialEntryMode:DatePickerEntryMode.calendarOnly,
//         cupertinoDatePickerBackgroundColor: Colors.white,
//         cupertinoDatePickerMaximumDate: DateTime(2099),
//         cupertinoDatePickerMaximumYear: 2099,
//         cupertinoDatePickerMinimumYear: 1990,
//         cupertinoDatePickerMinimumDate: DateTime(1990),
//         cupertinoDateInitialDateTime: DateTime(1990),
//         materialDatePickerFirstDate: DateTime(1990),
//         materialDatePickerInitialDate:
//         // _viewModel.searchDate!=''?
//         // DateTime.parse('${_viewModel.searchDate} 00:00:00.000'):
//         DateTime.now(),
//         materialDatePickerLastDate: DateTime(2099),
//         preferredDateFormat: DateFormat('yyyy-MM-dd','en'),
//         materialDatePickerLocale: const Locale('en'),
//         onSaved: (String? date){
//           print(">>>>>>>>. $date");
//
//           try{
//             // _viewModel.searchDate=date ??'';
//             // print("data.searchDate${_viewModel.searchDate}");
//             // _viewModel.searchAlmaryiyaat(0,1,date??'');
//           }catch(e){
//             print(">KKJN> $e");
//           }
//         },
//       //  textfieldDatePickerController: ,
//         style: TextStyle(
//           fontSize:14.sp,
//           fontWeight: FontWeight.w500,
//           color: Colors.blue,
//         ),
//         //textfieldDatePickerPadding: EdgeInsets.only(top: 2.h),
//         //   textfieldDatePickerMargin: EdgeInsets.only(top: 1.h),
//         //textfieldDatePickerPadding: EdgeInsets.only(top: 10.h),
//         textCapitalization: TextCapitalization.sentences,
//         cursorColor: AppColors.blackColor,
//         textAlign: TextAlign.left,
//         textAlignVertical: TextAlignVertical.center,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(right: 22.w,top: 6.h,bottom: 0.h),
//             //errorText: errorTextValue,
//             suffixIconColor: AppColors.blackColor,
//             suffixIconConstraints: BoxConstraints(
//                 maxHeight: 55.w,
//                 maxWidth: 55.w
//             ),
//             // suffixIcon: Padding(
//             //   padding:  EdgeInsets.only(
//             //       left: 22.0.w,right:0,top: 8,bottom: 8),
//             //   child: SvgPicture.asset(ImageAssets.calender,
//             //     color: ColorManager.primaryLib,
//             //     // fit: BoxFit.cover,
//             //   ),
//             // ),
//             helperStyle: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.grey),
//             focusedBorder: OutlineInputBorder(
//                 borderSide:  const BorderSide(width: 1,
//                   color: AppColors.blackColor,),
//                 borderRadius: BorderRadius.circular(22)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(22),
//                 borderSide:  BorderSide(
//                   width: 1.w,
//                   color: AppColors.blackColor,
//                 )),
//             hintText: 'hint text',
//             hintStyle: TextStyle(
//
//                 color: const Color(0xffc3c3c3),
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w500),
//             filled: true,
//             fillColor: AppColors.whiteColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             isDense:false
//         ),
//         textfieldDatePickerController: widget.textEditingController,
//
//       ),
//     );
//   }
// }
