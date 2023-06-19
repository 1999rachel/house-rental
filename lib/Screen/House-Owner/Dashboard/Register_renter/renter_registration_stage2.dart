import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/Register_renter/renter_bills.dart';

import '../../../../Utils/PreferenceUtil.dart';
import '../Renter_details/renter_detail.dart';
import '../Renter_details/renter_details_account_page.dart';
import 'more_about_selected_house.dart';

class renter_registration_stage2 extends StatefulWidget {
  final String email;
  const renter_registration_stage2({super.key, required this.email});

  @override
  State<renter_registration_stage2> createState() =>
      _renter_registration_stage2State();
}

class _renter_registration_stage2State
    extends State<renter_registration_stage2> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  bool _showContainer = false;
  late String _selectedId;

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<String?> checkHouseStatus(String selectedHouseId) async {
    DocumentSnapshot houseSnapshot = await FirebaseFirestore.instance
        .collection('houses_db')
        .doc(selectedHouseId)
        .get();

    String houseStatus = houseSnapshot.get('status');

    return houseStatus;
  }


  void updateHouseStatus(String selectedHouseId,) {
    FirebaseFirestore.instance
        .collection('houses_db')
        .doc(selectedHouseId)
        .update({'status': 'active'})
        .then((value) => print('House status updated successfully'))
        .catchError((error) => print('Failed to update house status: $error'));
  }

  void updateRenterHouse( String selectedHouseId) {
    FirebaseFirestore.instance
        .collection('renters_db')
        .doc(widget.email)
        .update({'house_id': selectedHouseId})
        .then((value) => print('Renter house updated successfully'))
        .catchError((error) => print('Failed to update renter house: $error'));}

    Future<void> onButtonPressed(String selectedHouseId) async {
      String? houseStatus = await checkHouseStatus(selectedHouseId);

      if (houseStatus == 'inactive') {
        // House is inactive, update the status to active
        updateHouseStatus(selectedHouseId);

        // Update the renter's house in the database
        // String renterId = 'REPLACE_WITH_RENTER_ID'; // Replace with actual renter ID
        updateRenterHouse( selectedHouseId);

        Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        renter_details()));
        // );
      } else if (houseStatus == 'active') {
        // House is already occupied

        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child:Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'This house is already occupied. Please choose another house.',textAlign: TextAlign.center,),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(color: ButtonColor,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextButton(
                          child: Text('OK',style: TextStyle(
                              color: Colors.white
                          ),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )

                    ],
                  ),
                ),



              );
            },
          );
        });

      } else {
        // House status is neither inactive nor active
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return  Dialog(
              child:Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                height: 130,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Invalide house status. Please try again',textAlign: TextAlign.center,),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 35,
                      width: 80,
                      decoration: BoxDecoration(color: ButtonColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: TextButton(
                        child: Text('OK',style: TextStyle(
                            color: Colors.white
                        ),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )

                  ],
                ),
              ),



            );
          },
        );
      }
    }


  // final Stream<QuerySnapshot> _house =
  //     FirebaseFirestore.instance.collection("houses").snapshots();
  // late Stream<QuerySnapshot> _house;

  // get id of the selected house
  //
  // @override
  // void initState() {
  //   super.initState();
  //   PreferenceUtil prefs = PreferenceUtil();
  //
  //   prefs.getItem("email", "string").then((email) {
  //     setState(() {
  //       final _house = FirebaseFirestore.instance
  //           .collection("houses")
  //           .where("house_owner_id", isEqualTo: email)
  //           .snapshots();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ButtonColor,
        elevation: 0,
        leading: Container(),
        title: Text(
          "Registered houses",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: BackgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Please tap to select renter house ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('houses_db')
                      .where("house_owner_id",
                          isEqualTo: _auth.currentUser?.uid)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: 30,
                          color: ButtonColor,
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      QuerySnapshot querysnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> ListQueryDocumentSnapshot =
                          querysnapshot.docs;
                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              QueryDocumentSnapshot data =
                                  ListQueryDocumentSnapshot[index];
                              return Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      try {
                                        final selectedHouseId = data.id;
                                        onButtonPressed(selectedHouseId);







                                        // setState(() async {
                                        //
                                        //   FirebaseFirestore.instance
                                        //       .collection("renters_db")
                                        //       .doc(widget.email)
                                        //       .update({"house_id": data.id,});
                                        //
                                        //   Navigator.of(context).push(
                                        //       MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               renter_details())
                                        //   );
                                        //   //
                                        //   // DocumentSnapshot houseSnapshot = await FirebaseFirestore.instance
                                        //   //     .collection('houses_db')
                                        //   //     .doc(selectedHouseId)
                                        //   //     .get();
                                        //
                                        //   // String houseStatus = houseSnapshot.get('status');
                                        //   // if(houseStatus=='inactive'){
                                        //   //   FirebaseFirestore.instance.collection("houses_db").doc(selectedHouseId).update({"status":'active'}).then((value) {
                                        //   //     FirebaseFirestore.instance
                                        //   //         .collection("renters_db")
                                        //   //         .doc(widget.email)
                                        //   //         .update({"house_id": data.id,}).then((value) =>Navigator.of(context).push(
                                        //   //         MaterialPageRoute(
                                        //   //             builder: (context) =>
                                        //   //                 renter_details())) );
                                        //   //
                                        //   //
                                        //   //
                                        //   //   });
                                        //   // }
                                        // });
                                        // checkHouseStatus(selectedHouseId);
                                        //
                                        // FirebaseFirestore.instance
                                        //     .collection("renters_db")
                                        //     .doc(widget.email)
                                        //      .update({"house_id": data.id,});
                                        // //     .then((value) async {
                                        // //
                                        // //   DocumentSnapshot<Map<String,dynamic>> houseData  =   await FirebaseFirestore.instance.collection("houses_db").doc(data.id).get();
                                        // //   if(houseData.exists){
                                        // //
                                        // //   }
                                        // //
                                        // // })
                                        //     // .update(
                                        //     //     {"house_no": data['house_no']});
                                        //
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             renter_details()));
                                      } catch (e) {
                                        Text("Something went wrong");
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    height: 100,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${index + 1}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    ".",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text("House name:"),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      data['house_no'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Rent per month",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          data['rent'],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffC21F1F),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Tzs",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffC21F1F),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Container()),
                                            GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet<void>(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10))),
                                                  useSafeArea: true,
                                                  isDismissible: true,
                                                  elevation: 1,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20, right: 20),
                                                      child: Center(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 30,
                                                              ),
                                                              Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "House name:",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      data[
                                                                          'house_no'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Kitchen :",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 80,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child: Text(data['kitchen'])),
                                                                        Divider(
                                                                          color:
                                                                              Colors.black54,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Dining :",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 90,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child: Text(data['dining'])),
                                                                        Divider(
                                                                          color:
                                                                              Colors.black54,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Seating room :",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 50,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child: Text(data['seating_room'])),
                                                                        Divider(
                                                                          color:
                                                                              Colors.black54,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Available rooms :",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child: Text(data['rooms'])),
                                                                        Divider(
                                                                          color:
                                                                              Colors.black54,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Master bed room :",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 25,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child: Text(data['master_bed_room'])),
                                                                        Divider(
                                                                          color:
                                                                              Colors.black54,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 25,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Cost per month :",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(data['rent']),
                                                                                Text(
                                                                                  "Tzs/ mo",
                                                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                                )
                                                                              ],
                                                                            )),
                                                                        Divider(
                                                                          color:
                                                                              Colors.black54,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 30,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_down_rounded,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: ListQueryDocumentSnapshot.length),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: 30,
                        color: ButtonColor,
                      ),
                    );
                  }),
              //
              // StreamBuilder(
              //     stream: _house,
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       if (snapshot.hasError) {
              //         return Text(snapshot.error.toString());
              //       } else if (snapshot.connectionState ==
              //           ConnectionState.waiting) {
              //         return CircularProgressIndicator(
              //           color: ButtonColor,
              //         );
              //       } else if (snapshot.connectionState ==
              //           ConnectionState.active) {
              //         QuerySnapshot querysnapshot = snapshot.data;
              //         List<QueryDocumentSnapshot> ListQueryDocumentSnapshot =
              //             querysnapshot.docs;
              //         return Expanded(
              //           child: ListView.separated(
              //               itemBuilder: (context, index) {
              //                 QueryDocumentSnapshot data =
              //                     ListQueryDocumentSnapshot[index];
              //                 return Padding(
              //                   padding: EdgeInsets.only(left: 20, right: 20),
              //                   child: GestureDetector(
              //                     onTap: (){
              //
              //                     },
              //
              //                     child: Container(
              //                       padding:
              //                           EdgeInsets.only(left: 10, right: 10),
              //                       height: 80,
              //                       color: Colors.white,
              //                       child: Column(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.center,
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.center,
              //                         children: [
              //                           SizedBox(
              //                             height: 10,
              //                           ),
              //                           Row(
              //                             children: [
              //                               Container(
              //                                 child: Row(
              //                                   children: [
              //                                     Text(
              //                                       data['house_no'],
              //                                       style: TextStyle(
              //                                           color: Colors.black,
              //                                           fontWeight:
              //                                               FontWeight.bold),
              //                                     ),
              //                                     Text(
              //                                       ".",
              //                                       style: TextStyle(
              //                                           color: Colors.black,
              //                                           fontWeight:
              //                                               FontWeight.bold),
              //                                     )
              //                                   ],
              //                                 ),
              //                               ),
              //                               SizedBox(
              //                                 width: 10,
              //                               ),
              //                               Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.center,
              //                                 children: [
              //                                   Text(
              //                                     "Rent per month",
              //                                     style: TextStyle(
              //                                         color: Colors.black),
              //                                   ),
              //                                   SizedBox(
              //                                     width: 5,
              //                                   ),
              //                                   Row(
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.end,
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.end,
              //                                     children: [
              //                                       Text(
              //                                         data['rent'],
              //                                         style: TextStyle(
              //                                             color:
              //                                                 Color(0xffC21F1F),
              //                                             fontWeight:
              //                                                 FontWeight.bold),
              //                                       ),
              //                                       SizedBox(
              //                                         width: 5,
              //                                       ),
              //                                       Text(
              //                                         "Tzs",
              //                                         style: TextStyle(
              //                                             color:
              //                                                 Color(0xffC21F1F),
              //                                             fontWeight:
              //                                                 FontWeight.bold),
              //                                       )
              //                                     ],
              //                                   ),
              //                                 ],
              //                               ),
              //                             ],
              //                           ),
              //                           SizedBox(height: 5),
              //                           Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               Container(
              //                                   padding:
              //                                       EdgeInsets.only(left: 20),
              //                                   child: Text(
              //                                     "See more",
              //                                     style: TextStyle(
              //                                         color: Colors.black54),
              //                                   )),
              //                               TextButton(
              //                                   onPressed: () {
              //                                     showModalBottomSheet<void>(
              //                                       shape: RoundedRectangleBorder(
              //                                           borderRadius:
              //                                               BorderRadius.only(
              //                                                   topLeft: Radius
              //                                                       .circular(
              //                                                           10),
              //                                                   topRight: Radius
              //                                                       .circular(
              //                                                           10))),
              //                                       useSafeArea: true,
              //                                       isDismissible: true,
              //                                       elevation: 1,
              //                                       context: context,
              //                                       builder:
              //                                           (BuildContext context) {
              //                                         return Container(
              //                                           margin: EdgeInsets.only(
              //                                               left: 20,
              //                                               right: 20),
              //                                           child: Center(
              //                                             child: Column(
              //                                               children: [
              //                                                 SizedBox(
              //                                                   height: 50,
              //                                                 ),
              //                                                 Row(
              //                                                   mainAxisAlignment:
              //                                                       MainAxisAlignment
              //                                                           .spaceBetween,
              //                                                   children: [
              //                                                     Text(
              //                                                       "Kitchen :",
              //                                                       style: TextStyle(
              //                                                           color: Colors
              //                                                               .black,
              //                                                           fontWeight:
              //                                                               FontWeight.bold),
              //                                                     ),
              //                                                     SizedBox(
              //                                                       width: 80,
              //                                                     ),
              //                                                     Expanded(
              //                                                       child:
              //                                                           Column(
              //                                                         crossAxisAlignment:
              //                                                             CrossAxisAlignment
              //                                                                 .start,
              //                                                         children: [
              //                                                           Container(
              //                                                               alignment:
              //                                                                   Alignment.topLeft,
              //                                                               child: Text(data['kitchen'])),
              //                                                           Divider(
              //                                                             color:
              //                                                                 Colors.black54,
              //                                                           )
              //                                                         ],
              //                                                       ),
              //                                                     )
              //                                                   ],
              //                                                 ),
              //                                                 SizedBox(
              //                                                   height: 25,
              //                                                 ),
              //                                                 Row(
              //                                                   mainAxisAlignment:
              //                                                       MainAxisAlignment
              //                                                           .spaceBetween,
              //                                                   children: [
              //                                                     Text(
              //                                                       "Dining :",
              //                                                       style: TextStyle(
              //                                                           color: Colors
              //                                                               .black,
              //                                                           fontWeight:
              //                                                               FontWeight.bold),
              //                                                     ),
              //                                                     SizedBox(
              //                                                       width: 90,
              //                                                     ),
              //                                                     Expanded(
              //                                                       child:
              //                                                           Column(
              //                                                         crossAxisAlignment:
              //                                                             CrossAxisAlignment
              //                                                                 .start,
              //                                                         children: [
              //                                                           Container(
              //                                                               alignment:
              //                                                                   Alignment.topLeft,
              //                                                               child: Text(data['dining'])),
              //                                                           Divider(
              //                                                             color:
              //                                                                 Colors.black54,
              //                                                           )
              //                                                         ],
              //                                                       ),
              //                                                     )
              //                                                   ],
              //                                                 ),
              //                                                 SizedBox(
              //                                                   height: 25,
              //                                                 ),
              //                                                 Row(
              //                                                   mainAxisAlignment:
              //                                                       MainAxisAlignment
              //                                                           .spaceBetween,
              //                                                   children: [
              //                                                     Text(
              //                                                       "Seating room :",
              //                                                       style: TextStyle(
              //                                                           color: Colors
              //                                                               .black,
              //                                                           fontWeight:
              //                                                               FontWeight.bold),
              //                                                     ),
              //                                                     SizedBox(
              //                                                       width: 50,
              //                                                     ),
              //                                                     Expanded(
              //                                                       child:
              //                                                           Column(
              //                                                         crossAxisAlignment:
              //                                                             CrossAxisAlignment
              //                                                                 .start,
              //                                                         children: [
              //                                                           Container(
              //                                                               alignment:
              //                                                                   Alignment.topLeft,
              //                                                               child: Text(data['seating_room'])),
              //                                                           Divider(
              //                                                             color:
              //                                                                 Colors.black54,
              //                                                           )
              //                                                         ],
              //                                                       ),
              //                                                     )
              //                                                   ],
              //                                                 ),
              //                                                 SizedBox(
              //                                                   height: 25,
              //                                                 ),
              //                                                 Row(
              //                                                   mainAxisAlignment:
              //                                                       MainAxisAlignment
              //                                                           .spaceBetween,
              //                                                   children: [
              //                                                     Text(
              //                                                       "Available rooms :",
              //                                                       style: TextStyle(
              //                                                           color: Colors
              //                                                               .black,
              //                                                           fontWeight:
              //                                                               FontWeight.bold),
              //                                                     ),
              //                                                     SizedBox(
              //                                                       width: 30,
              //                                                     ),
              //                                                     Expanded(
              //                                                       child:
              //                                                           Column(
              //                                                         crossAxisAlignment:
              //                                                             CrossAxisAlignment
              //                                                                 .start,
              //                                                         children: [
              //                                                           Container(
              //                                                               alignment:
              //                                                                   Alignment.topLeft,
              //                                                               child: Text(data['rooms'])),
              //                                                           Divider(
              //                                                             color:
              //                                                                 Colors.black54,
              //                                                           )
              //                                                         ],
              //                                                       ),
              //                                                     )
              //                                                   ],
              //                                                 ),
              //                                                 SizedBox(
              //                                                   height: 25,
              //                                                 ),
              //                                                 Row(
              //                                                   mainAxisAlignment:
              //                                                       MainAxisAlignment
              //                                                           .spaceBetween,
              //                                                   children: [
              //                                                     Text(
              //                                                       "Master bed room :",
              //                                                       style: TextStyle(
              //                                                           color: Colors
              //                                                               .black,
              //                                                           fontWeight:
              //                                                               FontWeight.bold),
              //                                                     ),
              //                                                     SizedBox(
              //                                                       width: 25,
              //                                                     ),
              //                                                     Expanded(
              //                                                       child:
              //                                                           Column(
              //                                                         crossAxisAlignment:
              //                                                             CrossAxisAlignment
              //                                                                 .start,
              //                                                         children: [
              //                                                           Container(
              //                                                               alignment:
              //                                                                   Alignment.topLeft,
              //                                                               child: Text(data['master_bed_room'])),
              //                                                           Divider(
              //                                                             color:
              //                                                                 Colors.black54,
              //                                                           )
              //                                                         ],
              //                                                       ),
              //                                                     )
              //                                                   ],
              //                                                 ),
              //                                                 SizedBox(
              //                                                   height: 25,
              //                                                 ),
              //                                                 Row(
              //                                                   mainAxisAlignment:
              //                                                       MainAxisAlignment
              //                                                           .spaceBetween,
              //                                                   children: [
              //                                                     Text(
              //                                                       "Cost per month :",
              //                                                       style: TextStyle(
              //                                                           color: Colors
              //                                                               .black,
              //                                                           fontWeight:
              //                                                               FontWeight.bold),
              //                                                     ),
              //                                                     SizedBox(
              //                                                       width: 30,
              //                                                     ),
              //                                                     Expanded(
              //                                                       child:
              //                                                           Column(
              //                                                         crossAxisAlignment:
              //                                                             CrossAxisAlignment
              //                                                                 .start,
              //                                                         children: [
              //                                                           Container(
              //                                                               alignment:
              //                                                                   Alignment.topLeft,
              //                                                               child: Row(
              //                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                                                                 children: [
              //                                                                   Text(data['rent']),
              //                                                                   Text(
              //                                                                     "Tzs/ mo",
              //                                                                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              //                                                                   )
              //                                                                 ],
              //                                                               )),
              //                                                           Divider(
              //                                                             color:
              //                                                                 Colors.black54,
              //                                                           )
              //                                                         ],
              //                                                       ),
              //                                                     )
              //                                                   ],
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                         );
              //                                       },
              //                                     );
              //
              //                                     ;
              //                                   },
              //                                   child: Icon(
              //                                     Icons.arrow_drop_down_rounded,
              //                                     size: 30,
              //                                     color: Colors.black,
              //                                   )),
              //                             ],
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 );
              //               },
              //               separatorBuilder: (context, index) {
              //                 return SizedBox(
              //                   height: 10,
              //                 );
              //               },
              //               itemCount: ListQueryDocumentSnapshot.length),
              //         );
              //       }
              //       return Center(
              //         child: CircularProgressIndicator(
              //           color: ButtonColor,
              //         ),
              //       );
              //     })
            ],
          ),
        ),
      ),
    );
  }}


