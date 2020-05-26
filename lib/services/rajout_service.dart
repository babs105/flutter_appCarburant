import 'dart:io';

import 'package:appcarburant/constantes/constants_network.dart' show baseURL;
import 'package:http/http.dart' as http;
import 'dart:convert';

class RajoutService  {
  static Future <dynamic> getAllRajout() async {
    http.Response response = await http.get('$baseURL/rajout/getAllRajout');
    // if (response.statusCode == 200) {
    String data = response.body;

    var jsonObject = jsonDecode(data);
    return jsonObject;

    //  } else {
    //print(response.statusCode);
    //  }


  }

  static Future <dynamic> rajouterCuve(String dateRajout, double qteRajout, String cuveName,String stationServiceName) async {
    print('future method getevent terminer');

    http.Response response = await http.post('$baseURL/rajout/rajouterCuve'
        ,body:json.encode(
            {

              "dateRajout": dateRajout,
              "qteRajout": qteRajout,
              "cuveName": cuveName,
              "stationServiceName":stationServiceName

            }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    // if (response.statusCode == 200) {
    String data = response.body;

    var jsonObject = jsonDecode(data);
    return jsonObject;

    //  } else {
    //print(response.statusCode);
    //  }


  }
}


