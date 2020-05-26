import 'package:appcarburant/screens/ravitaillement/add_ravitaillement.dart';
import 'package:appcarburant/screens/ravitaillement/details_ravitaille.dart';
import 'package:appcarburant/services/ravitaille_service.dart';
import 'package:flutter/material.dart';

class RavitaillePage extends StatefulWidget {
  @override
  _RavitaillePageState createState() => _RavitaillePageState();
}

class _RavitaillePageState extends State<RavitaillePage> {

  Future<dynamic> ravitaillements;
  int qteRavitaille;

  @override
  void initState() {
    super.initState();
    print('in init state');
    ravitaillements = getAllOperationsCuve();
  }

  Future<dynamic> getAllOperationsCuve() async {
    print('in method getALL');
    return RavitailleService.getAllOperationsCuve();

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
          var qte =  data[index]['quantityRavitaillement'];
               qteRavitaille = qte.toInt();
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailsRavitaille(event:data[index]);


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
                        "${data[index]['immatricule']}",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w800),

                      ),

                      subtitle:Text("$qteRavitaille litres",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w800,color:Color(0xFF100D60), ),),

                      leading: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.indigo,
                            radius: 25.0,
                            child:Icon(Icons.local_gas_station,color: Colors.white,),
                          )],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("${ data[index]['dateRavitaillement']}"),
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
            'Ravitaillements'
        ),

      ),

      body: Center(

        // child: createListView(data.,context),
        child: Container(

          color: Colors.white,
          child: FutureBuilder(
              future:ravitaillements,
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
              return AddRavitaillement();


            }),
            ).then((_)  {
              setState(() {
                ravitaillements = getAllOperationsCuve();
              });

            });
          } ,
          backgroundColor: Colors.pinkAccent,
          child:Icon(Icons.add) ,
        )
    );
  }




}
