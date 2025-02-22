import 'package:flutter/material.dart';

class QuestionOptionModel {
  //int id;
  int parentId;
 // String name;
  TextEditingController optionController;
   bool isHide;
  QuestionOptionModel( this.optionController, {this.parentId = 0,required this.isHide});}