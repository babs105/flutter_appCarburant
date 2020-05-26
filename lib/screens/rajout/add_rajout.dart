import 'package:appcarburant/data/cuves.dart';
import 'package:appcarburant/data/stations.dart';
import 'package:appcarburant/services/rajout_service.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddRajout extends StatefulWidget {
  @override
  _AddRajoutState createState() => _AddRajoutState();
}

class _AddRajoutState extends State<AddRajout> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy HH:mm");
  String cuveName;
  String dateTimeString;
  String stationName;
  String dateTimeRajout;
  double qteRajout;
  Widget load;
  dynamic rajoutResponse;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTimeRajout = '';
    cuveName = '';
    qteRajout = 0.0;
    stationName = '';
    load = null;
  }
 /* void getPrefsIdUser() async{
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.get('idUser') ??'';
  }*/

  void rajouterCuve(BuildContext context) async {


    var response = await RajoutService.rajouterCuve(
        dateTimeRajout,
        qteRajout,
        cuveName,
        stationName
    );

    print(response);

    if (response['id']!=null) {
      setState(() {
        load = null;
        rajoutResponse = response;

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Rajout effectué avec succes',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.green,
        ));
        print(rajoutResponse);
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
      rajouterCuve(context);


    }
    //form.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rajout Cuve'),
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
                      dateTimeRajout =
                          value.toIso8601String().substring(0,16);
                      print(dateTimeString);
                    },

                    onChanged: (value) {
                      dateTimeString = format.format(value);
                      dateTimeRajout =
                          value.toIso8601String().substring(0,16);

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

                    titleText: 'Nom de la Cuve',
                    hintText: 'selectionnez la Cuve',
                    value: cuveName,
                    onSaved: (value) {
                      setState(() {
                        cuveName = value;
                      });

                    },
                    onChanged: (value) {
                      setState(() {
                        cuveName = value;
                      });

                    },
                    dataSource: cuves,
                    validator: (value) {
                      if (value == null) {
                        return 'Entrez la cuve';
                      }
                      return null;
                    },
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropDownFormField(
                    filled: true,

                    titleText: 'Nom de la Station',
                    hintText: 'selectionnez la Station',
                    value: stationName,
                    onSaved: (value) {
                      setState(() {
                        stationName = value;
                      });

                    },
                    onChanged: (value) {
                      setState(() {
                        stationName = value;

                      });
                    },
                    dataSource: stations,
                    validator: (value) {
                      if (value == null) {
                        return 'Entrez la cuve';
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
                        hintText: 'Quantité Rajoutée',
                        labelText: 'Quantité Rajoutée',
                        filled: true,
                        prefixIcon: Icon(
                            Icons.slow_motion_video
                        )
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onSaved: (value) => setState(() => qteRajout = double.parse(value)),
                    onChanged: (value) {
                      qteRajout = double.parse(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Entrez la quantité du rajout';
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
                        print(dateTimeRajout);
                        print(cuveName);
                        print(stationName);
                        print(qteRajout);
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









