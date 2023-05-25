import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/dashboard.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/register_houses/register_house.dart';

import '../../../../Utils/PreferenceUtil.dart';
import 'more_about_house_number.dart';

class registered_houses extends StatefulWidget {
  const registered_houses({Key? key}) : super(key: key);

  @override
  State<registered_houses> createState() => _registered_housestate();
}

class _registered_housestate extends State<registered_houses> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  //
  // late Stream<QuerySnapshot> _houses = FirebaseFirestore.instance
  //     .collection("houses_db")
  //     .snapshots();
  // late final Stream<QuerySnapshot> _houseStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //     setState(() {
  //       _houses = FirebaseFirestore.instance
  //           .collection("house_db")
  //           .where("house_owner_id", isEqualTo: _auth.currentUser?.uid)
  //           .snapshots();
  //     });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ButtonColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>dashboard()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          "Registered houses",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => register_house()));
              },
              icon: Icon(
                Icons.add,
                size: 24,
                color: Colors.white,
              ))
        ],
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
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("houses_db").
                    where('house_owner_id', isEqualTo: _auth.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: ButtonColor,
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      QuerySnapshot querysnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> ListQueryDocumentSnapshot =
                          querysnapshot.docs;
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot data =
                                ListQueryDocumentSnapshot[index];

                            return Container(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              margin: EdgeInsets.only(left: 15, right: 15),
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            ".",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "House name:",
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
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    data['house_no'].toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        // color:
                                                        // Color(0xffC21F1F),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Rent",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data['rent'].toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffC21F1F),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "Tzs/mo",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Row(
                                        children: [
                                          Align(
                                          alignment: Alignment.bottomRight,
                                          child: TextButton(
                                              onPressed: () {
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
                                                                height: 0,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: ButtonColor,
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomRight: Radius.circular(20),
                                                                        bottomLeft: Radius.circular(20)
                                                                    )

                                                                ),

                                                                width: double.infinity,
                                                                height: 50,
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Text(
                                                                        "House name:",
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 17,
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
                                                                            color: Colors.white,
                                                                            fontWeight:
                                                                            FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              SizedBox(
                                                                height: 30,
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

                                                ;
                                              },
                                              child: Icon(
                                                Icons.arrow_drop_down_rounded,
                                                size: 30,
                                                color: Colors.black,
                                              )),
                                        ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: ListQueryDocumentSnapshot.length);
                    }
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: ButtonColor,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class more_about_house_number extends StatelessWidget {
//   const more_about_house_number({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
