
import 'package:flutter/material.dart';

class Validation {
  static final RegExp invalidCharacters = RegExp(r'[$%&*<>\[\]{}‘“;\/|^#-]');
  static final RegExp mobileNumberRegExp =
      RegExp('^(0|00)([1-9]{1,4})([0-9]{8,12})\$');

  static String? isEmptyValidator(
    BuildContext context,
    String? value,
    //  String name,
  ) {
    //  value = value!.cleanupWhiteSpace();
    if (value!.isEmpty || value.trim().isEmpty) {
      return 'Please Enter Name';
    } else {
      return null;
    }
  }

  static String? minLengthValidator(
      BuildContext context, String value, int minLength) {
    if (value.length < minLength) {
      return
          'Enter Min Length For the Field'; //EasyLocalization.of(context)?.pleaseEnterMinLength("$minLength") ??

    } else {
      return null;
    }
  }

  static String? maxLengthValidator(
      BuildContext context, String value, int maxLength) {
    if (value.length > maxLength) {
      return
          'Enter Max Length'; //EasyLocalization.of(context)?.pleaseEnterMinLength("$maxLength") ??" ";
    } else {
      return null;
    }
  }

  static String? mobileValidator(BuildContext context, String value) {
    RegExp mobilePattern = RegExp('^(5)(5|0|3|6|4|9|1|8|7)([0-9]{7})\$');

    if (!mobileNumberRegExp.hasMatch(value)) {
      return
          'Enter Right Phone Number'; //EasyLocalization.of(context)?.mobilePhoneWrongRegex ?? " ";
    } else {
      return null;
    }
  }

  static String? invalidCharacterValidator(BuildContext context, String value) {
    String specialCharacter = '!\$%.,&*<>[]{]‘“;/\?+|^#'; //:
    String foundedSpecialCharacter = '';

    specialCharacter.split('').forEach((element) {
      if (value.indexOf(element) >= 0) {
        foundedSpecialCharacter += element;
      }
    });
    if (foundedSpecialCharacter.length > 0) {
      return
          'Character Not Valid'; //EasyLocalization.of(context)?.invalidCharacter ?? " ";
    }
    return null;
  }

  static String? dateTimeValidator(
      BuildContext context, String value, String name) {
    if (DateTime.tryParse(value) == null) {
      return
          'Date Time Not Valid'; //EasyLocalization.of(context)?.dateTimeWrongRegex ?? " ";
    }
    return null;
  }

  static String? emailValidator(String value) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (value.isEmpty) {
      return 'Please Enter Email';
    } else if (!emailValid) {
      return 'Please Enter Valid Email';
    }
    return null;
  }
}
