import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:appcarburant/screens/home.dart';
import 'package:appcarburant/services/authentification_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String username;
  String pwd;
  dynamic loginResponse;
  Widget load;

  @override
  void initState() {
    super.initState();
    print("--------------$username");
    username = '';
    load = null;
    loginResponse = null;
    pwd = '';

  }

  void login(String username,String pwd) async {
    print("in login");
    final prefs = await SharedPreferences.getInstance();
    var response = await AuthenService.login(username,pwd);
    print(response["user"]);

    if(response["user"] == null){
      setState(() {

        load=errorLoginUI();
        //
      });

    }
    else if (response["user"]["id"] != null){
      setState(() {

        //iduser pour le remorquage
        prefs.setString('idUser', response['user']['id']);

        print("Iduser  "+prefs.get('idUser'));
        loginResponse = response;
        load = null;
        //
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return HomePage(
            loginResponse: loginResponse,
          );
        }),
      );
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
  Widget errorLoginUI() {
    return (Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child:Text("Error de Connexion ! Resseyez",style: TextStyle(color: Colors.red,fontSize:20.0,fontWeight: FontWeight.bold ),),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 5,
              ),
              TypewriterAnimatedTextKit(
                text:['APP CARBURANT'],
                textStyle: TextStyle(
                  color: Color(0xFF100D60),
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'USERNAME',
                    prefixIcon: Icon(
                      Icons.account_box,
                      size: 30.0,
                    ),
                  ),
                  onChanged: (value) {
                    print(value);
                    username = value;
                    print(username);
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'PASSWORD',
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30.0,
                    ),
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    print(value);
                    pwd = value;
                    print(pwd);
                  },
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              GestureDetector(
                  onTap: () {
                    print(username);
                    print(pwd);
                    loading();
                    print('logging.........');
                    login(username,pwd);
                    print(" "'passs login' "") ;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 60.0),
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Color(0xFF100D60),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.3,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5),
                    ),
                  )),
              Container(
                child: load,
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    color: Color(0xFF100D60),
                    height: 50.0,
                    child: Text(
                      'MSA-SASTRANS 2020',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

