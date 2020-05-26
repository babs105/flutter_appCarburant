import 'package:appcarburant/screens/cuve/cuve_screen.dart';
import 'package:appcarburant/screens/login/login_screen.dart';
import 'package:appcarburant/screens/rajout/rajout_screen.dart';
import 'package:appcarburant/screens/ravitaillement/ravitaille.dart';
import 'package:appcarburant/screens/vehicule/vehicule.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final loginResponse;

  HomePage({this.loginResponse});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  var user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.loginResponse['user'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      backgroundColor: Color(0xFFF4F3F1),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xFF5451A1),
                width: MediaQuery.of(context).size.width * 0.85,


                child: DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(child: Text("Profil",style: TextStyle(color: Colors.white),)),
                      IconButton(
                        onPressed: (){},
                        icon:Icon(Icons.account_circle,size: 100.0,color:Colors.white ,) ,
                      ),
                    ],
                  ),
                ),

              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(children: [
                ListTile(
                  leading:Icon(Icons.person),
                  title: Text(user['firstName']),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading:Icon(Icons.perm_identity),
                  title:  Text(user['lastName']),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading:Icon(Icons.verified_user),
                  title:  Text(user['username']),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading:Icon(Icons.settings ),
                  title:  Text(user['role']),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading:Icon(Icons.exit_to_app),
                  title: Text("Déconnexion"),
                  onTap: () async {


                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('idUser');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context ){
                      return LoginPage();
                    }));
                  },
                ),


              ]),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 30.0,
          onPressed: () {
            print('drawer');
            _drawerKey.currentState.openDrawer();
          },
        ),

        brightness: Brightness.light,
        backgroundColor:Color(0xFF5451A1) ,
        /*   actions: <Widget>[
         IconButton(
           icon:Icon(Icons.power_settings_new),
           onPressed: (){},
         )
       ],*/
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'APP CARBURANT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 5,
          ),
        ),
      ),
      body: Container(
        // alignment: Alignment.center,

        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(10.0),
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    /*  height:175.0 ,
                    width:175.0 ,*/
                    // elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Cuve',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color:Color(0xFF5451A1) ,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return CuvePage(loginResponse:widget.loginResponse);
                                }),
                              );

                            },
                            icon: Icon(
                              Icons.local_shipping,
                              color: Color(0xFF5451A1),
                            ),
                            iconSize: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    /*  height:175.0 ,
                    width:175.0 ,*/
                    //  elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Ravitaillement',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color:Color(0xFF5451A1) ,),
                          ),
                          IconButton(
                            onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return RavitaillePage(
                                  );
                                }),
                              );
                            },
                            icon: Icon(
                              Icons.local_gas_station,
                              color: Color(0xFF5451A1),
                            ),
                            iconSize: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    /*  height:175.0 ,
                    width:175.0 ,*/
                    //  elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Rajout',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color:Color(0xFF5451A1) ,),
                          ),
                          IconButton(
                            onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return RajoutPage(
                                  );
                                }),
                              );
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Color(0xFF5451A1),
                            ),
                            iconSize: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    /*  height:175.0 ,
                    width:175.0 ,*/
                    //  elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Vehicule',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color:Color(0xFF5451A1) ,),
                          ),
                          IconButton(
                            onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return VehiculePage(
                                  );
                                }),
                              );
                            },
                            icon: Icon(
                              Icons.drive_eta,
                              color: Color(0xFF5451A1),
                            ),
                            iconSize: 80.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //    Card(
                  /*  height:175.0 ,
                    width:175.0 ,*/
                  //  elevation: 10.0,
                  //margin: EdgeInsets.all(10.0),
                  // color:Colors.indigoAccent,
                  /*   child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Remorquage',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.lightBlueAccent),
                        ),
                        IconButton(
                          onPressed: () {
                            print('tapppp');
                          },
                          icon: Icon(
                            Icons.build,
                            color: Colors.blue,
                          ),
                          iconSize: 80.0,
                        ),
                      ],
                    )),*/
                  //),
                  //  Card(
                  /*  height:175.0 ,
                    width:175.0 ,*/
                  // elevation: 10.0,
                  /*    margin: EdgeInsets.all(10.0),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.lightBlueAccent),
                        ),
                      ],
                    )),
                 *///  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

