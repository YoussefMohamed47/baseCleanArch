import 'package:flutter/material.dart';

class ItemModel {
  //int id;
  int parentId;
 // String name;
  TextEditingController optionController;
   bool isHide;
  ItemModel( this.optionController, {this.parentId = 0,required this.isHide});}