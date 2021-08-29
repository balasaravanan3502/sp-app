import 'package:shared_preferences/shared_preferences.dart';

import '../Services/Network.dart';
import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier {
  var data = [];

  String id = '';

  Future<String> login(String id, String pass, bool remember) async {
    NetworkHelper networkHelper = NetworkHelper();

    var response = await networkHelper
        .postMethod('login.php', {"user_id": id, "password": pass});

    print(response);
    this.id = id;
    if (remember) {
      id = response['user_id'];

      final SharedPreferences sharedpref =
          await SharedPreferences.getInstance();
      sharedpref.setString('uid', id);
    }

    return response['code'];
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
