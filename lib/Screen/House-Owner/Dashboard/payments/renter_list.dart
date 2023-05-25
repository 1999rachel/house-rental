import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/payments/payments_per_individual.dart';

class renter_payments extends StatefulWidget {
  const renter_payments({Key? key}) : super(key: key);

  @override
  State<renter_payments> createState() => _renter_paymentsState();
}

class _renter_paymentsState extends State<renter_payments> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
          color: Colors.white,
          size: 24,
        )),
    title: Text(
      "Contracts",
      style: TextStyle(color: Colors.white, fontSize: 17),
    ),
      ),
      body: Container(
      width: double.infinity,
      height: double.infinity,
      color: BackgroundColor,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("renters_db")
                      .where("house_owner_id",
                          isEqualTo: _auth.currentUser?.uid)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      // return Text("Something went wrong");
                      return Center(
                        child: Center(
                            child: SpinKitCircle(color: ButtonColor)),
                      );
                    }
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: Center(
                            child: SpinKitCircle(color: ButtonColor)),
                      );
                    }

                    QuerySnapshot querysnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> DocumentSnapshotList =
                        querysnapshot.docs;

                    return ListView.separated(
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot renters_data =
                              DocumentSnapshotList[index];
                          return Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            payments_per_individual(renter_id: renters_data.id)));
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: 10, right: 10),
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
                                            child: Container(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.black54,
                                                size: 35,
                                              ),
                                            )),
                                        decoration: BoxDecoration(
                                            // color: Colors.white,
                                            color: BackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          renters_data['full_name'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('houses_db')
                                            .doc(renters_data['house_id'])
                                            .snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<dynamic> houseSnapshot) {
                                          if (houseSnapshot.hasData) {
                                            return Row(
                                              children: [
                                                Text("House no."),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                          houseSnapshot
                                              .data['house_no'],
                                                  style: TextStyle(
                                                      color: Color(0xffC21F1F)),
                                                )
                                              ],
                                            );
                                          }
                                          return Text("Loading...");

                                        }


                                      ),

                                      ],
                                    ),
                                    Expanded(child: Container()),
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
                  }))
        ],
      )),
    );
  }
}
