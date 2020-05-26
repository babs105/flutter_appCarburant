

import 'dart:io';

import 'package:appcarburant/constantes/constants_network.dart' show baseURL;
import 'package:http/http.dart' as http;
import 'dart:convert';


class CuveService  {
  static Future <dynamic> getAllCuves() async {
    http.Response response = await http.get('$baseURL/cuve/getAllCuves');
    // if (response.statusCode == 200) {
    String data = response.body;

    var jsonObject = jsonDecode(data);
    return jsonObject;

    //  } else {
    //print(response.statusCode);
    //  }


  }
}
