import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_contract_to_renter.dart';
import 'check_renter_payments.dart';

class renter_details_account_page extends StatefulWidget {
  const renter_details_account_page({Key? key}) : super(key: key);

  @override
  State<renter_details_account_page> createState() =>
      _renter_details_account_pageState();
}

class _renter_details_account_pageState
    extends State<renter_details_account_page> {

  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);

  final Stream<QuerySnapshot> _renterInfo = FirebaseFirestore.instance
      .collection("renters")
      .snapshots();
  late Stream<QuerySnapshot> _renterStream;

  @override
  void initState() {
    super.initState();
    _renterStream = _renterInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
    width: double.infinity,
    height: double.infinity,
    color: BackgroundColor,
    child: SingleChildScrollView(

      child: StreamBuilder<QuerySnapshot>(
        stream: _renterStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
           if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(
           child: CircularProgressIndicator(
                color: ButtonColor,
              ),
            );
          } else if (snapshot.connectionState ==
              ConnectionState.active) {
            QuerySnapshot querysnapshot = snapshot.data;
            List<QueryDocumentSnapshot> ListQueryDocumentSnapshot =
                querysnapshot.docs;
            return
              Column(


                children: [

                  Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(color: ButtonColor),
                    child: Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 20,
                          top: 30
                        ),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      size: 24,
                                      color: Colors.white,
                                    ))),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(
                                          "assets/profile1.jpeg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(50)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "John Shamba Ally",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "House no.",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "1",
                                          style: TextStyle(
                                              color: Color(0xffAA1414),
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
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
                              width: 50,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Rachel Japhet Sironga",
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
                              "Gender",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Female",
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
                              "Adress",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                Text(
                                  "kanyau1234@gmail.com",
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
                              "Phone 1",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                Text(
                                  "0750964523",
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
                              "Phone 2",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                Text(
                                  "073427198981",
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
                              "House no",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              children: [
                                Text(
                                  "1",
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
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child:Column(
                      children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,

                       children: [
                         Text("Rent"),
                         SizedBox(
                           width: 70,
                         ),
                         Text("150000"),
                         Expanded(child: Container()),

                         Text("Tzs/Mo")
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
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Text("Water bills"),
                            SizedBox(
                              width: 30,
                            ),
                            Text("150000"),
                            Expanded(child: Container()),

                            Text("Tzs/Mo")
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
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child:Column(
                      children: [
                        Row(
                          children: [
                            Text("Start date"),
                            SizedBox(
                              width: 40,
                            ),
                            Text("13.3.2014"),

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
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child:Column(
                      children: [
                        Row(
                          children: [
                            Text("End date"),
                            SizedBox(
                              width: 40,
                            ),
                            Text("13.3.2014"),

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
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child:Column(
                      children: [
                        Row(
                          children: [
                            Text("Contract"),
                            SizedBox(
                              width: 40,
                            ),
                            Expanded(child: Container(

                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ButtonColor,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: TextButton(onPressed: (){

                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>add_contract()));

                              }, child: Text("Add contract",style: TextStyle(

                                color: Colors.white,
                                fontSize: 17


                              ),)),
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
              );
          }
          return Center(
            child: CircularProgressIndicator(
              color: ButtonColor,
            ),
          );
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
      ),
    );
  }
}
