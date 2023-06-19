import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../payments/payments_per_individual.dart';
import 'add_contract_to_renter.dart';
import 'check_renter_payments.dart';

class renter_details_account_page extends StatefulWidget {
  final String renter_id;

  renter_details_account_page({Key? key, required this.renter_id})
      : super(key: key);

  @override
  State<renter_details_account_page> createState() =>
      _renter_details_account_pageState();
}

class _renter_details_account_pageState
    extends State<renter_details_account_page> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  bool profile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ButtonColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            )),
        actions: [
          IconButton(
            onPressed: () {

              setState(() {
                showDialog(context: context, builder: (context){
                  return Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 150,
                        width: 300,
                        // width: 150,

                        child: Align(
                          alignment: Alignment.topRight,
                          child: Dialog(
                            child: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>payments_per_individual(renter_id: widget.renter_id)));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(left: 10,right: 10),
                                        height: 45,
                                        decoration:BoxDecoration(
                                          // color: ButtonColor,
                                            borderRadius: BorderRadius.all(Radius.circular(10))

                                        ) ,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [

                                                Icon(Icons.dashboard,size: 24,color: Colors.black54,),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("View contracts",style: TextStyle(color: Colors.black),)
                                              ],
                                            ))))
                              ],
                            ),
                          ),
                        )
                    ),
                  );
                });
              });


            },
            icon: Icon(
              Icons.more_horiz,
              size: 24,
              color: Colors.white,
            ),
          )
        ],
        title: Text(
          "Renter account",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: BackgroundColor,
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("renters_db")
              .doc(widget.renter_id)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Center(child: SpinKitCircle(color: ButtonColor)),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              // QuerySnapshot querysnapshot = snapshot.data;
              // List<QueryDocumentSnapshot> ListQueryDocumentSnapshot =
              //     querysnapshot.docs;
              final data = snapshot.data!.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   width: double.infinity,
                    //   height: 180,
                    //   decoration: BoxDecoration(color: BackgroundColor),
                    //
                    //   // decoration: BoxDecoration(color: ButtonColor),
                    //   child: Container(
                    //       // padding:
                    //       //     EdgeInsets.only(left: 10, right: 20, top: 30),
                    //       child: Stack(
                    //     children: [
                    //       Container(
                    //         width: double.infinity,
                    //         height: 140,
                    //         decoration: BoxDecoration(color: ButtonColor),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(top: 30, left: 10),
                    //         child: Align(
                    //             alignment: Alignment.topLeft,
                    //             child: IconButton(
                    //                 onPressed: () {
                    //                   Navigator.of(context).pop();
                    //                 },
                    //                 icon: Icon(
                    //                   Icons.arrow_back_ios,
                    //                   size: 24,
                    //                   color: Colors.white,
                    //                 ))),
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.only(top: 80),
                    //         child: Center(
                    //           child: Column(
                    //             children: [
                    //               Container(
                    //                 width: 100,
                    //                 height: 100,
                    //                 child: ClipRRect(
                    //                   borderRadius: BorderRadius.circular(100),
                    //                   child: Icon(
                    //                     Icons.person,
                    //                     color: Colors.black54,
                    //                     size: 50,
                    //                   )
                    //                   // profile
                    //                   //     ? Icon(
                    //                   //         Icons.person,
                    //                   //         color: Colors.black,
                    //                   //         size: 50,
                    //                   //       )
                    //                       // : Image.network(
                    //                       //     data['downloadedUrl'],
                    //                       //     fit: BoxFit.cover,
                    //                       //   ),
                    //                 ),
                    //                 decoration: BoxDecoration(
                    //                     color: Colors.grey[100],
                    //                     borderRadius: BorderRadius.circular(50),
                    //                     border: Border(
                    //                         top: BorderSide(
                    //                           color: Colors.black38,
                    //                         ),
                    //                         left: BorderSide(
                    //                             color: Colors.black38),
                    //                         bottom: BorderSide(
                    //                             color: Colors.black38),
                    //                         right: BorderSide(
                    //                             color: Colors.black38))
                    //
                    //                 ),
                    //               ),
                    //               // SizedBox(
                    //               //   height: 5,
                    //               // ),
                    //               // Text(
                    //               //   data['full_name'],
                    //               //   style: TextStyle(
                    //               //       color: Colors.white,
                    //               //       fontSize: 16,
                    //               //       fontWeight: FontWeight.bold),
                    //               // ),
                    //               // SizedBox(
                    //               //   height: 5,
                    //               // ),
                    //               // StreamBuilder<DocumentSnapshot>(
                    //               //     stream: FirebaseFirestore.instance
                    //               //         .collection('houses_db')
                    //               //         .doc(data['house_id'])
                    //               //         .snapshots(),
                    //               //     builder: (BuildContext context,
                    //               //         AsyncSnapshot<dynamic>
                    //               //             houseSnapshot) {
                    //               //       if (houseSnapshot.hasData) {
                    //               //         return Row(
                    //               //           mainAxisAlignment:
                    //               //               MainAxisAlignment.center,
                    //               //           children: [
                    //               //             Text(
                    //               //               "House no.",
                    //               //               style: TextStyle(
                    //               //                 color: Colors.white,
                    //               //               ),
                    //               //             ),
                    //               //             Text(
                    //               //               houseSnapshot
                    //               //                   .data['house_no'],
                    //               //               style: TextStyle(
                    //               //                   color:
                    //               //                       Color(0xffAA1414),
                    //               //                   fontWeight:
                    //               //                       FontWeight.bold),
                    //               //             )
                    //               //           ],
                    //               //         );
                    //               //       }
                    //               //       return Text("Loading");
                    //               //     })
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   )),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Column(
                                children: [
                                  Text(
                                    data['full_name'],
                                    style: TextStyle(color: Colors.black),
                                  ),

                                ],
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 100),
                              child: Divider(
                                color: Colors.black38,
                                thickness: 0.3,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Gender",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 55,
                              ),
                              Column(
                                children: [
                                  Text(
                                    data['gender'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  // Divider(
                                  //   color: Colors.black,
                                  //   // thickness: ,
                                  //
                                  // )
                                ],
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 100),
                              child: Divider(
                                color: Colors.black38,
                                thickness: 0.3,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Address",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 55,
                              ),
                              Column(
                                children: [
                                  Text(
                                    data['email'],
                                    // ,
                                    style: TextStyle(color: Colors.black),
                                  ),

                                ],
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 100),
                              child: Divider(
                                color: Colors.black38,
                                thickness: 0.3,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Phone 1",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                children: [
                                  Text(
                                    data['primary_phone_number'],
                                    style: TextStyle(color: Colors.black),
                                  ),

                                ],
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 100),
                              child: Divider(
                                color: Colors.black38,
                                thickness: 0.3,
                              ))
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 20, right: 20),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         // mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             "Phone 2",
                    //             style: TextStyle(color: Colors.black),
                    //           ),
                    //           SizedBox(
                    //             width: 50,
                    //           ),
                    //           Column(
                    //             children: [
                    //               Text(
                    //                 data['secondary_phone_number'],
                    //                 style: TextStyle(color: Colors.black),
                    //               ),
                    //               // Divider(
                    //               //   color: Colors.black,
                    //               //   // thickness: ,
                    //               //
                    //               // )
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //       Padding(
                    //           padding: EdgeInsets.only(left: 100),
                    //           child: Divider(
                    //             color: Colors.black38,
                    //             thickness: 0.3,
                    //           ))
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "House no",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: [
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('houses_db')
                                        .doc(data['house_id'])
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> houseSnapshot) {
                                      if (houseSnapshot.hasData) {
                                        return Text(
                                          houseSnapshot.data['house_no'],
                                          style: TextStyle(color: Colors.black),
                                        );
                                      }
                                      return Text("Loading...");
                                    },
                                    // Divider(
                                    //   color: Colors.black,
                                    //   // thickness: ,
                                    //
                                    // )
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 100),
                              child: Divider(
                                color: Colors.black38,
                                thickness: 0.3,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Contract"),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                  child: Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ButtonColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      // FirebaseFirestore.instance
                                      //     .collection("contracts_db")
                                      //     .doc()
                                      //     .update(
                                      //         {"renter_id": widget.renter_id}).then((value) =>
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>add_contract(renter_id: widget.renter_id,


                                      )));

                                    },
                                    child: Text(
                                      "Add contract",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    )),
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              );
            }
            return Center(
                child: Center(child: SpinKitCircle(color: ButtonColor)));
          },
        ),
        //   Column(
        //     children: [
        //       Container(
        //         width: double.infinity,
        //         height: 190,
        //         decoration: BoxDecoration(color: ButtonColor),
        //         child: Container(
        //             padding: EdgeInsets.only(
        //               left: 10,
        //               right: 20,
        //               top: 30
        //             ),
        //             child: Stack(
        //               children: [
        //                 Align(
        //                     alignment: Alignment.topLeft,
        //                     child: IconButton(
        //                         onPressed: () {
        //                           Navigator.of(context).pop();
        //                         },
        //                         icon: Icon(
        //                           Icons.arrow_back_ios,
        //                           size: 24,
        //                           color: Colors.white,
        //                         ))),
        //                 Container(
        //                   margin: EdgeInsets.only(top: 20),
        //                   child: Center(
        //                     child: Column(
        //                       children: [
        //                         Container(
        //                           width: 80,
        //                           height: 80,
        //                           child: ClipRRect(
        //                             borderRadius: BorderRadius.circular(100),
        //                             child: Image.asset(
        //                               "assets/profile1.jpeg",
        //                               fit: BoxFit.cover,
        //                             ),
        //                           ),
        //                           decoration: BoxDecoration(
        //                               color: Colors.white,
        //                               borderRadius: BorderRadius.circular(50)),
        //                         ),
        //                         SizedBox(
        //                           height: 5,
        //                         ),
        //                         Text(
        //                           "John Shamba Ally",
        //                           style: TextStyle(
        //                               color: Colors.white,
        //                               fontSize: 16,
        //                               fontWeight: FontWeight.bold),
        //                         ),
        //                         SizedBox(
        //                           height: 5,
        //                         ),
        //                         Row(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Text(
        //                               "House no.",
        //                               style: TextStyle(
        //                                 color: Colors.white,
        //                               ),
        //                             ),
        //                             Text(
        //                               "1",
        //                               style: TextStyle(
        //                                   color: Color(0xffAA1414),
        //                                   fontWeight: FontWeight.bold),
        //                             )
        //                           ],
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             )),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child: Column(
        //           children: [
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               // mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Name",
        //                   style: TextStyle(color: Colors.black),
        //                 ),
        //                 SizedBox(
        //                   width: 50,
        //                 ),
        //                 Column(
        //                   children: [
        //                     Text(
        //                       "Rachel Japhet Sironga",
        //                       style: TextStyle(color: Colors.black),
        //                     ),
        //                     // Divider(
        //                     //   color: Colors.black,
        //                     //   // thickness: ,
        //                     //
        //                     // )
        //                   ],
        //                 )
        //               ],
        //             ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child: Column(
        //           children: [
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               // mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Gender",
        //                   style: TextStyle(color: Colors.black),
        //                 ),
        //                 SizedBox(
        //                   width: 50,
        //                 ),
        //                 Column(
        //                   children: [
        //                     Text(
        //                       "Female",
        //                       style: TextStyle(color: Colors.black),
        //                     ),
        //                     // Divider(
        //                     //   color: Colors.black,
        //                     //   // thickness: ,
        //                     //
        //                     // )
        //                   ],
        //                 )
        //               ],
        //             ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child: Column(
        //           children: [
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               // mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Adress",
        //                   style: TextStyle(color: Colors.black),
        //                 ),
        //                 SizedBox(
        //                   width: 50,
        //                 ),
        //                 Column(
        //                   children: [
        //                     Text(
        //                       "kanyau1234@gmail.com",
        //                       style: TextStyle(color: Colors.black),
        //                     ),
        //                     // Divider(
        //                     //   color: Colors.black,
        //                     //   // thickness: ,
        //                     //
        //                     // )
        //                   ],
        //                 )
        //               ],
        //             ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child: Column(
        //           children: [
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               // mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Phone 1",
        //                   style: TextStyle(color: Colors.black),
        //                 ),
        //                 SizedBox(
        //                   width: 50,
        //                 ),
        //                 Column(
        //                   children: [
        //                     Text(
        //                       "0750964523",
        //                       style: TextStyle(color: Colors.black),
        //                     ),
        //                     // Divider(
        //                     //   color: Colors.black,
        //                     //   // thickness: ,
        //                     //
        //                     // )
        //                   ],
        //                 )
        //               ],
        //             ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child: Column(
        //           children: [
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               // mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Phone 2",
        //                   style: TextStyle(color: Colors.black),
        //                 ),
        //                 SizedBox(
        //                   width: 50,
        //                 ),
        //                 Column(
        //                   children: [
        //                     Text(
        //                       "073427198981",
        //                       style: TextStyle(color: Colors.black),
        //                     ),
        //                     // Divider(
        //                     //   color: Colors.black,
        //                     //   // thickness: ,
        //                     //
        //                     // )
        //                   ],
        //                 )
        //               ],
        //             ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child: Column(
        //           children: [
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               // mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "House no",
        //                   style: TextStyle(color: Colors.black),
        //                 ),
        //                 SizedBox(
        //                   width: 40,
        //                 ),
        //                 Column(
        //                   children: [
        //                     Text(
        //                       "1",
        //                       style: TextStyle(color: Colors.black),
        //                     ),
        //                     // Divider(
        //                     //   color: Colors.black,
        //                     //   // thickness: ,
        //                     //
        //                     // )
        //                   ],
        //                 )
        //               ],
        //             ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child:Column(
        //           children: [
        //          Row(
        //            mainAxisAlignment: MainAxisAlignment.start,
        //
        //            children: [
        //              Text("Rent"),
        //              SizedBox(
        //                width: 70,
        //              ),
        //              Text("150000"),
        //              Expanded(child: Container()),
        //
        //              Text("Tzs/Mo")
        //            ],
        //          ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child:Column(
        //           children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //
        //               children: [
        //                 Text("Water bills"),
        //                 SizedBox(
        //                   width: 30,
        //                 ),
        //                 Text("150000"),
        //                 Expanded(child: Container()),
        //
        //                 Text("Tzs/Mo")
        //               ],
        //             ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child:Column(
        //           children: [
        //             Row(
        //               children: [
        //                 Text("Start date"),
        //                 SizedBox(
        //                   width: 40,
        //                 ),
        //                 Text("13.3.2014"),
        //
        //               ],
        //             ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child:Column(
        //           children: [
        //             Row(
        //               children: [
        //                 Text("End date"),
        //                 SizedBox(
        //                   width: 40,
        //                 ),
        //                 Text("13.3.2014"),
        //
        //               ],
        //             ),
        //             Padding(
        //                 padding: EdgeInsets.only(left: 100),
        //                 child: Divider(
        //                   color: Colors.black38,
        //                   thickness: 0.3,
        //                 ))
        //
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child:Column(
        //           children: [
        //             Row(
        //               children: [
        //                 Text("Contract"),
        //                 SizedBox(
        //                   width: 40,
        //                 ),
        //                 Expanded(child: Container(
        //
        //                   height: 45,
        //                   width: double.infinity,
        //                   decoration: BoxDecoration(
        //                     color: ButtonColor,
        //                     borderRadius: BorderRadius.all(Radius.circular(10)),
        //                   ),
        //                   child: TextButton(onPressed: (){
        //
        //                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>add_contract()));
        //
        //                   }, child: Text("Add contract",style: TextStyle(
        //
        //                     color: Colors.white,
        //                     fontSize: 17
        //
        //
        //                   ),)),
        //                 ))
        //
        //
        //               ],
        //             ),
        //
        //           ],
        //         ),
        //       ),
        //   SizedBox(
        //     height: 50,
        // )
        //     ],
        //   ),
      ),
    );
  }
}
