import 'package:appcarburant/screens/rajout/add_rajout.dart';
import 'package:appcarburant/screens/rajout/details_rajout.dart';
import 'package:appcarburant/services/rajout_service.dart';
import 'package:flutter/material.dart';

class RajoutPage extends StatefulWidget {
  @override
  _RajoutPageState createState() => _RajoutPageState();
}

class _RajoutPageState extends State<RajoutPage> {
  Future<dynamic> rajouts;
  int qteRajout;

  @override
  void initState() {
    super.initState();
    print('in init state');
    rajouts = getAllRajout();
  }

  Future<dynamic> getAllRajout() async {
    print('in method getALL');
    return RajoutService.getAllRajout();

  }


  /*void getAllClosedEvent(dynamic eventClosed) async {
    data = eventClosed;

  }
*/
  Widget createListView(List data, BuildContext context) {

    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,int index ){
           var qte =  data[index]['qteRajout'];
            qteRajout= qte.toInt();
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailsRajout(event:data[index]);


                }),
                );

              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  // Divider(thickness: 2.3,),

                  Card(
                    color:Colors.white ,
                    child: ListTile(
                      title: Text(
                        "${data[index]['cuve']['cuveName']}",style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w800),

                      ),


                      subtitle:Text("$qteRajout",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w800,color:Color(0xFF100D60), ),),

                      leading: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.indigo,
                            radius: 25.0,
                            child:Icon(Icons.add_circle,color: Colors.white,),
                          )],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("${ data[index]['dateRajout']}",style: TextStyle(fontSize: 13.0,color:Colors.black, ),),
                        //  Text("${ data[index]['station']['stationName']}"),
                        ],
                      ) ,
                    ),
                  )

                ],
              ),
            );

          }),

    );

  }

  @override
  Widget build(BuildContext context) {
    print('in builde');
    return Scaffold(
        backgroundColor: Color(0xFFF4F3F1),
        appBar: AppBar(
          title: Text(
              'Rajouts'
          ),

        ),

        body: Center(

          // child: createListView(data.,context),
          child: Container(

            color: Colors.white,
            child: FutureBuilder(
                future:rajouts,
                builder: (context, AsyncSnapshot snapshot){

                  if(snapshot.hasData){
                    return createListView(snapshot.data,context);

                    //  return Text(snapshot.data[0]['typeEvenement']);

                  }
                  return CircularProgressIndicator();


                }),
          ),
        ),
        floatingActionButton:FloatingActionButton(
          onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddRajout();


            }),
            ).then((_)  {

              setState(() {
                rajouts = getAllRajout();
              });

            });
          } ,
          backgroundColor: Colors.pinkAccent,
          child:Icon(Icons.add) ,
        )
    );
  }




}
