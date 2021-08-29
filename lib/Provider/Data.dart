import 'package:shared_preferences/shared_preferences.dart';

import '../Services/Network.dart';
import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier {
  var data = [];

  String id = '';

  Future<dynamic> login(body) async {
    NetworkHelper networkHelper = NetworkHelper();

    var response = await networkHelper.postMethod('user-login', body);

    print(response);
    if (response['code'] == '500') return response;
    this.id = response['id'];

    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString('id', response['id']);
    sharedpref.setString('email', response['email']);
    sharedpref.setString('role', response['role']);

    return response;
  }

  Future<List> getMaterialBySuject(body) async {
    NetworkHelper networkHelper = NetworkHelper();
    var response =
        await networkHelper.postMethod('material/get-materials', body);
    if (response['data'] != null) {
      return response['data'];
    }
    return [];
  }

  Future<List> addMaterialBySuject(body) async {
    NetworkHelper networkHelper = NetworkHelper();
    var response =
        await networkHelper.postMethod('material/add-material', body);
    if (response['data'] != null) {
      return response['data'];
    }
    return [];
  }
}