//
// Expanded(
// // child:  Padding(padding: EdgeInsets.only(left: 20,right: 20),
// child: ListView.separated(
// itemBuilder: (context, index) {
// return Padding(
// padding: EdgeInsets.only(left: 20, right: 20),
// child: TextButton(
// onPressed: (){
//
//
// Navigator.of(context).push(MaterialPageRoute(builder: (context)=>renter_details()));
//
//
//
// },
// child: Container(
//
// padding: EdgeInsets.only(left: 10, right: 10),
// height: 80,
// color: Colors.white,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// SizedBox(
// height: 10,
// ),
// Row(
//
// children: [
// Container(
// child: Row(
// children: [
// Text(
// "1",
// style: TextStyle(
// color: Colors.black,
// fontWeight: FontWeight.bold),
// ),
// Text(
// ".",
// style: TextStyle(
// color: Colors.black,
// fontWeight: FontWeight.bold),
// )
// ],
// ),
// ),
// SizedBox(
// width: 10,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text("Rent per month",style: TextStyle(
// color: Colors.black
// ),),
// SizedBox(
// width: 5,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// Text(
// "15000 Tzs",
// style: TextStyle(
// color: Color(0xffC21F1F),
// fontWeight: FontWeight.bold),
// ),
//
// ],
// ),
//
// ],
// ),
// ],
// ),
// SizedBox(
// height: 5
// ),
// Align(
// alignment: Alignment.bottomRight,
// child: Container(
// height: 35,
// margin: EdgeInsets.only(bottom: 10),
// decoration: BoxDecoration(
// color: ButtonColor,
// borderRadius: BorderRadius.all(Radius.circular(5))
//
// ),
// child: TextButton(onPressed: (){
//
// Navigator.of(context).push(MaterialPageRoute(builder: (context)=>more_about_selected_house()));
//
// }, child: Text("more",textAlign: TextAlign.center,style: TextStyle(
// color: Colors.white
// ),)),
// ),
// ),
// ],
// ),
// ),
// ),
// );
// },
// separatorBuilder: (context, index) {
// return SizedBox(
// height: 10,
// );
// },
// itemCount: 20),
// )
