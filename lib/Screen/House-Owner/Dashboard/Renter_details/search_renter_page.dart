import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/Renter_details/renter_details_account_page.dart';

import '../../../../Utils/UpperCaseTextFormat.dart';
import '../dashboard.dart';

class search_renter_page extends StatefulWidget {
  const search_renter_page({Key? key}) : super(key: key);

  @override
  State<search_renter_page> createState() => _search_renter_pageState();
}

class _search_renter_pageState extends State<search_renter_page> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  String renterName = '';
  void updateHouseStatus(String houseId) {
    FirebaseFirestore.instance
        .collection('houses_db')
        .doc(houseId)
        .update({'status': 'inactive'})
        .then((value) => print('House status updated successfully'))
        .catchError((error) => print('Failed to update house status: $error'));
  }


  Future<void> updateContractsStatus(String renterId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('contracts_db')  // Replace 'your_collection' with your actual collection name
          .where('renter_id', isEqualTo: renterId)  // Replace 'your_field' with the field you want to match
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = querySnapshot.docs.first;
        final String documentId = documentSnapshot.id;

        await FirebaseFirestore.instance
            .collection('contracts_db')
            .doc(documentId)
            .update({'status': 'inactive'});  // Replace 'status' with the field you want to update

        print('Status updated successfully!');
      } else {
        print('Document not found!');
      }
    } catch (e) {
      print('Error updating document status: $e');
    }
  }
  void updateRenterStatus(String renterId) {
    FirebaseFirestore.instance
        .collection('renters_db')
        .doc(renterId)
        .update({'status': 'inactive'})
        .then((value) => print('Renter status updated successfully'))
        .catchError((error) => print('Failed to update renter status: $error'));
  }

  void deleteRenter(String renterId) async {
    // Fetch the renter's data
    DocumentSnapshot renterSnapshot = await FirebaseFirestore.instance
        .collection('renters_db')
        .doc(renterId)
        .get();

    // Check if the renter exists
    if (renterSnapshot.exists) {
      // Get the house ID from the renter's data
      String houseId = renterSnapshot['house_id'];

      // Update the renter's status to inactive
      updateRenterStatus(renterId);

      // Update the status of the associated house
      updateHouseStatus(houseId,);
      updateContractsStatus(renterId);

      // Delete the renter
      // FirebaseFirestore.instance
      //     .collection('renters_db')
      //     .doc(renterId)
      //     .delete()
      //     .then((value) => print('Renter deleted successfully'))
      //     .catchError((error) => print('Failed to delete renter: $error'));
    } else {
      print('Renter does not exist');
    }
  }



  @override
  void initState() {
    super.initState();
 // / Fetch data from Firestore on screen initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //     centerTitle: true,
    //     backgroundColor: ButtonColor,
    //     leading: TextButton(
    //         onPressed: () {
    //         Navigator.of(context).pop();
    //         },
    //         child: Icon(
    //           Icons.arrow_back_ios,
    //           size: 24,
    //           color: Colors.white,
    //         )),
    //
    //     title:
    //       actions: [
    //
    // ],
    //   ),

      body: Container(
        color: BackgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [



            Form(
              child: Container(
                height: 90,
                color: ButtonColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Icon(
                          Icons.arrow_back_ios_new,size: 24,color: Colors.white,
                        )),
                        SizedBox(
                          width: 10,
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 35,
                          width: 250,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),

                          child: TextFormField(

                            inputFormatters: <TextInputFormatter>[
                              UpperCaseTextFormat()
                            ],

                            onChanged: (value){

                              setState(() {

                                renterName = value;
                              });
                            },
                            onFieldSubmitted:(value) {
                          setState(() {

                          renterName = value;
                          });
                            },
                            cursorHeight: 20,
                            cursorColor: Colors.black,
                            // onFieldSubmitted: (value) => searchData,
                            decoration: InputDecoration(
                              hintText: 'Search',

                              contentPadding: EdgeInsets.only(left: 20,right: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Colors.black38)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff0748A6),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    BorderSide(color: Color(0xff0748A6))),

                                fillColor: Colors.white,

                                hintStyle: TextStyle(
                                    color: Colors.black38, fontSize: 15),

                          ),
                        )
                        )],
                    )
                  ],



                ),

              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('renters_db')
                    .where("house_owner_id",
                    isEqualTo: FirebaseAuth.instance.currentUser?.uid).where('status',isEqualTo:'active')
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

                          if(renterName.isEmpty){
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
                                                                              String renterId = data.id;
                                                                              deleteRenter(renterId);
                                                                              Navigator.of(context).pop();


                                                                              //
                                                                              // renters.doc(data.id).delete().then((value){
                                                                              //
                                                                              //   Navigator.of(context).pop();
                                                                              // });

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
                          }
                          if (data['full_name'].toString().toUpperCase().startsWith(renterName.toUpperCase())){

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
                                                                              String renterId = data.id;
                                                                              deleteRenter(renterId);
                                                                              Navigator.of(context).pop();


                                                                              //
                                                                              // renters.doc(data.id).delete().then((value){
                                                                              //
                                                                              //   Navigator.of(context).pop();
                                                                              // });

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
                          }


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
    );
  }
}
