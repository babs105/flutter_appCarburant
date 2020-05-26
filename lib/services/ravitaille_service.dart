import 'dart:io';

import 'package:appcarburant/constantes/constants_network.dart' show baseURL;
import 'package:http/http.dart' as http;
import 'dart:convert';

class RavitailleService  {
  static Future <dynamic> getAllOperationsCuve() async {
    http.Response response = await http.get('$baseURL/operationsCuve/getAllOperationsCuve');
    // if (response.statusCode == 200) {
    String data = response.body;

    var jsonObject = jsonDecode(data);
    return jsonObject;

    //  } else {
    //print(response.statusCode);
    //  }


  }

  static Future <dynamic> ravitaillerVehicule(String dateRavitay, String immatricule, double quantityRavitay, int kilometrage,String idUser) async {
    print('future method getevent terminer');

    http.Response response = await http.post('$baseURL/operationsCuve/ravitaillerVehicule'
        ,body:json.encode(
            {

              "dateRavitay": dateRavitay,
              "immatricule": immatricule,
              "quantityRavitay":quantityRavitay,
              "kilometrage": kilometrage,
              "idUser" : idUser

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