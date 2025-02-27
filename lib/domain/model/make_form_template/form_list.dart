import '../from_model.dart';

class FormListModel {
  int? totalCount;
  List<FormModel>? items;

  FormListModel({
    this.totalCount,
    this.items,
  });

  factory FormListModel.fromJson(Map<String, dynamic> json) {
    return FormListModel(
      totalCount: json['totalCount'],
      items: json['items'] != null ? (json['items'] as List).map((i) => FormModel.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'items': items?.map((i) => i.toJson()).toList(),
    };
  }
}



