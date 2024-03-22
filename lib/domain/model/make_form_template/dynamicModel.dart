import 'package:questionnaire/app/app_enums.dart';
import 'package:questionnaire/domain/model/make_form_template/ItemModel.dart';
import 'package:questionnaire/domain/model/make_form_template/dynamic_form_validator.dart';

class DynamicModel {
  String? controlName;
  FormItemType? formType;
  String? value;
  List<ItemModel> items;
  ItemModel? selectedItem;
  bool isRequired;
  List<DynamicFormValidator> validators;
  DynamicModel(
      {
        this.controlName, this.formType,
        this.items = const [],
         this.selectedItem ,
        this.isRequired = false,
        this.validators = const []});
}