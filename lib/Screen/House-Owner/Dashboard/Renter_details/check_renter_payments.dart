import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/Renter_details/resit_view.dart';

class check_renter_payments extends StatefulWidget {
    String renter_id;
   check_renter_payments({Key? key, required this.renter_id}) : super(key: key);

  @override
  State<check_renter_payments> createState() => _check_renter_paymentsState();
}

class _check_renter_paymentsState extends State<check_renter_payments> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
          "Payments",
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
                height: 20,
              ),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("contracts_db").where('renter_id', isEqualTo: widget.renter_id).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                // if (!snapshot.hasError){
                //   return Center(
                //     child: Container(
                //       width: double.infinity,
                //       height: 100,
                //       padding: EdgeInsets.only(
                //         left: 20,right: 20
                //       ),
                //       child: Text("Something went wrong",textAlign: TextAlign.center,style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 17
                //       ),),
                //     ),
                //   );
                // }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return SpinKitCircle(
                    color: ButtonColor,

                  );
                }
                if(snapshot.connectionState==ConnectionState.active){
                  QuerySnapshot querysnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> ListQueryDocumentSnapshot =
                      querysnapshot.docs;
                  return  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot contract_data =
                          ListQueryDocumentSnapshot[index];
                          final start_date =  contract_data['start_date'].toDate();
                          return Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 90,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Date",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 42,
                                      ),
                                      Text(
                                        start_date.toString(),
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
                                        "Account",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "95346772719871771",
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
                                        width: 95,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              resit_view()));
                                                },
                                                child: Text(
                                                  "view resits",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))),
                                      )
                                    ],
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
                        itemCount:  ListQueryDocumentSnapshot.length),
                  );
                }
                return SpinKitCircle(
                  color: ButtonColor,
                );

              },


              ),


            ],
          )),
    ));
  }
}

// Expanded(
// child: ListView.separated(
// itemBuilder: (context, index) {
// return Padding(
// padding: EdgeInsets.only(left: 20, right: 20),
// child: Container(
// padding: EdgeInsets.only(left: 10, right: 10),
// height: 90,
// color: Colors.white,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Row(
// children: [
// Text(
// "Date",
// style:
// TextStyle(fontWeight: FontWeight.bold),
// ),
// SizedBox(
// width: 42,
// ),
// Text(
// "13.3.2023",
// style: TextStyle(fontSize: 13),
// )
// ],
// ),
// SizedBox(
// height: 3,
// ),
// Row(
// children: [
// Text(
// "Account",
// style:
// TextStyle(fontWeight: FontWeight.bold),
// ),
// SizedBox(
// width: 20,
// ),
// Text(
// "95346772719871771",
// style: TextStyle(fontSize: 13),
// )
// ],
// ),
// SizedBox(
// height: 2,
// ),
// Row(
// children: [
// Expanded(child: Container()),
// Container(
// padding: EdgeInsets.only(bottom: 1),
// decoration: BoxDecoration(
// color: Color(0xff0748A6),
// borderRadius: BorderRadius.all(
// Radius.circular(5))),
// height: 30,
// width: 95,
// child: Align(
// alignment: Alignment.center,
// child: TextButton(
// onPressed: () {
// Navigator.of(context).push(
// MaterialPageRoute(
// builder: (context) =>
// resit_view()));
// },
// child: Text(
// "view resits",
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.white),
// ))),
// )
// ],
// )
// ],
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