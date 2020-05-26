import 'package:appcarburant/services/cuve_service.dart';
import 'package:flutter/material.dart';

class CuvePage extends StatefulWidget {
  final loginResponse;
  CuvePage({this.loginResponse});
  @override
  _CuvePageState createState() => _CuvePageState();
}

class _CuvePageState extends State<CuvePage> {
  Future cuve;

  @override
  void initState() {
    super.initState();
    cuve = getAllCuves();
    print("ini current event state");
  }

  Future getAllCuves() {
    return CuveService.getAllCuves();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF4F3F1),
      // backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(
          'Etat Cuve',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddEvent();
          })).then((_){
            setState(() {
              eventsCurrent = getAllCurrentEvent();
            });
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),*/
      body: Center(
        child: Container(
          // color: Colors.white,
          child: FutureBuilder(
              future: cuve,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return createListView(snapshot.data, context);
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  Widget createListView(data, BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, int index) {
              return Container(
                height: MediaQuery.of(context).size.height/1.5,
                child: Card(
                          elevation: 8.0,
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "${data[index]['cuveName']}",
                                style: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            //  Text("${data[index]['capacityCuve']} "),
                              Text("${data[index]['quantityCurrentCuve'].toInt()} L ", style: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontSize: 70.0,
                                  fontWeight: FontWeight.bold),),

                              Text(
                                "${data[index]['dateCurrentCuve']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
              );


            }),
      ),
    );
  }
}



