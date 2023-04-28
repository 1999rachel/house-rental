import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/Screen/normal_users/user_dashboard/renter_account.dart';
import 'package:house_rental/Screen/normal_users/user_dashboard/user_payments.dart';

import '../Registration/LogIn/LogIn.dart';

class user_darshboard extends StatefulWidget {
  const user_darshboard({Key? key}) : super(key: key);

  @override
  State<user_darshboard> createState() => _user_darshboardState();
}

class _user_darshboardState extends State<user_darshboard> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final DrawableButtonColor = const Color(0xffD9D9D9);

  final Stream<QuerySnapshot> _contracts =
      FirebaseFirestore.instance.collection("contracts").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Material(
            child: Column(
              children: [DrawerHeader(context), DrawerList(context)],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ButtonColor,
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                alignment: Alignment.topLeft,
                width: 35,
                child: Divider(
                  thickness: 3,
                  height: 2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  size: 24,
                  color: Colors.white,
                ))
          ],
        ),
        body: SafeArea(
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: _contracts,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapShot) {
                if (snapShot.hasError) {
                  return Text(snapShot.error.toString());
                } else if (snapShot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: Text("Loading..."),
                  );
                }
                else if (snapShot.hasData) {
                  List<QueryDocumentSnapshot> contracts = snapShot.data!.docs;
                  // for (int i = 0; i < users.length; i++) {
                  //   print(users[i].get("fullname"));
                  // }
                  return Text(contracts[0].get("start_date"));
                  // return ListView(
                  //   children: snapShot.data!.docs.map((DocumentSnapshot document) {
                  //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  //     return ListTile(
                  //       title: Text(data['fullname']),
                  //       // subtitle: Text(data['company']),
                  //     );
                  //   }).toList(),
                  // );
                }

                return CircularProgressIndicator();
              },
            ),
          ),
        ));
    //   body: SafeArea(
    //     child: Container(
    // width: double.infinity,
    // height: double.infinity,
    // color: BackgroundColor,
    // child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 // mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Name",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 50,
    //                   ),
    //                   Column(
    //                     children: [
    //                       Text(
    //                         "Rachel Japhet Sironga",
    //                         style: TextStyle(color: Colors.black),
    //                       ),
    //                       // Divider(
    //                       //   color: Colors.black,
    //                       //   // thickness: ,
    //                       //
    //                       // )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 // mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Gender",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 50,
    //                   ),
    //                   Column(
    //                     children: [
    //                       Text(
    //                         "Female",
    //                         style: TextStyle(color: Colors.black),
    //                       ),
    //                       // Divider(
    //                       //   color: Colors.black,
    //                       //   // thickness: ,
    //                       //
    //                       // )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 // mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Address",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 50,
    //                   ),
    //                   Column(
    //                     children: [
    //                       Text(
    //                         "kanyau1234@gmail.com",
    //                         style: TextStyle(color: Colors.black),
    //                       ),
    //                       // Divider(
    //                       //   color: Colors.black,
    //                       //   // thickness: ,
    //                       //
    //                       // )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 // mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Phone 1",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 50,
    //                   ),
    //                   Column(
    //                     children: [
    //                       Text(
    //                         "0750964523",
    //                         style: TextStyle(color: Colors.black),
    //                       ),
    //                       // Divider(
    //                       //   color: Colors.black,
    //                       //   // thickness: ,
    //                       //
    //                       // )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 // mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Phone 2",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 50,
    //                   ),
    //                   Column(
    //                     children: [
    //                       Text(
    //                         "073427198981",
    //                         style: TextStyle(color: Colors.black),
    //                       ),
    //                       // Divider(
    //                       //   color: Colors.black,
    //                       //   // thickness: ,
    //                       //
    //                       // )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 // mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "House no",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 40,
    //                   ),
    //                   Column(
    //                     children: [
    //                       Text(
    //                         "1",
    //                         style: TextStyle(color: Colors.black),
    //                       ),
    //                       // Divider(
    //                       //   color: Colors.black,
    //                       //   // thickness: ,
    //                       //
    //                       // )
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "Rent",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 70,
    //                   ),
    //                   Text("150000"),
    //                   Expanded(child: Container()),
    //                   Text("Tzs/Mo")
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "Water bills",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 30,
    //                   ),
    //                   Text("150000"),
    //                   Expanded(child: Container()),
    //                   Text("Tzs/Mo")
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 children: [
    //                   Text(
    //                     "Start date",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 40,
    //                   ),
    //                   Text("13.3.2014"),
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 children: [
    //                   Text(
    //                     "End date",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 40,
    //                   ),
    //                   Text("13.3.2014"),
    //                 ],
    //               ),
    //               Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Divider(
    //                     color: Colors.black38,
    //                     thickness: 0.3,
    //                   ))
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             children: [
    //               Row(
    //                 children: [
    //                   Text(
    //                     "Payments",
    //                     style: TextStyle(
    //                         color: Colors.black, fontWeight: FontWeight.bold),
    //                   ),
    //                   SizedBox(
    //                     width: 40,
    //                   ),
    //                   Expanded(
    //                       child: Container(
    //                     height: 45,
    //                     width: double.infinity,
    //                     decoration: BoxDecoration(
    //                       color: ButtonColor,
    //                       borderRadius: BorderRadius.all(Radius.circular(10)),
    //                     ),
    //                     child: TextButton(
    //                         onPressed: () {
    //                           Navigator.of(context).push(MaterialPageRoute(
    //                               builder: (context) => user_payments()));
    //                         },
    //                         child: Text(
    //                           "Check payment",
    //                           style: TextStyle(
    //                               color: Colors.white, fontSize: 17),
    //                         )),
    //                   ))
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 50,
    //         )
    //       ],
    //     ),
    // ),
    //     ),
    //   ),
    // );
  }

  Widget DrawerHeader(BuildContext context) {
    return Container(
      color: ButtonColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            height: 200,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: ClipRRect(
                    child: Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/profile1.jpeg",
                          // width: 60,height: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: BackgroundColor,
                          border: Border(
                              top: BorderSide(width: 1, color: Colors.grey),
                              left: BorderSide(width: 1, color: Colors.grey),
                              right: BorderSide(width: 1, color: Colors.grey),
                              bottom: BorderSide(width: 1, color: Colors.grey)),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Juma Ally Shamba",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "House no.",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text("1",
                        style: TextStyle(
                            color: Color(0xffC21F1F),
                            fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget DrawerList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Material(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => user_darshboard()));
              },
              leading: Icon(
                Icons.home_outlined,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => user_payments()));
              },
              leading: Icon(
                Icons.payments_outlined,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Payments",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>user_calender()));
              },
              leading: Icon(
                Icons.calendar_month_outlined,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Calender",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>message()));
              },
              leading: Icon(
                Icons.message_outlined,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Messages",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => renter_account()));
              },
              leading: Icon(
                Icons.person,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Accounts",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () => FirebaseAuth.instance.signOut(),
              leading: Icon(
                Icons.logout,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Sign Out",
                style: TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
