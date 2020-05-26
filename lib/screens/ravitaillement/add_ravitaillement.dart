import 'package:appcarburant/data/vehicules.dart';
import 'package:appcarburant/services/ravitaille_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddRavitaillement extends StatefulWidget {
  @override
  _AddRavitaillementState createState() => _AddRavitaillementState();
}

class _AddRavitaillementState extends State<AddRavitaillement> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy HH:mm");
  String dateTimeString;
  String dateTimeString1;
  String matriculeVehicule;
  int kilometrage;
  double qteRavitaille;
  String idUser;
  Widget load;
  dynamic ravitailleResponse;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTimeString = '';
    matriculeVehicule = '';
    kilometrage = 0;
    qteRavitaille = 0.0;
    getPrefsIdUser();
    load = null;
  }
  void getPrefsIdUser() async{
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.get('idUser') ??'';
  }

  void ravitaillerVehicule(BuildContext context) async {


    var response = await RavitailleService.ravitaillerVehicule(
        dateTimeString1,
        matriculeVehicule,
        qteRavitaille,
        kilometrage,
        idUser
    );
    print(response);

    if (response['error'] == true) {
      setState(() {
        load = null;
        ravitailleResponse = response['ravitaillementRequest'];

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Ravitaillement effectué avec succes',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.green,
        ));
        print(ravitailleResponse);
      });
    }else{
      load = null;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Operation Echouée !!!',
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.red,
      ));

    }
  }

  void loading() {
    setState(() {
      load = loadingUI();
    });
  }

  Widget loadingUI() {
    return (Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: CircularProgressIndicator(),
      ),
    ));
  }


  saveForm(BuildContext context) {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'En cours de traitement',
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.pinkAccent,
      ));
      loading();
      ravitaillerVehicule(context);


    }
    //form.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ravitailler'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Builder(builder: (BuildContext context) {
          return Form(
            key: _formKey,
            autovalidate: false,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimeField(
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                    decoration: InputDecoration(
                        filled: true,
                        hintText: 'Date et Heure début patrouille',
                        labelText: 'Date et Heure',
                        prefixIcon: Icon(
                            Icons.date_range
                        )
                    ),
                    onSaved: (value) {
                      dateTimeString = format.format(value);
                      dateTimeString1 =
                          value.toIso8601String().substring(0,16);
                      print(dateTimeString);
                    },

                    onChanged: (value) {
                      dateTimeString = format.format(value);
                      dateTimeString1 =
                          value.toIso8601String().substring(0,16);
                      print(dateTimeString);
                    },
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null) {
                        return 'Entrez la Date et l\'heure';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropDownFormField(
                    filled: true,

                    titleText: 'Matricule Vehicule',
                    hintText: 'selectionnez votre Vehicule',
                    value: matriculeVehicule,
                    onSaved: (value) {
                      setState(() {
                        matriculeVehicule = value;
                      });

                    },
                    onChanged: (value) {
                      setState(() {
                        matriculeVehicule = value;
                      });

                    },
                    dataSource: vehicules,
                    validator: (value) {
                      if (value == null) {
                        return 'Entrez le Matricule Vehicule';
                      }
                      return null;
                    },
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Kilometrage',
                        labelText: 'Kilometrage',
                        filled: true,
                        prefixIcon: Icon(
                            Icons.slow_motion_video
                        )
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onSaved: (value) => setState(() => kilometrage = int.parse(value)),
                    onChanged: (value) {
                      kilometrage = int.parse(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Entrez le kilometrage';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Quantité Ravitaillée',
                        labelText: 'Quantité Ravitaillée',
                        filled: true,
                        prefixIcon: Icon(
                            Icons.slow_motion_video
                        )
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onSaved: (value) => setState(() => qteRavitaille = double.parse(value)),
                    onChanged: (value) {
                      qteRavitaille = double.parse(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Entrez la quantité';
                      }
                      return null;
                    },
                  ),
                ),

                Center(
                  child: Container(
                    child: load,
                  ),
                ),
                Container(

                    padding: EdgeInsets.only(left: 8.0, top: 20.0, right: 8.0),
                    child: RaisedButton(
                      color: Color(0xFF100D60),
                      child: Text(
                        'Valider',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        print("send");

                        print(dateTimeString);
                        print(dateTimeString1);
                        print(kilometrage);
                        print(matriculeVehicule);
                        print(qteRavitaille);
                        saveForm(context);
                      },
                    )
                ),
              ],
            ),
          );
        }));
  }
}







