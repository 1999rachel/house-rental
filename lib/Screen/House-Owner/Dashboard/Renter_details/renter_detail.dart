//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:house_rental/Screen/House-Owner/Dashboard/Renter_details/renter_details_account_page.dart';
//
// import '../../../../Utils/PreferenceUtil.dart';
// import '../Register_renter/renter_registration_stage1.dart';
//
// class renter_details extends StatefulWidget {
//   const renter_details({Key? key}) : super(key: key);
//
//   @override
//   State<renter_details> createState() => _renter_detailsState();
// }
//
// class _renter_detailsState extends State<renter_details> {
//   final ButtonColor = const Color(0xff0748A6);
//   final BackgroundColor = const Color(0xffEEEEEE);
//
//   // bottom navigation
//   int _page = 0;
//   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
//
//   Stream<QuerySnapshot> _renters =
//       FirebaseFirestore.instance.collection("renters").snapshots();
//
//   @override
//   void initState(){
//     PreferenceUtil prefs = PreferenceUtil();
//     prefs.getItem("email", "string").then((email){
//       setState(() {
//         FirebaseFirestore.instance
//             .collection("renters")
//             .where("house_owner_id", isEqualTo: email)
//             .snapshots();
//       });
//
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           autofocus: true,
//           mini: true,
//           backgroundColor: ButtonColor,
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => renter_registration_stage1()));
//           },
//           child: Icon(Icons.add),
//         ),
//         bottomNavigationBar: CurvedNavigationBar(
//           key: _bottomNavigationKey,
//           index: 0,
//           height: 60.0,
//           items: <Widget>[
//             Icon(
//               Icons.home,
//               size: 30,
//             ),
//             Icon(Icons.notifications, size: 30),
//             Icon(Icons.person, size: 30),
//           ],
//           color: BackgroundColor,
//           buttonBackgroundColor: ButtonColor,
//           backgroundColor: BackgroundColor,
//           animationCurve: Curves.ease,
//           animationDuration: Duration(milliseconds: 600),
//           onTap: (index) {
//             setState(() {
//               _page = index;
//             });
//           },
//           letIndexChange: (index) => true,
//         ),
//         appBar: AppBar(
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: ButtonColor,
//           leading: Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.white,
//             size: 24,
//           ),
//           title: Text(
//             "Renter details",
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//           actions: [
//             IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.search,
//                   size: 24,
//                 ))
//           ],
//         ),
//         body: Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: BackgroundColor,
//             child: Column(children: [
//               SizedBox(
//                 height: 10,
//               ),
//               StreamBuilder<DocumentSnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection("renters")
//                     .doc()
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<DocumentSnapshot> snapshot) {
//                   if (!snapshot.hasData) {}
//                   {
//                     Center(
//                       child: Text("Something went wrong..."),
//                     );
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: 20,
//                         color: ButtonColor,
//                       ),
//                     );
//                   }
//                   if (snapshot.connectionState == ConnectionState.active) {
//                     return Expanded(
//                         child: ListView.separated(
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: EdgeInsets.only(left: 10, right: 10),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 renter_details_account_page()));
//                                   },
//                                   child: Container(
//                                     padding:
//                                         EdgeInsets.only(left: 10, right: 10),
//                                     height: 80,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                     child: Row(
//                                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         ClipRRect(
//                                           child: Container(
//                                             width: 60,
//                                             height: 60,
//                                             child: ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(50),
//                                                 // child: Image.network(
//                                                 //   data['profile1'],
//                                                 //   fit: BoxFit.cover,
//                                                 // ),
//                                                 child: Icon(
//                                                   Icons.person,
//                                                   size: 40,
//                                                   color: Colors.black54,
//                                                 )),
//                                             decoration: BoxDecoration(
//                                                 color: BackgroundColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(50)),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15,
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Rachel Japhet",
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                             SizedBox(
//                                               height: 5,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   "House no.",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                                 SizedBox(
//                                                   width: 2,
//                                                 ),
//                                                 Text(
//                                                   "01",
//                                                   style: TextStyle(
//                                                       color: Color(0xffC21F1F)),
//                                                 )
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                         Expanded(child: Container()),
//                                         Row(
//                                           children: [
//                                             SizedBox(
//                                               width: 3,
//                                             ),
//                                             GestureDetector(
//                                                 onTap: () {},
//                                                 child: Icon(
//                                                   Icons.delete,
//                                                   color: Colors.red,
//                                                 ))
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (context, index) {
//                               return SizedBox(
//                                 height: 13,
//                               );
//                             },
//                             itemCount: 20));
//                   }
//                   return CircularProgressIndicator(
//                     value: 30,
//                   );
//                 },
//               ),
//             ])));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/Renter_details/renter_details_account_page.dart';

import '../../../../Utils/PreferenceUtil.dart';
import '../Register_renter/renter_registration_stage1.dart';
import '../account/account.dart';
import '../dashboard.dart';

class renter_details extends StatefulWidget {
  renter_details({
    Key? key,
  }) : super(key: key);

  @override
  State<renter_details> createState() => _renter_detailsState();
}

class _renter_detailsState extends State<renter_details> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool renter_navigation = false;

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final renters = FirebaseFirestore.instance.collection('renters_db');
  bool isContainerVisible = false;
  void showContainer() {
    AlertDialog(
        title: Text('Pop-up Container'),
    content: Container(
    height: 200,
    width: 200,
    color: Colors.blue,
    alignment: Alignment.center,
    child: Text(
    'This is a pop-up container',
    style: TextStyle(
    color: Colors.white,
    fontSize: 20,
    ),
    ),
    ));

    // setState(() {
    //   isContainerVisible = true;
    // });
  }

  void hideContainer() {
    setState(() {
      isContainerVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        autofocus: true,
        mini: true,
        backgroundColor: ButtonColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => renter_registration_stage1()));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => dashboard()));
            },
            icon: Icon(
              Icons.home,
              size: 30,
            ),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications, size: 30)),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => salon_owner_account()));
            },
            icon: Icon(Icons.person, size: 30),
          ),
        ],
        color: BackgroundColor,
        buttonBackgroundColor: ButtonColor,
        backgroundColor: BackgroundColor,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
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
              onPressed: showContainer,
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.white,
              ))
        ],
        title: Text(
          "Renters details",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: BackgroundColor),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: renters
                      .where("house_owner_id",
                          isEqualTo: _auth.currentUser?.uid)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      // return Text("Something went wrong");
                      return Center(
                        child: Center(child: SpinKitCircle(color: ButtonColor)),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Center(child: SpinKitCircle(color: ButtonColor)),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.active) {
                      QuerySnapshot querysnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> DocumentSnapshotList =
                          querysnapshot.docs;

                      return ListView.separated(
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot data =
                                DocumentSnapshotList[index];
                            return Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).push(
                                  //             MaterialPageRoute(
                                  //                 builder: (context) =>
                                  //                     renter_details_account_page()));
                                  //
                                  setState(() {
                                    try {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  renter_details_account_page(
                                                    renter_id: data.id,
                                                  )));
                                    } catch (e) {
                                      Text("Something went wrong");
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            // child: Image.network(
                                            //   data['downloadedUrl'],
                                            //   fit: BoxFit.cover,
                                            // ),
                                            child: Icon(
                                              Icons.person,
                                              size: 40,
                                              color: Colors.black54,
                                            )
                                          ),
                                          decoration: BoxDecoration(
                                              color: BackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['full_name'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          StreamBuilder<DocumentSnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('houses_db')
                                                .doc(data['house_id'])
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<dynamic>
                                                    houseSnapshot) {
                                              if (houseSnapshot.hasData) {
                                                return Row(
                                                  children: [
                                                    Text(
                                                      "House no.",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      // "house 1w",
                                                      houseSnapshot
                                                          .data['house_no'],
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffC21F1F)),
                                                    )
                                                  ],
                                                );
                                              }

                                              return Text("Loading...");
                                            },
                                          )
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 3,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                // renters.doc(data.id).delete();
                                                setState(() {

                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                          (context) {
                                                        return Dialog(
                                                          child: Container(
                                                              height: 130,
                                                              width: double.infinity,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Center(
                                                                    child: Text(
                                                                      softWrap: true,
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        // fontSize: 17
                                                                      ),
                                                                      "Do you want to delete this user?",
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 20, right: 20),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: TextButton(
                                                                            onPressed: () { Navigator.of(context).pop(); },
                                                                            child: Container(
                                                                                height: 40,
                                                                                width: 150,
                                                                                decoration: BoxDecoration(color: ButtonColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Cancel",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 20,
                                                                        ),
                                                                        Expanded(
                                                                          child: TextButton(

                                                                            onPressed: () {
                                                                              renters.doc(data.id).delete().then((value){

                                                                                Navigator.of(context).pop();
                                                                              });

                                                                            },
                                                                            child: Container(
                                                                              height: 40,
                                                                              width: 200,
                                                                              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "Yes",
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                        );
                                                      });
                                                  // showDialog(
                                                  //     context: context,
                                                  //     builder: (context) {
                                                  //       return Center(
                                                  //         child: Container(
                                                  //           decoration: BoxDecoration(
                                                  //               color: Colors
                                                  //                   .white,
                                                  //               borderRadius: BorderRadius
                                                  //                   .all(Radius
                                                  //                       .circular(
                                                  //                           20))),
                                                  //           margin:
                                                  //               EdgeInsets.only(
                                                  //                   left: 20,
                                                  //                   right: 20),
                                                  //           width:
                                                  //               double.infinity,
                                                  //           height: 150,
                                                  //           child: Column(
                                                  //             mainAxisAlignment:
                                                  //                 MainAxisAlignment
                                                  //                     .center,
                                                  //             children: [
                                                  //               Text(
                                                  //                 "Do you want to delete this user?",
                                                  //                 style: TextStyle(
                                                  //                     color: Colors
                                                  //                         .black,
                                                  //                     fontSize:
                                                  //                         16),
                                                  //               ),
                                                  //               SizedBox(
                                                  //                 height: 20,
                                                  //               ),
                                                  //               Row(
                                                  //                 mainAxisAlignment:
                                                  //                     MainAxisAlignment
                                                  //                         .center,
                                                  //                 crossAxisAlignment:
                                                  //                     CrossAxisAlignment
                                                  //                         .center,
                                                  //                 children: [
                                                  //                   Container(
                                                  //                     height:
                                                  //                         40,
                                                  //                     width:
                                                  //                         100,
                                                  //                     decoration: BoxDecoration(
                                                  //                         color:
                                                  //                             BackgroundColor,
                                                  //                         borderRadius:
                                                  //                             BorderRadius.all(Radius.circular(10))),
                                                  //                     child:
                                                  //                         TextButton(
                                                  //                       onPressed:
                                                  //                           () {
                                                  //                         Navigator.of(context)
                                                  //                             .pop();
                                                  //                       },
                                                  //                       child:
                                                  //                           Text(
                                                  //                         "Cancel",
                                                  //                         style:
                                                  //                             TextStyle(color: Colors.black),
                                                  //                       ),
                                                  //                     ),
                                                  //                   ),
                                                  //                   SizedBox(
                                                  //                     width: 40,
                                                  //                   ),
                                                  //                   Container(
                                                  //                     height:
                                                  //                         40,
                                                  //                     width:
                                                  //                         100,
                                                  //                     decoration: BoxDecoration(
                                                  //                         color:
                                                  //                             BackgroundColor,
                                                  //                         borderRadius:
                                                  //                             BorderRadius.all(Radius.circular(10))),
                                                  //                     child:
                                                  //                         TextButton(
                                                  //                       onPressed:
                                                  //                           () {
                                                  //                         setState(
                                                  //                             () {
                                                  //                           renters.doc(data.id).delete();
                                                  //                           Navigator.of(context).pop();
                                                  //                         });
                                                  //                       },
                                                  //                       child:
                                                  //                           Text(
                                                  //                         "Yes",
                                                  //                         style:
                                                  //                             TextStyle(color: Colors.black),
                                                  //                       ),
                                                  //                     ),
                                                  //                   )
                                                  //                 ],
                                                  //               )
                                                  //             ],
                                                  //           ),
                                                  //         ),
                                                  //       );
                                                  //     });
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Color(0xffC21F1F),
                                              )),
                                          SizedBox(
                                            width: 3,
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
                          itemCount: DocumentSnapshotList.length);
                    }
                    return Center(
                      child: Center(child: SpinKitCircle(color: ButtonColor)),
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
