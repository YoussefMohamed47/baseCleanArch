

import 'package:shared_module/helper/endpoints.dart';
import 'package:shared_module/service/network_module.dart';
import '../../model/from_model.dart';
import '../../model/make_form_template/form_list.dart';

class FormRepository {


  Future<FormModel>
  addForm(FormModel input) async {
    var response = await NetworkModule.provideDio(autoLoader: true)
        .post(Endpoints.addForms, data: input.toJson());

    return FormModel.fromJson(response.data);
  }


  Future<FormModel>
  getFormDetail({required String id}) async {
    var response = await NetworkModule.provideDio(autoLoader: true)
        .get("${Endpoints.getForms}/$id");

    return FormModel.fromJson(response.data);
  }


  Future<FormModel>
  updateFormDetail({required String id,required FormModel input}) async {
    var response = await NetworkModule.provideDio(autoLoader: true)
        .put("${Endpoints.getForms}/$id",data: input.toJson());

    return FormModel.fromJson(response.data);
  }


  Future<FormListModel>
  getForm({required bool isTemplate}) async {
    var response = await NetworkModule.provideDio(autoLoader: true).get(Endpoints.addForms,

    queryParameters: {"IsTemplate":isTemplate,"SkipCount":0,"MaxResultCount":1000}
    );

    return FormListModel.fromJson(response.data);
  }

}
