import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Renter_details/resit_view.dart';
import '../Renter_details/view_contract.dart';

class payments_per_individual extends StatefulWidget {
  String renter_id;
  payments_per_individual({Key? key, required this.renter_id})
      : super(key: key);

  @override
  State<payments_per_individual> createState() =>
      _payments_per_individualState();
}

class _payments_per_individualState extends State<payments_per_individual> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
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
        title: Text(
          "Contract details",
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
                  height: 10,
                ),
                Expanded(
                    // child:  Padding(padding: EdgeInsets.only(left: 20,right: 20),
                    child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("contracts_db")
                      .where('renter_id', isEqualTo: widget.renter_id).where('status', isEqualTo:'active')
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
                    QuerySnapshot querysnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> DocumentSnapshotList =
                        querysnapshot.docs;

                    return ListView.separated(
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot contract_data =
                              DocumentSnapshotList[index];

                          Timestamp startTimestamp =
                              contract_data['start_date'];
                          Timestamp endTimestamp = contract_data['end_date'];

                          DateTime startDate = startTimestamp.toDate();
                          DateTime endDate = endTimestamp.toDate();
                          return Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Start Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 28,
                                      ),
                                      Text(
                                        '${startDate.day} . ${startDate.month} . ${startDate.year}',
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "End Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 35,
                                      ),
                                      Text(
                                        '${endDate.day} . ${endDate.month} . ${endDate.year}',
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Paid Amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        contract_data['paid_amount'],
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Container()),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 1),
                                        decoration: BoxDecoration(
                                            color: Color(0xff0748A6),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        height: 30,
                                        width: 100,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              view_contract(
                                                                renter_id: widget
                                                                    .renter_id,
                                                                start_date:
                                                                    startDate,
                                                              )));
                                                },
                                                child: Text(
                                                  "view contract",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
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
                  },
                )),
              ],
            )),
      ),
    );
  }
}
