import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class houseAnalysisPage extends StatefulWidget {
  const houseAnalysisPage({Key? key}) : super(key: key);

  @override
  State<houseAnalysisPage> createState() => _houseAnalysisPageState();
}

class _houseAnalysisPageState extends State<houseAnalysisPage> {

  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final CardColor = const Color(0xffFBFBFB);
  int totalNumberOfRoomsOccupied= 0;
  int totalNumberOfRoomsNotOccupied= 0;


  final FirebaseAuth auth = FirebaseAuth.instance;

  fetchTotalNoOfHouseOccupied() async {

    try{
      await FirebaseFirestore.instance.collection('houses_db').where('status', isEqualTo:'active').where('house_owner_id',isEqualTo:auth.currentUser?.uid).get().then((querySnapshot) {
        totalNumberOfRoomsOccupied = querySnapshot.size;
        // print('Total Number of Documents: $totalNumberOfRoomsOccupied');
      });

    }
    catch(e){

      print  ( '${e.toString()}');
    }
  }

  fetchInactiveHouses() async {

    try{
      await FirebaseFirestore.instance.collection('houses_db').where('status', isEqualTo:'inactive').where('house_owner_id',isEqualTo:auth.currentUser?.uid).get().then((querySnapshot) {
      int  totalNumberOfRoomsNotOccupied = querySnapshot.size;
        // print('Total Number of Documents: $totalNumberOfRoomsNotOccupied');
      });

    }
    catch(e){

      print  ( '${e.toString()}');
    }
  }
  // totalNumberOfHouses() async {
  //   int TotalHousesAvailable= totalNumberOfInactive+totalNumberOfDocuments;
  //
  //   print (TotalHousesAvailable);
  // }

  @override
  initState()
  {

    fetchTotalNoOfHouseOccupied();
    fetchInactiveHouses();
    // totalNumberOfHouses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ButtonColor,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 24,)),

        title: Text("Report",style: TextStyle(
          color: Colors.white,
          // fontSize: 17
        ),),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: BackgroundColor,
          child: Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("House statistic",style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),),
                      Divider(),
                      SizedBox(
                          height:15
                      ),
                      Row(
                        children: [

                          Text("Total number of houses registered are:"),
                          SizedBox(
                            width: 5,
                          ),
                          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            future: FirebaseFirestore.instance
                                .collection('houses_db')
                                .where('house_owner_id',isEqualTo: auth.currentUser?.uid)
                                .get(),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return SpinKitCircle(
                                  size: 20,
                                ); // Show a loading indicator while data is being fetched
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}'); // Show an error message if data retrieval fails
                              }
                              else{
                                int registeredHouses = snapshot.data!.docs.length;
                                return Text( '${
                                    registeredHouses

                                }',style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,

                                    fontWeight: FontWeight.bold
                                ),
                                );

                              }
                            },

                          )



                        ],
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Occupied Houses",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 100,
                                  width: 100,

                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.blue),
                                  child: Center(
                                      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                        future: FirebaseFirestore.instance
                                            .collection('houses_db')
                                            .where('status', isEqualTo: 'active').where('house_owner_id',isEqualTo: auth.currentUser?.uid)
                                            .get(),
                                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return SpinKitCircle(
                                              size: 20,
                                            ); // Show a loading indicator while data is being fetched
                                          } else if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}'); // Show an error message if data retrieval fails
                                          }
                                          else{
                                            int activeHousesCount = snapshot.data!.docs.length;
                                            return Text( '${
                                                activeHousesCount

                                            }',style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 45,
                                                fontWeight: FontWeight.w400
                                            ),
                                            );

                                          }
                                        },

                                      ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              Text(
                                "Empty Houses",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.orange),
                                  child: Center(
                                    child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                      future: FirebaseFirestore.instance
                                          .collection('houses_db')
                                          .where('status', isEqualTo: 'inactive').where('house_owner_id',isEqualTo: auth.currentUser?.uid)
                                          .get(),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return SpinKitCircle(
                                            size: 20,
                                          ); // Show a loading indicator while data is being fetched
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}'); // Show an error message if data retrieval fails
                                        }
                                        else{
                                          int inactiveHousesCount = snapshot.data!.docs.length;
                                          return Text( '${
                                              inactiveHousesCount

                                          }',style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 45,
                                              fontWeight: FontWeight.w400
                                          ),
                                          );

                                        }
                                      },

                                    ),
                                  )
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),

                    ],
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Renters statistic",style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),),
                      Divider(),
                      SizedBox(
                          height:15
                      ),
                      Row(
                        children: [

                          Text("Total number of  registered Renters are:"),
                          SizedBox(
                            width: 5,
                          ),
                          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            future: FirebaseFirestore.instance
                                .collection('renters_db')
                                .where('house_owner_id',isEqualTo: 'jxEB0r0EFSaPEqGXwIEiLGNQtb72')
                                .get(),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return SpinKitCircle(
                                  size: 20,
                                ); // Show a loading indicator while data is being fetched
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}'); // Show an error message if data retrieval fails
                              }
                              else{
                                int registeredRenters = snapshot.data!.docs.length;
                                return Text( '${
                                    registeredRenters

                                }',style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,

                                    fontWeight: FontWeight.bold
                                ),
                                );

                              }
                            },

                          )



                        ],
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Active Renters",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      // color: Colors.grey.withOpacity(0.1)
                                      color: Colors.green

                                  ),
                                  child: Center(
                                    child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                      future: FirebaseFirestore.instance
                                          .collection('renters_db')
                                          .where('status', isEqualTo: 'active').where('house_owner_id',isEqualTo: auth.currentUser?.uid)
                                          .get(),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return SpinKitCircle(
                                            size: 20,
                                          ); // Show a loading indicator while data is being fetched
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}'); // Show an error message if data retrieval fails
                                        }
                                        else{
                                          int activeRenters = snapshot.data!.docs.length;
                                          return Text( '${
                                              activeRenters

                                          }',style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 45,
                                              fontWeight: FontWeight.w400
                                          ),
                                          );

                                        }
                                      },

                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              Text(
                                "Inactive Renters",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    height: 100,
                                    width: 100,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        // color: Colors.grey.withOpacity(0.1)
                                      color: Colors.red
                                        //
                                    ),
                                    child: Center(
                                      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                        future: FirebaseFirestore.instance
                                            .collection('renters_db')
                                            .where('status', isEqualTo: 'inactive').where('house_owner_id',isEqualTo: auth.currentUser?.uid)
                                            .get(),
                                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return SpinKitCircle(
                                              size: 20,
                                            ); // Show a loading indicator while data is being fetched
                                          } else if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}'); // Show an error message if data retrieval fails
                                          }
                                          else{
                                            int inactiveRenters = snapshot.data!.docs.length;
                                            return Text( '${
                                                inactiveRenters

                                            }',style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 45,
                                                fontWeight: FontWeight.w400
                                            ),
                                            );

                                          }
                                        },

                                      ),
                                    )
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),


        ),
      ),
    );
  }
}
